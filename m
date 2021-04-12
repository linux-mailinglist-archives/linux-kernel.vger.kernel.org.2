Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19DA935C5DE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 14:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240820AbhDLMBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 08:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240810AbhDLMBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 08:01:45 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC20C061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 05:01:26 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id r20so15022429ljk.4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 05:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CiuSat9oXZrDkfWovQuP0xZcrshIInhP+XNXeKoyYAc=;
        b=kMZbkkfEos6jn8/fUg9ChgrE1JV6VHmZI964BISxF+A0mLoYjNXM5ySjaDvaHi7S38
         jCrxVudPC9ylN2+GHo6TNGKZssMG6WS2mB/Um9pEJRzw6fPatU96ElpI8J8uTnab9wUb
         fDJLG6V6723QIoXbcEzi51vZ151WWT4KFSt2mdTWWfjiYyDENvaE58BOJKTXxzK0hr9i
         mQu+ngtDUTqMsTsUD2mq7Ch0oex/jxXJ37pe1+3L6OPKNe7QxLZlUBoZAqKNfp+JKpPL
         uPaLb2qhvJUXc45Yb6gej+b5FvzDiQwwvId5pUUofbn89OMsLmgJTMTzYSXBmL79ovdC
         KdJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CiuSat9oXZrDkfWovQuP0xZcrshIInhP+XNXeKoyYAc=;
        b=tCM8YxA023+6WKSUfbFMP/ggyt9Ejy6A7jYrQ+8xp2GelhKBn0jBCbTINmTOh2Y2+F
         Py0KJbJeVOnMZGykwv9BgC03WLhnNryra5R1iF391L1lMR9w0Qwe4gLBdR59bq77wcxn
         vRj13c3OK9++wXK8eLdg8qjmFv/YdqtULrFnoU4ktp8+FJPiDRtpQDBhHSxI/u4Wb2ci
         49KHN5XLbjalUQOzpQfjNobPh8Zw7LBOKbDhyr7M/mGVYMhWZ8/E4gMSzqBeslq7bSnn
         dfrB5hnrJ4LXPyLXJSooWTYaGawTWPJUf6WvsYDZEl/iceE3lcteUmDHOpD69sLTEl7V
         kjaw==
X-Gm-Message-State: AOAM5313Gg/oKd3LdMh7mxl/GuIKmK8depU3SWWvTWGKEUZx3uicztRW
        fCenMfA/+Ed/Snpt46OFsEX7qHNToUIEsOx62lvr7Q==
X-Google-Smtp-Source: ABdhPJzI2N5jstAvCOZ5rYNbRQN6nH+h4QX5CaOM5JD3Y4o9o4ofs3goY3p5Vo9hVlcGpdQXZdrhfZtyPyBHT30jGJA=
X-Received: by 2002:a2e:5c47:: with SMTP id q68mr18154053ljb.314.1618228884737;
 Mon, 12 Apr 2021 05:01:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210330080615.21938-1-lecopzer.chen@mediatek.com>
 <20210330083218.22285-1-lecopzer.chen@mediatek.com> <CAFA6WYMqLMEG2s7OdNweQKkP0K2LZ575B1BVw-zfsg7_KBSM5Q@mail.gmail.com>
In-Reply-To: <CAFA6WYMqLMEG2s7OdNweQKkP0K2LZ575B1BVw-zfsg7_KBSM5Q@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 12 Apr 2021 17:31:13 +0530
Message-ID: <CAFA6WYPXu8biPPim5EoQ1pi+w3APKm65tzfOvH4OSORZdJ6+8Q@mail.gmail.com>
Subject: Re: [PATCH v5] arm64: Enable perf events based hard lockup detector
To:     Will Deacon <will@kernel.org>
Cc:     Alexandru Elisei <alexandru.elisei@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Lecopzer Chen <lecopzer@gmail.com>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <swboyd@chromium.org>, yj.chiang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On Tue, 30 Mar 2021 at 18:00, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> On Tue, 30 Mar 2021 at 14:07, Lecopzer Chen <lecopzer.chen@mediatek.com> wrote:
> >
> > > > Hi Will, Mark,
> > > >
> > > > On Fri, 15 Jan 2021 at 17:32, Sumit Garg <sumit.garg@linaro.org> wrote:
> > > > >
> > > > > With the recent feature added to enable perf events to use pseudo NMIs
> > > > > as interrupts on platforms which support GICv3 or later, its now been
> > > > > possible to enable hard lockup detector (or NMI watchdog) on arm64
> > > > > platforms. So enable corresponding support.
> > > > >
> > > > > One thing to note here is that normally lockup detector is initialized
> > > > > just after the early initcalls but PMU on arm64 comes up much later as
> > > > > device_initcall(). So we need to re-initialize lockup detection once
> > > > > PMU has been initialized.
> > > > >
> > > > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > > > ---
> > > > >
> > > > > Changes in v5:
> > > > > - Fix lockup_detector_init() invocation to be rather invoked from CPU
> > > > >   binded context as it makes heavy use of per-cpu variables and shouldn't
> > > > >   be invoked from preemptible context.
> > > > >
> > > >
> > > > Do you have any further comments on this?
> > > >

Since there aren't any further comments, can you re-pick this feature for 5.13?

-Sumit

> > > > Lecopzer,
> > > >
> > > > Does this feature work fine for you now?
> > >
> > > This really fixes the warning, I have a real hardware for testing this now.
>
> Thanks for the testing. I assume it as an implicit Tested-by.
>
> > > but do we need to call lockup_detector_init() for each cpu?
> > >
> > > In init/main.c, it's only called by cpu 0 for once.
> >
> > Oh sorry, I just misread the code, please ignore previous mail.
> >
>
> No worries.
>
> -Sumit
>
> >
> > BRs,
> > Lecopzer
