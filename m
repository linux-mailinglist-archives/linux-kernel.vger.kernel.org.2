Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA3931F78E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 11:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbhBSKpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 05:45:51 -0500
Received: from m42-2.mailgun.net ([69.72.42.2]:30032 "EHLO m42-2.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229726AbhBSKpu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 05:45:50 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1613731524; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=PHtSozV1wqFYDIra8avEfQv4FUHfL153zH8ugwPj86E=; b=DL9eEGg8gIjvGj+Slj2dR57rMITobxHg7tWn2XUBwCwItGZsar04Vii+bdDIKdJ9tRCHS4YM
 sp808Wqlj68A80Ha2rhOiStd75zZCem489u5I3HHILRgd6OinMquPx14A4h3KOTGgqLVmJ/v
 L7BMQI4LdifjDznFqi6wkJkCd4A=
X-Mailgun-Sending-Ip: 69.72.42.2
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 602f969bba086638301ea862 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 19 Feb 2021 10:44:43
 GMT
Sender: akhilpo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CAB43C43469; Fri, 19 Feb 2021 10:44:41 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from [192.168.1.105] (unknown [117.217.236.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akhilpo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0D5F1C433ED;
        Fri, 19 Feb 2021 10:44:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0D5F1C433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=akhilpo@codeaurora.org
Subject: Re: [PATCH] drm/msm/a6xx: fix for kernels without CONFIG_NVMEM
To:     Rob Clark <robdclark@gmail.com>
Cc:     Jonathan Marek <jonathan@marek.ca>,
        freedreno <freedreno@lists.freedesktop.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Eric Anholt <eric@anholt.net>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20210216200909.19039-1-jonathan@marek.ca>
 <CAF6AEGv53nnzqMgTfSA6t2YpHx1dDW8UqnH9Gw0w3p8bf0mTLw@mail.gmail.com>
 <775436ba-c94a-ab22-d65b-b2391047ec65@codeaurora.org>
 <20210217190820.GA2229@jcrouse1-lnx.qualcomm.com>
 <CAF6AEGsHws23ozeJ8G23LFQ8J=CVVrx5xvkSgBuE_uSwT4YurQ@mail.gmail.com>
 <74d1277e-295f-0996-91c3-05cfce8d3a0e@marek.ca>
 <e4b62857-bd4d-cca6-0d6b-b9cc960b52a2@codeaurora.org>
 <CAF6AEGsWCrkOgMVxnx53k8b_o7xy3KWv9VaNRoY44+4GfXtWdg@mail.gmail.com>
From:   Akhil P Oommen <akhilpo@codeaurora.org>
Message-ID: <757b557a-b5f6-6018-caa4-34bffb1b60b7@codeaurora.org>
Date:   Fri, 19 Feb 2021 16:14:34 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAF6AEGsWCrkOgMVxnx53k8b_o7xy3KWv9VaNRoY44+4GfXtWdg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/18/2021 9:41 PM, Rob Clark wrote:
> On Thu, Feb 18, 2021 at 4:28 AM Akhil P Oommen <akhilpo@codeaurora.org> wrote:
>>
>> On 2/18/2021 2:05 AM, Jonathan Marek wrote:
>>> On 2/17/21 3:18 PM, Rob Clark wrote:
>>>> On Wed, Feb 17, 2021 at 11:08 AM Jordan Crouse
>>>> <jcrouse@codeaurora.org> wrote:
>>>>>
>>>>> On Wed, Feb 17, 2021 at 07:14:16PM +0530, Akhil P Oommen wrote:
>>>>>> On 2/17/2021 8:36 AM, Rob Clark wrote:
>>>>>>> On Tue, Feb 16, 2021 at 12:10 PM Jonathan Marek <jonathan@marek.ca>
>>>>>>> wrote:
>>>>>>>>
>>>>>>>> Ignore nvmem_cell_get() EOPNOTSUPP error in the same way as a
>>>>>>>> ENOENT error,
>>>>>>>> to fix the case where the kernel was compiled without CONFIG_NVMEM.
>>>>>>>>
>>>>>>>> Fixes: fe7952c629da ("drm/msm: Add speed-bin support to a618 gpu")
>>>>>>>> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
>>>>>>>> ---
>>>>>>>>    drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 6 +++---
>>>>>>>>    1 file changed, 3 insertions(+), 3 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>>>>>>>> b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>>>>>>>> index ba8e9d3cf0fe..7fe5d97606aa 100644
>>>>>>>> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>>>>>>>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>>>>>>>> @@ -1356,10 +1356,10 @@ static int a6xx_set_supported_hw(struct
>>>>>>>> device *dev, struct a6xx_gpu *a6xx_gpu,
>>>>>>>>
>>>>>>>>           cell = nvmem_cell_get(dev, "speed_bin");
>>>>>>>>           /*
>>>>>>>> -        * -ENOENT means that the platform doesn't support
>>>>>>>> speedbin which is
>>>>>>>> -        * fine
>>>>>>>> +        * -ENOENT means no speed bin in device tree,
>>>>>>>> +        * -EOPNOTSUPP means kernel was built without CONFIG_NVMEM
>>>>>>>
>>>>>>> very minor nit, it would be nice to at least preserve the gist of the
>>>>>>> "which is fine" (ie. some variation of "this is an optional thing and
>>>>>>> things won't catch fire without it" ;-))
>>>>>>>
>>>>>>> (which is, I believe, is true, hopefully Akhil could confirm.. if not
>>>>>>> we should have a harder dependency on CONFIG_NVMEM..)
>>>>>> IIRC, if the gpu opp table in the DT uses the 'opp-supported-hw'
>>>>>> property,
>>>>>> we will see some error during boot up if we don't call
>>>>>> dev_pm_opp_set_supported_hw(). So calling "nvmem_cell_get(dev,
>>>>>> "speed_bin")"
>>>>>> is a way to test this.
>>>>>>
>>>>>> If there is no other harm, we can put a hard dependency on
>>>>>> CONFIG_NVMEM.
>>>>>
>>>>> I'm not sure if we want to go this far given the squishiness about
>>>>> module
>>>>> dependencies. As far as I know we are the only driver that uses this
>>>>> seriously
>>>>> on QCOM SoCs and this is only needed for certain targets. I don't
>>>>> know if we
>>>>> want to force every target to build NVMEM and QFPROM on our behalf.
>>>>> But maybe
>>>>> I'm just saying that because Kconfig dependencies tend to break my
>>>>> brain (and
>>>>> then Arnd has to send a patch to fix it).
>>>>>
>>>>
>>>> Hmm, good point.. looks like CONFIG_NVMEM itself doesn't have any
>>>> other dependencies, so I suppose it wouldn't be the end of the world
>>>> to select that.. but I guess we don't want to require QFPROM
>>>>
>>>> I guess at the end of the day, what is the failure mode if you have a
>>>> speed-bin device, but your kernel config misses QFPROM (and possibly
>>>> NVMEM)?  If the result is just not having the highest clk rate(s)
>>
>> Atleast on sc7180's gpu, using an unsupported FMAX breaks gmu. It won't
>> be very obvious what went wrong when this happens!
> 
> Ugg, ok..
> 
> I suppose we could select NVMEM, but not QFPROM, and then the case
> where QFPROM is not enabled on platforms that have the speed-bin field
> in DT will fail gracefully and all other platforms would continue on
> happily?
> 
> BR,
> -R

Sounds good to me.

-Akhil.

> 
>>
>>>> available, that isn't the end of the world.  But if it makes things
>>>> not-work, that is sub-optimal.  Generally, especially on ARM, kconfig
>>>> seems to be way harder than it should be to build a kernel that works,
>>>> if we could somehow not add to that problem (for both people with a6xx
>>>> and older gens) that would be nice ;-)
>>>>
>>>
>>> There is a "imply" kconfig option which solves exactly this problem.
>>> (you would "imply NVMEM" instead of "select NVMEM". then it would be
>>> possible to disable NVMEM but it would get enabled by default)
>>>
>>>> BR,
>>>> -R
>>>>
>>> _______________________________________________
>>> dri-devel mailing list
>>> dri-devel@lists.freedesktop.org
>>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>>

