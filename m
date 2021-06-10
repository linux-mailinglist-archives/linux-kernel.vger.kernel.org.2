Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3A63A348F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 22:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbhFJUIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 16:08:43 -0400
Received: from mail-ed1-f46.google.com ([209.85.208.46]:43878 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbhFJUIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 16:08:42 -0400
Received: by mail-ed1-f46.google.com with SMTP id s6so34480878edu.10;
        Thu, 10 Jun 2021 13:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yec5z1rTz/gbfswMoHozIs3lpOfgznp00BzpVVk/Y+g=;
        b=NOuXijbMtdHHPd9iVu7KVaqKOLJiCO6mDkLyrAfA8TCBEgbaNfOZSGejLdDs1wzAlu
         3grHvfoY1U2GHv23+pdNMdpFQ/2UWGtam+AwbP/Ss2BkbD12kZlc49W3LRrWBjkWD2Zh
         zKyPwuA4UD7FL7RJvdIZ5jwk++z6gWCgiNsOvnfiRJzj+dSYOkIlnx/YB1F6G+pNu1kk
         OnzVNL4lDTTM05/aWhmItgYIp5TyT0iXLmRKSryvTxd9rr1a+HJvQa4vbDDDehMaotMT
         qcsdRITcR49C+Bv5Ig44Rzib47bLAM2dadY1vkLAZzeShDiItV89QZMuZkPgt7nEAHil
         z7jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yec5z1rTz/gbfswMoHozIs3lpOfgznp00BzpVVk/Y+g=;
        b=Y1QTbiOnXNPd/XE9J9DCtlv7hhLzKBZ8CHEA5U6tNVxIsaNO0tDSSRJk7zEFJRAwcm
         v1avkRplsHN4Inip7BWZ0zlQ2RreQFFm5qc8+DmaeQMfTUW1AOw0L1JehAMk+TQ9oSlt
         aIjQnrdBRRibPpuyLieE5OWAB2WCgPh2UJTRCiHb+7HhExbm6dnAow4yEPMmeDFE5y2z
         ROLbdjZzwRauvNe2LJJQWtX6N9B8GmPz8IwCzYSAkKXAzS3IrZpkJQelBHqihRLgf2nm
         q+CN1/BwqeNq6TF/2VQBd1zvIwtMqvAJGXk7LIHS6zBcT1jQpGPqLUeD/VKU60xnqNuZ
         umTw==
X-Gm-Message-State: AOAM5334GBJ/9pOBV9cJ3x+305UTJtlvWbKm5bMJcY1msIZy4fqSWeUy
        /3FfwNN6e5kT7TGY1qVvNlU=
X-Google-Smtp-Source: ABdhPJw8ysHlGGhrLeKg1ByZDwKEQ4Hrf+NERoFbfhuIwwdHbUN7ir+SmisAX+3iBZdTEAx9aU5IhA==
X-Received: by 2002:aa7:c753:: with SMTP id c19mr194068eds.33.1623355531760;
        Thu, 10 Jun 2021 13:05:31 -0700 (PDT)
Received: from localhost.localdomain ([188.24.178.25])
        by smtp.gmail.com with ESMTPSA id du7sm1800978edb.1.2021.06.10.13.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 13:05:31 -0700 (PDT)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Edgar Bernardi Righi <edgar.righi@lsitec.org.br>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v3 2/6] clk: actions: Fix SD clocks factor table on Owl S500 SoC
Date:   Thu, 10 Jun 2021 23:05:22 +0300
Message-Id: <196c948d708a22b8198c95f064a0f6b6820f9980.1623354574.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1623354574.git.cristian.ciocaltea@gmail.com>
References: <cover.1623354574.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the unsupported entries in the factor table used for the SD[0-2]
clocks definitions on the Actions Semi Owl S500 SoC.

Fixes: ed6b4795ece4 ("clk: actions: Add clock driver for S500 SoC")
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
Changes in v3:
 - Added Reviewed-by tag from Mani

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
2.32.0

