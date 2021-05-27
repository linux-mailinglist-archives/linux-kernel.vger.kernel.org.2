Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95AE7392F43
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 15:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236408AbhE0NSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 09:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236379AbhE0NSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 09:18:25 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52794C0613CE;
        Thu, 27 May 2021 06:16:51 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id e12so52961ejt.3;
        Thu, 27 May 2021 06:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=crig0bzSf2SgCM+EYnsItW6y8m075yiQFudfhyHny3Y=;
        b=r3zXf9PXJyaSQoeJL0J7o4RLGNp5T8/of+o46r92qRwQKZ1BWDPxsELPIOQGpGmiqe
         J6HLZ9bdg6F1GGSvs72BLDYYzV7pyCsY5BkYsMQITnRb2/Wad4ntcqUDG4JpYvGZG59u
         UkqdNJqpw8IuRywypTBg2tXJ4Ef627VrmCDxiBf+OBtCMUz6mW7A6L0EvX2GR1Mqub72
         iVVLFi0s+1IRBTKOdT9FBAQLB5lDnV7NkZx9E/DqUfUFSbqewPdBwhlv+vVX0Z8YDVqp
         6HVFjptIyTqPIuHTfaJMAY40nyumpfu7pR+TEQ+2c5q1UaDt08p5v661Eyf+g1UYslRN
         Y3TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=crig0bzSf2SgCM+EYnsItW6y8m075yiQFudfhyHny3Y=;
        b=F0AClPp1NhjckdTcZOVIYMqGESwc55p4DGFVbZCOjgMJWoJ4TTn4U3TcoTx/teTYEy
         /LU1RVcKrBqTjlPnTPnz97ZVebjFNrkHAn3xS+br4sZOV3CHuc/cXmXprc8cVt9tHn6b
         fvy+l6w+u4JhrlYQUpFSHXjWeTy6zH89u+WRZdUEy4vobiOHakTFXxauJ2uxG96a3cNm
         9ogTA9/Yg4XN53qjYs3Gp4jfKBq4SAv17yuZ//HDrGpmikzRUgxLUYrysdmQUx3JYHeO
         bkE8MTF0glxFBgnhytko+Vd7PkHjKluN5rJs2xI8hBxuDSQ2nElvIahlhm9FIMloIen4
         WCIw==
X-Gm-Message-State: AOAM5331HZMagK6JovoEtdzUadmkStmMAfrKGz622pizeGmZp6CLC2kE
        DlHewuNs4H+wyZFlhqAnY9gcwpEscTE=
X-Google-Smtp-Source: ABdhPJzWexKK6TMKAp90yIfRFCp6HKY74EqmgszOQNQRVH1ZHIm9OHCpUKYJvMuf5POc2v8mscTVgA==
X-Received: by 2002:a17:906:3715:: with SMTP id d21mr3883315ejc.34.1622121409962;
        Thu, 27 May 2021 06:16:49 -0700 (PDT)
Received: from localhost.localdomain ([188.24.140.160])
        by smtp.gmail.com with ESMTPSA id r23sm1104206edq.59.2021.05.27.06.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 06:16:49 -0700 (PDT)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Edgar Bernardi Righi <edgar.righi@lsitec.org.br>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 2/6] clk: actions: Fix SD clocks factor table on Owl S500 SoC
Date:   Thu, 27 May 2021 16:16:40 +0300
Message-Id: <ca94fddbb790d2c4de25213c65e306f497e119e7.1622119892.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1622119892.git.cristian.ciocaltea@gmail.com>
References: <cover.1622119892.git.cristian.ciocaltea@gmail.com>
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
Changes in v2:
 - Re-added entry "{ 24, 1, 25 }" to sd_factor_table, according to the
   datasheet (V1.8+), this is a valid divider

 drivers/clk/actions/owl-s500.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/actions/owl-s500.c b/drivers/clk/actions/owl-s500.c
index 75b7186185b0..42abdf964044 100644
--- a/drivers/clk/actions/owl-s500.c
+++ b/drivers/clk/actions/owl-s500.c
@@ -127,8 +127,7 @@ static struct clk_factor_table sd_factor_table[] = {
 	{ 12, 1, 13 }, { 13, 1, 14 }, { 14, 1, 15 }, { 15, 1, 16 },
 	{ 16, 1, 17 }, { 17, 1, 18 }, { 18, 1, 19 }, { 19, 1, 20 },
 	{ 20, 1, 21 }, { 21, 1, 22 }, { 22, 1, 23 }, { 23, 1, 24 },
-	{ 24, 1, 25 }, { 25, 1, 26 }, { 26, 1, 27 }, { 27, 1, 28 },
-	{ 28, 1, 29 }, { 29, 1, 30 }, { 30, 1, 31 }, { 31, 1, 32 },
+	{ 24, 1, 25 },
 
 	/* bit8: /128 */
 	{ 256, 1, 1 * 128 }, { 257, 1, 2 * 128 }, { 258, 1, 3 * 128 }, { 259, 1, 4 * 128 },
@@ -137,8 +136,7 @@ static struct clk_factor_table sd_factor_table[] = {
 	{ 268, 1, 13 * 128 }, { 269, 1, 14 * 128 }, { 270, 1, 15 * 128 }, { 271, 1, 16 * 128 },
 	{ 272, 1, 17 * 128 }, { 273, 1, 18 * 128 }, { 274, 1, 19 * 128 }, { 275, 1, 20 * 128 },
 	{ 276, 1, 21 * 128 }, { 277, 1, 22 * 128 }, { 278, 1, 23 * 128 }, { 279, 1, 24 * 128 },
-	{ 280, 1, 25 * 128 }, { 281, 1, 26 * 128 }, { 282, 1, 27 * 128 }, { 283, 1, 28 * 128 },
-	{ 284, 1, 29 * 128 }, { 285, 1, 30 * 128 }, { 286, 1, 31 * 128 }, { 287, 1, 32 * 128 },
+	{ 280, 1, 25 * 128 },
 	{ 0, 0, 0 },
 };
 
-- 
2.31.1

