Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1F7C3BF6F5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 10:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbhGHIoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 04:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbhGHIop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 04:44:45 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 724DEC061574
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 01:42:03 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id cy23so2379287edb.4
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 01:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=os/T813PZdDCU5XBX3OMjqspJfYpz1AMtwUEcpldmCU=;
        b=d1gplhl6eBDBBtCFbhQ87Fu5JJvAdcL0ZtOA/xnA/P44IGqhqYrHr1miuolseUIeKp
         +nXMZmw/jcyqylbOHuZYz69yGM73v98UgtBqFLdx9Z+vn1BuZcmPzygE0Y6oSKT3aYhC
         d8H9ODr61uI52Fq0RVqmLCyGbgj++7SYf3kUJmjySftyXAt5VyLvzrT/uNuHYXb/X4RR
         j+0NZCKmNnX6ANd9xMH4YkB8H0fvszFuqtT6CVCJsTbW2cHWqw9icRr1X8olGfaBtT7o
         aPZf3/Pd9CQfrP+T01RN5PPHoFhlJkWTKE8LCPTz8/wQc14J1Ygx7YzehJsREx9HFjBn
         GYBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=os/T813PZdDCU5XBX3OMjqspJfYpz1AMtwUEcpldmCU=;
        b=OB4wYXBn9aAub3ovpPeMt5nkupkRFuf7WDDrHUuxtfcA01bdXF7EsLq8QA5bu5Ico0
         vyCBAlc6KK32tK4LzANjyE+8Pm5YeVWu3+m2g6wEdDeLvttWSubxR9oVBBVGd0n9zCg9
         QOBpnzjf3lb8/hO8KN404CgEPg+F6CaQwkjcmM8b2TqKAx1b7kSrDOBTWgTu56yvEXRx
         6LFisGhT0BLAu3lQWDHo/9YNsO0C4lM4HPR4u/qSOKto56LKLQFC6rNv2tXNHouiAyPp
         T+xgf84ZWBwJmemDcBKz7QMVjsBOW6/x49+qq/5bgWXbTlxul6AyPKBTiWh1YPZTHUYM
         8rEQ==
X-Gm-Message-State: AOAM5338OXhyRYFb6ZF3GkjCsG4o/5aKwhdQqFDqeuMnDPoYpZk4jJe1
        M3mFsu4BWtslTjpg+T0NRsAZkWuY8oYqQmWySTM=
X-Google-Smtp-Source: ABdhPJx83Wr9R9gdGNSGocTRyRtkWBZAGSCWqjaompP2jLu6wFyiWdSCGUG3FLeBDgXgrd8lyLyM5pBRHsvsxEJrN3U=
X-Received: by 2002:a05:6402:100e:: with SMTP id c14mr35744812edu.51.1625733722153;
 Thu, 08 Jul 2021 01:42:02 -0700 (PDT)
MIME-Version: 1.0
References: <YJ4yBmIV6RJCo42U@google.com> <s5hk0o18tio.wl-tiwai@suse.de>
 <YJ5cHdv6MVmAKD3b@google.com> <YKDYQfDf7GiMfGCN@google.com>
 <YKDYbaprE3K2QpCe@google.com> <s5hbl9b6mah.wl-tiwai@suse.de>
 <CAMo8BfKKMQkcsbOQaeEjq_FsJhdK=fn598dvh7YOcZshUSOH=g@mail.gmail.com>
 <s5ho8be8v3z.wl-tiwai@suse.de> <CAMo8Bf+FF8Ofq=FwoZZXp9vKiMaUZNAm+W=OJmu2j2XN6kLb-Q@mail.gmail.com>
 <s5hk0m26lfu.wl-tiwai@suse.de> <CAMo8BfLj+VLUbfUmHUSHOfc3PwbWd2w_xnaTZa9HyrcmvJCAkQ@mail.gmail.com>
 <s5hfswp6zx8.wl-tiwai@suse.de>
In-Reply-To: <s5hfswp6zx8.wl-tiwai@suse.de>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Thu, 8 Jul 2021 01:41:50 -0700
Message-ID: <CAMo8Bf+bGujLN7H5yBqy-AkPCN7LgfmGSiWEGdjW6ZWeFoXs9A@mail.gmail.com>
Subject: Re: ALSA: intel8x0: div by zero in snd_intel8x0_update()
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        alsa-devel@alsa-project.org, Leon Romanovsky <leon@kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 8, 2021 at 12:13 AM Takashi Iwai <tiwai@suse.de> wrote:
> On Wed, 07 Jul 2021 22:33:22 +0200,
> Max Filippov wrote:
> >
> > On Wed, Jul 7, 2021 at 11:14 AM Takashi Iwai <tiwai@suse.de> wrote:
> > > On Wed, 07 Jul 2021 19:50:07 +0200, Max Filippov wrote:
> > > > It didn't change anything in my case. My further observation is that
> > > > the snd_intel8x0_update is called before the ichdev->prepared
> > > > is set to one and as a result IRQ is apparently never cleared.
> > >
> > > So it's broken in anyway no matter whether
> > > intel8x0_measure_ac97_clock() is called or not, right?
> >
> > The change that you suggested didn't eliminate the call to
> > intel8x0_measure_ac97_clock, it's still called and an interrupt
> > flood happens at the same place.
>
> Ah I see the point.  Then the fix would be a oneliner like below.
>
>
> Takashi
>
> --- a/sound/pci/intel8x0.c
> +++ b/sound/pci/intel8x0.c
> @@ -694,7 +694,7 @@ static inline void snd_intel8x0_update(struct intel8x0 *chip, struct ichdev *ich
>         int status, civ, i, step;
>         int ack = 0;
>
> -       if (!ichdev->prepared || ichdev->suspended)
> +       if (!(ichdev->prepared || ichdev->in_measurement) || ichdev->suspended)

There's no ichdev::in_measurement, but if replaced with
chip->in_measurement it indeed fixes my issue.
So with this change:
Tested-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max
