Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 404023EAE98
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 04:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238369AbhHMCaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 22:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237916AbhHMCaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 22:30:04 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE24CC061756
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 19:29:37 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id k4so5898879wms.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 19:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sKJWG2wYefEMFzSTPD/O3cAcigf3Odbg7bAq2foda4E=;
        b=Pyt+KggUWdRtQE+PXCngiP4ntbu1CFIosRqKmwZRRePB8WO5Cd5+roeHCtBk4Yp9ZM
         FOxzLu6UmT3CqxO0YysCj2hJ1peFjWZNwrx9OWDF9TgVvgfcX6lC/W2j5io3gKMJlBBv
         RtrSLhF55PRkuVV/nhaA9TpTOMiDTidXmfny2xohYGdjUjkW2cRUGj2DgIMWKGNO1XuB
         f8MRbhHG0TtZSjhssN9GOCA3BxHw2fJ40aLJEufUfN2EcaLeW7Eqoe6FxjGeS2D5vEzB
         4VURVsR8Fljnn1BDzJ5JSI58MYLZ3md43n+mizYspPogJaaQAOqfhr6mBUEw9AJ2Jd72
         k3Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sKJWG2wYefEMFzSTPD/O3cAcigf3Odbg7bAq2foda4E=;
        b=hi0w7GLpL0JHHnXSPYpJCi7xNGTVSgfTiNmGGFPjscdObzTQ7/nUJ2H1BJBIxF1TLp
         4kMjpGp+6SWnNtjH+n+/Oxqz/k85i//XCSrkJozxVGKqa7rSIfV8CyGC9G1M+OUPwzdM
         9AEyTwPIveCNvRv2NJ8l/1vW09fI4ZS6E9YqOg4wkxidKXWbSSgmMI9zRIjdgtGwWV70
         P6pEm2wTFBvW+TYWu39d20eF9jXpAoEZyp7Ni5eGBe1F/EQAA4KXr3edP7fhl8rhqY11
         l4/jVzyBh/5SAGwMCRLSTZuOSg3QxTXSaVJfQ4NBB9q3mEz5WnFiVNNRkQOMnLRBKZXf
         QsXw==
X-Gm-Message-State: AOAM531D82uSYCRuZL2+SsyRTnLlj7tp2BPCkT3ZHIyYW7wMburVqqje
        gndeb12Il2gdMJD/aaOyWufunxJGw/c/VikXfFQ=
X-Google-Smtp-Source: ABdhPJxFbUV8C03/+u2TN/FTqlFUv1yY95Sj3kgAwVYlg3KoCpzCv9nbMj2UjGWces49Mqy30otnhQ9yFbfX90UhowM=
X-Received: by 2002:a1c:e904:: with SMTP id q4mr297827wmc.26.1628821776591;
 Thu, 12 Aug 2021 19:29:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210715065455.392923-2-zhang.lyra@gmail.com> <202108011431.Nx7sS0uY-lkp@intel.com>
 <CAAfSe-vY9bkLb7Q2Tn=2ug6pau9VHkfZyvmoQNMqeKmxfquOHg@mail.gmail.com> <874kbuiupn.ffs@tglx>
In-Reply-To: <874kbuiupn.ffs@tglx>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Fri, 13 Aug 2021 10:29:00 +0800
Message-ID: <CAAfSe-tf9GsqFnSdBa2xkRLD5ffUX+4FT7hUJ2d40AE196_cUg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] drivers/clocksource/timer-of: Remove __init markings
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     kernel test robot <lkp@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        clang-built-linux@googlegroups.com, kbuild-all@lists.01.org,
        Saravana Kannan <saravanak@google.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Aug 2021 at 22:49, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Thu, Aug 12 2021 at 14:39, Chunyan Zhang wrote:
> > On Sun, 1 Aug 2021 at 14:18, kernel test robot <lkp@intel.com> wrote:
> >> >> s390x-linux-gnu-ld: timer-of.c:(.text+0x306): undefined reference to `iounmap'
> >
> > Seems TIMER_OF should depend on HAS_IOMEM, but this error is not
> > related with changes in the above patch?
>
> Right, it's not caused by your patch, but if you already analyzed the
> problem, then why are you not sending a fix for this?

Ok, I will send a fix.
BTW, if no more comments on this patchset, could you or Daniel please
apply the patch-set to your tree?

Thanks,
Chunyan
