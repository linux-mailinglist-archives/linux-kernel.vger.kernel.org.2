Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3EE132BBAB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 22:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347331AbhCCMqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 07:46:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1842522AbhCCIGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 03:06:16 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BDABC061794
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 23:50:38 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id e9so3822733pjj.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 23:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=59eVpKaioyRI5+Xc51X8cQInHO+VEu2CINu8TtonyKs=;
        b=KH8xroxbSaW9lubJkO8+PZTvAyFoKuDONoOTqMvM168HzNTcoMSxN2bagaRezxeixY
         O/eOyh5ochhnlFmMeBu2gTYIss0pvbpC0VHIY/9qXniRzGGEDg/qw5KHb8nMNfJMKryl
         9EYJYeBd2TOUy6U0/DjiLR4EQ0FJoBulVAehzr6xSKK3GZASr3xmSnWb25kIY2Kw7Pfy
         7XhxfI9LqnhyaP1E31ckfRWuIsc8OuvZrS3MN7CBNWV6zZDClTAtPzlFmpRCFAEs3q6O
         sD2adf5Xh9IMHyrVw4d/ILkaFoOLZtJADjrh+Rt3h/7QNz2M3zsX3eSkUH/yaOV1KS/S
         IFhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=59eVpKaioyRI5+Xc51X8cQInHO+VEu2CINu8TtonyKs=;
        b=AAq4x9RVjGdO4GK1O56yPN8Kg/2U9atfGsSFL08UVPWwbnRRh9d7EtnrhG87/5H++A
         O32HUlWcqdBeB4RzZQ4iED4NJ82Cepxk0jLMLmw6c3FP8oy+8sp4Ex+RQMcbl1cVSfMq
         RPP0oHgggKm/iA0mu/QT8ljpb7Gv18ARAtS4ozZ81DtkV1KbIAExZPY7na61IbUIGJio
         G25kGgo3qOJAxD7pkpOhaILWaRtkLi8dDX2aDnMowMEzYC7ETzvKgLfQYO/b7S3jbt9G
         QozftCgUEfvtczTynHkaIgDlxR1ZwrQZgHEYT5luXzjWzrPOUra1diFbp70w0VXoFhXB
         iJbw==
X-Gm-Message-State: AOAM533W41rbc1IJLamRLkrFIBxm33TGVTWa1/e+9umwnZW84EU3EZm2
        9Ucz4RByatwUaY/AeRAD3y6sWqOw1twehaSvumMw/Q==
X-Google-Smtp-Source: ABdhPJyakXdmOAnrxpK9H4hnFLJslQhnguV37QWVjVEOEla6l/PrQIpa6wqbgCnGJxWqC0CAhpM9ohjJZbMr0x6qIJc=
X-Received: by 2002:a17:90a:c087:: with SMTP id o7mr4144780pjs.38.1614757837645;
 Tue, 02 Mar 2021 23:50:37 -0800 (PST)
MIME-Version: 1.0
References: <20210224164835.3497311-1-mathieu.poirier@linaro.org>
 <YD41GUtuq8fVa4Q6@kernel.org> <CAJ9a7ViKLg8vjBnuA1eWh8b5-PN7RryefyOV1qoX9Zu362Eq8Q@mail.gmail.com>
 <YD5mu7Df3fXiWZuk@kernel.org> <20210302164254.GA3789438@xps15>
 <CAJ9a7Vg5H-UUr9B3iOG4FqtgF=f3-2p8-VVqCCoegbrLn_GMjA@mail.gmail.com> <F5C1A802-C5B5-45D6-96CC-2D13FCB23BAE@gmail.com>
In-Reply-To: <F5C1A802-C5B5-45D6-96CC-2D13FCB23BAE@gmail.com>
From:   Leo Yan <leo.yan@linaro.org>
Date:   Wed, 3 Mar 2021 15:50:26 +0800
Message-ID: <CALZQ+UPGT1OxxUFxFNgx2FKYz4ih56H1R1EirtJXF8DQStupkQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] coresight: Patches for v5.12 (perf tools)
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Mike Leach <mike.leach@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2021 at 02:11:10PM -0300, Arnaldo Carvalho de Melo wrote:
>
>
> On March 2, 2021 2:02:17 PM GMT-03:00, Mike Leach <mike.leach@linaro.org> wrote:
> >On Tue, 2 Mar 2021 at 16:42, Mathieu Poirier
> ><mathieu.poirier@linaro.org> wrote:
> >>
> >> On Tue, Mar 02, 2021 at 01:24:27PM -0300, Arnaldo Carvalho de Melo
> >wrote:
>
>
> >> > Can you please try one more time, these are the last csets on this
> >> > branch:
> >> >
> >> >   $ git log --oneline acme/tmp.perf/core -10
> >> >   8e1488a46dcf73b1 (HEAD -> perf/core, five/perf/core,
> >acme/tmp.perf/core, acme.korg/tmp.perf/core) perf cs-etm: Detect pid in
> >VMID for kernel running at EL2
> >> >   47f0d94c203751dd perf cs-etm: Add helper cs_etm__get_pid_fmt()
> >> >   30cb76aabfb4deab perf cs-etm: Support PID tracing in config
> >> >   8c559e8d68630d64 perf cs-etm: Fix bitmap for option
> >> >   2bb4ccbd95d7fbf5 tools headers UAPI: Update tools' copy of
> >linux/coresight-pmu.h
> >> >   42b2b570b34afb5f perf cs-etm: Update ETM metadata format
> >> >   83bf6fb8b076c72f perf vendor events power9: Remove unsupported
> >metrics
> >> >   34968b9327c83589 perf buildid-cache: Add test for PE executable
> >> >   9bb8b74bdb186bd3 perf docs: Add man pages to see also
> >> >   d9fd5a718977702f perf tools: Generate mips syscalls_n64.c syscall
> >table
> >> >   $
> >>
> >> As far as I can tell you have all 6 patches.
> >>
> >
> >Agreed - [1] I was trying is in fact:
> >42b2b570b34afb5f perf cs-etm: Update ETM metadata format
> >in the above list.
>
> Ok, I misunderstood, good that's all already in, thanks for checking!

Thanks for the effort, Arnaldo/Mathieu/Mike.
