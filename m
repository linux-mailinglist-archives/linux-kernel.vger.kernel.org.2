Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4C25306CA1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 06:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbhA1FML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 00:12:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbhA1FMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 00:12:07 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3338BC061574
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 21:11:26 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id a25so4848839ljn.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 21:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yz4dvbWilv+59+sGvg7GlreEXmLYHQWRQqY4rHmQdj8=;
        b=DA1aho4knu8EGzj179+534CVs3VecnJZBpLja6mPhWG/xBuAx9rDxzXSUifoEgPTs5
         Ph9OLQDunZxUpZO6gnUjM2AdExHmh4vrgf1Zet00XwJMirfurIp9uZQvjp2wc/d6UkrU
         Z38rRoKRhyo3jsNYTk3f8PQadKp3/Rh9TiuPKJFJUea2i5UF4/ZRtMkqohBsvYR4mLBJ
         A3H0xXUdHCEcTqkDnJ4gfzj9bOX+d4Hf+An/guf1uSx+cv89bkGXnvgKBln8/N3sL+TU
         4OI51WtZfUYE/g99NT1XeiM7s1d/ZqgQLJVMUUZPvN3EelapRn7aNrKjze/PVaDacAaI
         VtZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yz4dvbWilv+59+sGvg7GlreEXmLYHQWRQqY4rHmQdj8=;
        b=giNqYfAsmbLf7rl6+/dWahqsiTKP0a8CRHCnwjOx6Y7soAhAO9Kdw+57KnAn8nF/F9
         vYsvGQVmseiMqqgI+hJDjeKv6PjaXRsZvQr3KjuIQ5X4LXbwP0PibKdQFXJsSG89xXMV
         NCVw5IpU3+xmTZCRti8mht3VDHSzVXT5v/U8BiiNo9R0AwxW58KV6W+ZiBkE6nemSYIU
         Kkzjvnde8UNC5QVuqsEJPQ3QIuQAfVK89Y2pAl2ESpHp9QXAOs5uov6OFILYxo6Apx3p
         tWj3KrY43BK5vd9QIISP9w7zjxgSbfE7gwio3oo97GqaXl5ZGI1Vrho5T/XMjt8Ym53y
         V/kQ==
X-Gm-Message-State: AOAM5318vFFRGZ3pDVLX5iaREtEOomXhXQ/dUZHeaoSHp07znfALOIVO
        vnd4x0HWfh7Eq4DbE8wvGSs9Vwo11rf9hIMZZEEWpevw9lOpNQ==
X-Google-Smtp-Source: ABdhPJx1h6w8r4GuWW2pMTFX/gJji2VtuNCQtzxOgmz9AZ9wjQFJUaHAmSpPueSwlFMNk5huWj533XG+GxZ9oZbGbsY=
X-Received: by 2002:a2e:97cc:: with SMTP id m12mr7313826ljj.343.1611810684701;
 Wed, 27 Jan 2021 21:11:24 -0800 (PST)
MIME-Version: 1.0
References: <1611313556-4004-1-git-send-email-sumit.garg@linaro.org>
 <CAD=FV=V8HwhdhpCoiZx4XbTMWug0CAxhsnPR+5V9rB0W7QXFTQ@mail.gmail.com> <20210125081855.gfq3n6urcmght3ef@maple.lan>
In-Reply-To: <20210125081855.gfq3n6urcmght3ef@maple.lan>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 28 Jan 2021 10:41:12 +0530
Message-ID: <CAFA6WYN8dOScFg8txFFis+kTm9qLU95XO4JO6uqZ4o=SfZeJGg@mail.gmail.com>
Subject: Re: [PATCH v3] kdb: Make memory allocations more robust
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Jason Wessel <jason.wessel@windriver.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "# 4.0+" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jan 2021 at 13:48, Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Fri, Jan 22, 2021 at 09:25:44AM -0800, Doug Anderson wrote:
> > Hi,
> >
> > On Fri, Jan 22, 2021 at 3:06 AM Sumit Garg <sumit.garg@linaro.org> wrote:
> > >
> > > Currently kdb uses in_interrupt() to determine whether its library
> > > code has been called from the kgdb trap handler or from a saner calling
> > > context such as driver init.  This approach is broken because
> > > in_interrupt() alone isn't able to determine kgdb trap handler entry from
> > > normal task context. This can happen during normal use of basic features
> > > such as breakpoints and can also be trivially reproduced using:
> > > echo g > /proc/sysrq-trigger
> >
> > I guess an alternative to your patch is to fully eliminate GFP_KDB.
> > It always strikes me as a sub-optimal design to choose between
> > GFP_ATOMIC and GFP_KERNEL like this.  Presumably others must agree
> > because otherwise I'd expect that the overall kernel would have
> > something like "GFP_AUTOMATIC"?
> >
> > It doesn't feel like it'd be that hard to do something more explicit.
> > From a quick glance:
> >
> > * I think kdb_defcmd() and kdb_defcmd2() are always called in response
> > to a user typing something on the kdb command line.  Those should
> > always be GFP_ATOMIC, right?
>
> No. I'm afraid not. The kdb parser is also used to execute
> kernel/debug/kdb/kdb_cmds as part of the kdb initialization. This
> initialization happens from the init calls rather than from the kgdb
> trap handler code.
>
> When I first looked at Sumit's patch I had a similar reaction to you
> but, whilst it is clearly it's not impossible to pass flags into the
> kdb parser and all its subcommands, I concluded that GFP_KDB is a
> better approach.
>
> BTW the reason I insisted on getting rid of the in_atomic() was to make
> it clear that GFP_KDB discriminates between exactly two calling contexts
> (normal and kgdb trap handler). I was didn't want any hints that imply
> GFP_KDB is a (broken) implementation of something like GFP_AUTOMATIC!
>

Ah, I see the reasoning to keep GFP_KDB. So we don't need any further
refactoring and can go ahead with this patch only.

-Sumit

>
> Daniel.
