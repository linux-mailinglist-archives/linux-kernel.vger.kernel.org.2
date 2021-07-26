Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5BA3D5344
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 08:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbhGZF4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 01:56:42 -0400
Received: from foss.arm.com ([217.140.110.172]:45614 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232085AbhGZF4h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 01:56:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 79DC5139F;
        Sun, 25 Jul 2021 23:37:06 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.66.17])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7630F3F66F;
        Sun, 25 Jul 2021 23:37:02 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, suzuki.poulose@arm.com,
        mark.rutland@arm.com, will@kernel.org, catalin.marinas@arm.com,
        maz@kernel.org, james.morse@arm.com, steven.price@arm.com,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [RFC V2 04/10] arm64/mm: Add FEAT_LPA2 specific ID_AA64MMFR0.TGRAN[2]
Date:   Mon, 26 Jul 2021 12:07:19 +0530
Message-Id: <1627281445-12445-5-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1627281445-12445-1-git-send-email-anshuman.khandual@arm.com>
References: <1627281445-12445-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PAGE_SIZE support is tested against possible minimum and maximum values for
its respective ID_AA64MMFR0.TGRAN field, depending on whether it is signed
or unsigned. But then FEAT_LPA2 implementation needs to be validated for 4K
and 16K page sizes via feature specific ID_AA64MMFR0.TGRAN values. Hence it
adds FEAT_LPA2 specific ID_AA64MMFR0.TGRAN[2] values per ARM ARM (0487G.A).

Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/include/asm/sysreg.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 5cbfaf6..deecde0 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -849,16 +849,19 @@
 
 #define ID_AA64MMFR0_TGRAN4_NI		0xf
 #define ID_AA64MMFR0_TGRAN4_SUPPORTED	0x0
+#define ID_AA64MMFR0_TGRAN4_LPA2	0x1
 #define ID_AA64MMFR0_TGRAN64_NI		0xf
 #define ID_AA64MMFR0_TGRAN64_SUPPORTED	0x0
 #define ID_AA64MMFR0_TGRAN16_NI		0x0
 #define ID_AA64MMFR0_TGRAN16_SUPPORTED	0x1
+#define ID_AA64MMFR0_TGRAN16_LPA2	0x2
 #define ID_AA64MMFR0_PARANGE_48		0x5
 #define ID_AA64MMFR0_PARANGE_52		0x6
 
 #define ID_AA64MMFR0_TGRAN_2_SUPPORTED_DEFAULT	0x0
 #define ID_AA64MMFR0_TGRAN_2_SUPPORTED_NONE	0x1
 #define ID_AA64MMFR0_TGRAN_2_SUPPORTED_MIN	0x2
+#define ID_AA64MMFR0_TGRAN_2_SUPPORTED_LPA2	0x3
 #define ID_AA64MMFR0_TGRAN_2_SUPPORTED_MAX	0x7
 
 #ifdef CONFIG_ARM64_PA_BITS_52
@@ -1030,10 +1033,12 @@
 #define ID_AA64MMFR0_TGRAN_SHIFT		ID_AA64MMFR0_TGRAN4_SHIFT
 #define ID_AA64MMFR0_TGRAN_SUPPORTED_MIN	ID_AA64MMFR0_TGRAN4_SUPPORTED
 #define ID_AA64MMFR0_TGRAN_SUPPORTED_MAX	0x7
+#define ID_AA64MMFR0_TGRAN_LPA2			ID_AA64MMFR0_TGRAN4_LPA2
 #elif defined(CONFIG_ARM64_16K_PAGES)
 #define ID_AA64MMFR0_TGRAN_SHIFT		ID_AA64MMFR0_TGRAN16_SHIFT
 #define ID_AA64MMFR0_TGRAN_SUPPORTED_MIN	ID_AA64MMFR0_TGRAN16_SUPPORTED
 #define ID_AA64MMFR0_TGRAN_SUPPORTED_MAX	0xF
+#define ID_AA64MMFR0_TGRAN_LPA2			ID_AA64MMFR0_TGRAN16_LPA2
 #elif defined(CONFIG_ARM64_64K_PAGES)
 #define ID_AA64MMFR0_TGRAN_SHIFT		ID_AA64MMFR0_TGRAN64_SHIFT
 #define ID_AA64MMFR0_TGRAN_SUPPORTED_MIN	ID_AA64MMFR0_TGRAN64_SUPPORTED
-- 
2.7.4

