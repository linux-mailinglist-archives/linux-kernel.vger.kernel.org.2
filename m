Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEAB5438BAD
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 21:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbhJXTqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 15:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbhJXTqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 15:46:06 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6319BC061764
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 12:43:45 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id r17so8452211qtx.10
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 12:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=4T1h/6MdNJIw0PPm4TEcxKFEMqXNYmxYZcwSKomTJoU=;
        b=ePhq4DD4vYJwbaIb2ECaxBpkPV3hzJPWQgjoe7AdGOK3R4UGX8PSPO3cv2JFLhDOiv
         w0qhRX0w1yx+rZZIvnzMzcwt7DrgPafaVbOFK5klrrt7G6r87ZwbQauhYcmKPRJXZld5
         fY9qQIxW2x+kqN0VfxP5OtYplUJJgdnvmhiSsRw/8+Owju8F+gkcHZwX74EwazMBKWda
         N2Vp/UENJxPzlHYnDi5X7dzbEq986OQyPekwx+/0XQLrJGJ7disE5iq5ce8TyjIZUdRW
         dXZjWwynf6Z3OEjm1jIHox8dtAAR9IdaqZ61VZElFQLT4RvVq8TLfKE+OehmVotgadpB
         cc8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=4T1h/6MdNJIw0PPm4TEcxKFEMqXNYmxYZcwSKomTJoU=;
        b=I5881pREWqt8DoYGvGxd4Wa4Omn6pytvvLIZcA8LtrpvsOzQiHqR1ynPT+wLNZEKzi
         DasUPJ2CB2WmFhjxuGNjqTrOiF03R3MTtRNKdiLdCgfuUtVmplUgWoI1v0mVI6Mbzbq8
         M3urAYhqWtpgZzZcNlANSIV7aBJTWO/fatDoGOCY0l7ale7mhwQ+fyuivvO5rnjGW42O
         3Czc5Pl4oaOvlEC8V2+9stwvYl8huWhiknQG4Q9qqCjYD/jEvKS+hmlCWMrrAVJzxqxn
         dBGGFKkrp+eBLjnt+r4kghRysPL5yaBdoefOcaEInpdyaNuX49aJTLtT4U2s8cieV7ub
         K5ug==
X-Gm-Message-State: AOAM530doTVJgyAv77urQMS75H2gSRR15DHyoYfexQs2uVuhDl1punLU
        XnZHRSGODWXexjBFXri9NHLo3A==
X-Google-Smtp-Source: ABdhPJyj4j7EzR6DsNeSrBj8n/XeKi48Tc9FcFD/6edaoTvrtJRsPP7TBfb4OJGLA68gn5La79/o3Q==
X-Received: by 2002:ac8:58d3:: with SMTP id u19mr13440124qta.29.1635104624242;
        Sun, 24 Oct 2021 12:43:44 -0700 (PDT)
Received: from Andryuu.br ([2804:431:c7fd:423:9dac:f639:6086:598])
        by smtp.gmail.com with ESMTPSA id m66sm7521178qkb.87.2021.10.24.12.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Oct 2021 12:43:43 -0700 (PDT)
Date:   Sun, 24 Oct 2021 16:43:39 -0300
From:   =?iso-8859-1?Q?Andr=E9?= Gustavo Nakagomi Lopez <andregnl@usp.br>
To:     jic23@kernel.org, lars@metafoo.de, vz@mleia.com
Cc:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, andregnl@usp.br
Subject: [PATCH] iio: adc: lpc18xx_adc: Reorder clk_get_rate function call
Message-ID: <YXW3azIjPzGjvjTX@Andryuu.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clk_get_rate is not garanteed to work if called before clk_prepare_enable.

Reorder clk_get_rate, so it's called after clk_prepare_enable and
after devm_add_action_or_reset of lpc18xx_clk_disable.

Signed-off-by: André Gustavo Nakagomi Lopez <andregnl@usp.br>
---
 drivers/iio/adc/lpc18xx_adc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/lpc18xx_adc.c b/drivers/iio/adc/lpc18xx_adc.c
index ceefa4d793cf..ae9c9384f23e 100644
--- a/drivers/iio/adc/lpc18xx_adc.c
+++ b/drivers/iio/adc/lpc18xx_adc.c
@@ -157,9 +157,6 @@ static int lpc18xx_adc_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(adc->clk),
 				     "error getting clock\n");
 
-	rate = clk_get_rate(adc->clk);
-	clkdiv = DIV_ROUND_UP(rate, LPC18XX_ADC_CLK_TARGET);
-
 	adc->vref = devm_regulator_get(&pdev->dev, "vref");
 	if (IS_ERR(adc->vref))
 		return dev_err_probe(&pdev->dev, PTR_ERR(adc->vref),
@@ -192,6 +189,9 @@ static int lpc18xx_adc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	rate = clk_get_rate(adc->clk);
+	clkdiv = DIV_ROUND_UP(rate, LPC18XX_ADC_CLK_TARGET);
+
 	adc->cr_reg = (clkdiv << LPC18XX_ADC_CR_CLKDIV_SHIFT) |
 			LPC18XX_ADC_CR_PDN;
 	writel(adc->cr_reg, adc->base + LPC18XX_ADC_CR);
-- 
2.33.0

