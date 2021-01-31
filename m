Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98FF6309CC9
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 15:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbhAaOTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 09:19:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231944AbhAaN36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 08:29:58 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC88FC06178C;
        Sun, 31 Jan 2021 05:27:51 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id i9so10903145wmq.1;
        Sun, 31 Jan 2021 05:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=w0AjcOnxN+fVVGn+tV+gduZDAkpbNXFgkp5E/FuYeRA=;
        b=V8jquRuFkG92B9NiAwvbKnipL0o12U9sc71/MrVsazR4kIQpND2V1ynYJUBUVT34rn
         g6mu+VW/V+b2wfEzqe8iP0iH4Yb5M9HGHkol7uQltaD43phRWV3eX9QvgvFT7XgH6sqC
         Ez3iCZFnXlIjCG4tOyVhUrXYEM5ufBR+w+etUo+IrqH+Lm4owWuyEUE/tcDZCGl2uY73
         GIxDWbVLhhftxPsiaHxDxsz9mGKI9m0pSG9WHbi5osdiFHJ8JIPzPvQt90Ui7fjq8JfN
         Zt6JsejLXEc1a76amPGTXXhB3cnA0loV5zYEBH1x+mkEI/Frkb4rziXBbs+pLxauu5Bw
         Ep8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=w0AjcOnxN+fVVGn+tV+gduZDAkpbNXFgkp5E/FuYeRA=;
        b=Ltl7P9NRGbazVF7i32Ob9tD5cPlw9oa7vlwdboSz8DgSpiuwJiyohFQuhMuUIPp/nP
         Df+OozA08QNBV52Q+RGhth1Dcmz7BnL5YvOLBn60xu78KiOIldozS/aTeUMalHkDfQti
         HzxLRCa0DZ6QaQ3CoaQP5+sSrZ03SeYMYEXgJ9O5n/BcNcKkFf4S4WZLbejR0PYXBFF5
         bwj2TwaWdr0aZNKUv31sAFhb8zZT3Vw4fOXdlJPaEwwDRyxAlDDfJZBHqQF8i6OmDzXo
         DLV1Vc5WLQ2JoM7D/TC8zgv89wiWksYddkymH7aQsbAybxvhxd5z/Gso1UT6mpM5Gfqb
         qo1g==
X-Gm-Message-State: AOAM532Rnlf1Rz5cH+L+GVxRvsoYRj5wKCpPlV9xlZ3Kmr3i2/4Oj49Z
        ZuQ9u3ol50xoeu8shj6fPrk=
X-Google-Smtp-Source: ABdhPJws8CH4DaeoGzSOwTNOe8P0bjHH0XBzbGAG8etRS+DruKxNIPlbIz5lZhPG5dZwQr1wpu1Uvw==
X-Received: by 2002:a1c:2501:: with SMTP id l1mr11061166wml.41.1612099670275;
        Sun, 31 Jan 2021 05:27:50 -0800 (PST)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id b11sm22538263wrp.60.2021.01.31.05.27.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jan 2021 05:27:49 -0800 (PST)
Subject: Re: [PATCH 0/2] Add MediaTek MT8192 clock provider device nodes
To:     Weiyi Lu <weiyi.lu@mediatek.com>, Rob Herring <robh@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-clk@vger.kernel.org, srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <1608644414-17793-1-git-send-email-weiyi.lu@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <4536e0a3-8e64-d2b0-df83-33705d10359a@gmail.com>
Date:   Sun, 31 Jan 2021 14:27:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <1608644414-17793-1-git-send-email-weiyi.lu@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/12/2020 14:40, Weiyi Lu wrote:
> This series is based on v5.10-rc1, MT8192 dts v6[1] and
> MT8192 clock v6 series[2].
> 
> [1] https://patchwork.kernel.org/project/linux-mediatek/list/?series=373899
> [2] https://patchwork.kernel.org/project/linux-mediatek/list/?series=405295
> 

[1] is already mainline. You could add this patch as a new one to [2]. But
please try to improve the series, before sending just a new version with this
patch added.

Regards,
Matthias

> Weiyi Lu (2):
>   arm64: dts: mediatek: Add mt8192 clock controllers
>   arm64: dts: mediatek: Correct UART0 bus clock of MT8192
> 
>  arch/arm64/boot/dts/mediatek/mt8192.dtsi | 165 ++++++++++++++++++++++-
>  1 file changed, 164 insertions(+), 1 deletion(-)
> 
