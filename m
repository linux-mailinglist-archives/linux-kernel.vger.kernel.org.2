Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A907330F4F9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 15:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236723AbhBDOaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 09:30:20 -0500
Received: from foss.arm.com ([217.140.110.172]:59204 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236655AbhBDOYq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 09:24:46 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0C2DAD6E;
        Thu,  4 Feb 2021 06:24:00 -0800 (PST)
Received: from [10.57.11.154] (unknown [10.57.11.154])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D7A223F694;
        Thu,  4 Feb 2021 06:23:57 -0800 (PST)
Subject: Re: [PATCH] drm/lima: Use delayed timer as default in devfreq profile
To:     Robin Murphy <robin.murphy@arm.com>, Qiang Yu <yuq825@gmail.com>
Cc:     lima@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Christian Hewitt <christianshewitt@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
References: <20210127105121.20345-1-lukasz.luba@arm.com>
 <CAKGbVbsn=xVEa0=c3rywRShVZD18LkmLZ1qDUuDsrT5KnTjr6g@mail.gmail.com>
 <3d1b4696-0172-f88a-f41f-c66ac3baa429@arm.com>
 <CAKGbVbsuqsGYRqUyWRiC+h9o7kNMvB16-Y6378KG_rv0SG4VDQ@mail.gmail.com>
 <aab9c140-155e-894f-5b7d-749396a388fc@arm.com>
 <CAKGbVbvTzmj=3tAyNyDRU8autb+de8R9dc6ohBTuM5miJV4cWg@mail.gmail.com>
 <0afa6299-1c35-ab98-702e-8dcd168bcaac@arm.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <deb2c075-4177-d487-b1cd-1c60790ca625@arm.com>
Date:   Thu, 4 Feb 2021 14:23:56 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <0afa6299-1c35-ab98-702e-8dcd168bcaac@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/4/21 1:39 PM, Robin Murphy wrote:
> On 2021-02-03 02:01, Qiang Yu wrote:
>> On Tue, Feb 2, 2021 at 10:02 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>>
>>>
>>>
>>> On 2/2/21 1:01 AM, Qiang Yu wrote:
>>>> Hi Lukasz,
>>>>
>>>> Thanks for the explanation. So the deferred timer option makes a 
>>>> mistake that
>>>> when GPU goes from idle to busy for only one poll periodic, in this
>>>> case 50ms, right?
>>>
>>> Not exactly. Driver sets the polling interval to 50ms (in this case)
>>> because it needs ~3-frame average load (in 60fps). I have discovered the
>>> issue quite recently that on systems with 2 CPUs or more, the devfreq
>>> core is not monitoring the devices even for seconds. Therefore, we might
>>> end up with quite big amount of work that GPU is doing, but we don't
>>> know about it. Devfreq core didn't check <- timer didn't fired. Then
>>> suddenly that CPU, which had the deferred timer registered last time,
>>> is waking up and timer triggers to check our device. We get the stats,
>>> but they might be showing load from 1sec not 50ms. We feed them into
>>> governor. Governor sees the new load, but was tested and configured for
>>> 50ms, so it might try to rise the frequency to max. The GPU work might
>>> be already lower and there is no need for such freq. Then the CPU goes
>>> idle again, so no devfreq core check for next e.g. 1sec, but the
>>> frequency stays at max OPP and we burn power.
>>>
>>> So, it's completely unreliable. We might stuck at min frequency and
>>> suffer the frame drops, or sometimes stuck to max freq and burn more
>>> power when there is no such need.
>>>
>>> Similar for thermal governor, which is confused by this old stats and
>>> long period stats, longer than 50ms.
>>>
>>> Stats from last e.g. ~1sec tells you nothing about real recent GPU
>>> workload.
>> Oh, right, I missed this case.
>>
>>>
>>>> But delayed timer will wakeup CPU every 50ms even when system is 
>>>> idle, will this
>>>> cause more power consumption for the case like phone suspend?
>>>
>>> No, in case of phone suspend it won't increase the power consumption.
>>> The device won't be woken up, it will stay in suspend.
>> I mean the CPU is waked up frequently by timer when phone suspend,
>> not the whole device (like the display).
>>
>> Seems it's better to have deferred timer when device is suspended for
>> power saving,
>> and delayed timer when device in working state. User knows this and
>> can use sysfs
>> to change it.
> 
> Doesn't devfreq_suspend_device() already cancel any timer work either 
> way in that case?

Correct, the governor should pause the monitoring mechanism (and timer).

Regards,
Lukasz
