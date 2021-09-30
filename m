Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5795441D7D9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 12:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350069AbhI3KgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 06:36:22 -0400
Received: from foss.arm.com ([217.140.110.172]:52064 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350061AbhI3KgR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 06:36:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 940F5106F;
        Thu, 30 Sep 2021 03:34:34 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.73.203])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 643EB3F793;
        Thu, 30 Sep 2021 03:34:31 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     suzuki.poulose@arm.com, mark.rutland@arm.com, will@kernel.org,
        catalin.marinas@arm.com, maz@kernel.org, james.morse@arm.com,
        steven.price@arm.com, Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [RFC V3 05/13] arm64/mm: Add FEAT_LPA2 specific ID_AA64MMFR0.TGRAN[2]
Date:   Thu, 30 Sep 2021 16:05:08 +0530
Message-Id: <1632998116-11552-6-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1632998116-11552-1-git-send-email-anshuman.khandual@arm.com>
References: <1632998116-11552-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PAGE_SIZE support is tested against possible minimum and maximum values for
its respective ID_AA64MMFR0.TGRAN field, depending on whether it is signed
or unsigned. But then FEAT_LPA2 implementation needs to be validated for 4K
and 16K page sizes via feature specific ID_AA64MMFR0.TGRAN values. Hence it
adds FEAT_LPA2 specific ID_AA64MMFR0.TGRAN[2] values per ARM ARM (0487G.A).

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/include/asm/sysreg.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 4630eac..334d91f 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -850,12 +850,14 @@
 #define ID_AA64MMFR0_ASID_16		0x2
 
 #define ID_AA64MMFR0_TGRAN4_NI			0xf
+#define ID_AA64MMFR0_TGRAN4_LPA2		0x1
 #define ID_AA64MMFR0_TGRAN4_SUPPORTED_MIN	0x0
 #define ID_AA64MMFR0_TGRAN4_SUPPORTED_MAX	0x7
 #define ID_AA64MMFR0_TGRAN64_NI			0xf
 #define ID_AA64MMFR0_TGRAN64_SUPPORTED_MIN	0x0
 #define ID_AA64MMFR0_TGRAN64_SUPPORTED_MAX	0x7
 #define ID_AA64MMFR0_TGRAN16_NI			0x0
+#define ID_AA64MMFR0_TGRAN16_LPA2		0x2
 #define ID_AA64MMFR0_TGRAN16_SUPPORTED_MIN	0x1
 #define ID_AA64MMFR0_TGRAN16_SUPPORTED_MAX	0xf
 
@@ -872,6 +874,7 @@
 #define ID_AA64MMFR0_TGRAN_2_SUPPORTED_DEFAULT	0x0
 #define ID_AA64MMFR0_TGRAN_2_SUPPORTED_NONE	0x1
 #define ID_AA64MMFR0_TGRAN_2_SUPPORTED_MIN	0x2
+#define ID_AA64MMFR0_TGRAN_2_SUPPORTED_LPA2	0x3
 #define ID_AA64MMFR0_TGRAN_2_SUPPORTED_MAX	0x7
 
 #ifdef CONFIG_ARM64_PA_BITS_52
@@ -1042,11 +1045,13 @@
 
 #if defined(CONFIG_ARM64_4K_PAGES)
 #define ID_AA64MMFR0_TGRAN_SHIFT		ID_AA64MMFR0_TGRAN4_SHIFT
+#define ID_AA64MMFR0_TGRAN_LPA2			ID_AA64MMFR0_TGRAN4_LPA2
 #define ID_AA64MMFR0_TGRAN_SUPPORTED_MIN	ID_AA64MMFR0_TGRAN4_SUPPORTED_MIN
 #define ID_AA64MMFR0_TGRAN_SUPPORTED_MAX	ID_AA64MMFR0_TGRAN4_SUPPORTED_MAX
 #define ID_AA64MMFR0_TGRAN_2_SHIFT		ID_AA64MMFR0_TGRAN4_2_SHIFT
 #elif defined(CONFIG_ARM64_16K_PAGES)
 #define ID_AA64MMFR0_TGRAN_SHIFT		ID_AA64MMFR0_TGRAN16_SHIFT
+#define ID_AA64MMFR0_TGRAN_LPA2			ID_AA64MMFR0_TGRAN16_LPA2
 #define ID_AA64MMFR0_TGRAN_SUPPORTED_MIN	ID_AA64MMFR0_TGRAN16_SUPPORTED_MIN
 #define ID_AA64MMFR0_TGRAN_SUPPORTED_MAX	ID_AA64MMFR0_TGRAN16_SUPPORTED_MAX
 #define ID_AA64MMFR0_TGRAN_2_SHIFT		ID_AA64MMFR0_TGRAN16_2_SHIFT
-- 
2.7.4

