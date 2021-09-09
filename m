Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A11C4056D7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 15:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357405AbhIINYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 09:24:17 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:60878 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1358903AbhIINJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 09:09:55 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 1899nKP1011941;
        Thu, 9 Sep 2021 15:08:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=rt676OizKDcO67ptb6jl8Y21o8rSxXOR9Kpb3o0BI8w=;
 b=mysjjy3EBMCQZ9oItGBAfMsZ4iTw2TJWygahXDhHPxT6TrPTCiaBvUtmOrto8TzC1Pui
 z92LBGA591B0eSc9JYPi9xTg7pWc/WDvXhmZL3OwEAjRBJfR6IFoxI3KLUJ9E5hgmFOO
 tMWUSgfNJBjj6yheEX3MS441WVHkqFM3Y8sKqITppLMsiGt+x4JhKyE0MUuMKJBD0ap5
 duKZ02HvyEoZPUDaoyvciV/brJeQDKXrqMsv6w2n9ahMUJHig6+UQ0a1VQ3BR67e0s+q
 iuwszErqtWD+4KhK1GuPUR+v/N0eg5ePDMjCr/9crcVkXUSsO0IxapaniXDLdp4ALGIL 0w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3ay86m3hg3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Sep 2021 15:08:31 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 156F210002A;
        Thu,  9 Sep 2021 15:08:31 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag1node3.st.com [10.75.127.3])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 54E542171E0;
        Thu,  9 Sep 2021 15:08:28 +0200 (CEST)
Received: from lmecxl0993.lme.st.com (10.75.127.50) by SFHDAG1NODE3.st.com
 (10.75.127.3) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 9 Sep
 2021 15:08:27 +0200
Subject: Re: [PATCH v2] drm/stm: ltdc: add layer alpha support
To:     Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
        Yannick Fertre <yannick.fertre@foss.st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>
CC:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        "Maxime Coquelin" <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Raphael Gallais-Pou <raphael.gallais-pou@st.com>
References: <20210907151534.6013-1-raphael.gallais-pou@foss.st.com>
From:   Philippe CORNU <philippe.cornu@foss.st.com>
Message-ID: <90bbee44-b827-e660-3bb7-a37494f4b933@foss.st.com>
Date:   Thu, 9 Sep 2021 15:08:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210907151534.6013-1-raphael.gallais-pou@foss.st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG1NODE3.st.com
 (10.75.127.3)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-09_04,2021-09-09_01,2020-04-07_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/7/21 5:15 PM, Raphael Gallais-Pou wrote:
> Android Hardware Composer supports alpha values applied to layers.
> Enabling non-opaque layers for the STM CRTC could help offload GPU
> resources for screen composition.
> 
> Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
> Acked-by: Yannick Fertre <yannick.fertre@foss.st.com>
> Reviewed-by: Yannick Fertre <yannick.fertre@foss.st.com>
> ---
>   drivers/gpu/drm/stm/ltdc.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
> index 195de30eb90c..e0fef8bacfa8 100644
> --- a/drivers/gpu/drm/stm/ltdc.c
> +++ b/drivers/gpu/drm/stm/ltdc.c
> @@ -845,7 +845,7 @@ static void ltdc_plane_atomic_update(struct drm_plane *plane,
>   			LXCFBLR_CFBLL | LXCFBLR_CFBP, val);
>   
>   	/* Specifies the constant alpha value */
> -	val = CONSTA_MAX;
> +	val = newstate->alpha >> 8;
>   	reg_update_bits(ldev->regs, LTDC_L1CACR + lofs, LXCACR_CONSTA, val);
>   
>   	/* Specifies the blending factors */
> @@ -997,6 +997,8 @@ static struct drm_plane *ltdc_plane_create(struct drm_device *ddev,
>   
>   	drm_plane_helper_add(plane, &ltdc_plane_helper_funcs);
>   
> +	drm_plane_create_alpha_property(plane);
> +
>   	DRM_DEBUG_DRIVER("plane:%d created\n", plane->base.id);
>   
>   	return plane;
> 

Applied on drm-misc-next.
Many thanks for your patch,
Philippe :-)
