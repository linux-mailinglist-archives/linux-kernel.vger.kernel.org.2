Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 743BC32CEC8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 09:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236615AbhCDIvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 03:51:10 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:15824 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S236479AbhCDIux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 03:50:53 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1248m3Ze014700;
        Thu, 4 Mar 2021 09:49:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=FVNy8tJa/zBb6Dg12zoReyCjkz82aSQwtAndHZjvGrI=;
 b=U4rIj9FWvU3QrNu8eC7iMsPaO5M3+VYijeR/qKqVEbkIfB7bFhgMVHqzx2bQhAM41bx1
 uy0xUuy6JQNL5m8T8+Is/l3X+nj4KssdJO7kbSkQz3itCywduFAAiz8a/B3A3NTBfP68
 zGwDozSj3w34/pGoCMkvRsQW4Fe+9K5JxWvV8RVYkK2Xyg2r97vQ+kfpohr2FoLRcsJ9
 lddIy1QAgdQZFazh2hzvpvxniYNTTl4JNBYwNy1Mmsp1OgYG+vZu2AyiP7kJcJkvxye8
 8jhPiss1zGvUcgoAJz4IqG4BY0qMqHItC1/pW9qwjxl2ig1TdNB+IqOR90DiwcNuuEXN Dg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 36yfdye49s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Mar 2021 09:49:57 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9FEEF10002A;
        Thu,  4 Mar 2021 09:49:56 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 74D7A228C23;
        Thu,  4 Mar 2021 09:49:56 +0100 (CET)
Received: from lmecxl0951.lme.st.com (10.75.127.51) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 4 Mar
 2021 09:49:55 +0100
Subject: Re: [PATCH] drm/stm: ltdc: Use simple encoder
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Yannick Fertre <yannick.fertre@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-amarula@amarulasolutions.com>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20210302175700.28640-1-jagan@amarulasolutions.com>
 <791a6f75-3603-9b84-c267-76c24fb77ee2@suse.de>
From:   yannick Fertre <yannick.fertre@foss.st.com>
Message-ID: <1d6ff4e2-9213-6e13-214d-b1705199610e@foss.st.com>
Date:   Thu, 4 Mar 2021 09:49:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <791a6f75-3603-9b84-c267-76c24fb77ee2@suse.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-04_02:2021-03-03,2021-03-04 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,
I wait a few days before merging it.
Thank you for your help.

Best regards

Yannick


On 3/4/21 9:21 AM, Thomas Zimmermann wrote:
> Hi,
> 
> shall I merge this patch?
> 
> Am 02.03.21 um 18:57 schrieb Jagan Teki:
>> STM ltdc driver uses an empty implementation for its encoder.
>> Replace the code with the generic simple encoder.
>>
>> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
>> ---
>>   drivers/gpu/drm/stm/ltdc.c | 12 ++----------
>>   1 file changed, 2 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
>> index 7812094f93d6..aeeb43524ca0 100644
>> --- a/drivers/gpu/drm/stm/ltdc.c
>> +++ b/drivers/gpu/drm/stm/ltdc.c
>> @@ -31,6 +31,7 @@
>>   #include <drm/drm_of.h>
>>   #include <drm/drm_plane_helper.h>
>>   #include <drm/drm_probe_helper.h>
>> +#include <drm/drm_simple_kms_helper.h>
>>   #include <drm/drm_vblank.h>
>>   #include <video/videomode.h>
>> @@ -1020,14 +1021,6 @@ static int ltdc_crtc_init(struct drm_device 
>> *ddev, struct drm_crtc *crtc)
>>       return ret;
>>   }
>> -/*
>> - * DRM_ENCODER
>> - */
>> -
>> -static const struct drm_encoder_funcs ltdc_encoder_funcs = {
>> -    .destroy = drm_encoder_cleanup,
>> -};
>> -
>>   static void ltdc_encoder_disable(struct drm_encoder *encoder)
>>   {
>>       struct drm_device *ddev = encoder->dev;
>> @@ -1088,8 +1081,7 @@ static int ltdc_encoder_init(struct drm_device 
>> *ddev, struct drm_bridge *bridge)
>>       encoder->possible_crtcs = CRTC_MASK;
>>       encoder->possible_clones = 0;    /* No cloning support */
>> -    drm_encoder_init(ddev, encoder, &ltdc_encoder_funcs,
>> -             DRM_MODE_ENCODER_DPI, NULL);
>> +    drm_simple_encoder_init(ddev, encoder, DRM_MODE_ENCODER_DPI);
>>       drm_encoder_helper_add(encoder, &ltdc_encoder_helper_funcs);
>>
> 
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
