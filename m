Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5099E331479
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 18:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbhCHRTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 12:19:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbhCHRSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 12:18:37 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57642C06174A;
        Mon,  8 Mar 2021 09:18:37 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id jt13so21974486ejb.0;
        Mon, 08 Mar 2021 09:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RYsjPradGS8ApOPyI0o2lRWvUZqCfCUNgbBO342kp4Q=;
        b=WFVDT5yLvxXAwsyNBe5017cELXgSwobsqxLtI0ALi9P7YAmc7XBwB0th17LXaLunBf
         P9fxgX4AvBZtq1g4Nf5j5x6uXTWC0Beo/qC5XrwVyknkSP5VGiUJVNLnoaOwC7topATX
         tvZFMvD/X35InooOJDakHU5BvAC5XjGHyWq9lPA6rhDySRI13rvP/yRz3hEQkT2OLHKI
         YGV7y4O2fko4r1jZYVI1OvT9bJAFqtxGYTSCnn8QaI/P5dVtNlPbeqwE5GGRVVH2QX7k
         wqn+2fERuy7TAw6zn9klJP5SVCIHKHt5YVon7Yib5chHjPEv+/oxMeYt3zUbKupQjywX
         dAng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RYsjPradGS8ApOPyI0o2lRWvUZqCfCUNgbBO342kp4Q=;
        b=cTjQl3HjTPipZHAN/s1UDcCmgFEqOhvHuLq+L/3k0wgsmFdEmmpawdIOJ9EsYGNow7
         vjeeFth808aGuV22Y2lIJgmx5IhvcMjNE5mvz+rO+c4aSR39Nh7M0B3AHhlumBwOTyro
         L/iLvIFrjdf636C/XXtqbFI50prP8kM/IyjGwGNIaHgcPfpgnkAKFMGYCAxtsHSV/mBJ
         oIUCNDSXT/PaT37JYXWNCbT+4U2RS/c4cWc+TRi4a90Y1j9DLWNAahqhdQ+pToIv+0+U
         Is8bplJawgPfNbHAInLIBTKoeL8UgUXDQiTaOJFGqjTAEGaKYIDv56XYeDGNyhFhEyhB
         sb6Q==
X-Gm-Message-State: AOAM532dmwIvRJ0fm9QRkXy17N5DAuAdEt5n7+tamz0bqfJOWJ4rzASV
        hNCkS573HZcGe++9HMZQxXY=
X-Google-Smtp-Source: ABdhPJwOXycXsakFZ72cmFhDJv2CT4lqQGXyjHAmlC9rE9RmeAhJg7UTiveMAZKyG17GFOGn7fRiAQ==
X-Received: by 2002:a17:906:90d8:: with SMTP id v24mr15741412ejw.547.1615223916111;
        Mon, 08 Mar 2021 09:18:36 -0800 (PST)
Received: from localhost.localdomain ([81.18.95.223])
        by smtp.gmail.com with ESMTPSA id r5sm7457714eds.49.2021.03.08.09.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 09:18:35 -0800 (PST)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Edgar Bernardi Righi <edgar.righi@lsitec.org.br>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 2/6] clk: actions: Fix SD clocks factor table on Owl S500 SoC
Date:   Mon,  8 Mar 2021 19:18:27 +0200
Message-Id: <973b08fe414321ba4ade096a4917cadc2013426e.1615221459.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1615221459.git.cristian.ciocaltea@gmail.com>
References: <cover.1615221459.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the unsupported entries in the factor table used for the SD[0-2]
clocks definitions on the Actions Semi Owl S500 SoC.

Fixes: ed6b4795ece4 ("clk: actions: Add clock driver for S500 SoC")
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
---
 drivers/clk/actions/owl-s500.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/clk/actions/owl-s500.c b/drivers/clk/actions/owl-s500.c
index 75b7186185b0..69cd959205f5 100644
--- a/drivers/clk/actions/owl-s500.c
+++ b/drivers/clk/actions/owl-s500.c
@@ -127,8 +127,6 @@ static struct clk_factor_table sd_factor_table[] = {
 	{ 12, 1, 13 }, { 13, 1, 14 }, { 14, 1, 15 }, { 15, 1, 16 },
 	{ 16, 1, 17 }, { 17, 1, 18 }, { 18, 1, 19 }, { 19, 1, 20 },
 	{ 20, 1, 21 }, { 21, 1, 22 }, { 22, 1, 23 }, { 23, 1, 24 },
-	{ 24, 1, 25 }, { 25, 1, 26 }, { 26, 1, 27 }, { 27, 1, 28 },
-	{ 28, 1, 29 }, { 29, 1, 30 }, { 30, 1, 31 }, { 31, 1, 32 },
 
 	/* bit8: /128 */
 	{ 256, 1, 1 * 128 }, { 257, 1, 2 * 128 }, { 258, 1, 3 * 128 }, { 259, 1, 4 * 128 },
@@ -137,8 +135,6 @@ static struct clk_factor_table sd_factor_table[] = {
 	{ 268, 1, 13 * 128 }, { 269, 1, 14 * 128 }, { 270, 1, 15 * 128 }, { 271, 1, 16 * 128 },
 	{ 272, 1, 17 * 128 }, { 273, 1, 18 * 128 }, { 274, 1, 19 * 128 }, { 275, 1, 20 * 128 },
 	{ 276, 1, 21 * 128 }, { 277, 1, 22 * 128 }, { 278, 1, 23 * 128 }, { 279, 1, 24 * 128 },
-	{ 280, 1, 25 * 128 }, { 281, 1, 26 * 128 }, { 282, 1, 27 * 128 }, { 283, 1, 28 * 128 },
-	{ 284, 1, 29 * 128 }, { 285, 1, 30 * 128 }, { 286, 1, 31 * 128 }, { 287, 1, 32 * 128 },
 	{ 0, 0, 0 },
 };
 
-- 
2.30.1

