Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C22A7391301
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 10:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233121AbhEZIw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 04:52:27 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50918 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232617AbhEZIw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 04:52:26 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <colin.king@canonical.com>)
        id 1llpFZ-0001IQ-Ir; Wed, 26 May 2021 08:50:49 +0000
From:   Colin King <colin.king@canonical.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Trent Piepho <tpiepho@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] lib/math/rational: Fix spelling mistake "demominator" -> "denominator"
Date:   Wed, 26 May 2021 09:50:49 +0100
Message-Id: <20210526085049.6393-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a literal string. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 lib/math/rational-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/math/rational-test.c b/lib/math/rational-test.c
index df6ab5f43e8c..01611ddff420 100644
--- a/lib/math/rational-test.c
+++ b/lib/math/rational-test.c
@@ -20,7 +20,7 @@ static const struct rational_test_param test_parameters[] = {
 	{ 27,32,	16, 16,		11, 13,    "Use convergent" },
 	{ 1155, 7735,	255, 255,	33, 221,   "Exact answer" },
 	{ 87, 32,	70, 32,		68, 25,    "Semiconvergent, numerator limit" },
-	{ 14533, 4626,	15000, 2400,	7433, 2366, "Semiconvergent, demominator limit" },
+	{ 14533, 4626,	15000, 2400,	7433, 2366, "Semiconvergent, denominator limit" },
 };
 
 static void get_desc(const struct rational_test_param *param, char *desc)
-- 
2.31.1

