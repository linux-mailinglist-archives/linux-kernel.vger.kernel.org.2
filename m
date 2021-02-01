Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC94930A3E9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 10:01:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbhBAJAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 04:00:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232565AbhBAJAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 04:00:30 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6653EC061573
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 00:59:50 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id e15so12440425wme.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 00:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Ga5Wn4Eex51ui7fkqD+QdHO2SxUk0pWG55X7znoYW1o=;
        b=NF3/w6iBpDa6dw3c8knn0Dpgq6BDkre5I+/SQWKWoVHRZ1y4wDjIPv3/il33zJrHPt
         uuCyZNEZd0Iywq389XacekYZ7RdxPr0DHofo7YQpTdNUd+C8ioHCmiNoZHV8LEOWqWXo
         61xtbGk9nzr/JD3v8dfCc8VnF+KXnnUvgJ6up7vjI1XkMcu3AVr3iFDhYRq6Cg+T9OWA
         od0ZUVKJ2+6glHagfgwmSbNu2nv/iQmaRYU4Bd12/D+J2Rim2Kvz1xXVmUyXGZQMl9yq
         c0Mok+qYSyKoeX9IWD/2xbXJS0ZBYKoAB34Z8GnOHDX5dGy89GXaJhUisczK08bO89ko
         mPNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ga5Wn4Eex51ui7fkqD+QdHO2SxUk0pWG55X7znoYW1o=;
        b=qFbPAIDe0nZ9BiWlfXC6QRh7imu4JcxM0fptzGpbLirQDEt0Ffzn0lTM5RwFqf7Kab
         z71mJZDT/TQu7BKFw/jH+BGP0nqFo5XVdKvKwjoWqh1eH7qTCfDKkUgqRaQtpFbO0LRE
         ayfg/Qsn1YHeGyhDPoEtb0lvEWYQ3iVDUg3jAXsI/FmblG1x9p92VttH3R6+PKTD+rmk
         IgZVFJNcO9FjcI7L2j18RQC8LYz967t6jDLTdaTaOVUvBvPLJFVUdc0+avFYFayg92Mj
         l5/UC5XSjFy54fLb3SKSRvu6bjVnPklAbjol+d13cIDBXCrdpCz4cGx5uVzqziw3FSui
         L6GQ==
X-Gm-Message-State: AOAM530vbPIBv5XoeYvcjuubnRdVHKAmu4sVWQLoNWGKqLWX3KzGua8A
        /EA9tiRk4QmvghYjKX8Z2mrPZ2uamPAiNUcM
X-Google-Smtp-Source: ABdhPJyqD3lnfamEWdXR0fEBZ53K1Km2cEtErSfVz8XmOxHUXgB7b3hPxR+Maae7JOowmnUsekQGIQ==
X-Received: by 2002:a1c:cb:: with SMTP id 194mr14283189wma.30.1612169989209;
        Mon, 01 Feb 2021 00:59:49 -0800 (PST)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id u6sm27489814wro.75.2021.02.01.00.59.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Feb 2021 00:59:48 -0800 (PST)
Subject: Re: [PATCH 1/2] soc: mediatek: pm-domains: Use correct mask for
 bus_prot_clr
To:     Bilal Wasim <bilalwasim676@gmail.com>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        enric.balletbo@collabora.com, hsinyi@chromium.org,
        weiyi.lu@mediatek.com
References: <20210201054542.1470695-1-Bilal.Wasim@imgtec.com>
 <20210201054542.1470695-2-Bilal.Wasim@imgtec.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <e4961c5e-db52-148d-c414-25f16101fb3f@gmail.com>
Date:   Mon, 1 Feb 2021 09:59:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210201054542.1470695-2-Bilal.Wasim@imgtec.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/02/2021 06:45, Bilal Wasim wrote:
> When "bus_prot_reg_update" is false, the driver should use
> INFRA_TOPAXI_PROTECTEN for both setting and clearing the bus
> protection. However, the driver does not use this mask for
> clearing bus protection which causes failure when booting
> the imgtec gpu.
> 
> Corrected and tested with mt8173 chromebook.
> 
> Signed-off-by: Bilal Wasim <Bilal.Wasim@imgtec.com>
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

BUS_PROT_UPDATE sets bus_prot_reg_update to true, which contradicts what you say
in the commit message.

Please clarify.

Regards,
Matthias

>  				INFRA_TOPAXI_PROTECTSTA1)
>  
>  struct scpsys_bus_prot_data {
> 
