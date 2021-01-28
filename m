Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3206530735E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 11:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232419AbhA1KDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 05:03:21 -0500
Received: from foss.arm.com ([217.140.110.172]:55722 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231872AbhA1KCh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 05:02:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A6BA11042;
        Thu, 28 Jan 2021 02:01:51 -0800 (PST)
Received: from [10.57.11.243] (unknown [10.57.11.243])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E779B3F766;
        Thu, 28 Jan 2021 02:01:49 -0800 (PST)
Subject: Re: [PATCH] drm/lima: add governor data with pre-defined thresholds
To:     Christian Hewitt <christianshewitt@gmail.com>
Cc:     Qiang Yu <yuq825@gmail.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, lima@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Steven Price <steven.price@arm.com>
References: <20210125081804.13016-1-christianshewitt@gmail.com>
 <9e30a8e1-ef69-5929-17f1-cdb603686495@arm.com>
 <88ae6467-07fc-2c4e-9db9-a02a00d01347@arm.com>
 <08B992A3-6A8C-4585-8B0D-EE0DA6C5F4E2@gmail.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <3b38b9ce-e93e-5850-5321-e2208927c36c@arm.com>
Date:   Thu, 28 Jan 2021 10:01:47 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <08B992A3-6A8C-4585-8B0D-EE0DA6C5F4E2@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/27/21 7:35 PM, Christian Hewitt wrote:
> 
>> On 27 Jan 2021, at 3:11 pm, Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>> On 1/27/21 10:24 AM, Lukasz Luba wrote:
>>> Hi Christian,
>>> On 1/25/21 8:18 AM, Christian Hewitt wrote:
>>>> This patch adapts the panfrost pre-defined thresholds change [0] to the
>>>> lima driver to improve real-world performance. The upthreshold value has
>>>> been set to ramp GPU frequency to max freq faster (compared to panfrost)
>>>> to compensate for the lower overall performance of utgard devices.
>>>>
>>>> [0] https://patchwork.kernel.org/project/dri-devel/patch/20210121170445.19761-1-lukasz.luba@arm.com/
>>>>
>>>> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
>>>> ---
>>>> I have been using Kodi as my test application. If you scroll in library
>>>> views with hundreds of list items and the panfrost values the slow GPU
>>>> ramp up is quite noticeable and the GUI feels sluggish. As everything
>>>> lima runs on is inherently slower than panfrost using devices I believe
>>>> it's better to ramp up to max freq quicker.
>>> It's quite low value for the upthreshold, but I believe you have
>>> experimented and observed that a bit higher (30, 40?) don't work well.
>>> I don't know the Kodi system, though.
>>> You can check if the other frequencies are also used in statistics for
>>> devfreq device:
>>> cat /sys/class/devfreq/<your_gpu>/trans_stats
>>> If they are also used, then it OK (better than stuck at min freq).
>>
>> I've just realized that your board might suffer a another issue.
>> Please apply this patch [1] and run your experiments with upthresholds.
>>
>> [1] https://lore.kernel.org/lkml/20210127105121.20345-1-lukasz.luba@arm.com/
> 
> I’ve included the patch and with unscientific testing it feels snappier with a larger value than
> before. I did revert back to 45 first, but again this feels sluggish when navigating around the
> Kodi GUI. My main test is to enter ‘Movies’ in Kodi then start scrolling in a long list. When
> the GPU ramps up quickly the experience is snappy, but when it ramps more conservatively
> scrolling feels like it stutters, then (once you hit max freq) it becomes fluid.
> 
> WP2:~ # cat /sys/class/devfreq/d00c0000.gpu/trans_stat
>       From  :   To
>             : 125000000 250000000 285714285 400000000 500000000 666666666 744000000   time(ms)
> * 125000000:         0         0         0         0         0         0       264     52720
>    250000000:         9         0         0         0         0         0        36      3404
>    285714285:         9         3         0         0         0         0        32      2628
>    400000000:        18        20        13         0         0         0       191     21140
>    500000000:        12        12         8        63         0         0        31     10068
>    666666666:       179         5        16       133        66         0        24     29360
>    744000000:        37         5         7        46        60       423         0     46016
> 
> I’ll send v2 with the value set to 30.

Thank you Christian for re-testing it and attaching the stats. It looks
good. I'll add my reviewed-by for v2 patch.

Regards,
Lukasz
