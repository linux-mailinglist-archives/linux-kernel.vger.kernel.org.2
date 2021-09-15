Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE1E40C8E1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 17:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238441AbhIOPvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 11:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238613AbhIOPvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 11:51:23 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D106C0617A9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 08:49:43 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id g16so4644615wrb.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 08:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=gxvIk/3dplKod5R6MerJbNpMQbcwiJJARjdwQMpnT/w=;
        b=hRZA9gFOO6PpVTFsKSMyJe/x/ov5s+egnBGCmw4dR5IvYHu3MRtEKWc4ItAprWcP68
         U+sRGHAPP0ydaD+4HfmOkxooRx8jc7tb5/jVKzSGcPIAd5crr7dksUMrvUgP+HRrSbOL
         rQQXiJ6g+En1AJWphzMKkmbObVrMXm4BSLkyxbGyccqq+2Ga4PEChA/H+lMgUf1+NX7s
         TwPUdNmW+Gh/pQoTC1G1ZZF15XDIteajUWsM4pGfXzEeLVymGzcXYPigFJ6g72xS9neh
         4pryab3M/rzOepHAajzPDFzEVs8/CB403UChETzfLUbEMtPh/pOU2uCM+T6fnZwUEkmh
         rdHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gxvIk/3dplKod5R6MerJbNpMQbcwiJJARjdwQMpnT/w=;
        b=QsEvJI8lWPPPDRPpUHonb85QzSECsPYc+L9SrLcSEFVqh+3PAx9TZwEhQavJ1BSru7
         DDaTJS9WJ7X1QjIXSkQwgyMRWk7BKeOwrHckZJbx70f0UycLyO8K4QmfJ/UFpVGAn6xW
         2WVH1f9FQrJ/vLJem8/n/hGcSgCl9sWbK9ufPFe7iG3b5p80VEb7LEyCc/KJt9x4AjMQ
         at3ZqLNDWIQnlliVR9WZS00ROKcQlFsS0z5lwrdM6mmUDxuloBUiBPiKsUXMyWPSy8OH
         MqyHsVJPu8TeGdVnnW7jiYlKb7441EHWlTRhrPXN0KLWG2fFjQafgO1VOWYCIWiVRfzI
         816A==
X-Gm-Message-State: AOAM5303iYUYoygbi4gPU2pXR9BP1KZP1OnbCiUh8j6s+afew3DmMbnL
        PD+IEYVqgVhrExsiFBDq2MY=
X-Google-Smtp-Source: ABdhPJzksEhuqES2o1uIFL2bXdOHeDbnnWn+XtNMfBOge294ryKCmV27h7pIeWsf5WgoXSyZAbD5qg==
X-Received: by 2002:a5d:43d2:: with SMTP id v18mr773098wrr.98.1631720981849;
        Wed, 15 Sep 2021 08:49:41 -0700 (PDT)
Received: from ?IPV6:2a02:8108:96c0:3b88::ae40? ([2a02:8108:96c0:3b88::ae40])
        by smtp.gmail.com with ESMTPSA id i5sm325288wrc.86.2021.09.15.08.49.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Sep 2021 08:49:41 -0700 (PDT)
Message-ID: <f0fcfced-3d32-f302-10f2-a1eeca57039e@gmail.com>
Date:   Wed, 15 Sep 2021 17:49:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.3
Subject: Re: [PATCH v2 0/4] staging: r8188eu: remove unused fields from struct
 hal_data_8188e
Content-Language: en-US
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20210915090156.4169-1-straube.linux@gmail.com>
 <2416232.Kz4EfdPaPr@localhost.localdomain>
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <2416232.Kz4EfdPaPr@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/15/21 15:34, Fabio M. De Francesco wrote:
> On Wednesday, September 15, 2021 11:01:52 AM CEST Michael Straube wrote:
>> This series removes some unused fields from struct hal_data_8188eu.
>>
>> Tested on x86_64 with Inter-Tech DMG-02.
>>
>> v1 -> v2
>> Fixed a typo in the subject line of patch 3/4.
>>
>> Michael Straube (4):
>>    staging: r8188eu: remove unused macros from rtl8188e_hal.h
>>    staging: r8188eu: remove write-only fields from struct hal_data_8188e
>>    staging: r8188eu: remove unused enums from rtl8188e_hal.h
>>    staging: r8188eu: remove unused field from struct hal_data_8188e
>>
>>   .../staging/r8188eu/hal/rtl8188e_hal_init.c   |  5 -----
>>   .../staging/r8188eu/include/rtl8188e_hal.h    | 22 -------------------
>>   2 files changed, 27 deletions(-)
>>
>> -- 
>> 2.33.0
> 
> Hi Michael,
> 
> Due to your removals, this driver is now about a third lighter. After fixing
> that little issue that Philip noticed, this series looks as good as any of
> yours. So...
> 
> Acked-by:  Fabio M. De Francesco <fmdefrancesco@gmail.com>

Thank you Fabio.

Well others have contributed to rip out unused code too. ;)
It's nice to see so many people care about this driver. Seems there is a
little chance to get it out of staging some day... though there is still
a lot of work/cleanup to do.

Regards,
Michael
