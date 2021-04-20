Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 965BF3650B1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 05:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbhDTDNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 23:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhDTDNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 23:13:18 -0400
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61F9C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 20:12:47 -0700 (PDT)
Received: by mail-vk1-xa2f.google.com with SMTP id f70so224377vke.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 20:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wq9WQE+gjf5AOz3ht7nqU8rHSrKU7bFASKr3ai0X3g4=;
        b=LJbIXe45welW3xxiczHvMlvgbVeALo8yB1tAzl62otfFsrByGtRz3jy+K0RluqgbGo
         ux7R/fySUZGbWpxN5S/wws2AWzjc3tjJXkvppX7Rv7NNIQHm/NouPnHtdJ5IxWr5pPT7
         SVVOrnCvV1kLfjJ0WEIdtQmhHx4JAC+i8FCexXUZ+v/xXPiL7B4DsFN+8C5/5pmdEUcb
         fcMfvqRgnIljr0EHQ7zs1+EmrqTe4cele2sTmt6qU3d0nDu0zSQZhHxyZjaSt8uVkSfO
         M6uS3BpuCKJ3ured9uev7cTbDIeQyx362aofSD0Bw7ifKyn0bomFMuc+U5vnfjZTVdP1
         EBIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wq9WQE+gjf5AOz3ht7nqU8rHSrKU7bFASKr3ai0X3g4=;
        b=DE37BagS1lWDEkByJBVEEFAK1XzkQPyrFriqBC6FDtZCAh3sxtYQVh5Xgb0dNLzZLu
         +ekkrH8VHgieGxiM83M2dqyZv8ExqnmzvkODqLNHa9eZVH0YLowA9GA9C3WTIlSAaFa1
         LzMs9KlEAA1GIbP5oTQBsGPjhw5GHKbf4WpV94t31z24TjZJl3RHmHopWpF2UApwTE+N
         Sg1VlR1u/s5fNf+1aXSwc7Wm1duZni49fVkrP5ULwvq90Yq+xODYdGEM4aLVIAebPGf0
         rqR/8pbMtH2wueUdQane1IwpxlU429SHaijLnVEw4R5F0bTNR83EgA58oXJismliezP2
         jp4w==
X-Gm-Message-State: AOAM5310fvpoXsNY6aE8e9XuPYfQDr8feQgXPX9j0519zeSybELcTHLU
        XlGHQBKPtT+JGpygR75Ol9C7apunCabvF6cNW2KEzg==
X-Google-Smtp-Source: ABdhPJyKHpgyTCZK1BXTy1JWwBlaLx8+vOpK/Tsa6L492YiM2QXGXRpg7IJ8BjzIQYFD/1n1s6sMMAzadQyT4UMasa8=
X-Received: by 2002:a1f:5504:: with SMTP id j4mr17787360vkb.7.1618888366522;
 Mon, 19 Apr 2021 20:12:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAHo-OowM2jRNuvyDf-T8rzr6ZgUztXqY7m_JhuFvQ+uB8N3ZrQ@mail.gmail.com>
 <YHXRWoVIYLL4rYG9@kroah.com> <CAKD1Yr1DnDTELUX2DQtPDtAoDMqCz6dV+TZbBuC1CFm32O8MrA@mail.gmail.com>
 <87r1jbv6jc.ffs@nanos.tec.linutronix.de>
In-Reply-To: <87r1jbv6jc.ffs@nanos.tec.linutronix.de>
From:   =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date:   Mon, 19 Apr 2021 20:12:34 -0700
Message-ID: <CANP3RGcX11RS=rwbem7+5it+Zu072sd15pHHFHjCFkXk11qrgw@mail.gmail.com>
Subject: Re: [PATCH] hrtimer: Update softirq_expires_next correctly after __hrtimer_get_next_event()
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Lorenzo Colitti <lorenzo@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        lkml <linux-kernel@vger.kernel.org>, mikael.beckius@windriver.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2021 at 9:47 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Wed, Apr 14 2021 at 11:49, Lorenzo Colitti wrote:
> > On Wed, Apr 14, 2021 at 2:14 AM Greg KH <gregkh@linuxfoundation.org> wr=
ote:
> >> To give context, the commit is now 46eb1701c046 ("hrtimer: Update
> >> softirq_expires_next correctly after __hrtimer_get_next_event()") and =
is
> >> attached below.
> >>
> >> The f_ncm.c driver is doing a lot of calls to hrtimer_start() with mod=
e
> >> HRTIMER_MODE_REL_SOFT for I think every packet it gets.  If that shoul=
d
> >> not be happening, we can easily fix it but I guess no one has actually
> >> had fast USB devices that noticed this until now :)
> >
> > AIUI the purpose of this timer is to support packet aggregation. USB
> > transfers are relatively expensive/high latency. 6 Gbps is 500k
> > 1500-byte packets per second, or one every 2us. So f_ncm buffers as
> > many packets as will fit into 16k (usually, 10 1500-byte packets), and
> > only initiates a USB transfer when those packets have arrived. That
> > ends up doing only one transfer every 20us. It sets a 300us timer to
> > ensure that if the 10 packets haven't arrived, it still sends out
> > whatever it has when the timer fires. The timer is set/updated on
> > every packet buffered by ncm.
> >
> > Is this somehow much more expensive in 5.10.24 than it was before?
> > Even if this driver is somehow "holding it wrong", might there not be
> > other workloads that have a similar problem? What about regressions on
> > those workloads?
>
> Let's put the question of whether this hrtimer usage is sensible or not
> aside for now.
>
> I stared at the change for a while and did some experiments to recreate
> the problem, but that didn't get me anywhere.
>
> Could you please do the following?
>
> Enable tracing and enable the following tracepoints:
>
>     timers/hrtimer_cancel
>     timers/hrtimer_start
>     timers/hrtimer_expire_entry
>     irq/softirq_raise
>     irq/softirq_enter
>     irq/softirq_exit
>
> and function tracing filtered on ncm_wrap_ntb() and
> package_for_tx() only (to reduce the noise).
>
> Run the test on a kernels with and without that commit and collect trace
> data for both.
>
> That should give me a pretty clear picture what's going on.

Lorenzo is trying to get the traces you asked for, or rather he=E2=80=99s
trying to get confirmation he can post them.

Our initial observation of these results seems to suggest that
updating the timer (hrtimer_start, which seems to also call
hrtimer_cancel) takes twice as long as it used to.

My gut feeling is that softirq_activated is usually false, and the old
code in such a case calls just __hrtimer_get_next_event(,
HRTIMER_ACTIVE_ALL).  While the new code will first call
__hrtimer_get_next_event(, HRTIMER_ACTIVE_SOFT) and then
__hrtimer_get_next_event(, HRTIMER_ACTIVE_HARD)

Perhaps __hrtimer_get_next_event() should return both soft and hard
event times in one function call?
Or perhaps hrtimer_start should not call hrtimer_cancel?

We've also been looking at the f_ncm driver itself, and trying to
reduce the number of hrtimer_cancel/start calls.
It's pretty easy to reduce this by a factor of 10x (we=E2=80=99re not yet 1=
00%
certain this is race free), which does drastically improve
performance.
However, it still only takes the regression from 60% to 20%.

- Maciej
