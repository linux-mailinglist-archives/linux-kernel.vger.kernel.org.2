Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7BC40DA33
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 14:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239828AbhIPMnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 08:43:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33386 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240010AbhIPMnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 08:43:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631796099;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r4AJF4HobndyOklY50amdYHMzmPAKT1BKl478/qkMHo=;
        b=a9//J4FXEwVjd19V5DdMoHgVD+dnsHLXfKlbHHxua8h48nn9FMKw6c/VSVFnv7X3xV/tT0
        tHQTEI91NcV2JvLe1B3AXnmjhP2FM0KoSQoTz0ydL63RV7LU6xsPBTBhQcHPBdq4MvuB+E
        ES8JgLRJBAMNxQTI6LZISdTgEVhRipM=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-494-A52BXP_4P5WBKKcy9--C4w-1; Thu, 16 Sep 2021 08:41:38 -0400
X-MC-Unique: A52BXP_4P5WBKKcy9--C4w-1
Received: by mail-qk1-f200.google.com with SMTP id h7-20020a37b707000000b003fa4d25d9d0so33606739qkf.17
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 05:41:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=r4AJF4HobndyOklY50amdYHMzmPAKT1BKl478/qkMHo=;
        b=OwykC4V6QDeeTCuF4S4uqWeZaXm4JGTPHyy3HRiWc0zN1RQQFlCsICo6dwYFFTpziY
         PHY3MMZZetP/Cq24c5IxBJqCaOPm0M6Km0f6oW50QEFyxDHzXOg4h8at+92m19gaayrJ
         YAUWLARpTjEQyCpNJvq5rdlSX92Jb+HM7LvVgURxcJAHoFa1fzLTlh/H/RxTxhBnFRLA
         OLTPYK8+3hfVSP0416wUkkaoM77N9M8lQ8L21DIk4yfb6F7Kpxf0UeM6GJI/+4nuscke
         Q4rr+7Y6BSJr3+WZU1mpcjU6qzj6MUNFIeHm6NWSjjw+finiB6N/+VmSPNZS7Foz6rbZ
         QhFA==
X-Gm-Message-State: AOAM530v8LzYBRGK8VSfiU+5+uLMd3gdYBQHMLX+en7u9XxNxCywdg7B
        dCAkpif6sBk9eeHhQourN1n9V73xPtZLzj1oXzCzYnfe1Stdd9XQsYi9lBI6tLoKcwQY1vxf9Ak
        B4gCUJU/CitLjI8X3DDFR5B/+
X-Received: by 2002:a37:391:: with SMTP id 139mr4816658qkd.356.1631796098195;
        Thu, 16 Sep 2021 05:41:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyLHkvXEq/rZbrCi80t8T/eQL0RywgfsYsJ86+FTcHAlSlKihhks7GjCtfMfWatsITkTdmdVw==
X-Received: by 2002:a37:391:: with SMTP id 139mr4816629qkd.356.1631796097919;
        Thu, 16 Sep 2021 05:41:37 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id g27sm1857762qts.79.2021.09.16.05.41.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Sep 2021 05:41:37 -0700 (PDT)
Subject: Re: [PATCH] MAINTAINERS: Add Tom Rix as fpga maintainer
To:     Moritz Fischer <mdf@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>, hao.wu@intel.com,
        linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
References: <20210914182333.3903389-1-trix@redhat.com>
 <YUDw0gvgdijpytfU@kroah.com>
 <25d1dac2-4f9f-b5f0-8ce8-b88442deac9d@redhat.com>
 <YUH9dg01Mtk+kO+C@kroah.com>
 <c0630361-69cf-992a-78bf-a1c8335acd28@redhat.com>
 <YUJdts/9kowAen+K@epycbox.lan>
