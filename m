Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65FF234E4CB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 11:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbhC3Jxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 05:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbhC3JxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 05:53:11 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF184C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 02:53:10 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id c8so15579343wrq.11
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 02:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0VQQ0CcevqZjEsDG9+Tim60Cck7tjX6oWI7ImfoA6t0=;
        b=qwn8N3Ar5+8PHU0n803uS//yCpcQCSdmdzY2yxq9thhtul63jHSeuuh61reKtas1Vi
         ao7BoC5lGCadw6mEOYwPQURq6SZQU4DJReN3k0CTrNZpC8ZEGOtTTCHKaLf4bQoMZ1zI
         vLj0n23TkDiGqZ9VrzHCEGJ5mS3MrNzpI1Ndumao0B1t+VpzA/MI48IZhUyfYzkkeBSe
         WF2S5/pfNgSKjj0Rx5kx5JDv3vwIxA7efvgTkkmkcJFU9+6FWeB2yY2Xdm+gwX20CYAN
         2vBA5t7I2H5sdXxcaLebbW2tEr83EZCWYOs8KfhiXgy+D8TPUMyfQ6d+fmSMXrgCWK2T
         jtIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0VQQ0CcevqZjEsDG9+Tim60Cck7tjX6oWI7ImfoA6t0=;
        b=te1xG2EU2g5bx1yYnp/8+565o5YsrDMfHlgy8a3uNgkE1AqkukHDaInykDlOBCmvRu
         vvbWU2XmLECOV8Kpv6wqoXZv0H2LuEb5fAwH30vuEicJkvcftvslgwWcy9sMvkFs19k/
         xMxRW36fGNSJ13GfLyqEwE+vsP5+r9Q9rDZoyFy9Z9kPaqEFx1x5bXb20oUotjjYKAuL
         C1F25TA+VtGfLf8xQWyIt6o2/Px+6XdX4cO8vxlubP9PFSGEEi0tyd1vElsE1qYMW58d
         D1DbdnHOr+EUdEFCrAl0acustXFx1TStJGpIDW4AQoIGSRuZ51DAsg4B77oTkQGZcf1l
         dlOQ==
X-Gm-Message-State: AOAM5333AZOIum2cakG7WFnXVQ0f/kU01dhOtMVyL3LRoacbFBvQGGH4
        OHEjMwlGKaD91mKpszXkpVA=
X-Google-Smtp-Source: ABdhPJzY5PnSfJikeiaQFITOB9nETnRYxl3Qzti5OItClmgYl/Omxx2o7ZA2HweHapoqD5kah5SD6Q==
X-Received: by 2002:a5d:670f:: with SMTP id o15mr25344196wru.349.1617097989511;
        Tue, 30 Mar 2021 02:53:09 -0700 (PDT)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id r14sm34114892wrw.91.2021.03.30.02.53.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Mar 2021 02:53:09 -0700 (PDT)
Subject: Re: [PATCH] soc: mediatek: pm-domains: Fix missing error code in
 scpsys_add_subdomain()
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org
Cc:     drinkcat@chromium.org, hsinyi@chromium.org, weiyi.lu@mediatek.com,
        Collabora Kernel ML <kernel@collabora.com>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20210303091054.796975-1-enric.balletbo@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <7568cab4-11ad-24df-3d45-cafdbbb3d94d@gmail.com>
Date:   Tue, 30 Mar 2021 11:53:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210303091054.796975-1-enric.balletbo@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/03/2021 10:10, Enric Balletbo i Serra wrote:
> Adding one power domain in scpsys_add_subdomain is missing to assign an
> error code when it fails. Fix that assigning an error code to 'ret',
> this also fixes the follwowing smatch warning.
> 
>   drivers/soc/mediatek/mtk-pm-domains.c:492 scpsys_add_subdomain() warn: missing error code 'ret'
> 
> Fixes: dd65030295e2 ("soc: mediatek: pm-domains: Don't print an error if child domain is deferred")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Applied to v5.12-next/soc
Thanks!

> ---
> 
>  drivers/soc/mediatek/mtk-pm-domains.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
> index 694d6ea6de1d..0af00efa0ef8 100644
> --- a/drivers/soc/mediatek/mtk-pm-domains.c
> +++ b/drivers/soc/mediatek/mtk-pm-domains.c
> @@ -491,8 +491,9 @@ static int scpsys_add_subdomain(struct scpsys *scpsys, struct device_node *paren
>  
>  		child_pd = scpsys_add_one_domain(scpsys, child);
>  		if (IS_ERR(child_pd)) {
> -			dev_err_probe(scpsys->dev, PTR_ERR(child_pd),
> -				      "%pOF: failed to get child domain id\n", child);
> +			ret = PTR_ERR(child_pd);
> +			dev_err_probe(scpsys->dev, ret, "%pOF: failed to get child domain id\n",
> +				      child);
>  			goto err_put_node;
>  		}
>  
> 
