Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62C2D44B9A8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 01:39:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbhKJAl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 19:41:58 -0500
Received: from mga09.intel.com ([134.134.136.24]:28355 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230457AbhKJAl4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 19:41:56 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10163"; a="232416063"
X-IronPort-AV: E=Sophos;i="5.87,221,1631602800"; 
   d="scan'208";a="232416063"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2021 16:39:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,221,1631602800"; 
   d="scan'208";a="642354122"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by fmsmga001.fm.intel.com with ESMTP; 09 Nov 2021 16:39:08 -0800
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, tglx@linutronix.de, dave.hansen@linux.intel.com,
        bp@alien8.de, mingo@redhat.com, yang.zhong@intel.com,
        jing2.liu@intel.com, chang.seok.bae@intel.com
Subject: [PATCH v3 0/2] x86: Fix ARCH_REQ_XCOMP_PERM and update the test
Date:   Tue,  9 Nov 2021 16:32:07 -0800
Message-Id: <20211110003209.21666-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed the authorship from V2:
    https://lore.kernel.org/lkml/20211109012122.1142-1-chang.seok.bae@intel.com/

---

The recent x86 dynamic state support incorporates the arch_prctl option to
request permission before using a dynamic state.

It was designed to add the requested feature in the group leader's
permission bitmask so that every thread can reference this master bitmask.
The group leader is assumed to be unchanged here. The mainline is the case
as a group leader is identified at fork() or exec() time only.

This master bitmask should include non-dynamic features always, as they
are permitted by default. Users may check them via ARCH_GET_XCOMP_PERM.

But, in hindsight, the implementation does overwrite the bitmask with the
requested bit only, instead of adding the bit to the existing one. This
overwrite effectively revokes the permission that is granted already.

Fix the code and also update the selftest to disclose the issue if there
is.

Cc: Yang Zhong <yang.zhong@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>

Chang S. Bae (1):
  selftests/x86/amx: Update the ARCH_REQ_XCOMP_PERM test

Yang Zhong (1):
  x86/arch_prctl: Fix the ARCH_REQ_XCOMP_PERM implementation

 arch/x86/kernel/fpu/xstate.c      |  2 +-
 tools/testing/selftests/x86/amx.c | 16 ++++++++++++++--
 2 files changed, 15 insertions(+), 3 deletions(-)


base-commit: 9a6cf455a952725422f4fb10848839989f833579
-- 
2.17.1