From:   Tom Rix <trix@redhat.com>
Message-ID: <ad209636-a819-5bd5-b643-1cda12201a73@redhat.com>
Date:   Thu, 16 Sep 2021 05:41:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YUJdts/9kowAen+K@epycbox.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/15/21 1:55 PM, Moritz Fischer wrote:
> On Wed, Sep 15, 2021 at 09:12:51AM -0700, Tom Rix wrote:
>> On 9/15/21 7:04 AM, Greg KH wrote:
>>> On Wed, Sep 15, 2021 at 06:23:16AM -0700, Tom Rix wrote:
>>>> On 9/14/21 11:58 AM, Greg KH wrote:
>>>>> [note, you got the maintainer's email address wrong on your cc: line
>>>>>     I fixed it up...]
>>>>>
>>>>> On Tue, Sep 14, 2021 at 11:23:33AM -0700, trix@redhat.com wrote:
>>>>>> From: Tom Rix <trix@redhat.com>
>>>>>>
>>>>>> I am the maintainer of the fpga/ subsystem for both the kernel and
>>>>>> userspace for Red Hat.  I have been an active reviewer and contributor
>>>>>> on for public fpga/ subsystem for the last year.  I would like to
>>>>>> help out more.
>>>>>>
>>>>>> Since I am paid to do this work, change the status to Supported.
>>>>>>
>>>>>> Signed-off-by: Tom Rix <trix@redhat.com>
>>>>>> ---
>>>>>>     MAINTAINERS | 4 ++--
>>>>>>     1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>>>> index 04fa4edf100b83..0443d7ab826659 100644
>>>>>> --- a/MAINTAINERS
>>>>>> +++ b/MAINTAINERS
>>>>>> @@ -7353,9 +7353,9 @@ F:	include/uapi/linux/fpga-dfl.h
>>>>>>     FPGA MANAGER FRAMEWORK
>>>>>>     M:	Moritz Fischer <mdf@kernel.org>
>>>>>> -R:	Tom Rix <trix@redhat.com>
>>>>>> +M:	Tom Rix <trix@redhat.com>
>>>>>>     L:	linux-fpga@vger.kernel.org
>>>>>> -S:	Maintained
>>>>>> +S:	Supported
>>>>>>     W:	http://www.rocketboards.org
>>>>>>     Q:	http://patchwork.kernel.org/project/linux-fpga/list/
>>>>>>     T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga.git
>>>>>> -- 
>>>>>> 2.26.3
>>>>>>
>>>>> Traditionally existing maintainers are the ones that add new
>>>>> maintainers, it's not something that you just submit a patch for hoping
>>>>> it will be accepted.
>>>>>
>>>>> What has changed since the last time you asked to do this?
>>>> Because public and private requests have gone unanswered for so long, it is
>>>> unclear if Moritz is still maintaining the subsystem.
>>> He is, as is evident by the patches I accept from him each merge.
>>>
>>>> The nearly year old xrt patchset has been pending for 6 weeks with minor
>>>> changes to one patch out of 14 needing reviews.
>>> Code quality is not the maintainer's job, it's the developer's, so the
>>> age and number of reviews is not any indication.
>> https://lore.kernel.org/linux-fpga/20210802160521.331031-1-lizhi.hou@xilinx.com/
>>
>> The review is needed because Moritz asked for the changes v8 here
>>
>> https://lore.kernel.org/linux-fpga/YP42zE2ljx4hHj40@epycbox.lan/
>>
>> When the maintainer asks for the changes, they are responsible for the
>> followup.
>>
>>>> The standard release patchset, which needs an opinion has on an api change,
>>>> has been outstanding for 8 weeks.
>>> Have a pointer to it?
>> This was a change you requested. the recent patchset is
>>
>> https://lore.kernel.org/linux-fpga/20210914214327.94048-4-russell.h.weight@intel.com/
>>
>> The discussion around the api change is
>>
>> https://lore.kernel.org/linux-fpga/661d53d0-0ba4-d344-8da0-995a9b612905@redhat.com/
>>
>> In these toss up's if the maintainer does not weigh in as the tie breaker,
>> the patch stalls.
>>
>>>> If maintainership depends on an approving maintainter, what happens when the
>>>> approving maintainer has left ?
>>> Vacations happen in the summer.  I've talked to Moritz many times, and
>>> all is well here.
>> Yes. in the xrt v9 patch Moritz announced late of a vacation with a return
>> of 9/4.
>>
>> It has been 11 days.
> I had a family issue that was unforseen combined with an unusual high
> post-vacation workload at $dayjob when I got back.
>
> I'm still catching up, and will get to it when I can.

I almost never take vacation because of the post vacation workload.

You not having backup is a problem.

Please consider taking the help I am offering.

Tom

>   
> - Moritz
>

