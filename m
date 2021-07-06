Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2B803BD46C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 14:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239529AbhGFMJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 08:09:09 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56353 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238318AbhGFLuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 07:50:02 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <colin.king@canonical.com>)
        id 1m0jWT-0006JW-8k; Tue, 06 Jul 2021 11:45:53 +0000
From:   Colin King <colin.king@canonical.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] perf/x86/intel/uncore: Fix integer overflow on 23 bit left shift of a u32
Date:   Tue,  6 Jul 2021 12:45:53 +0100
Message-Id: <20210706114553.28249-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The u32 variable pci_dword is being masked with 0x1fffffff and then left
shifted 23 places. The shift is a u32 operation,so a value of 0x200 or
more in pci_dword will overflow the u32 and only the bottow 32 bits
are assigned to addr. I don't believe this was the original intent.
Fix this by casting pci_dword to a resource_size_t to ensure no
overflow occurs.

Note that the mask and 12 bit left shift operation does not need this
because the mask SNR_IMC_MMIO_MEM0_MASK and shift is always a 32 bit
value.

Fixes: ee49532b38dd ("perf/x86/intel/uncore: Add IMC uncore support for Snow Ridge")
Addresses-Coverity: ("Unintentional integer overflow")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 arch/x86/events/intel/uncore_snbep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 48419dad3b17..7518143850df 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -4827,7 +4827,7 @@ static int snr_uncore_mmio_map(struct intel_uncore_box *box,
 		return -ENODEV;
 
 	pci_read_config_dword(pdev, SNR_IMC_MMIO_BASE_OFFSET, &pci_dword);
-	addr = (pci_dword & SNR_IMC_MMIO_BASE_MASK) << 23;
+	addr = ((resource_size_t)pci_dword & SNR_IMC_MMIO_BASE_MASK) << 23;
 
 	pci_read_config_dword(pdev, mem_offset, &pci_dword);
 	addr |= (pci_dword & SNR_IMC_MMIO_MEM0_MASK) << 12;
-- 
2.31.1

