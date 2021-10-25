Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7BFE43960A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 14:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233025AbhJYMWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 08:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232881AbhJYMWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 08:22:17 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B22EC061767
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 05:19:55 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id x3so2362686uar.13
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 05:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=zwmpU/4wUBOOjvtzhmHsdtzGo9J9noPc+g2NVU0zBxc=;
        b=zdb7e5wgfnKy23IF9N+nt68OhysvD7UjZ5zDYtdgZ0sivFULWY9/ugfSFeix0JXopS
         ziNYkrV3JAE2eoI6BDjbLHmoKFCYJhdkfryGUfZ1xdgLM9FzxTcSgi1+WnWe8gTYD0/8
         fPAZq4D3xit+HpvCyLjEsQDxQerW6UcSkXtExYFNZwK6CFsRw+1soqeGeq5rhVfpmHv6
         Rvpk8+miDk28wz2oH2daV0v4ZJJCP4OvMBslThVP8Jve9hlzk75Yi+hoyxdHZZ5ShbY8
         OJGl02WdhcSzIg1ke8hQ3ndiRB8p/Cwj/fJrlQFasC0E9Befo3N/NnG2UY1gyauJ61V7
         F5Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=zwmpU/4wUBOOjvtzhmHsdtzGo9J9noPc+g2NVU0zBxc=;
        b=sJ7PS1ISKpzmEkgj2mfvn3cLQaRsijfRbJ/UX6WS1dNneBpO3GYczZDOrawipgDd1/
         sGhfAmHPBWkLiCHaawTJNDnKF2UzndkO/dnh1HTfhXe46BEZKJ7F4z1bkM/ZX9nuCgLW
         a7n9eq5hqk94FohEV2vux3aM3x//35GKLT1LuPj6ApPIOLDOivuOynkJGlIuPOjli2lT
         FOlVEJtkt8fxvk9GMv2dXEQ9QcUqKD42xTJk9P94BBQr1fZYkSeeh2LGlgrnLXIS27+e
         0hqnOij2rJowPs7UUESL55LSu68jUVXIAyAvgv6bMYh1vOmRclc8DAjVRpNmewPIBPAp
         Wkpg==
X-Gm-Message-State: AOAM533U4C3eUG4UM+F5Z0ov9bhbKAzCfJATDSwJ6iZ06MX/2dl+7RE9
        QEU8fVoEB0VWnoK7LNKwhuzU9A2gWfTxy7Rd
X-Google-Smtp-Source: ABdhPJwO0IHmRP033afGZOvNBH76vR6CJDWgHofTo24bK/FSoHv7O6QBDFOMfGnQpyjlLwXwYtmSGA==
X-Received: by 2002:a67:b202:: with SMTP id b2mr14375566vsf.33.1635164394426;
        Mon, 25 Oct 2021 05:19:54 -0700 (PDT)
Received: from Andryuu.br ([2804:431:c7fd:423:9dac:f639:6086:598])
        by smtp.gmail.com with ESMTPSA id ba22sm848466vkb.7.2021.10.25.05.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 05:19:54 -0700 (PDT)
Date:   Mon, 25 Oct 2021 09:19:50 -0300
From:   =?iso-8859-1?Q?Andr=E9?= Gustavo Nakagomi Lopez <andregnl@usp.br>
To:     jic23@kernel.org, lars@metafoo.de, vz@mleia.com
Cc:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] iio: adc: lpc18xx_adc: Reorder clk_get_rate function call
Message-ID: <YXag5l4xBkGQH3tq@Andryuu.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clk_get_rate is not guaranteed to work if called before clk_prepare_enable.

Reorder clk_get_rate, so it's called after clk_prepare_enable and
after devm_add_action_or_reset of lpc18xx_clk_disable.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Acked-by: Vladimir Zapolskiy <vz@mleia.com>
Signed-off-by: André Gustavo Nakagomi Lopez <andregnl@usp.br>
---
Change log V1 -> V2:
		  -Fixed typo
		  -Added appropriate Suggested-by and Acked-by tags
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

