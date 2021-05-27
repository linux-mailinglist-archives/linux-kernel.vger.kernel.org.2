Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BCB13939D9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 01:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235421AbhE0X7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 19:59:42 -0400
Received: from mga06.intel.com ([134.134.136.31]:62232 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236706AbhE0X7M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 19:59:12 -0400
IronPort-SDR: So1ghIB51NVU+2Yoh/DLuRtMcw89221B7nY6NCm+sNCoFbZTsg37F9QfrpszTAq/iOS8/vMldQ
 Z7v7/HDqjycg==
X-IronPort-AV: E=McAfee;i="6200,9189,9997"; a="264056306"
X-IronPort-AV: E=Sophos;i="5.83,228,1616482800"; 
   d="scan'208";a="264056306"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2021 16:57:37 -0700
IronPort-SDR: 9ZFlg3sGbjSQxnOyaaTDmNRe3esrK6QKVLZjgaZeDojwcFOC1gLIryltHoXaSBDLcmDkBnsP99
 M1Wcq2ajCfsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,228,1616482800"; 
   d="scan'208";a="615568004"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by orsmga005.jf.intel.com with ESMTP; 27 May 2021 16:57:37 -0700
Subject: [PATCH 3/5] x86/pkeys: skip 'init_pkru' debugfs file creation when pkeys not supported
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, luto@kernel.org,
        shuah@kernel.org, babu.moger@amd.com, dave.kleikamp@oracle.com,
        linuxram@us.ibm.com, bauerman@linux.ibm.com, bigeasy@linutronix.de
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Thu, 27 May 2021 16:51:16 -0700
References: <20210527235109.B2A9F45F@viggo.jf.intel.com>
In-Reply-To: <20210527235109.B2A9F45F@viggo.jf.intel.com>
Message-Id: <20210527235116.E5A35872@viggo.jf.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

The PKRU hardware is permissive by default: all reads and writes are
allowed.  The in-kernel policy is restrictive by default: deny all
unnecessary access until explicitly requested.

That policy can be modified with a debugfs file: "x86/init_pkru".
This file is created unconditionally, regardless of PKRU support in
the hardware, which is a little silly.

Avoid creating the file when pkeys are not available.  This also
removes the need to check for pkey support at runtime, which would be
required once the new pkey modification infrastructure is put in place
later in this series.

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

 b/arch/x86/mm/pkeys.c |    4 ++++
 1 file changed, 4 insertions(+)

diff -puN arch/x86/mm/pkeys.c~x86-pkeys-skip-debugfs-file arch/x86/mm/pkeys.c
--- a/arch/x86/mm/pkeys.c~x86-pkeys-skip-debugfs-file	2021-05-27 16:40:25.847705465 -0700
+++ b/arch/x86/mm/pkeys.c	2021-05-27 16:40:25.852705465 -0700
@@ -193,6 +193,10 @@ static const struct file_operations fops
 
 static int __init create_init_pkru_value(void)
 {
+	/* Do not expose the file if pkeys are not supported. */
+	if (!cpu_feature_enabled(X86_FEATURE_OSPKE))
+		return 0;
+
 	debugfs_create_file("init_pkru", S_IRUSR | S_IWUSR,
 			arch_debugfs_dir, NULL, &fops_init_pkru);
 	return 0;
_
