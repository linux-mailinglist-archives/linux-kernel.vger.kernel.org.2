Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 731E4370279
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 22:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236053AbhD3Uxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 16:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbhD3Uxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 16:53:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9516C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 13:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=qKHOGRgzC7YnT+Ecg1F4J0o80yRMnRSqDzcjOADroEo=; b=o4Ow+GUsvockWChlSPm17pfQRD
        p9QRtbrHHvBYDuPZmBeMqExIDnqDW71yT3fSw5/WGPEv/kt83NWbh09wpxCLMy42G2nhaOaliNlBY
        Rq+T33hSOL+UgkfwLnP8YJ01lnxECMWtq5Vs2NQo1Z+FIY1ju09UXBoWB1PMyesI1j3eflxVod5t4
        6EhnKRQIxHN5pa7sgzwNXb6stZrxXf9f8PfCwzXviKSQP0WdwSDGzSjkF7ZM9OImW6ApXYD4rzq2O
        v7BJT0gG7mCkQJmUX839nofGF6dm1A0fTaZdSzfVmv/5BVMq6yqIcEBWFqeIpunv4l9zU7PAFo/NC
        4ljPTj+g==;
Received: from [2601:1c0:6280:3f0::df68] (helo=casper.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lca6F-00BWOZ-K6; Fri, 30 Apr 2021 20:51:57 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Huacai Chen <chenhc@lemote.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Jinyang He <hejinyang@loongson.cn>
Subject: [PATCH] mips: loongson64: fix reset.c build errors when SMP=n
Date:   Fri, 30 Apr 2021 13:50:55 -0700
Message-Id: <20210430205055.13594-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable 'secondary_kexec_args' is only declared when
CONFIG_SMP=y. When CONFIG_SMP is not set, referencing the variable
causes syntax errors, so guard the references with #ifdef CONFIG_SMP.

../arch/mips/loongson64/reset.c: In function 'loongson_kexec_shutdown':
../arch/mips/loongson64/reset.c:133:2: error: 'secondary_kexec_args' undeclared (first use in this function)
  133 |  secondary_kexec_args[0] = TO_UNCAC(0x3ff01000);
      |  ^~~~~~~~~~~~~~~~~~~~
../arch/mips/loongson64/reset.c: In function 'loongson_crash_shutdown':
../arch/mips/loongson64/reset.c:144:2: error: 'secondary_kexec_args' undeclared (first use in this function)
  144 |  secondary_kexec_args[0] = TO_UNCAC(0x3ff01000);
      |  ^~~~~~~~~~~~~~~~~~~~

Fixes: 6ce48897ce47 ("MIPS: Loongson64: Add kexec/kdump support")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Cc: Huacai Chen <chenhc@lemote.com>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Jinyang He <hejinyang@loongson.cn>
---
 arch/mips/loongson64/reset.c |    4 ++++
 1 file changed, 4 insertions(+)

--- linux-next-20210430.orig/arch/mips/loongson64/reset.c
+++ linux-next-20210430/arch/mips/loongson64/reset.c
@@ -130,7 +130,9 @@ static void loongson_kexec_shutdown(void
 	kexec_args[0] = kexec_argc;
 	kexec_args[1] = fw_arg1;
 	kexec_args[2] = fw_arg2;
+#ifdef CONFIG_SMP
 	secondary_kexec_args[0] = TO_UNCAC(0x3ff01000);
+#endif
 	memcpy((void *)fw_arg1, kexec_argv, KEXEC_ARGV_SIZE);
 	memcpy((void *)fw_arg2, kexec_envp, KEXEC_ENVP_SIZE);
 }
@@ -141,7 +143,9 @@ static void loongson_crash_shutdown(stru
 	kexec_args[0] = kdump_argc;
 	kexec_args[1] = fw_arg1;
 	kexec_args[2] = fw_arg2;
+#ifdef CONFIG_SMP
 	secondary_kexec_args[0] = TO_UNCAC(0x3ff01000);
+#endif
 	memcpy((void *)fw_arg1, kdump_argv, KEXEC_ARGV_SIZE);
 	memcpy((void *)fw_arg2, kexec_envp, KEXEC_ENVP_SIZE);
 }
