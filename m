Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC44F324BB6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 09:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235502AbhBYIGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 03:06:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbhBYIGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 03:06:04 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 871D6C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 00:05:24 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id g1so5392048ljj.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 00:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WKCCMtCbzxfqTiUSpCCEYULXbcAHFbFe4Bf+kfsn4QE=;
        b=WoZHMIIo/FnwfF5iZnlntHzXD76+Y5AxT+tTnzEzjE6RQacHBiy1eY9pqXzVdj2tpt
         +Ov83mhEnFATOL+s1CjTDziralISNqgB3dkXR1Ttv1jT6+2s/BtmXiJrvF/R0tCmdu5V
         kCd7UWHHpccTjeas+g1hZnLkPKxURl5YhLpFmbtXn+VDTR/b5PF5Uh5wsTnwAGjF4DhD
         a5KPN6zWbrfo8pejV3xiAvRarQngKGmxFXM9LCfLCBvMoJQl2vPlTWHbXsQkIm3yx7sQ
         eeKFacryWeHZfZUIV2ey0loF2H2c7yF3gdQ5z2KkeVWX1jeNUcjhCq0L/lF7/T9PRVSg
         dykQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WKCCMtCbzxfqTiUSpCCEYULXbcAHFbFe4Bf+kfsn4QE=;
        b=lUbZi+lhW1L4xZ6I/nRy2sADr7SB4PbtNV1eVf0NJFvfpNWfHfyPlnw0GuulFzHnZD
         sGyjFG2Ncgi+wX2hozJF399ljGnDUY7Ug3PpSxDqrs6naRGc9Gjj/6JZQbP4V4kBphUS
         AUJ9WXCcUsi+5J+KLqgi1UabV97pHJhzjLLwkPi86RN80GmC/WrMmsNoyC/+vTf3qbJN
         9Iq0YX2moOnpCjpLWGx73P0sQBXHVetoJvTi+ohZf4mY5SKaKH+RCInAeGSZn64KjY+v
         cGMP5Nu6APKeO7C7FJ/7bsFINmOCwBgdh3Dr0NSa5TcCydFsMExH1qmQSwe6aRHA86RJ
         HvNg==
X-Gm-Message-State: AOAM532i5fnY4lJNHgoUJ4gPA7FvPvLFbxE45/hmbsGbRrGdD76M4RR/
        O6oZB0YxJqXholsLRIy6A7ialHEECfUOsX6mSEqgeg==
X-Google-Smtp-Source: ABdhPJxs6fyt0D0Jzanycc0lNKxWk6RGgRaxgcuASffzAEGF0CSNM8kPIm1UB3PbrpeiqfgONVXV5lmJ/BEzTsBzxBA=
X-Received: by 2002:a2e:b5b4:: with SMTP id f20mr948325ljn.445.1614240323036;
 Thu, 25 Feb 2021 00:05:23 -0800 (PST)
MIME-Version: 1.0
References: <20210224133007.28644-1-vincent.guittot@linaro.org> <jhjblc95mo0.mognet@arm.com>
In-Reply-To: <jhjblc95mo0.mognet@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 25 Feb 2021 09:05:11 +0100
Message-ID: <CAKfTPtDjVBP676kzW-5QF8nMyD1+WNnJWH4=gKPVV+55tm3Cng@mail.gmail.com>
Subject: Re: [PATCH 0/7 v4] move update blocked load outside newidle_balance
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Qais Yousef <qais.yousef@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Valentin,

On Wed, 24 Feb 2021 at 19:46, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> On 24/02/21 14:30, Vincent Guittot wrote:
> > Joel reported long preempt and irq off sequence in newidle_balance because
> > of a large number of CPU cgroups in use and having to be updated. This
> > patchset moves the update outside newidle_imblance. This enables to early
> > abort during the updates in case of pending irq as an example.
> >
> > Instead of kicking a normal ILB that will wakes up CPU which is already
> > idle, patch 6 triggers the update of statistics in the idle thread of
> > the CPU before selecting and entering an idle state.
> >
> > Changes on v4:
> > - Add a dedicated bit for updating blocked load when entering idle.
> >   This simplifies the management of concurrency with kick_ilb.
> >
>
> I believe that solves the issues vs nohz balance.
>
> One last thing for patch 7: mayhaps we could do a tad better to avoid
> duplicate updates going through a heapful of leaf cfs rqs, see
>
>   http://lore.kernel.org/r/jhj4kiht7oh.mognet@arm.com

rq->last_blocked_load_update_tick is there only to filter duplicate
update during _nohz_idle_balance but not for other normal LB.

>
>
> Otherwise, feel free to add to the lot:
>
>   Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
>
