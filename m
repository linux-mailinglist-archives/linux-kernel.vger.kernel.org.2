Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF1E933B325
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 14:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbhCOM7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 08:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbhCOM7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 08:59:07 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8765C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 05:59:07 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0786006d6cd745861f0d39.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:8600:6d6c:d745:861f:d39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 651FF1EC0577;
        Mon, 15 Mar 2021 13:59:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1615813144;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HTqEg4OUDvrACvXnLzvk/MQSEoEXL8yN5S/THlN4AqU=;
        b=hj9y3B21KjiZEmw4iwVal/XQ6uTvcEEluB9j2sJAthT8xprGzG60AySx/4BBIl1uy0yGk6
        4OPkzqFami7YVhI5dyIEwGmCcwydj6XFl/MyrxqqFvfwuHfSJJRZxAVJW4xr1QCFiZRRjS
        nQN5ZdwwsUUPF4SjBEjgwMMuSSK37HU=
From:   Borislav Petkov <bp@alien8.de>
To:     Feng Tang <feng.tang@intel.com>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] tools/x86/kcpuid: Add AMD leaf 0x8000001E
Date:   Mon, 15 Mar 2021 13:59:01 +0100
Message-Id: <20210315125901.30315-2-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210315125901.30315-1-bp@alien8.de>
References: <20210315125901.30315-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Contains core IDs, node IDs and other topology info.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 tools/arch/x86/kcpuid/cpuid.csv | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/tools/arch/x86/kcpuid/cpuid.csv b/tools/arch/x86/kcpuid/cpuid.csv
index dd94c07421a8..4f1c4b0c29e9 100644
--- a/tools/arch/x86/kcpuid/cpuid.csv
+++ b/tools/arch/x86/kcpuid/cpuid.csv
@@ -379,12 +379,22 @@
 0x80000008,    0,  EAX,   15:8, lnr_adr_bits, Linear Address Bits
 0x80000007,    0,  EBX,      9, wbnoinvd, WBNOINVD
 
+# 0x8000001E
+# EAX: Extended APIC ID
+0x8000001E,	0, EAX,   31:0, extended_apic_id, Extended APIC ID
+# EBX: Core Identifiers
+0x8000001E,	0, EBX,    7:0, core_id, Identifies the logical core ID
+0x8000001E,	0, EBX,   15:8, threads_per_core, The number of threads per core is threads_per_core + 1
+# ECX: Node Identifiers
+0x8000001E,	0, ECX,    7:0, node_id, Node ID
+0x8000001E,	0, ECX,   10:8, nodes_per_processor, Nodes per processor { 0: 1 node, else reserved }
+
 # 8000001F: AMD Secure Encryption
-0x8000001F,	0, EAX, 0, sme,	Secure Memory Encryption
-0x8000001F,	0, EAX, 1, sev,	Secure Encrypted Virtualization
-0x8000001F,	0, EAX, 2, vmpgflush, VM Page Flush MSR
-0x8000001F,	0, EAX, 3, seves, SEV Encrypted State
-0x8000001F,	0, EBX, 5:0, c-bit, Page table bit number used to enable memory encryption
-0x8000001F,	0, EBX, 11:6, mem_encrypt_physaddr_width, Reduction of physical address space in bits with SME enabled
-0x8000001F,	0, ECX, 31:0, num_encrypted_guests, Maximum ASID value that may be used for an SEV-enabled guest
-0x8000001F,	0, EDX, 31:0, minimum_sev_asid, Minimum ASID value that must be used for an SEV-enabled, SEV-ES-disabled guest
+0x8000001F,	0, EAX,	     0, sme,	Secure Memory Encryption
+0x8000001F,	0, EAX,      1, sev,	Secure Encrypted Virtualization
+0x8000001F,	0, EAX,      2, vmpgflush, VM Page Flush MSR
+0x8000001F,	0, EAX,      3, seves, SEV Encrypted State
+0x8000001F,	0, EBX,    5:0, c-bit, Page table bit number used to enable memory encryption
+0x8000001F,	0, EBX,   11:6, mem_encrypt_physaddr_width, Reduction of physical address space in bits with SME enabled
+0x8000001F,	0, ECX,   31:0, num_encrypted_guests, Maximum ASID value that may be used for an SEV-enabled guest
+0x8000001F,	0, EDX,   31:0, minimum_sev_asid, Minimum ASID value that must be used for an SEV-enabled, SEV-ES-disabled guest
-- 
2.29.2

