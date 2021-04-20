Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34560365B2A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 16:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232756AbhDTOaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 10:30:03 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44992 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232304AbhDTOaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 10:30:00 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1lYrNE-0000GO-5a; Tue, 20 Apr 2021 14:29:08 +0000
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
        George Dunlap <george.dunlap@eu.citrix.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] perf/x86: Fix integer overflow when left shifting an integer more than 32 bits
Date:   Tue, 20 Apr 2021 15:29:07 +0100
Message-Id: <20210420142907.382417-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The 64 bit value read from MSR_ARCH_PERFMON_FIXED_CTR_CTRL is being
bit-wise masked with the value (0x03 << i*4). However, the shifted value
is evaluated using 32 bit arithmetic, so will overflow when i > 8.
Fix this by making 0x03 a ULL so that the shift is performed using
64 bit arithmetic.

Addresses-Coverity: ("Unintentional integer overflow")
Fixes: a5ebe0ba3dff ("perf/x86: Check all MSRs before passing hw check")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 arch/x86/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index bafd93c54ffa..59c665c8c2e9 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -261,7 +261,7 @@ static bool check_hw_exists(void)
 		for (i = 0; i < x86_pmu.num_counters_fixed; i++) {
 			if (fixed_counter_disabled(i))
 				continue;
-			if (val & (0x03 << i*4)) {
+			if (val & (0x03ULL << i*4)) {
 				bios_fail = 1;
 				val_fail = val;
 				reg_fail = reg;
-- 
2.30.2

