Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCC833927B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 16:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbhCLPyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 10:54:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232229AbhCLPx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 10:53:57 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A096C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 07:53:57 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id y16so5093754wrw.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 07:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Nf/x3zdOo4NltH5YdliW8QtzzVE+SJmh6Ofm5Su6NTI=;
        b=DPoPxHIC42Nu7DXh2UsEAnJWPFfA50NY9vRtjTTu52q/y2IropDXGPAanOKL276Dux
         /yBBODZK/+F0U2WDPTSeqONqwea06TkjA00UKGmBvd7aIMO1N3odzUpf12f0jNO4IQ70
         NBNbtrI7KpVb1DMvauN+htMpb4eQ5TgBoY81JaKbJ+mZQ11eFi0Yxr9/Zmc8tAS9Ar7O
         1fGOK1KCMrQ8AUsSNR/VgkUIPziYbegKu35VvAVMrjcyRSc4xI7Lgrn/9iyqltNROjOP
         1s3UGwvKG+1cr2Dd12gq1GxOVY3tuYQiNAizic26XSjKGLZdMuXSQBr0N+fgfPMDXDHL
         E5PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Nf/x3zdOo4NltH5YdliW8QtzzVE+SJmh6Ofm5Su6NTI=;
        b=mwqX4jAHaGoWyhLt3bAlvUgdzBSiFTHwUuksezepiUfxr35vxV9LC/boPS3lk8Lixj
         GS3AMwbqSo7AJB/HcRqXhTRRkrlPdQeo3+1IjlzNUGpFj7OLqNSvz0wKd6vyZz+fVU20
         r/7H33dMguh1yCTE+rtJg6sFG//sA1DNGM2de6OfG6Kk8hvJOjE0GZFdxASVIA8c16YD
         mV4caOLnnkacIp2qc+UVXjSfYiN5viyOZkbWR5PfkNFaWd8wL34CdJ9rnbeotsl2IBlr
         cJipSUGMR0bYja0ESCGVY7BH4DQHWpAbka6zb7C2UKrUdkO+QvMAalhm+lUR/7+8mNhp
         /Q+Q==
X-Gm-Message-State: AOAM531OIiGAL4e10T8K5IdPbqNMb2vD/Vh0RH/LHNMtu7FBt4nZ4FDf
        skpyb9/KwN5sjY/XPhKrn57pca+5yfoXjw==
X-Google-Smtp-Source: ABdhPJyOgIySm2XuuxssRqoflifsys8dPKXZGlhOXbB4SqKGDnrsUhWWwqynyp7g5FQ058K4gPpjoQ==
X-Received: by 2002:a5d:4903:: with SMTP id x3mr14701303wrq.143.1615564435935;
        Fri, 12 Mar 2021 07:53:55 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:cc8a:6653:68f4:ff69? ([2a01:e34:ed2f:f020:cc8a:6653:68f4:ff69])
        by smtp.googlemail.com with ESMTPSA id h22sm2964654wmb.36.2021.03.12.07.53.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Mar 2021 07:53:55 -0800 (PST)
Subject: Re: [PATCH 2/3] thermal/drivers/devfreq_cooling: Use device name
 instead of auto-numbering
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     rui.zhang@intel.com, amitk@kernel.org, linux-pm@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
References: <20210310114600.27178-1-daniel.lezcano@linaro.org>
 <20210310114600.27178-2-daniel.lezcano@linaro.org>
 <8f17dc8b-3259-8e6a-f46b-b97495ecd550@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <345395f7-006d-c879-a777-c24d79ae9e23@linaro.org>
Date:   Fri, 12 Mar 2021 16:53:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <8f17dc8b-3259-8e6a-f46b-b97495ecd550@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/03/2021 12:15, Lukasz Luba wrote:
> 
> 
> On 3/10/21 11:45 AM, Daniel Lezcano wrote:
>> Currently the naming of a cooling device is just a cooling technique
>> followed by a number. When there are multiple cooling devices using
>> the same technique, it is impossible to clearly identify the related
>> device as this one is just a number.
>>
>> For instance:
>>
>>   thermal-devfreq-0
>>   thermal-devfreq-1
>>   etc ...
>>
>> The 'thermal' prefix is redundant with the subsystem namespace. This
>> patch removes the 'thermal prefix and changes the number by the device
> 
> missing ' after 'thermal
> 
>> name. So the naming above becomes:
>>
>>   devfreq-5000000.gpu
>>   devfreq-1d84000.ufshc
>>   etc ...
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---

[ ... ]

> ---------------------------------------------------------
> 
> We should allocate tmp buffer for it, to not loose the meaningful part
> of that string name or end up with only the same prefix, like for the
> first 3 from top:
> 
> devfreq-18321000.qco
> 
> or for the GPU:
> devfreq-3d00000.qcom
> 
> This is tricky area and vendors might put any non-meaningful prefix.
> 
> The rest of the code looks OK, only this name construction part.

That requires a change in the thermal_core code to replace the strlcpy
into the cdev->type by a kstrdup.

Otherwise the name will be truncated in any case by the underlying
thermal_cooling_device_register() function.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
