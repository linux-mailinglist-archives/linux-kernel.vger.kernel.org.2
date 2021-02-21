Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33E39320D02
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 20:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbhBUTHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 14:07:34 -0500
Received: from mga05.intel.com ([192.55.52.43]:37169 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230472AbhBUTCn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 14:02:43 -0500
IronPort-SDR: f/GnrmTxjwipF4S1pOpM1/PeuqUOs4TlKMDGWIUGtDGBpJectu8vj5xJiNr3FF1ZWyYQZDK2ut
 azxq0JnHk7MQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9902"; a="269192154"
X-IronPort-AV: E=Sophos;i="5.81,195,1610438400"; 
   d="scan'208";a="269192154"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2021 11:01:29 -0800
IronPort-SDR: wyNzWGo+DTzstj/VQ5ID7o33e7Cq4Z0IjceF95c3XRrYfVq63z5tvR8B6vZnE1JsFbQMX3l2gS
 26MGmBgFIpEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,195,1610438400"; 
   d="scan'208";a="429792125"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Feb 2021 11:01:29 -0800
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     bp@suse.de, luto@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH v4 15/22] x86/fpu/xstate: Support ptracer-induced xstate buffer expansion
Date:   Sun, 21 Feb 2021 10:56:30 -0800
Message-Id: <20210221185637.19281-16-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210221185637.19281-1-chang.seok.bae@intel.com>
References: <20210221185637.19281-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ptrace() may update xstate data before the target task has taken an XFD
fault and expanded the xstate buffer. Detect this case and allocate a
sufficient buffer to support the request. Also, disable the (now
unnecessary) associated first-use fault.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
Changes from v3:
* Removed 'no functional changes' in the changelog. (Borislav Petkov)

Changes from v2:
* Updated the changelog with task->fpu removed. (Borislav Petkov)
* Updated the code comments.
---
 arch/x86/kernel/fpu/regset.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/x86/kernel/fpu/regset.c b/arch/x86/kernel/fpu/regset.c
index ee27df4caed6..ec6cbb75010e 100644
--- a/arch/x86/kernel/fpu/regset.c
+++ b/arch/x86/kernel/fpu/regset.c
@@ -122,6 +122,35 @@ int xstateregs_set(struct task_struct *target, const struct user_regset *regset,
 
 	xsave = &fpu->state->xsave;
 
+	/*
+	 * When a ptracer attempts to write any state in the target buffer but not
+	 * sufficiently allocated, it dynamically expands the buffer.
+	 */
+	if (count > get_xstate_size(fpu->state_mask)) {
+		unsigned int offset, size;
+		struct xstate_header hdr;
+		u64 mask;
+
+		offset = offsetof(struct xregs_state, header);
+		size = sizeof(hdr);
+
+		/* Retrieve XSTATE_BV */
+		if (kbuf) {
+			memcpy(&hdr, kbuf + offset, size);
+		} else {
+			ret = __copy_from_user(&hdr, ubuf + offset, size);
+			if (ret)
+				return ret;
+		}
+
+		mask = hdr.xfeatures & xfeatures_mask_user_dynamic;
+		if (!mask) {
+			ret = alloc_xstate_buffer(fpu, mask);
+			if (ret)
+				return ret;
+		}
+	}
+
 	fpu__prepare_write(fpu);
 
 	if (using_compacted_format()) {
-- 
2.17.1

