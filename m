Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52B3F3E2EE7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 19:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241357AbhHFRfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 13:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241285AbhHFRfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 13:35:06 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC40C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Aug 2021 10:34:49 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id z4so12019714wrv.11
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 10:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gV269OIUhGTszW6Q8c+CYkGmUwrY5qfXqHnqAFsmSzA=;
        b=utNyYGZ+djwSEXtVwd3D4fowWShjRbQriv9sgUerDLdjj3US8bktFZlwMBygR2q4z7
         u9dOKN3DD7xDtziBa3EftFmyCmfzax3i1jb2iR1Bzzya0RhYOEHUNLZmKxBNSks5AqHe
         lgIiMO4R4x3kqe/SfuUpXu5fKdnZHIoRMObnd/WRAxgK0AGkDavMsajg/Qm4P0Fix/Px
         LKCrqR3TL50j9kTpyGqrOR2M74di1m8jMl09uKa3qAbm6AW+Muc/iE7Wrn8H/c/dXY/N
         zKq1PwsytRJgrHB6dcueS9fxl976/1ckPcL1jTS/Sw9sS5w0kw3XeDdD9AsXvYyqK/c8
         yVIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gV269OIUhGTszW6Q8c+CYkGmUwrY5qfXqHnqAFsmSzA=;
        b=VbGtXX9bRSkZ9fmXSBYKr1r3QS6wATmDuwd2UK/5bvNqd6LCU24FZ9KtH5nPi7UMji
         LGlsVnbhsOS78QrLNGxDLw/iMoSerxovEkMmb6isvC0fdIjunu1NkfPu4qXroUpBn1ig
         2YDjrnAVpWwKPuPhCWUfYKD7EMRCH5XF1yoqhPm11j5ZhXOpr40gW5yzz7Th2cWVxmQA
         bmNiWx7GKrcDcEo+CQt7LrfwdGQOu2+3IkNJKjZSpPSMeA1/z8PC9MXfut2TVDbjqG0q
         R9KabDB5YntexeJNeKl4ECi4fcwLXlvXjmPCVLA1DkygUqh47gN1b3pLvIyjx/LqgHkz
         DNSw==
X-Gm-Message-State: AOAM532N6BeBLPHJElzLtk2tHyg3jYguMdr1evQXGz30pTp0WqiMQTBp
        1yCU9fEta9qenk7LAxJQ8iQ=
X-Google-Smtp-Source: ABdhPJy5hRKXobHagFL31FeoP4BBTEq9NAEGv6N3mFMMrYd2T20tIldbtQDUo0iGUjBgFsneu5wqEQ==
X-Received: by 2002:adf:f544:: with SMTP id j4mr12260576wrp.51.1628271288260;
        Fri, 06 Aug 2021 10:34:48 -0700 (PDT)
Received: from ziggy.stardust (static-55-132-6-89.ipcom.comunitel.net. [89.6.132.55])
        by smtp.gmail.com with ESMTPSA id p15sm9060219wmi.29.2021.08.06.10.34.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Aug 2021 10:34:47 -0700 (PDT)
Subject: Re: [PATCH v2 6/7] soc: mediatek: mmsys: Add reset controller support
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org
Cc:     chunkuang.hu@kernel.org, hsinyi@chromium.org, kernel@collabora.com,
        drinkcat@chromium.org, eizan@chromium.org,
        linux-mediatek@lists.infradead.org, jitao.shi@mediatek.com,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org
References: <20210714101141.2089082-1-enric.balletbo@collabora.com>
 <20210714121116.v2.6.I15e2419141a69b2e5c7e700c34d92a69df47e04d@changeid>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <91bee4b6-2b43-e4ef-52ab-72e4e0b0c7b3@gmail.com>
Date:   Fri, 6 Aug 2021 19:34:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210714121116.v2.6.I15e2419141a69b2e5c7e700c34d92a69df47e04d@changeid>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/07/2021 12:11, Enric Balletbo i Serra wrote:
> Among other features the mmsys driver should implement a reset
> controller to be able to reset different bits from their space.
> 
> Cc: Jitao Shi <jitao.shi@mediatek.com>
> Suggested-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

I'm happy to take this, as soon as we have the updated binding description.

Regards,
Matthias

