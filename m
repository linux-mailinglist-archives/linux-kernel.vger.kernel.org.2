Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD5E4023B2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 08:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235312AbhIGG4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 02:56:42 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:58136 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235276AbhIGG4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 02:56:41 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 1872qDNW030676;
        Tue, 7 Sep 2021 08:55:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=pPWWaNwMDzyikRTWDISy5sjjTX8UIPo1qSx4LUPLwxA=;
 b=mxD6e0fuEA913caHEUABA1NDOa6dqb+EnzE8ByiidNC5kiF0ZcpYnou85R0Y8H1sJbuU
 oionhz6yi3OMoprhgzrtNW6hzviBPJAhw5UmwUTH7BVNaE+Gh+7OyeKq1Iu4glQf84bI
 Y58qydwyqegXSDY4mG1O4yeZjzR3sDFzz5AU2eqXjROo3AGkmHNAPChNemk2MNF8+20V
 8K1aY+kdrWdwZqHhOhdAm5pyyn7Cx35LcCyDQbArSr99BMzXfFdYbTei0icrtVc6lUJT
 aG4mMzeXWvIwfyvm6/yChPkPHjJyLtwQRlftfyHRMTW3yfzbt3yqZYxMJdpI2ucKboWK Hg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3awyp0rwwa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Sep 2021 08:55:18 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 97DC910002A;
        Tue,  7 Sep 2021 08:55:15 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag1node3.st.com [10.75.127.3])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 64CE52122E8;
        Tue,  7 Sep 2021 08:55:15 +0200 (CEST)
Received: from lmecxl0951.lme.st.com (10.75.127.45) by SFHDAG1NODE3.st.com
 (10.75.127.3) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 7 Sep
 2021 08:55:14 +0200
Subject: Re: [PATCH] drm/stm: ltdc: add layer alpha support
To:     Raphael GALLAIS-POU - foss <raphael.gallais-pou@foss.st.com>,
        "Philippe CORNU - foss" <philippe.cornu@foss.st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>
CC:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        "Maxime Coquelin" <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE - foss <alexandre.torgue@foss.st.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Raphael GALLAIS-POU <raphael.gallais-pou@st.com>
References: <20210903085740.23108-1-raphael.gallais-pou@foss.st.com>
From:   yannick Fertre <yannick.fertre@foss.st.com>
Message-ID: <19331273-3464-869e-8e62-a0c3e096ed70@foss.st.com>
Date:   Tue, 7 Sep 2021 08:55:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210903085740.23108-1-raphael.gallais-pou@foss.st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG1NODE3.st.com
 (10.75.127.3)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-07_02,2021-09-03_01,2020-04-07_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Raphael,
thanks for the patch.

Acked-by: Yannick Fertre <yannick.fertre@foss.st.com>
Reviewed-by: Yannick Fertre <yannick.fertre@foss.st.com>

On 9/3/21 10:58 AM, Raphael GALLAIS-POU - foss wrote:
> Android Hardware Composer supports alpha values applied to layers.
> Enabling non-opaque layers for the STM CRTC could help offload GPU
> resources for screen composition.
> 
> Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
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
