Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 835A83076F3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 14:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbhA1NTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 08:19:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbhA1NTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 08:19:41 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04580C061574
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 05:19:01 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id n2so5497503iom.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 05:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gjy6o/hBoBKHdPHDXM51PZiuX5YGQ+mMH4IEIhNoHVg=;
        b=p+lsnKT+rIJdPmdWBsl7+xoHGQ3RV0xpDcav7tLVH2vgSgvZhvgXnmQw43jJsCHwvf
         Qkw7HFMCbtMH2UmHdidk1u3ryARbgEVHuhgK++8rlIegsBjsGzNzzwu426gzFtZm5S6w
         jHwTXJjxjkCZEElzYuHoknqDkYQDRgxSGX1EggkcbOdEWmU0VadQiN+kyOC6gpc7rHDq
         59o1+0+r+H02hg7RyV+ZxyVimN0ovWlCWUr1k9U/kFvmpnldXNXQ1sWRx9EVL3qgm5UN
         dDXw+agUJa1OzFvlfqxM2lqkuofpP35o1BoebAkkfvXG+uDbVLLmcnS9GdSPM/b/e+jI
         fNJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gjy6o/hBoBKHdPHDXM51PZiuX5YGQ+mMH4IEIhNoHVg=;
        b=iru1d2r6yg93cfCt2ge/+CZ1KiYhWjZcrgxG7XddnoAx4E7Gxq65JMh75007hEvBHr
         JLjvM4aMXmsz9Uwv+9ptHDaZ6idD15716hG9Td0vnz8d6gKIwjBrszyQ7k/dIovzYXwK
         KUh0Aik3CI1Nt/RRFfSymL5+q30uXKZNNoXGEFQE9sZKyueipMvUiFtnP59ruFniPB35
         cmiXs8bmnEykjwaIwiFDKuxFp651w31rsUJpEUaSdR6Vy+Yo8jWOkHLfw7g0IJHH+3jC
         n+aHDPVZiRq4WsjGPVZcPYyuf7xKGqhqyu6s79KJk+ynq4husLU9Jh3UipPZH6pRi2vN
         q8MQ==
X-Gm-Message-State: AOAM530RCDyNMMn8rAPoVz22uY/j9FkAZ3xBbSwVB/65U+IN0WN37vxP
        7q/hxiyuumeUSmF8k7zQY1I17z6HcOtpOOHihyQ=
X-Google-Smtp-Source: ABdhPJwCE8tynFIbe8qGDUc9yNjnhzR6XHtmoxy88HRWO1HvCwvh5LdWN4aM9o1DIWHdj5/hdQAP5PGAKVNEjnRcnJ8=
X-Received: by 2002:a5d:9487:: with SMTP id v7mr11210434ioj.202.1611839940515;
 Thu, 28 Jan 2021 05:19:00 -0800 (PST)
MIME-Version: 1.0
References: <20210128021947.22877-1-laoar.shao@gmail.com> <20210128021947.22877-4-laoar.shao@gmail.com>
 <YBKp/NHanaN4e0im@smile.fi.intel.com>
In-Reply-To: <YBKp/NHanaN4e0im@smile.fi.intel.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Thu, 28 Jan 2021 21:18:24 +0800
Message-ID: <CALOAHbA+MV9Xi5Ge--6F+e9bqouJvXfWmqP6ucvUkX8CWNuQPw@mail.gmail.com>
Subject: Re: [PATCH 3/3] printk: dump full information of page flags in pGp
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>, penberg@kernel.org,
        David Rientjes <rientjes@google.com>, iamjoonsoo.kim@lge.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021 at 8:11 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Jan 28, 2021 at 10:19:47AM +0800, Yafang Shao wrote:
> > Currently the pGp only shows the names of page flags, rather than
> > the full information including section, node, zone, last cpupid and
> > kasan tag. While it is not easy to parse these information manually
> > because there're so many flavors. Let's interpret them in pGp as well.
> >
> > - Before the patch,
> > [ 6312.639698] ERR: Slab 0x000000006d1133b9 objects=33 used=3 fp=0x000000006d0779d1 flags=0x17ffffc0010200(slab|head)
> >
> > - After the patch,
> > [ 6315.235783] ERR: Slab 0x000000006d1133b9 objects=33 used=3 fp=0x000000006d0779d1 flags=0x17ffffc0010200(Node 0x0,Zone 0x2,Lastcpupid 0x1fffff,slab|head)
>
> > +     int i;
> > +
> > +     for (i = 0; i < sizeof(pfl) / sizeof(struct page_flags_layout) && buf < end; i++) {
>
> 'buf < end' is redundant.
>

Thanks for pointing this out.

> > +             if (pfl[i].width == 0)
> > +                     continue;
> > +
> > +             buf = string(buf, end, pfl[i].name, default_str_spec);
>
> > +             if (buf >= end)
> > +                     break;
>
> Can you rather use usual patter, i.e.
>
>         if (buf < end) {
>                 ...do something...
>         }
>         buf++; // or whatever increase should be done
>
> Moreover, number() and string() IIRC have the proper checks embedded into them.
>

I will take a look at the detail in these two functions.

> > +             buf = number(buf, end, (flags >> pfl[i].shift) & pfl[i].mask,
> > +                          default_flag_spec);
>
> > +             if (buf >= end)
> > +                     break;
> > +             *buf = ',';
> > +             buf++;
>
> Here is a very standard pattern can be used, see code around
>
>                 if (buf < end)
>                         *buf = ',';
>                 buf++;
>
> > +     }
>

Thanks for the explanation.
I will change it as you suggested.


-- 
Thanks
Yafang
