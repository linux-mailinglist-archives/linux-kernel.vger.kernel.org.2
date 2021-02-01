Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 623CE30A42D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 10:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232650AbhBAJQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 04:16:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbhBAJPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 04:15:14 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDFB3C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 01:14:02 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id m13so15707128wro.12
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 01:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Fo7SHQNM6Z0HqKpfGDmnmMPvTFBZ4gb+tdjIA9oKGDg=;
        b=avyrrve8VKwKmHmarlQMcrmqR3D5rivE/qotzf19jkWIHDhIC1n87r3D7DVoV0piAd
         q/p8eoe7IF+PxV/DgU7esnASvKDxXnQqczwEQDwfCkvkdFx7J0Ybl1G4CJjl7plCmz+6
         6/uOccObWFbTWqd1JBMV3Pn3hmWocQkkBU9eKn+90IXS4CQfBYVve8wqjsZUpqzFbJRy
         hZObpYtb/ZwjZce+RZeAiKWdaXgIJx+yziUcENnlBDS13T19fJE8FBwjdjGCX/KcAd0p
         g3MCDHdF9YMTvpgDH+kBxyfHGbovEYKk3tXuzvobwUif+YxU0WefLqBreJpApY8WDVKe
         O59Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Fo7SHQNM6Z0HqKpfGDmnmMPvTFBZ4gb+tdjIA9oKGDg=;
        b=k6K5D+PSDasUrU5QNpUmZw2U2JoDGnCNNAh5bclqp0WP58p5e3i7Nt8qM5jWc2I9yg
         hhf7+9VhzAa5YJKbrI8nbmVJDcHESuCRzw3eBMmnF07TXlgbXJiZ0O3EZwyc5WETem7M
         sQ3H+F5AkJqBhe3yxUthcFcRdlagj/uo1bhD3xrwif530Oa3X9mxgSAPlf7VPyTlY0+m
         L0uOrkhU9073ch/PM9voNLhXEVyP22j7M8LiECQ9JbvQzINb8cMV4eeaJGbtge3U2R2k
         E4Nez23Bqe/N8fXqw+mCXx3KtRVg2KKsLhewXmY5VSjNZ+7vP+McUIYPTznuC2Cvu0T8
         mkXQ==
X-Gm-Message-State: AOAM530RT6xUjjBqsieBLgZRyxWNt3XSsik3p7y9na/6tEWahiA9Puu/
        wjadrIYakazh1XSiv9vPnts=
X-Google-Smtp-Source: ABdhPJwpf0YKtXdwdta7Zb7q7dGeMFn2HKVn5m8c3F/LST0fdks44LO6E12JNoEMV9eR//ueyraZLg==
X-Received: by 2002:adf:e4c4:: with SMTP id v4mr16091337wrm.376.1612170841464;
        Mon, 01 Feb 2021 01:14:01 -0800 (PST)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id y20sm19869845wmj.44.2021.02.01.01.14.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Feb 2021 01:14:00 -0800 (PST)
Subject: Re: [PATCH 2/2] soc: mediatek: pm-domains: Add domain_supply cap for
 mfg_async PD
To:     Bilal Wasim <bilalwasim676@gmail.com>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        enric.balletbo@collabora.com, hsinyi@chromium.org,
        weiyi.lu@mediatek.com
References: <20210201054542.1470695-1-Bilal.Wasim@imgtec.com>
 <20210201054542.1470695-3-Bilal.Wasim@imgtec.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <e5c7352b-58db-760b-120c-090f225768b2@gmail.com>
Date:   Mon, 1 Feb 2021 10:14:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210201054542.1470695-3-Bilal.Wasim@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/02/2021 06:45, Bilal Wasim wrote:
> The mfg_async power domain in mt8173 is used to power up imgtec
> gpu. This domain requires the da9211 regulator to be enabled before
> the power domain can be enabled successfully.
> 
> Signed-off-by: Bilal Wasim <Bilal.Wasim@imgtec.com>
> ---
>  drivers/soc/mediatek/mt8173-pm-domains.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/soc/mediatek/mt8173-pm-domains.h b/drivers/soc/mediatek/mt8173-pm-domains.h
> index 3e8ee5dabb43..065b8195e7d6 100644
> --- a/drivers/soc/mediatek/mt8173-pm-domains.h
> +++ b/drivers/soc/mediatek/mt8173-pm-domains.h
> @@ -63,6 +63,7 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8173[] = {
>  		.ctl_offs = SPM_MFG_ASYNC_PWR_CON,
>  		.sram_pdn_bits = GENMASK(11, 8),
>  		.sram_pdn_ack_bits = 0,
> +		.caps = MTK_SCPD_DOMAIN_SUPPLY,
>  	},
>  	[MT8173_POWER_DOMAIN_MFG_2D] = {
>  		.sta_mask = PWR_STATUS_MFG_2D,
> 

We are missing a third patch for the DTS to actually add the regulator. Please
provide them for both, mt8173-evb.dts and mt8173-elm.dts

Thanks a lot and I'm very happy to see you starting to contribute!

Regards,
Matthias
