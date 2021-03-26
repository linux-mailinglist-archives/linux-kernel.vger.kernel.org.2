Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED36349D23
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 01:03:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbhCZACw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 20:02:52 -0400
Received: from mga11.intel.com ([192.55.52.93]:15382 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229639AbhCZACo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 20:02:44 -0400
IronPort-SDR: 9T8PQX9oK+9VCPypOpJY9i8BFNZW3HndZENHBXYbPz8L7TQf9OICyYu3WLG1WJTtILsI80l+F/
 4DZ8VXO103kg==
X-IronPort-AV: E=McAfee;i="6000,8403,9934"; a="187748032"
X-IronPort-AV: E=Sophos;i="5.81,278,1610438400"; 
   d="scan'208";a="187748032"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2021 17:02:43 -0700
IronPort-SDR: jsHsDEqu/weqLP3OJ95iv8Mg/NMIUrDTLzjsPL6wiIDNiqHEwgIydXYrMNenNt/r/BKjP90xK8
 9TqF+unw3HcQ==
X-IronPort-AV: E=Sophos;i="5.81,278,1610438400"; 
   d="scan'208";a="416265834"
Received: from agluck-desk2.sc.intel.com ([10.3.52.146])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2021 17:02:43 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andy Lutomirski <luto@kernel.org>,
        Aili Yao <yaoaili@kingsoft.com>,
        =?UTF-8?q?HORIGUCHI=20NAOYA=28=20=E5=A0=80=E5=8F=A3=E3=80=80=E7=9B=B4=E4=B9=9F=29?= 
        <naoya.horiguchi@nec.com>
Subject: [PATCH 1/4] x86/mce: Fix copyin code to return -EFAULT on machine check.
Date:   Thu, 25 Mar 2021 17:02:32 -0700
Message-Id: <20210326000235.370514-2-tony.luck@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210326000235.370514-1-tony.luck@intel.com>
References: <20210326000235.370514-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When copy from user fails due to a machine check on poison reading
user data it should return an error code.

---

Separate patch just now, but likely needs to be combined with patches
to iteration code for bisection safety.
---
 arch/x86/lib/copy_user_64.S | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/arch/x86/lib/copy_user_64.S b/arch/x86/lib/copy_user_64.S
index 77b9b2a3b5c8..2987118c541a 100644
--- a/arch/x86/lib/copy_user_64.S
+++ b/arch/x86/lib/copy_user_64.S
@@ -14,6 +14,7 @@
 #include <asm/alternative-asm.h>
 #include <asm/asm.h>
 #include <asm/smap.h>
+#include <asm/errno.h>
 #include <asm/export.h>
 #include <asm/trapnr.h>
 
@@ -237,18 +238,21 @@ SYM_CODE_START_LOCAL(.Lcopy_user_handle_tail)
 	cmp $X86_TRAP_MC,%eax		/* check if X86_TRAP_MC */
 	je 3f
 1:	rep movsb
-2:	mov %ecx,%eax
+	mov %ecx,%eax
+	ASM_CLAC
+	ret
+
+2:
+	cmp $X86_TRAP_MC,%eax
+	je 3f
+	mov %ecx,%eax
 	ASM_CLAC
 	ret
 
 	/*
-	 * Return zero to pretend that this copy succeeded. This
-	 * is counter-intuitive, but needed to prevent the code
-	 * in lib/iov_iter.c from retrying and running back into
-	 * the poison cache line again. The machine check handler
-	 * will ensure that a SIGBUS is sent to the task.
+	 * Return -EFAULT for the machine check cases
 	 */
-3:	xorl %eax,%eax
+3:	movl $-EFAULT,%eax
 	ASM_CLAC
 	ret
 
-- 
2.29.2

