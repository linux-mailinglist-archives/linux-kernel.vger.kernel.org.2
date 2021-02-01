Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A32B30A4B6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 10:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232983AbhBAJyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 04:54:15 -0500
Received: from foss.arm.com ([217.140.110.172]:54570 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232972AbhBAJyD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 04:54:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5300A101E;
        Mon,  1 Feb 2021 01:53:17 -0800 (PST)
Received: from [10.57.8.191] (unknown [10.57.8.191])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AD2FE3F718;
        Mon,  1 Feb 2021 01:53:15 -0800 (PST)
Subject: Re: [PATCH] drm/lima: Use delayed timer as default in devfreq profile
To:     Qiang Yu <yuq825@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, lima@lists.freedesktop.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        christianshewitt@gmail.com
References: <20210127105121.20345-1-lukasz.luba@arm.com>
 <CAKGbVbsn=xVEa0=c3rywRShVZD18LkmLZ1qDUuDsrT5KnTjr6g@mail.gmail.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <3d1b4696-0172-f88a-f41f-c66ac3baa429@arm.com>
Date:   Mon, 1 Feb 2021 09:53:13 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAKGbVbsn=xVEa0=c3rywRShVZD18LkmLZ1qDUuDsrT5KnTjr6g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qiang,

On 1/30/21 1:51 PM, Qiang Yu wrote:
> Thanks for the patch. But I can't observe any difference on glmark2
> with or without this patch.
> Maybe you can provide other test which can benefit from it.

This is a design problem and has impact on the whole system.
There is a few issues. When the device is not checked and there are
long delays between last check and current, the history is broken.
It confuses the devfreq governor and thermal governor (Intelligent Power
Allocation (IPA)). Thermal governor works on stale stats data and makes
stupid decisions, because there is no new stats (device not checked).
Similar applies to devfreq simple_ondemand governor, where it 'tires' to
work on a loooong period even 3sec and make prediction for the next
frequency based on it (which is broken).

How it should be done: constant reliable check is needed, then:
- period is guaranteed and has fixed size, e.g 50ms or 100ms.
- device status is quite recent so thermal devfreq cooling provides
   'fresh' data into thermal governor

This would prevent odd behavior and solve the broken cases.

> 
> Considering it will wake up CPU more frequently, and user may choose
> to change this by sysfs,
> I'd like to not apply it.

The deferred timer for GPU is wrong option, for UFS or eMMC makes more
sense. It's also not recommended for NoC busses. I've discovered that
some time ago and proposed to have option to switch into delayed timer.
Trust me, it wasn't obvious to find out that this missing check has
those impacts. So the other engineers or users might not know that some
problems they faces (especially when the device load is changing) is due
to this delayed vs deffered timer and they will change it in the sysfs.

Regards,
Lukasz

> 
> Regards,
> Qiang
> 
