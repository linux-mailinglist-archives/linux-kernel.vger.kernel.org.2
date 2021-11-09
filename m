Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D6AA44A405
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 02:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239651AbhKIBiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 20:38:55 -0500
Received: from mga05.intel.com ([192.55.52.43]:9878 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243195AbhKIBiU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 20:38:20 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10162"; a="318555844"
X-IronPort-AV: E=Sophos;i="5.87,218,1631602800"; 
   d="scan'208";a="318555844"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2021 17:28:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,218,1631602800"; 
   d="scan'208";a="641693040"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by fmsmga001.fm.intel.com with ESMTP; 08 Nov 2021 17:28:21 -0800
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, tglx@linutronix.de, dave.hansen@linux.intel.com,
        bp@alien8.de, mingo@redhat.com, yang.zhong@intel.com,
        jing2.liu@intel.com, chang.seok.bae@intel.com
Subject: [PATCH v2 0/2] x86: Fix ARCH_REQ_XCOMP_PERM and update the test
Date:   Mon,  8 Nov 2021 17:21:20 -0800
Message-Id: <20211109012122.1142-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Reported-by: Yang Zhong <yang.zhong@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>

Changes from v1:
* Change the mask value only.

Chang S. Bae (2):
  x86/arch_prctl: Fix ARCH_REQ_XCOMP_PERM
  selftests/x86/amx: Update the ARCH_REQ_XCOMP_PERM test

 arch/x86/kernel/fpu/xstate.c      |  2 +-
 tools/testing/selftests/x86/amx.c | 16 ++++++++++++++--
 2 files changed, 15 insertions(+), 3 deletions(-)


base-commit: 9a6cf455a952725422f4fb10848839989f833579
-- 
2.17.1

