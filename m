Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2CB6405873
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 16:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343578AbhIIOCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 10:02:39 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:35842
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345439AbhIIOBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 10:01:12 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id B9DD2401A4;
        Thu,  9 Sep 2021 13:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631195995;
        bh=k3mt0waMENh6y68J+JpXCf3sDS7Ly3J1EHRKsMbqoIw=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=b7ft1PKlq+dc3a9uungOPU7pCA1XxRYmUobKnhnVFah1qIyi6dJrDBFR+pMXUQ+KH
         XkG4hWIK4dvD5KqBbxXpFE6yyvnlsLH4negNuG8M9MUQMdMmlOGo5rVVhZ7RCVv/K4
         IIVeZrqeE2l+u/vX6oHwKMxY50TY2dsK5I9BEMysJp83UcpWc/lBtIt1VTc58m8+7z
         I0JYU2S8VwZMrFaH34Sfk3P7wDyBwaNcWcgaN+4yK/jC5pCOQiWpU+W0Ju8QtYfedQ
         FVgxGCaSlySyrZ1rCtRG/ESLVrz9lgnkLVOEw9UIzpda9X8yS+5GRt8HOfkC8KQo+D
         MHytnEIzJsxBg==
From:   Colin King <colin.king@canonical.com>
To:     Neil Brown <neilb@suse.de>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] md/raid6 algorithms: scale test duration for speedier boots
Date:   Thu,  9 Sep 2021 14:59:55 +0100
Message-Id: <20210909135955.5881-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The original code runs for a set run time based on the duration of
2^RAID6_TIME_JIFFIES_LG2. The default kernel value for
RAID6_TIME_JIFFIES_LG2 is 4, however, emperical testing shows that a
value of 3.5 is the sweet spot for getting consistent benchmarking
results and speeding up the run time of the benchmarking.

To achieve 2^3.5 we use the following:
   2^3.5 = 2^4 / 2^0.5
         = 2^4 / sqrt(2)
         = 2^4 * 0.707106781

Too keep this as integer math that is as accurate as required and avoiding
overflow, this becomes:
         = 2^4 * 181 / 256
         = (2^4 * 181) >> 8

We also need to scale down perf by the same factor, however, to
get a good approximate integer result without an overflow we scale
by 2^4.0 * sqrt(2) =
         = 2 ^ 4 * 1.41421356237
         = 2 ^ 4 * 1448 / 1024
         = (2 ^ 4 * 1448) >> 10

This has been tested on 2 AWS instances, a small t2 and a medium m3
with 30 boot tests each and compared to the same instances booted 30
times on an umodified kernel. In all results, we get the same
algorithms being selected and a 100% consistent result over the 30
boots, showing that this optimised jiffy timing scaling does not break
the original functionality.

On the t2.small we see a saving of ~0.126 seconds and t3.medium a saving of
~0.18 seconds.

Tested on a 4 CPU VM on an 8 thread Xeon server; seeing a saving of ~0.35
seconds (average over 50 boots).

The testing included double checking the algorithm chosen by the optimized
selection and seeing the same as pre-optimised version.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 lib/raid6/algos.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/lib/raid6/algos.c b/lib/raid6/algos.c
index 6d5e5000fdd7..5d5b04632168 100644
--- a/lib/raid6/algos.c
+++ b/lib/raid6/algos.c
@@ -152,6 +152,10 @@ static inline const struct raid6_calls *raid6_choose_gen(
 
 	for (bestgenperf = 0, bestxorperf = 0, best = NULL, algo = raid6_algos; *algo; algo++) {
 		if (!best || (*algo)->prefer >= best->prefer) {
+			/* 2 ^ (RAID6_TIME_JIFFIES_LG2 - 0.5) */
+			const unsigned long raid6_time_jiffies =
+				((1 << RAID6_TIME_JIFFIES_LG2) * 181) >> 8;
+
 			if ((*algo)->valid && !(*algo)->valid())
 				continue;
 
@@ -167,7 +171,7 @@ static inline const struct raid6_calls *raid6_choose_gen(
 			while ((j1 = jiffies) == j0)
 				cpu_relax();
 			while (time_before(jiffies,
-					    j1 + (1<<RAID6_TIME_JIFFIES_LG2))) {
+					    j1 + raid6_time_jiffies)) {
 				(*algo)->gen_syndrome(disks, PAGE_SIZE, *dptrs);
 				perf++;
 			}
@@ -178,8 +182,8 @@ static inline const struct raid6_calls *raid6_choose_gen(
 				best = *algo;
 			}
 			pr_info("raid6: %-8s gen() %5ld MB/s\n", (*algo)->name,
-				(perf * HZ * (disks-2)) >>
-				(20 - PAGE_SHIFT + RAID6_TIME_JIFFIES_LG2));
+				(((perf * HZ * (disks-2)) >>
+				 (20 - 16 + RAID6_TIME_JIFFIES_LG2)) * 1448) >> 10);
 
 			if (!(*algo)->xor_syndrome)
 				continue;
@@ -191,7 +195,7 @@ static inline const struct raid6_calls *raid6_choose_gen(
 			while ((j1 = jiffies) == j0)
 				cpu_relax();
 			while (time_before(jiffies,
-					    j1 + (1<<RAID6_TIME_JIFFIES_LG2))) {
+					    j1 + raid6_time_jiffies)) {
 				(*algo)->xor_syndrome(disks, start, stop,
 						      PAGE_SIZE, *dptrs);
 				perf++;
@@ -202,8 +206,8 @@ static inline const struct raid6_calls *raid6_choose_gen(
 				bestxorperf = perf;
 
 			pr_info("raid6: %-8s xor() %5ld MB/s\n", (*algo)->name,
-				(perf * HZ * (disks-2)) >>
-				(20 - PAGE_SHIFT + RAID6_TIME_JIFFIES_LG2 + 1));
+				(((perf * HZ * (disks-2)) >>
+				 (20 - 16 + RAID6_TIME_JIFFIES_LG2 + 1)) * 1448) >> 10);
 		}
 	}
 
@@ -215,8 +219,8 @@ static inline const struct raid6_calls *raid6_choose_gen(
 				(20 - PAGE_SHIFT+RAID6_TIME_JIFFIES_LG2));
 			if (best->xor_syndrome)
 				pr_info("raid6: .... xor() %ld MB/s, rmw enabled\n",
-					(bestxorperf * HZ * (disks-2)) >>
-					(20 - PAGE_SHIFT + RAID6_TIME_JIFFIES_LG2 + 1));
+					(((bestxorperf * HZ * (disks-2)) >>
+					 (20 - 16 + RAID6_TIME_JIFFIES_LG2 + 1)) * 1448) >> 10);
 		} else
 			pr_info("raid6: skip pq benchmark and using algorithm %s\n",
 				best->name);
-- 
2.32.0

