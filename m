Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56F9E3939D7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 01:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235001AbhE0X7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 19:59:38 -0400
Received: from mga18.intel.com ([134.134.136.126]:10241 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236203AbhE0X7K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 19:59:10 -0400
IronPort-SDR: 2tK2K3W07ILJL2kx6QxKhz5g4gnSdNWpUCqj0vR6S1HwDOBMe9LkTOLh1C81BZGCLZiX8fauEx
 cRcd/kEKA4gw==
X-IronPort-AV: E=McAfee;i="6200,9189,9997"; a="190229892"
X-IronPort-AV: E=Sophos;i="5.83,228,1616482800"; 
   d="scan'208";a="190229892"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2021 16:57:36 -0700
IronPort-SDR: ZeIFmsdsFsOlue/8YEFXyR6NydiZCn/WmQ1NjqfrLjrWgFb8OJC/EeEGhPimHBbp8ROR/GbO2m
 9PPKTfr6G0RQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,228,1616482800"; 
   d="scan'208";a="472807339"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by FMSMGA003.fm.intel.com with ESMTP; 27 May 2021 16:57:35 -0700
Subject: [PATCH 2/5] x86/pkeys: rename write_pkru()
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, luto@kernel.org,
        shuah@kernel.org, babu.moger@amd.com, dave.kleikamp@oracle.com,
        linuxram@us.ibm.com, bauerman@linux.ibm.com, bigeasy@linutronix.de
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Thu, 27 May 2021 16:51:13 -0700
References: <20210527235109.B2A9F45F@viggo.jf.intel.com>
In-Reply-To: <20210527235109.B2A9F45F@viggo.jf.intel.com>
Message-Id: <20210527235113.C5DAFE12@viggo.jf.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

write_pkru() was once concerned purely with writing to the PKRU register.
However, the current task XSAVE buffer must also be updated in a
coordinated way.

Change the naming to reflect that this is an operation which applies to
a task (current) and its state in addition to the register itself.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Babu Moger <babu.moger@amd.com>
Cc: Dave Kleikamp <dave.kleikamp@oracle.com>
Cc: Ram Pai <linuxram@us.ibm.com>
Cc: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---

 b/arch/x86/include/asm/fpu/xstate.h |    6 +++++-
 b/arch/x86/kernel/fpu/xstate.c      |    2 +-
 b/arch/x86/mm/pkeys.c               |    2 +-
 3 files changed, 7 insertions(+), 3 deletions(-)

diff -puN arch/x86/include/asm/fpu/xstate.h~rename-write_pkru arch/x86/include/asm/fpu/xstate.h
--- a/arch/x86/include/asm/fpu/xstate.h~rename-write_pkru	2021-05-27 16:40:24.618705468 -0700
+++ b/arch/x86/include/asm/fpu/xstate.h	2021-05-27 16:40:24.631705468 -0700
@@ -124,7 +124,11 @@ static inline u32 read_pkru(void)
 	return 0;
 }
 
-static inline void write_pkru(u32 pkru)
+/*
+ * Update all of the PKRU state for the current task:
+ * PKRU register and PKRU xstate.
+ */
+static inline void current_write_pkru(u32 pkru)
 {
 	struct pkru_state *pk;
 
diff -puN arch/x86/kernel/fpu/xstate.c~rename-write_pkru arch/x86/kernel/fpu/xstate.c
--- a/arch/x86/kernel/fpu/xstate.c~rename-write_pkru	2021-05-27 16:40:24.620705468 -0700
+++ b/arch/x86/kernel/fpu/xstate.c	2021-05-27 16:40:24.633705468 -0700
@@ -1026,7 +1026,7 @@ int arch_set_user_pkey_access(struct tas
 	old_pkru &= ~((PKRU_AD_BIT|PKRU_WD_BIT) << pkey_shift);
 
 	/* Write old part along with new part: */
-	write_pkru(old_pkru | new_pkru_bits);
+	current_write_pkru(old_pkru | new_pkru_bits);
 
 	return 0;
 }
diff -puN arch/x86/mm/pkeys.c~rename-write_pkru arch/x86/mm/pkeys.c
--- a/arch/x86/mm/pkeys.c~rename-write_pkru	2021-05-27 16:40:24.626705468 -0700
+++ b/arch/x86/mm/pkeys.c	2021-05-27 16:40:24.634705468 -0700
@@ -139,7 +139,7 @@ void copy_init_pkru_to_fpregs(void)
 	 * Override the PKRU state that came from 'init_fpstate'
 	 * with the baseline from the process.
 	 */
-	write_pkru(init_pkru_value_snapshot);
+	current_write_pkru(init_pkru_value_snapshot);
 }
 
 static ssize_t init_pkru_read_file(struct file *file, char __user *user_buf,
_
