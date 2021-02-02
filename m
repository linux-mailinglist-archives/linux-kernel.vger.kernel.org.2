Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC7A30B460
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 02:04:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhBBBCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 20:02:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbhBBBCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 20:02:44 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 556BFC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 17:02:04 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id b3so491008wrj.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 17:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jQ1WfUQt71q9l47M9pw0jo5iRtif7JjLaJa1M/+QKNA=;
        b=sfxw6+zLWDJRfH56sqKa94m7XlcE20QqtuZWiUdSqnAbENFGMkOTIrsrFcV+gfwjph
         mATOGJxGfnmlFvSnAxTObjuQIqbZpUeNzcSlthCa3peNPkbDy8VwwHZswGFsxRveHsFa
         OlzLAMaQKawooUlRGX0XYqL6M+RRBuWMi8Pz/TF2uSMSglFHIc8zbQz3MLspMr+93EEk
         hvMf7XUMSLKe3bWRt6/HPX6BKTAJh0DyO8K3pSAEgw6jpmziL/0iJyvw6DuGwl9p+QQO
         hOSQkQpkinfRhRSQmWsfTR7IScQcvkPSmck6Iax0Cs1avxUqNeGTaXhIWaEx3mLmd+w2
         gD+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jQ1WfUQt71q9l47M9pw0jo5iRtif7JjLaJa1M/+QKNA=;
        b=qybQyqS1DArAPHkZQxJ5sUxwX2Rh+SZ2GTBvF7RqgfBzL4rfhonP0Z/QgPGAxUCEGB
         ONVMFBEHg6aNdJK6/0Fz39/C3W4NanfFWtdhaeQSZlhAsB4xHHFPXWO6+4ww1eSsDlLK
         6gofldTzGl62V+rWt+KbZh/XU7iUYfoor03rxWxpWm/cQxSdwQp1t3Zs0wbnc2cdREXk
         0/BES77DZ6xKRmhOZAcV7/UsDQcZSGEWiW4TtfL9eNNY/JUx6whAoUurC7Mr99ZpYj18
         Od9nbK6ksLljsEH0hcw/WKfqX7Hsxn+cMRjv0KYy2X+tAhNqdexCqgjb6fRDmPcRtqvn
         ZRsQ==
X-Gm-Message-State: AOAM533t33ofdGe7DfI1zoGHpp9J2+CekMKCTKIYQUoMC9k85ttvSkVN
        Cbj0P2obwxKHKcNR8meknPsRIEksrLc7BJ7ZeQQ=
X-Google-Smtp-Source: ABdhPJyN9lDOFpf6i67VfzNyhPIg+MgZptmc6lM8lXHJwQb7WZhKmtjZOl8MQcPqYywrkpcTepEhBr4RoZMPZwLMUnU=
X-Received: by 2002:a5d:69ce:: with SMTP id s14mr20175051wrw.206.1612227723132;
 Mon, 01 Feb 2021 17:02:03 -0800 (PST)
MIME-Version: 1.0
References: <20210127105121.20345-1-lukasz.luba@arm.com> <CAKGbVbsn=xVEa0=c3rywRShVZD18LkmLZ1qDUuDsrT5KnTjr6g@mail.gmail.com>
 <3d1b4696-0172-f88a-f41f-c66ac3baa429@arm.com>
In-Reply-To: <3d1b4696-0172-f88a-f41f-c66ac3baa429@arm.com>
From:   Qiang Yu <yuq825@gmail.com>
Date:   Tue, 2 Feb 2021 09:01:51 +0800
Message-ID: <CAKGbVbsuqsGYRqUyWRiC+h9o7kNMvB16-Y6378KG_rv0SG4VDQ@mail.gmail.com>
Subject: Re: [PATCH] drm/lima: Use delayed timer as default in devfreq profile
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, lima@lists.freedesktop.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Christian Hewitt <christianshewitt@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz,

Thanks for the explanation. So the deferred timer option makes a mistake that
when GPU goes from idle to busy for only one poll periodic, in this
case 50ms, right?
But delayed timer will wakeup CPU every 50ms even when system is idle, will this
cause more power consumption for the case like phone suspend?

Regards,
Qiang


On Mon, Feb 1, 2021 at 5:53 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>
> Hi Qiang,
>
> On 1/30/21 1:51 PM, Qiang Yu wrote:
> > Thanks for the patch. But I can't observe any difference on glmark2
> > with or without this patch.
> > Maybe you can provide other test which can benefit from it.
>
> This is a design problem and has impact on the whole system.
> There is a few issues. When the device is not checked and there are
> long delays between last check and current, the history is broken.
> It confuses the devfreq governor and thermal governor (Intelligent Power
> Allocation (IPA)). Thermal governor works on stale stats data and makes
> stupid decisions, because there is no new stats (device not checked).
> Similar applies to devfreq simple_ondemand governor, where it 'tires' to
> work on a loooong period even 3sec and make prediction for the next
> frequency based on it (which is broken).
>
> How it should be done: constant reliable check is needed, then:
> - period is guaranteed and has fixed size, e.g 50ms or 100ms.
> - device status is quite recent so thermal devfreq cooling provides
>    'fresh' data into thermal governor
>
> This would prevent odd behavior and solve the broken cases.
>
> >
> > Considering it will wake up CPU more frequently, and user may choose
> > to change this by sysfs,
> > I'd like to not apply it.
>
> The deferred timer for GPU is wrong option, for UFS or eMMC makes more
> sense. It's also not recommended for NoC busses. I've discovered that
> some time ago and proposed to have option to switch into delayed timer.
> Trust me, it wasn't obvious to find out that this missing check has
> those impacts. So the other engineers or users might not know that some
> problems they faces (especially when the device load is changing) is due
> to this delayed vs deffered timer and they will change it in the sysfs.
>
> Regards,
> Lukasz
>
> >
> > Regards,
> > Qiang
> >
