Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A33823401AD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 10:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbhCRJPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 05:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbhCRJOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 05:14:53 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD8CC061760
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 02:14:53 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id b9so4676404wrt.8
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 02:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:cc:references:from:subject:message-id:date:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=WwfwygZ0uyO/8qnwByDJeqKuIzR1LpilYHqI7Bczxo8=;
        b=uUyOQOXeDjrR28SpCD0JA/vq1e3Sml4lVpehemL4k+jNHeSJBExwZLl5xy6cDaoE88
         gKg1vR0b7fxBR5sY6uNxRGxI9OAKBnuS2/zLKqH8bSg4PjuXAOruyYW4XE5TgeJ9QDEz
         P7e7cL9HioJlbXpjNbu7vHym3l4pm1C1O5psBsH/sBtb4EWGx/UrpRs5LZ8wX0zaJQOj
         pWiGWit+PPUinxd+C5Nd0xU2hO3BWY6ix0fTNYJAAViEgew0TlNRLcU5T5GBqqzOi+SP
         dh/2Wgf3/0UlS/m6UK3T0QhbS2SsvTNanQOWyxITmsRTae1HPjXYJBA3eboDRHdbkr9U
         GhJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WwfwygZ0uyO/8qnwByDJeqKuIzR1LpilYHqI7Bczxo8=;
        b=I7BV8oZFpoSUq/aOhAArqitwjyjB5HjVZTEeETnQ0aCOSnD5fxsPnka7wQfkcwheD3
         znfz1clAKcKw6BC6xPFeodu27Q4HMFgpVHcj63kACKuNS3O4Q7hggH/go7HSJVtSrR2K
         WlFbD2/Gb4Nt0w6b8U+/e2GwkNr6Yq8lbMJY46++8GtqPCvI8xl3z9wQeIIcHt43WzDV
         BIhZwAgMIbCbbpRrwIhG+NLUKygn8rrim86doDe53BoU30e2/T6EHfd7KIy1HkpojXoh
         ST7HiLJGMUjaAu/9Z8yNs0DN/F4zBIYVygdYNn1H3L+PTlXw6XpEXoAoAXP6Yraw6YiB
         tcEA==
X-Gm-Message-State: AOAM5315MhbdRJ9gX2dggso6IhmhpZTRSyys5dakwcUxnw4QtwkEBkE0
        /HJ6cK+CCH2w3d3b+T7UcEVg8g==
X-Google-Smtp-Source: ABdhPJwdLMlTIT5VmEKupwPrWeSSoNTJaF3z3AqcVnE8J0jPyMEHT5LG1zTyMrqXoRjGF7sP52krLA==
X-Received: by 2002:a5d:5043:: with SMTP id h3mr8515651wrt.120.1616058891911;
        Thu, 18 Mar 2021 02:14:51 -0700 (PDT)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id l4sm2002873wrt.60.2021.03.18.02.14.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Mar 2021 02:14:51 -0700 (PDT)
To:     Henry Chen <henryc.chen@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Ryan Case <ryandcase@chromium.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Nicolas Boichat <drinkcat@google.com>,
        Fan Chen <fan.chen@mediatek.com>,
        James Liao <jamesjj.liao@mediatek.com>,
        Arvin Wang <arvin.wang@mediatek.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <1614656863-8530-1-git-send-email-henryc.chen@mediatek.com>
 <1614656863-8530-9-git-send-email-henryc.chen@mediatek.com>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [PATCH V9 08/12] interconnect: mediatek: Add interconnect
 provider driver
Message-ID: <cc1d4ea2-22f6-e962-07bc-815ce73b2cb9@linaro.org>
Date:   Thu, 18 Mar 2021 11:14:50 +0200
MIME-Version: 1.0
In-Reply-To: <1614656863-8530-9-git-send-email-henryc.chen@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/2/21 05:47, Henry Chen wrote:
> Introduce Mediatek MT6873/MT8183/MT8192 specific provider driver
> using the interconnect framework.
> 
>              ICC provider         ICC Nodes
>                               ----          ----
>              ---------       |CPU |   |--- |VPU |
>     -----   |         |-----  ----    |     ----
>    |DRAM |--|DRAM     |       ----    |     ----
>    |     |--|scheduler|----- |GPU |   |--- |DISP|
>    |     |--|(EMI)    |       ----    |     ----
>    |     |--|         |       -----   |     ----
>     -----   |         |----- |MMSYS|--|--- |VDEC|
>              ---------        -----   |     ----
>                /|\                    |     ----
>                 |change DRAM freq     |--- |VENC|
>              ----------               |     ----
>             |  DVFSR   |              |
>             |          |              |     ----
>              ----------               |--- |IMG |
>                                       |     ----
>                                       |     ----
>                                       |--- |CAM |
>                                             ----
> Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
> ---
>  drivers/interconnect/Kconfig            |   1 +
>  drivers/interconnect/Makefile           |   1 +
>  drivers/interconnect/mediatek/Kconfig   |  13 ++
>  drivers/interconnect/mediatek/Makefile  |   3 +
>  drivers/interconnect/mediatek/mtk-emi.c | 331 ++++++++++++++++++++++++++++++++
>  5 files changed, 349 insertions(+)
>  create mode 100644 drivers/interconnect/mediatek/Kconfig
>  create mode 100644 drivers/interconnect/mediatek/Makefile
>  create mode 100644 drivers/interconnect/mediatek/mtk-emi.c
[..]
> +++ b/drivers/interconnect/mediatek/mtk-emi.c
> @@ -0,0 +1,331 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2021, The Linux Foundation. All rights reserved.
> + *
> + */
> +
> +#include <linux/device.h>
> +#include <linux/interconnect-provider.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/soc/mediatek/mtk_dvfsrc.h>

The patch looks good to me, but as there is a build dependency I'll wait
until the dvfsrc patches are reviewed/picked by Matthias.

Thanks,
Georgi
