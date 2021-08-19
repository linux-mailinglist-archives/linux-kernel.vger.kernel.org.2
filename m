Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1B003F2372
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 00:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236420AbhHSW6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 18:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbhHSW6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 18:58:21 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E018C061575
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 15:57:44 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id z2so7646143iln.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 15:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dqyq+xLCC62WmtlbZNmPjxhJEJorkWCEaN0Bhw2AePY=;
        b=cooKeToWpfZekERzCgF0kWR6bvPZBKI+V6Im5GxgZiTYFO0YF/kOpLxrerXm7nf7L0
         qAyTMoV5DhF8fVFq+DvreRkoGtQg1mA1918Y8s+P5Fx9kpyYfQovpbKQTovjTxuTBgQA
         pBht8ci2g8MBR2gtAS/xVkND32I1qDDjH4LwU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dqyq+xLCC62WmtlbZNmPjxhJEJorkWCEaN0Bhw2AePY=;
        b=Mz5ri2EZk4y4OvpRew5z0wpO9c3H7roBgDnxYwuJgdjV0I+a3vEU3w2ONv+/L3n+UP
         gGDdvqQah6IaSDT/wz8irQfqfusToxzqTxLD0iPxQh25vEitV6YXuzEQopLV4cb6UVPJ
         zAMgce5HUu+2G7NrfEfYWn6j8Q0Ex5y6uH71XoP3QtThfsVeDQGvMm1pVKU6SwI0SbME
         8mWIFILh76Yhtkl+kozPl1tV/r8ZXncS0vIm8kEcmyQRorsv2jdyGVqv1Uv6N/px2gRU
         IbhU3vojwau94VZ3MaszSPQHxodDa8XWaCF+8aLFHzLjQIeDTY6eGiJiQvUUyqQSolnH
         O0AQ==
X-Gm-Message-State: AOAM533AwH44Uf+NGdOQvCivfynGENtATi4m2mu1YUslbfRnAbqMT0Yx
        QhpmwjPjSXfmFNjd0QxdF8XNxw==
X-Google-Smtp-Source: ABdhPJwQZ73vfotSnWwgMIvfGhwDa5AtWHmSypp0n37PAVBu8xmpd6r/tOmHTAfQmO3MuQpW2Ox8Gw==
X-Received: by 2002:a92:360e:: with SMTP id d14mr11069647ila.171.1629413863755;
        Thu, 19 Aug 2021 15:57:43 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id g23sm2277471ioc.8.2021.08.19.15.57.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Aug 2021 15:57:42 -0700 (PDT)
Subject: Re: [PATCH v2] vhci_hcd: USB port can get stuck in the disabled state
To:     Michael <msbroadf@gmail.com>
Cc:     valentina.manea.m@gmail.com, shuah@kernel.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20210721235526.10588-1-msbroadf@gmail.com>
 <7b02cb66-d672-ae95-01ea-c6015725e1ac@linuxfoundation.org>
 <CALdjXpA4_eXen6RjhsEBYt8CQs-2gzwYs9h9q0Z2LKZ=rXVp+Q@mail.gmail.com>
 <ad07410b-05d6-6a12-13df-14e31cbf50ff@linuxfoundation.org>
 <CALdjXpBPRraC8xxORgE3SXw4xFnTW-Y6rLbcS+Cx0xYq3+aBeQ@mail.gmail.com>
 <976d34c0-d603-1f16-edbd-ad6c8881ad4e@linuxfoundation.org>
 <CALdjXpAzE3o7Bwdvj1TvsBRpDWDe1FZ8LsmL5q0suxYnRJCOaA@mail.gmail.com>
 <5165bd84-11af-35dd-8a9b-11c7f219fb88@linuxfoundation.org>
 <CALdjXpCmx_nfYEguv9UvOrBMYFxB4sqwmNiV99ggHRZnZjiM-A@mail.gmail.com>
 <4f345afe-61d5-66b3-3252-562988c8926f@linuxfoundation.org>
 <CALdjXpB+-RHMrjt10f1ZksR9VZMuT3gj7HyvrXYtdJ_jq0J93g@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <3349aa56-afa0-a919-5810-3dbbdbe8717b@linuxfoundation.org>
Date:   Thu, 19 Aug 2021 16:57:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CALdjXpB+-RHMrjt10f1ZksR9VZMuT3gj7HyvrXYtdJ_jq0J93g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/21 8:30 PM, Michael wrote:
> On Wed, 11 Aug 2021 at 03:46, Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> On 8/2/21 7:00 PM, Michael wrote:
>>> On Tue, 3 Aug 2021 at 09:14, Shuah Khan <skhan@linuxfoundation.org> wrote:
>>>>
>>>> On 7/30/21 5:52 PM, Michael wrote:
>>>>> Yes i think just adding the VDEV_ST_USED check in addition to the
>>>>> VDEV_ST_NOT_ASSIGNED state is fine and would fix the issue.
>>>>>
>>>>
>>>> Can you please confirm if this works?
>>>>
>>>>> After many years of writing virtualhere (a similar system to usb/ip
>>>>> but cross-platform and different non-kernel way of doing it server
>>>>> side) I've seen many drivers that issue reset at any time. Loading
>>>>> firmware is usually the reason.  Also sometimes switching
>>>>> configurations requires a reset also, for example some gaming wheels
>>>>> do this. I don't think you should make this VDEV_ST_USED check
>>>>> specific to Wifi devices, as a lot of devices don't follow too closely
>>>>> to the USB protocol to begin with from my experience. They primarily
>>>>> base their USB interactions assuming the windows platform and its
>>>>> quirks.
>>>>>
>>>>
>>>> When sending responses to Linux kernel mailing lists, please use bottom post.
>>>> This check will be used for all drivers. We don't add checks for specific cases
>>>> in the code.
>>>>
>>>> thanks,
>>>> -- Shuah
>>>>
>>>
>>> Yes it works with that change.
>>>
>>
>> Would you like to send me a patch for this?
>>
>> thanks,
>> -- Shuah
> 
> usbip: Allow port reset to occur when the port is also in the ST_USED state
> 
>   Signed-off-by: Michael <mail@virtualhere.com>
> ---
>   drivers/usb/usbip/vhci_hcd.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
> index 4ba6bcdaa8e9..300131ae5897 100644
> --- a/drivers/usb/usbip/vhci_hcd.c
> +++ b/drivers/usb/usbip/vhci_hcd.c
> @@ -456,7 +456,9 @@ static int vhci_hub_control(struct usb_hcd *hcd,
> u16 typeReq, u16 wValue,
>                          vhci_hcd->re_timeout = 0;
> 
>                          if (vhci_hcd->vdev[rhport].ud.status ==
> -                           VDEV_ST_NOTASSIGNED) {
> +                           VDEV_ST_NOTASSIGNED ||
> +                               vhci_hcd->vdev[rhport].ud.status ==
> +                               VDEV_ST_USED) {
>                                  usbip_dbg_vhci_rh(
>                                          " enable rhport %d (status %u)\n",
>                                          rhport,
> --
> 2.30.2
> 

Unfortunately we can't apply this diff. I turned this into a proper
patch giving you credit for reporting the problem, suggesting the
fix and testing it. Patch will be sent shortly.

thanks,
-- Shuah
