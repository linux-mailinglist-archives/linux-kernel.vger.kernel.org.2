Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54F4D39714B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 12:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbhFAKVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 06:21:52 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:47972 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230262AbhFAKVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 06:21:51 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 151A7eWx009015;
        Tue, 1 Jun 2021 12:19:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : subject : to
 : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=fp2rZiFbJHmMj1veiCA0AXV7LlRmE6SizObFbCHhGkA=;
 b=FFFM2iPg4Q9bxynK+9dR80EmiV2uHj+aet/XcDds3uP6mdMYETCEvRVtIXbBe7tR/3cd
 AMT2bhhFWcZE9g9Cv/XTl8DUFdTFUfm2BNJ3tMQoQaAJtMDJ8suFZYEYsIWtPqNKYbJ4
 +sPdFtVHTdgFVeV3atGgo+tYwf/AOtGxR1xOhfPObtTV4pHEAfCwYFLT+Rw36sUB5p9B
 bWGyDw5xpR8k87ndn531lQOg1NfSA+LQEejGAei0gWf+ri/RceiVeLyYrrNu46cI4jtH
 /GTAt3wgNy3FhqOyZaTgrsT+uRj8gIh6qMZc0d0uvuFQexGy7rfEhbm93AGG+LB7w0Y4 BQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 38wjdg080t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Jun 2021 12:19:54 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 73DA110002A;
        Tue,  1 Jun 2021 12:19:53 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 57BDA21B330;
        Tue,  1 Jun 2021 12:19:53 +0200 (CEST)
Received: from lmecxl0993.lme.st.com (10.75.127.45) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 1 Jun
 2021 12:19:52 +0200
From:   Philippe CORNU <philippe.cornu@foss.st.com>
Subject: Re: [PATCH] drm/stm: Remove usage of drm_display_mode_to_videomode()
To:     yannick Fertre <yannick.fertre@foss.st.com>,
        Antonio Borneo <antonio.borneo@st.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "Alexandre Torgue" <alexandre.torgue@st.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, "Marek Vasut" <marex@denx.de>
References: <20210528080513.8168-1-yannick.fertre@foss.st.com>
 <7f99af28-f4ef-303b-2844-89dc266d1ace@foss.st.com>
Message-ID: <d5ed22bc-3c28-f8a0-946b-6c82c16f03e1@foss.st.com>
Date:   Tue, 1 Jun 2021 12:19:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <7f99af28-f4ef-303b-2844-89dc266d1ace@foss.st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-01_05:2021-05-31,2021-06-01 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marek,

Many thanks for your patch and sorry for the delay regarding this "last 
Christmas" patch (Dec. 24, 2020), lost in my inbox :(

Could you please resend it (as I did not succeed to apply it directly)?

patchwork reference 
https://patchwork.freedesktop.org/patch/409968/?series=85222

Many thanks,
Philippe :-)


On 5/28/21 4:01 PM, yannick Fertre wrote:
> 
> Hi Philippe,
> I have already reviewed this patch on January 7, 2020.
> (https://lore.kernel.org/dri-devel/0ab4ee45-4437-3b02-cf63-0e3b1b53920f@st.com/) 
> 
> Could you please review it and merge it?
> 
> Best regards
> 
> Yannick
> 
> On 5/28/21 10:05 AM, Yannick Fertre wrote:
>> There is not much value in the extra conversion step, the calculations
>> required for the LTDC IP are different than what is used in the
>> drm_display_mode_to_videomode(), so just do the right ones in the LTDC
>> driver right away.
>>
>> Signed-off-by: Marek Vasut <marex@denx.de>
>> Signed-off-by: Yannick Fertre <yannick.fertre@foss.st.com>
>> ---
>>   drivers/gpu/drm/stm/ltdc.c | 32 +++++++++++++++++---------------
>>   1 file changed, 17 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
>> index e99771b947b6..d113b9be12c0 100644
>> --- a/drivers/gpu/drm/stm/ltdc.c
>> +++ b/drivers/gpu/drm/stm/ltdc.c
>> @@ -570,31 +570,33 @@ static void ltdc_crtc_mode_set_nofb(struct 
>> drm_crtc *crtc)
>>           }
>>       }
>> -    drm_display_mode_to_videomode(mode, &vm);
>> -
>>       DRM_DEBUG_DRIVER("CRTC:%d mode:%s\n", crtc->base.id, mode->name);
>> -    DRM_DEBUG_DRIVER("Video mode: %dx%d", vm.hactive, vm.vactive);
>> +    DRM_DEBUG_DRIVER("Video mode: %dx%d", mode->hdisplay, 
>> mode->vdisplay);
>>       DRM_DEBUG_DRIVER(" hfp %d hbp %d hsl %d vfp %d vbp %d vsl %d\n",
>> -             vm.hfront_porch, vm.hback_porch, vm.hsync_len,
>> -             vm.vfront_porch, vm.vback_porch, vm.vsync_len);
>> +             mode->hsync_start - mode->hdisplay,
>> +             mode->htotal - mode->hsync_end,
>> +             mode->hsync_end - mode->hsync_start,
>> +             mode->vsync_start - mode->vdisplay,
>> +             mode->vtotal - mode->vsync_end,
>> +             mode->vsync_end - mode->vsync_start);
>>       /* Convert video timings to ltdc timings */
>> -    hsync = vm.hsync_len - 1;
>> -    vsync = vm.vsync_len - 1;
>> -    accum_hbp = hsync + vm.hback_porch;
>> -    accum_vbp = vsync + vm.vback_porch;
>> -    accum_act_w = accum_hbp + vm.hactive;
>> -    accum_act_h = accum_vbp + vm.vactive;
>> -    total_width = accum_act_w + vm.hfront_porch;
>> -    total_height = accum_act_h + vm.vfront_porch;
>> +    hsync = mode->hsync_end - mode->hsync_start - 1;
>> +    vsync = mode->vsync_end - mode->vsync_start - 1;
>> +    accum_hbp = mode->htotal - mode->hsync_start - 1;
>> +    accum_vbp = mode->vtotal - mode->vsync_start - 1;
>> +    accum_act_w = accum_hbp + mode->hdisplay;
>> +    accum_act_h = accum_vbp + mode->vdisplay;
>> +    total_width = mode->htotal - 1;
>> +    total_height = mode->vtotal - 1;
>>       /* Configures the HS, VS, DE and PC polarities. Default Active 
>> Low */
>>       val = 0;
>> -    if (vm.flags & DISPLAY_FLAGS_HSYNC_HIGH)
>> +    if (mode->flags & DRM_MODE_FLAG_PHSYNC)
>>           val |= GCR_HSPOL;
>> -    if (vm.flags & DISPLAY_FLAGS_VSYNC_HIGH)
>> +    if (mode->flags & DRM_MODE_FLAG_PVSYNC)
>>           val |= GCR_VSPOL;
>>       if (bus_flags & DRM_BUS_FLAG_DE_LOW)
>>
