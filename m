Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE4D03A0DF8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 09:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235781AbhFIHqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 03:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233136AbhFIHqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 03:46:06 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A65EEC061574;
        Wed,  9 Jun 2021 00:43:58 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id m41-20020a05600c3b29b02901b9e5d74f02so401848wms.3;
        Wed, 09 Jun 2021 00:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4Ed9mm909+j2egVHjfeRzyEVoKd06Gn517VmwgTGDNY=;
        b=ihs/M3HXxfcfdqcK6ShERGmNiIwPqOR4VL78BLcUpL2KZujymyOFRY/qkAe+5slhsW
         QGGw1zRiCl3/oKgVIG0L5N/UwmRohLjxkvDZYW0ZgMgueMUgQ5p5KxICAKZgBW5MByI6
         1wvCIUA4w09NWUzZMCsAe/bdnLIHleQDciilgfOlygDXs/99S1fxZBhSQw6YZDXtKLlB
         V41F7zfaEGWNQ5hZOl22FQ+UI2Sr/vnqfRXBRST0lTMBAO+FcANq+f6kJlFDVIetgOv4
         5yuqeeUBORrQos9RQszQJMuytnjC2598FLs9JBlRP5FS28zZQcfdYtjdaRYVh/4Ldxoy
         rfRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4Ed9mm909+j2egVHjfeRzyEVoKd06Gn517VmwgTGDNY=;
        b=r1KGaJrkOLNhIJhYKDzsYigEKZlRfS7DgiHHUGnjPPhwhsI+Ykzh8uuz7i/Ft6kqVw
         Yhn8lPapkiCZ7+0NcheuQXBm6nm0T/WLtGCzCBFKjODQLYOdeHXsmRKRJ4PeOtV/iwTa
         WQ6kvo8fH0xpWpk7wp0yBK0zjx6WdVeS/8MhUmrFw2zBmSe3J5MkTGLwuwVNPDM3weqd
         ZOEN83iqwkvRreO0eAZv04ylwzLRSIvPVvvwkEKJLrX1eGdIN4vFLGmS8BTFS5UG1h9N
         gMRtIsM2Xb60ZamfUQNq8e/5J775Z7tyryjP24Ass5DF0sUP/mJYHp4I7UYCJFRFe/TY
         9w6g==
X-Gm-Message-State: AOAM532qFay7k/cnfRj7PDAlm5Nh+TTEfIyUaFcyVCDYp2vr9dIdEOmo
        0+G/EGEnVoXFnikTyXTiP/c=
X-Google-Smtp-Source: ABdhPJy1TN5g9HVPQta2ngBPCU9iX96cZHpN+j/ZJV4T2M0MwzeH3BbE0S0m5qwPSCAQmLDWiA+gmw==
X-Received: by 2002:a7b:c189:: with SMTP id y9mr26040858wmi.106.1623224637195;
        Wed, 09 Jun 2021 00:43:57 -0700 (PDT)
Received: from ziggy.stardust (81.172.61.185.dyn.user.ono.com. [81.172.61.185])
        by smtp.gmail.com with ESMTPSA id q3sm22548486wrr.43.2021.06.09.00.43.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 00:43:56 -0700 (PDT)
Subject: Re: [PATCH v5, 3/4] soc: mediatek: mmsys: add component RDMA4
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
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <1618236288-1617-1-git-send-email-yongqiang.niu@mediatek.com>
 <1618236288-1617-4-git-send-email-yongqiang.niu@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <a1824cdc-7e2f-a38f-d019-e1d8f92ead2b@gmail.com>
Date:   Wed, 9 Jun 2021 09:43:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <1618236288-1617-4-git-send-email-yongqiang.niu@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/04/2021 16:04, Yongqiang Niu wrote:
> This patch add component RDMA4
> 
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> ---
>  include/linux/soc/mediatek/mtk-mmsys.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/soc/mediatek/mtk-mmsys.h b/include/linux/soc/mediatek/mtk-mmsys.h
> index 7718cd6..4bba275 100644
> --- a/include/linux/soc/mediatek/mtk-mmsys.h
> +++ b/include/linux/soc/mediatek/mtk-mmsys.h
> @@ -38,6 +38,7 @@ enum mtk_ddp_comp_id {
>  	DDP_COMPONENT_RDMA0,
>  	DDP_COMPONENT_RDMA1,
>  	DDP_COMPONENT_RDMA2,
> +	DDP_COMPONENT_RDMA4,

Pach 1-3 looks good, but could be squashed in one patch. Please try to come up
with a more descriptive commit message. Rule of thumb is to explain why we need
a patch not what the patch does.

Regards,
Matthias

>  	DDP_COMPONENT_UFOE,
>  	DDP_COMPONENT_WDMA0,
>  	DDP_COMPONENT_WDMA1,
> 
