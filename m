Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13E623768E9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 18:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238276AbhEGQi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 12:38:57 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:52501 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238267AbhEGQi4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 12:38:56 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4FcGMk6w9Qz9sb2;
        Fri,  7 May 2021 18:37:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id iZj_GOJ_yNpY; Fri,  7 May 2021 18:37:54 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4FcGMk6109z9sb1;
        Fri,  7 May 2021 18:37:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id ADD488B835;
        Fri,  7 May 2021 18:37:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id kb8OqGOTT2os; Fri,  7 May 2021 18:37:54 +0200 (CEST)
Received: from po15610vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 412DD8B81C;
        Fri,  7 May 2021 18:37:54 +0200 (CEST)
Received: by po15610vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 0430B64923; Fri,  7 May 2021 16:37:53 +0000 (UTC)
Message-Id: <2541e4e415505b27db8ccbb8977035c20e408ef4.1620405461.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] powerpc/8xx: Update mpc885_ads_defconfig to improve CI
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri,  7 May 2021 16:37:53 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mpc885_ads_defconfig is used by several CI robots.

A few functionnalities are specific to 8xx and are not covered
by other default configuration, so improve build test coverage
by adding them to mpc885_ads_defconfig.

8xx is the only platform supporting 16k page size in addition
to 4k page size. Considering that 4k page size is widely tested
by other configurations, lets make 16k pages the selection for
8xx, as it has demonstrated in the past to be a weakness.

CONFIG_PIN_TLB is specific to 8xx, select it as it mainly adds
code with removing much.

CONFIG_BDI_SWITCH is specific to PPC32 and adds codes.

CONFIG_PPC_PTDUMP has specific part for 8xx.

CONFIG_MODULES has specific handling for 8xx.

CONFIG_SMC_UCODE_PATCH is specific to 8xx for loading microcode.

CONFIG_PERF_EVENTS has specific parts for 8xx.

CONFIG_MATH_EMULATION is used by 8xx.

CONFIG_STRICT_KERNEL_RWX has specificities for 8xx.

CONFIG_VIRT_CPU_ACCOUNTING_NATIVE has specific parts for PPC32.

CONFIG_IPV6 has specificities for PPC32.

CONFIG_BPF_JIT has specificities for PPC32.

A few drivers are tightly linked to the 8xx:
- CONFIG_SPI_FSL_SPI
- CONFIG_CRYPTO_DEV_TALITOS
- CONFIG_8xxx_WDT
- CONFIG_8xx_GPIO
- CONFIG_PPC_EARLY_DEBUG_CPM

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/configs/mpc885_ads_defconfig | 25 +++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/powerpc/configs/mpc885_ads_defconfig b/arch/powerpc/configs/mpc885_ads_defconfig
index 949ff9ccda5e..d21f266cea9a 100644
--- a/arch/powerpc/configs/mpc885_ads_defconfig
+++ b/arch/powerpc/configs/mpc885_ads_defconfig
@@ -57,3 +57,28 @@ CONFIG_CRC32_SLICEBY4=y
 CONFIG_DEBUG_INFO=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DETECT_HUNG_TASK=y
+CONFIG_PPC_16K_PAGES=y
+CONFIG_DEBUG_KERNEL=y
+CONFIG_DEBUG_FS=y
+CONFIG_PPC_PTDUMP=y
+CONFIG_MODULES=y
+CONFIG_SPI=y
+CONFIG_SPI_FSL_SPI=y
+CONFIG_CRYPTO=y
+CONFIG_CRYPTO_DEV_TALITOS=y
+CONFIG_8xx_GPIO=y
+CONFIG_WATCHDOG=y
+CONFIG_8xxx_WDT=y
+CONFIG_SMC_UCODE_PATCH=y
+CONFIG_ADVANCED_OPTIONS=y
+CONFIG_PIN_TLB=y
+CONFIG_PERF_EVENTS=y
+CONFIG_MATH_EMULATION=y
+CONFIG_VIRT_CPU_ACCOUNTING_NATIVE=y
+CONFIG_STRICT_KERNEL_RWX=y
+CONFIG_IPV6=y
+CONFIG_BPF_JIT=y
+CONFIG_DEBUG_VM_PGTABLE=y
+CONFIG_BDI_SWITCH=y
+CONFIG_PPC_EARLY_DEBUG=y
+CONFIG_PPC_EARLY_DEBUG_CPM_ADDR=0xff002008
-- 
2.25.0