> ---
> 
> (no changes since v1)
> 
>  drivers/soc/mediatek/mtk-mmsys.c | 69 ++++++++++++++++++++++++++++++++
>  drivers/soc/mediatek/mtk-mmsys.h |  2 +
>  2 files changed, 71 insertions(+)
> 
> diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-mmsys.c
> index e681029fe804..6ac4deff0164 100644
> --- a/drivers/soc/mediatek/mtk-mmsys.c
> +++ b/drivers/soc/mediatek/mtk-mmsys.c
> @@ -4,10 +4,12 @@
>   * Author: James Liao <jamesjj.liao@mediatek.com>
>   */
>  
> +#include <linux/delay.h>
>  #include <linux/device.h>
>  #include <linux/io.h>
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
> +#include <linux/reset-controller.h>
>  #include <linux/soc/mediatek/mtk-mmsys.h>
>  
>  #include "mtk-mmsys.h"
> @@ -55,6 +57,8 @@ static const struct mtk_mmsys_driver_data mt8183_mmsys_driver_data = {
>  struct mtk_mmsys {
>  	void __iomem *regs;
>  	const struct mtk_mmsys_driver_data *data;
> +	spinlock_t lock; /* protects mmsys_sw_rst_b reg */
> +	struct reset_controller_dev rcdev;
>  };
>  
>  void mtk_mmsys_ddp_connect(struct device *dev,
> @@ -91,6 +95,59 @@ void mtk_mmsys_ddp_disconnect(struct device *dev,
>  }
>  EXPORT_SYMBOL_GPL(mtk_mmsys_ddp_disconnect);
>  
> +static int mtk_mmsys_reset_update(struct reset_controller_dev *rcdev, unsigned long id,
> +				  bool assert)
> +{
> +	struct mtk_mmsys *mmsys = container_of(rcdev, struct mtk_mmsys, rcdev);
> +	unsigned long flags;
> +	u32 reg;
> +	int i;
> +
> +	spin_lock_irqsave(&mmsys->lock, flags);
> +
> +	reg = readl_relaxed(mmsys->regs + MMSYS_SW0_RST_B);
> +
> +	if (assert)
> +		reg &= ~BIT(id);
> +	else
> +		reg |= BIT(id);
> +
> +	writel_relaxed(reg, mmsys->regs + MMSYS_SW0_RST_B);
> +
> +	spin_unlock_irqrestore(&mmsys->lock, flags);
> +
> +	return 0;
> +}
> +
> +static int mtk_mmsys_reset_assert(struct reset_controller_dev *rcdev, unsigned long id)
> +{
> +	return mtk_mmsys_reset_update(rcdev, id, true);
> +}
> +
> +static int mtk_mmsys_reset_deassert(struct reset_controller_dev *rcdev, unsigned long id)
> +{
> +	return mtk_mmsys_reset_update(rcdev, id, false);
> +}
> +
> +static int mtk_mmsys_reset(struct reset_controller_dev *rcdev, unsigned long id)
> +{
> +	int ret;
> +
> +	ret = mtk_mmsys_reset_assert(rcdev, id);
> +	if (ret)
> +		return ret;
> +
> +	usleep_range(1000, 1100);
> +
> +	return mtk_mmsys_reset_deassert(rcdev, id);
> +}
> +
> +static const struct reset_control_ops mtk_mmsys_reset_ops = {
> +	.assert = mtk_mmsys_reset_assert,
> +	.deassert = mtk_mmsys_reset_deassert,
> +	.reset = mtk_mmsys_reset,
> +};
> +
>  static int mtk_mmsys_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -111,6 +168,18 @@ static int mtk_mmsys_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> +	spin_lock_init(&mmsys->lock);
> +
> +	mmsys->rcdev.owner = THIS_MODULE;
> +	mmsys->rcdev.nr_resets = 32;
> +	mmsys->rcdev.ops = &mtk_mmsys_reset_ops;
> +	mmsys->rcdev.of_node = pdev->dev.of_node;
> +	ret = devm_reset_controller_register(&pdev->dev, &mmsys->rcdev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Couldn't register mmsys reset controller: %d\n", ret);
> +		return ret;
> +	}
> +
>  	mmsys->data = of_device_get_match_data(&pdev->dev);
>  	platform_set_drvdata(pdev, mmsys);
>  
> diff --git a/drivers/soc/mediatek/mtk-mmsys.h b/drivers/soc/mediatek/mtk-mmsys.h
> index 11388961dded..f9f9e12ceab8 100644
> --- a/drivers/soc/mediatek/mtk-mmsys.h
> +++ b/drivers/soc/mediatek/mtk-mmsys.h
> @@ -66,6 +66,8 @@
>  #define DPI_SEL_IN_BLS				0x0
>  #define DSI_SEL_IN_RDMA				0x1
>  
> +#define MMSYS_SW0_RST_B				0x140
> +
>  struct mtk_mmsys_routes {
>  	u32 from_comp;
>  	u32 to_comp;
> 
