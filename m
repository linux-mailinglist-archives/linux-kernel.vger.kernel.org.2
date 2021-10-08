Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2069426A1A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 13:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241564AbhJHLta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 07:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243968AbhJHLtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 07:49:19 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6FB5C029804;
        Fri,  8 Oct 2021 04:37:24 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id i12so16253151wrb.7;
        Fri, 08 Oct 2021 04:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=nhVv3Nu8L78RD8tuH9ekjolQi0/WLnSIsU3PjboDD2E=;
        b=cyG5X880niFfEcC+hw3EYtl11pMrvkr/xcfUgwlo2MDTSIFyu0/rBR6x0eaCFvTYbx
         YJXuPIHqh8x7zwEC8NaEN5Pu/0lvQ/kerYIDsHWNqKtv2/qAiIAeLfkVcTsA/CVnc5gy
         1ovf3PmLXqteGvQmeJff/Bf4clkKNoxIHkOjEAZX6Kx5aF41hxN2b61RXcU7PuV+Sw/K
         3v32ot+h2DkQJFm1pH4jeV2r/96PsTFkiyZovKXT+TRhbclkNVhvJaeI0pTCFJn6P6Dy
         Pr1IRn4Lts9Q0ozAU8NKc70PsyZkKEpSQrGlS9NosYAT+EWClUbg5ZxZRjvAc+eqfUaL
         DTcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nhVv3Nu8L78RD8tuH9ekjolQi0/WLnSIsU3PjboDD2E=;
        b=aUqil68MxtyMktSsrm5C3HsLwSlybfxc3I4y5G9rg+FgRqlaDV8bzcH+1x4g2/CJN5
         Ds2NO8BfhNjFdZztNzGhik9ReepAAR3//yfFdGk4CtOo+WCfR4MsmCC4ZJxhlICU6QOV
         XSaAbucYzCcRTptOoTb7f7uRqqBIi7RM/OVcTNp1E+690wocowglNTCLcfGdCkiHGOtj
         fjmy6z7kwQ7Ml5CxCa1ptFcHQiRFF3mGFQGYXDWoc/4F0dUDe/txUTy8pJhIs//8B9Lb
         NymAez8195IBABqrVpOahAbs2KrNJrKKwPfGGbmIyNbEM1EV3CI+rppEj9VWhiTyNc+Q
         ylUg==
X-Gm-Message-State: AOAM530GXOur7GgqkSCjOdS2tytK+zUV4nLopWTIfH/Km1f6n+CA1gbD
        3qhSyEKskaXqnf8VbqY1/9A=
X-Google-Smtp-Source: ABdhPJwVR2YF8maIX6p9K/HHX630G689zHLSPVI6jT9XLKwM0kaDfCSBSWfXXwV+O5bt5doVm72EZQ==
X-Received: by 2002:a7b:cbc2:: with SMTP id n2mr2925803wmi.2.1633693043342;
        Fri, 08 Oct 2021 04:37:23 -0700 (PDT)
Received: from [192.168.2.177] ([206.204.146.29])
        by smtp.gmail.com with ESMTPSA id z17sm2280277wml.24.2021.10.08.04.37.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Oct 2021 04:37:22 -0700 (PDT)
Message-ID: <e3f30009-31ae-f37d-5016-bc8677d8d364@gmail.com>
Date:   Fri, 8 Oct 2021 13:37:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH v11, 0/2] soc: mediatek: mmsys: add mt8192 mmsys support
Content-Language: en-US
To:     Yongqiang Niu <yongqiang.niu@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Fabien Parent <fparent@baylibre.com>,
        Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Hsin-Yi Wang <hsinyi@chromium.org>
References: <20211008020504.1678-1-yongqiang.niu@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20211008020504.1678-1-yongqiang.niu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/10/2021 04:05, Yongqiang Niu wrote:
> base v5.15
> 
> Yongqiang Niu (2):
>    soc: mediatek: mmsys: add comp OVL_2L2/POSTMASK/RDMA4
>    soc: mediatek: mmsys: Add mt8192 mmsys routing table

I'm a bit puzzled that you keep on sending this series while I accepted an older 
one long time ago:
https://lore.kernel.org/lkml/e4afa712-9936-15fc-ad43-576948758f6c@gmail.com/

As you don't provide a changelog I'm not able to find out what has changed. I 
also asked you to double check if the fixup I did was correct, but you never 
answered.

If there are anything to fix for this series that's not in my tree yet, please 
send a follow-up patch.

Regards,
Matthias

> 
>   drivers/soc/mediatek/mt8192-mmsys.h    | 77 ++++++++++++++++++++++++++
>   drivers/soc/mediatek/mtk-mmsys.c       | 11 ++++
>   include/linux/soc/mediatek/mtk-mmsys.h |  3 +
>   3 files changed, 91 insertions(+)
>   create mode 100644 drivers/soc/mediatek/mt8192-mmsys.h
> 
