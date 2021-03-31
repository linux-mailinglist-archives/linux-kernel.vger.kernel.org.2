Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7280634FE4E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 12:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235062AbhCaKsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 06:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234833AbhCaKsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 06:48:03 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A762C061574
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 03:48:03 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id z2so19176231wrl.5
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 03:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:references:from:subject:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=an95RGWWeD1g/A49F28kwsJEkG2XvzpxDDx3Znsl2aE=;
        b=SRBZKkxCaBMgFirGX6d2mCBBeSrA34vHaLPU1AsyBHAnQSH//EaMYbmaubanC7OvH0
         8jLsnwNPKFxJJVE/qYleBch9PPknrwfA1r58hDm5ObUY/NBN1fDihzJZ09gO/mENkaRy
         l4003gLGcLaI+YR0xREZdnJa7oINV9MsVexxSdxSs4PRo4+TyFKbO8pQdnlwbFghd4vF
         zwIwvV42UMDNZyQO3OYESmSbVaGazr7J7o+tR4/Vp6wNTzK96B6igL7OVV/XDFVxNS8d
         HxpP7MB6wUTn77OT20uU6O0Y0mzjbcXr0jhFJNQh6r4WXXZJrAibCz4XhDaV1jYAy+ch
         jB5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=an95RGWWeD1g/A49F28kwsJEkG2XvzpxDDx3Znsl2aE=;
        b=i8jK1NkceegVuixBAsXrNgT7bU/BrzyNPi6bB7R77JpPQH8zODOqjCmqD6VaonJnvA
         1Lkgx8YAoNbKVlSp2L37UN4lYs+gT98vowsvTgnmo6fqskceus26Z2rUcCAUKSOK71YU
         o3LYNXE/1OhK4JUt8T+ZkXtoq/N2d4mPJaHfUh2dLpuqSYgxTmZKasR2+tT0evmctN0Y
         egNIyi8s3vO7N25rSuw+AaThkqFSsIuwxENZI7B+kfcHqBPmhAGiryP6hmHOqIGQkvlK
         nAD512zONsTx3yXqzvpzEJQYOt19cnnL3XEMxEfJUnjjuIxvrRpBoWnL7MyqdBBOZP4h
         Jr3A==
X-Gm-Message-State: AOAM532AEMeg2simsNEQ6jvtJmVJ9hsTBLr+ZPHctGOel+GIBY2G4d0D
        JmKQUocn25dKhkFUPVtRWIk=
X-Google-Smtp-Source: ABdhPJx530xnik+wLz0S1QarfQsK7fbyvmGzMAZS7c5MRia3h/O5oa90KaQACZU4p+ozmQRQAv8/aQ==
X-Received: by 2002:a5d:6b84:: with SMTP id n4mr2941778wrx.258.1617187681977;
        Wed, 31 Mar 2021 03:48:01 -0700 (PDT)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id 91sm4098632wrl.20.2021.03.31.03.48.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Mar 2021 03:48:01 -0700 (PDT)
To:     Bilal Wasim <bilalwasim676@gmail.com>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        enric.balletbo@collabora.com, hsinyi@chromium.org,
        weiyi.lu@mediatek.com
References: <20210201121416.1488439-1-Bilal.Wasim@imgtec.com>
 <20210201121416.1488439-3-Bilal.Wasim@imgtec.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v2 2/3] soc: mediatek: pm-domains: Add domain_supply cap
 for mfg_async PD
Message-ID: <cbad9d05-6acb-eb11-a46e-4a2ccc634128@gmail.com>
Date:   Wed, 31 Mar 2021 12:48:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210201121416.1488439-3-Bilal.Wasim@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/02/2021 13:14, Bilal Wasim wrote:
> The mfg_async power domain in mt8173 is used to power up imgtec
> gpu. This domain requires the da9211 regulator to be enabled before
> the power domain can be enabled successfully.
> 
> Signed-off-by: Bilal Wasim <Bilal.Wasim@imgtec.com>
> Reviewed-by: Hsin-Yi Wang <hsinyi@chromium.org>
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

Hm, I think the problem here is, that we don't find the regulator
"domain-supply" in the DTS. And that provokes that we error out on all power
domains. Not sure if we should fix that somehow, so that a missing regulator
will only affect one power domain (and it's childs).

Regards,
Matthias

>  	},
>  	[MT8173_POWER_DOMAIN_MFG_2D] = {
>  		.sta_mask = PWR_STATUS_MFG_2D,
> 
