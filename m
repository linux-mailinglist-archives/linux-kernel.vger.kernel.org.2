Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 759B534E781
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 14:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbhC3MbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 08:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbhC3Max (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 08:30:53 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6215C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 05:30:52 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id g8so23499958lfv.12
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 05:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0zXyI1yetwTGYJFePdX3pdL1jxNBabDK2g4CkJzJcq8=;
        b=Ar+ZnS44CybblOQvAYvNqov7Oy7ZltCpQE5htgBQ0PS4qrgt6bC/iJeE/rFYp45kSz
         Du4dzYK8zzUh/fmk3H567+9gJhVRjw1JhnrD/E0mCcEynzbDauBN7teBzwjqHboIbEP5
         0ZQYtMYM0zeD89RQjkr48X+NLhWDF6dzuyQF9FYFLismPpfXw3RTKmQl8RtphFCS7GRO
         GUWywvmExjrhrgZmDsrr3kk7W60t3mKOYpW3eCvJtKD39p5x1ShWdF3hWL5VsCF7uwMu
         xISeketgQ174JSYOTeaEH8jZso5PsmAuV8GBdUd6JpmhxihuQc0e9knhvJ/vbdzzKTbW
         fq+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0zXyI1yetwTGYJFePdX3pdL1jxNBabDK2g4CkJzJcq8=;
        b=B6Q5FYp1JCoJW1utc+uuDB5Pm3CCXrMuK3055yhc8JKP9H4udWuXjnkZ+Hm9QXes/R
         8n0lIgI1ZWMydKL8oRUvhkKP64QsAKipQVjqOcFe1hE3hlSQZbYy0atmR1FxEihH+1GN
         CAJmGxZ22VzVrrHN6LP90VYaAxKo9R7Xmw4AGUGYqi6BT17kpgJ67FiPmBIlqxD0EEaE
         qPE4rNtJ/STQZBmOPqrXKapWuCHGWt3jJbeQ3pySJ84D+Mz8Cih4ddS0RT2RLljFJ02x
         MOMP17BvUF/CppHnsBGQmyZnJB/mjjiqNmM4axqdj1Dae0cWAuNO+bg8A6fDx0MPnCUz
         0Jgw==
X-Gm-Message-State: AOAM532Ng+T30Z0NnvuFgn42uXKpHH8Qp3Rz84rCwKKUImM/Gw4sTrT5
        2m/RK9dhJPmhJEtLqfLPiy1+E3uI3sGBMi4ZUFzUGw==
X-Google-Smtp-Source: ABdhPJyGSbW2h5yCweQVPa1tQb6SlDPUcQA1ps0F1YPmOe2dM1okKohocJfCFT0KxDcxjCRvNvx6fg5o5HZmS8y4/SY=
X-Received: by 2002:ac2:5509:: with SMTP id j9mr19391729lfk.302.1617107451100;
 Tue, 30 Mar 2021 05:30:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210330080615.21938-1-lecopzer.chen@mediatek.com> <20210330083218.22285-1-lecopzer.chen@mediatek.com>
In-Reply-To: <20210330083218.22285-1-lecopzer.chen@mediatek.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 30 Mar 2021 18:00:39 +0530
Message-ID: <CAFA6WYMqLMEG2s7OdNweQKkP0K2LZ575B1BVw-zfsg7_KBSM5Q@mail.gmail.com>
Subject: Re: [PATCH v5] arm64: Enable perf events based hard lockup detector
To:     Lecopzer Chen <lecopzer.chen@mediatek.com>
Cc:     Alexandru Elisei <alexandru.elisei@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Lecopzer Chen <lecopzer@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Will Deacon <will@kernel.org>, yj.chiang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Mar 2021 at 14:07, Lecopzer Chen <lecopzer.chen@mediatek.com> wrote:
>
> > > Hi Will, Mark,
> > >
> > > On Fri, 15 Jan 2021 at 17:32, Sumit Garg <sumit.garg@linaro.org> wrote:
> > > >
> > > > With the recent feature added to enable perf events to use pseudo NMIs
> > > > as interrupts on platforms which support GICv3 or later, its now been
> > > > possible to enable hard lockup detector (or NMI watchdog) on arm64
> > > > platforms. So enable corresponding support.
> > > >
> > > > One thing to note here is that normally lockup detector is initialized
> > > > just after the early initcalls but PMU on arm64 comes up much later as
> > > > device_initcall(). So we need to re-initialize lockup detection once
> > > > PMU has been initialized.
> > > >
> > > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > > ---
> > > >
> > > > Changes in v5:
> > > > - Fix lockup_detector_init() invocation to be rather invoked from CPU
> > > >   binded context as it makes heavy use of per-cpu variables and shouldn't
> > > >   be invoked from preemptible context.
> > > >
> > >
> > > Do you have any further comments on this?
> > >
> > > Lecopzer,
> > >
> > > Does this feature work fine for you now?
> >
> > This really fixes the warning, I have a real hardware for testing this now.

Thanks for the testing. I assume it as an implicit Tested-by.

> > but do we need to call lockup_detector_init() for each cpu?
> >
> > In init/main.c, it's only called by cpu 0 for once.
>
> Oh sorry, I just misread the code, please ignore previous mail.
>

No worries.

-Sumit

>
> BRs,
> Lecopzer
