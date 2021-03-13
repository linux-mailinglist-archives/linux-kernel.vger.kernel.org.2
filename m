Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46407339E65
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 15:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233298AbhCMOBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 09:01:45 -0500
Received: from mail.skyhub.de ([5.9.137.197]:33138 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233188AbhCMOBX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 09:01:23 -0500
Received: from zn.tnic (p200300ec2f1971005f32d49e743e65b9.dip0.t-ipconnect.de [IPv6:2003:ec:2f19:7100:5f32:d49e:743e:65b9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CB33F1EC008F;
        Sat, 13 Mar 2021 15:01:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1615644081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=Pp7bSRA9gM2UaHSJgzuP7xRc1SFdojzkNmSwnl8e2GI=;
        b=rYM8ZeNHcbYFAKo9P91y6p5Vv08RA1QJON6eed2BtyHmVWFffi95YglrGwMvnYkiuQrZFp
        7FNidBDLSJe2LEyXujEtUYoQLkZTj80ZrhnLMTr08pKqd/HLz/9clHX3a1de4wG0+4U8p8
        6Qm7r0qghDrPR6UxKus6oOwWEyLOKT8=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     Feng Tang <feng.tang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] tools/x86/kcpuid: Add AMD Secure Encryption leaf
Date:   Sat, 13 Mar 2021 15:01:18 +0100
Message-Id: <20210313140118.17010-1-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Add the 0x8000001f leaf's fields.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 tools/arch/x86/kcpuid/cpuid.csv | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/arch/x86/kcpuid/cpuid.csv b/tools/arch/x86/kcpuid/cpuid.csv
index f4a5b85073f4..7cb5c2189345 100644
--- a/tools/arch/x86/kcpuid/cpuid.csv
+++ b/tools/arch/x86/kcpuid/cpuid.csv
@@ -378,3 +378,13 @@
 0x80000008,    0,  EAX,    7:0, phy_adr_bits, Physical Address Bits
 0x80000008,    0,  EAX,   15:8, lnr_adr_bits, Linear Address Bits
 0x80000007,    0,  EBX,      9, wbnoinvd, WBNOINVD
+
+# 8000001F: AMD Secure Encryption
+0x8000001F,	0, EAX, 0, SME,	Secure Memory Encryption
+0x8000001F,	0, EAX, 1, SEV,	Secure Encrypted Virtualization
+0x8000001F,	0, EAX, 2, VmPgFlush, VM Page Flush MSR
+0x8000001F,	0, EAX, 3, SevEs, SEV Encrypted State
+0x8000001F,	0, EBX, 5:0, C-Bit, Page table bit number used to enable memory encryption
+0x8000001F,	0, EBX, 11:6, MemEncryptPhysAddWidth, Reduction of physical address space in bits when SME is enabled
+0x8000001F,	0, ECX, 31:0, NumEncryptedGuests, Maximum ASID value that may be used for an SEV-enabled guest
+0x8000001F,	0, EDX, 31:0, MinimumSEVASID, Minimum ASID value that must be used for an SEV-enabled, SEV-ES-disabled guest
-- 
2.29.2

