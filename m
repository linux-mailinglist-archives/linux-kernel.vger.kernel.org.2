Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B140534FF1D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 13:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235455AbhCaLCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 07:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235065AbhCaLBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 07:01:44 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD808C061574
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 04:01:43 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id x13so19201527wrs.9
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 04:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:references:from:subject:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=HAhIfCQ+mBWnswdejnwbejzH4FaA9h1d0ZjzSYKZEME=;
        b=YCnGKukVouS7rkCDjXX6Yc62SurfBGZOtz54DQy1yOspgkm7F0w62awSMcn7a96KRi
         JX9RaIjV7sfDccUnUF8FTNxFBfTqjlEz2ZqrmHenFQLVaX2g7uy3ialDzFAENwez/osI
         Vr26DAANq2zjrTqqUCvZvI8CiXJ5912isBPh+MgFKgz5CiTMT/7qIH+LAuMU8O6yIlyu
         3onfV4KtxU5PycHKJDiFKSgVoD4MTzCstQENeiah8YxxTWXAOawB17iQMPHFemZJpf9N
         +1yGPfFV/cugOfo6s5ZqX3juRuTP+zI3NYEG7kC4fAnrmqQvTFr/ijEblv4/EjrJ0g/r
         gUYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HAhIfCQ+mBWnswdejnwbejzH4FaA9h1d0ZjzSYKZEME=;
        b=rs1lNSeOmWwmsUB0f37wYtW4mjtcoRV2X4RztMp3f/nWdjqaFotTDHDzYPOCZ8HCRj
         YMGwFM82dFUmvx5qTfMf2NFuqb+dMZyJwLpvoRjPjVGqdEMFGCBI0U3duOGvnweDHu5I
         mZ/Y7O1ifYmgvBv8MyXUVxinKt9j/s8A55c4j2uV9rya3CMyRDfyS4Hyy1shhilVuU2z
         b00xkN6dNRb91aE8KPEO6wMQFmzijgPgZ3Sw8qW1fcR/P1sQb5IN2Zh3JrIYsBxsgKuo
         r8hOLR+JbsLjvJf3oHdsNnrA8hcOcZ4xkc2aQ8A+5E2/gnfcMlcOJZhv6GFPpbqU3+31
         UE5Q==
X-Gm-Message-State: AOAM531pIpKcWgAGjFF/kCUP189X1DiX8LE5EWCsL3uflolcfd0KBK8o
        Vhm5nFOrStxAPjEXNL3kTC0=
X-Google-Smtp-Source: ABdhPJyzvkcg1Nzw2O81sq2cyAk9HlnaAuUBneSFAcMDEfnmxGsPYbbm0P14gKvDv8IQKwks3v4eig==
X-Received: by 2002:adf:b30f:: with SMTP id j15mr3041345wrd.132.1617188502697;
        Wed, 31 Mar 2021 04:01:42 -0700 (PDT)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id f7sm3270564wmq.11.2021.03.31.04.01.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Mar 2021 04:01:42 -0700 (PDT)
To:     Bilal Wasim <bilalwasim676@gmail.com>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        enric.balletbo@collabora.com, hsinyi@chromium.org,
        weiyi.lu@mediatek.com, Fabien Parent <fparent@baylibre.com>
References: <20210201121416.1488439-1-Bilal.Wasim@imgtec.com>
 <20210201121416.1488439-2-Bilal.Wasim@imgtec.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v2 1/3] soc: mediatek: pm-domains: Use correct mask for
 bus_prot_clr
Message-ID: <c0cace72-e114-6b00-0254-c103e52a7b1f@gmail.com>
Date:   Wed, 31 Mar 2021 13:01:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210201121416.1488439-2-Bilal.Wasim@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/02/2021 13:14, Bilal Wasim wrote:
> When "bus_prot_reg_update" is true, the driver should use
> INFRA_TOPAXI_PROTECTEN for both setting and clearing the bus
> protection. However, the driver does not use this mask for
> clearing bus protection which causes failure when booting
> the imgtec gpu.
> 
> Corrected and tested with mt8173 chromebook.
> 
> Signed-off-by: Bilal Wasim <Bilal.Wasim@imgtec.com>
> Reviewed-by: Hsin-Yi Wang <hsinyi@chromium.org>

BUS_PROT_UPDATE_TOPAXI is also used in mt8167. I'd need feedback if this would
break that SoC before accepting this patch.

Regards,
Matthias

> ---
>  drivers/soc/mediatek/mtk-pm-domains.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-pm-domains.h b/drivers/soc/mediatek/mtk-pm-domains.h
> index 141dc76054e6..7454c0b4f768 100644
> --- a/drivers/soc/mediatek/mtk-pm-domains.h
> +++ b/drivers/soc/mediatek/mtk-pm-domains.h
> @@ -60,7 +60,7 @@
>  #define BUS_PROT_UPDATE_TOPAXI(_mask)				\
>  		BUS_PROT_UPDATE(_mask,				\
>  				INFRA_TOPAXI_PROTECTEN,		\
> -				INFRA_TOPAXI_PROTECTEN_CLR,	\
> +				INFRA_TOPAXI_PROTECTEN,		\
>  				INFRA_TOPAXI_PROTECTSTA1)
>  
>  struct scpsys_bus_prot_data {
> 
