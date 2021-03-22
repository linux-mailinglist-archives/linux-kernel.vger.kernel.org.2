Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E76C344FD2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 20:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbhCVTXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 15:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbhCVTWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 15:22:42 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 730E3C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 12:22:41 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id g20so11797860qkk.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 12:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cLy5RBMbVv+7pgZZbo/ExjQRPvzPQKaVh0hhl1CwHas=;
        b=K2riKvcAmdu/6NO7DSJFQtQ2uYZUr7E5HDWpXE31+ZFW8NxoYeo8HJgbdTPWvJx2uk
         WY9Pi6gT4xhXUayqnk8iDMB8EC3rLJl0XcimZpWlq6TcZVvPcjyvQQkXJ7x+kuOoQtIp
         KcD5qL+JutHFOFev+kfSzRWannf7vB/GeqbPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cLy5RBMbVv+7pgZZbo/ExjQRPvzPQKaVh0hhl1CwHas=;
        b=pZi3JjA8dgMfAc5i5rfeNKdVaWSQ1SJBI2c1+SnoWYweP6C+h5RUuYwd6L14tFHYDP
         wA4csxN+MPFw2m2Kh8l+c7ZU+/LCS2x0Ox5HfFBZUhYrZm/0mv1Of7Lp71tM5b8mF0/C
         GZ99/H1pXjGlYrD5hIT0IA0UpSGskU1Vdpw8gJ9m1MLENeyj+hGYqGEt1dGTvsr8tpCa
         YYr3U5zldf33dg5h6ybXnihavGPCiia0Hr25eWH+n40NlpBuBEDAQsFSP0BhjPRf9lNY
         DF0qzHyZl92FeSRBe77IzGp7uMI0HPqf4ESOTrTCCJFZlCTBukBCH8Rk3PEtN5aSn7ZG
         mfuw==
X-Gm-Message-State: AOAM5303S/eHQeVkoLzsOiHTz5d0vmtKKJRLelWtvs55Qjw3vOJOwinD
        gWExgx5UwZnVUL6Nzpryxq6FQ0QiR8SRSg==
X-Google-Smtp-Source: ABdhPJzgG8GhDBlexzwLzO2YedFHAF8bzXf2IvPUulmqE3sM2j/luhb8+rnX0wj+JiKgFEjbcVtXzA==
X-Received: by 2002:a37:a0d1:: with SMTP id j200mr1673411qke.426.1616440960302;
        Mon, 22 Mar 2021 12:22:40 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id q2sm11562304qkq.59.2021.03.22.12.22.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Mar 2021 12:22:39 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id x189so433523ybg.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 12:22:39 -0700 (PDT)
X-Received: by 2002:a25:ab54:: with SMTP id u78mr194252ybi.276.1616440959152;
 Mon, 22 Mar 2021 12:22:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210322164308.827846-1-arnd@kernel.org> <CAD=FV=WY6yxx+vkH+UU4VYei29xBftdnyRBE1OpEELmJ-kLfFg@mail.gmail.com>
 <CAK8P3a33qv79GedMCwA=GFBWYCMB2fYrq2QmGpN3TWfqgg8j2A@mail.gmail.com>
In-Reply-To: <CAK8P3a33qv79GedMCwA=GFBWYCMB2fYrq2QmGpN3TWfqgg8j2A@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 22 Mar 2021 12:22:27 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WaOFJEnZ=b+UTaTXDWMs8JOeBw1gRFYrtSJK-+CXGPyw@mail.gmail.com>
Message-ID: <CAD=FV=WaOFJEnZ=b+UTaTXDWMs8JOeBw1gRFYrtSJK-+CXGPyw@mail.gmail.com>
Subject: Re: [PATCH] kgdb: fix gcc-11 warning on indentation
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@elte.hu>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        kgdb-bugreport@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Mar 22, 2021 at 11:19 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Mon, Mar 22, 2021 at 6:07 PM Doug Anderson <dianders@chromium.org> wrote:
> > On Mon, Mar 22, 2021 at 9:43 AM Arnd Bergmann <arnd@kernel.org> wrote:
> > >
> > > -#define v1printk(a...) do { \
> > > -       if (verbose) \
> > > -               printk(KERN_INFO a); \
> > > -       } while (0)
> > > -#define v2printk(a...) do { \
> > > -       if (verbose > 1) \
> > > -               printk(KERN_INFO a); \
> > > -               touch_nmi_watchdog();   \
> > > -       } while (0)
> > > -#define eprintk(a...) do { \
> > > -               printk(KERN_ERR a); \
> > > -               WARN_ON(1); \
> > > -       } while (0)
> > > +#define v1printk(a...) do {            \
> >
> > nit: In addition to the indentation change you're also lining up the
> > backslashes. Is that just personal preference, or is there some
> > official recommendation in the kernel? I don't really have a strong
> > opinion either way (IMO each style has its advantages).
>
> I don't think there is an official recommendation, I just think the
> style is more common, and it helped my figure out what the
> indentation should look like in this case.

OK, makes sense. I just wasn't sure if there was some standard that I
wasn't aware of. Given that you have to touch all these lines anyway
then making them all pretty like this seems fine to me.


> > > +       if (verbose)                    \
> > > +               printk(KERN_INFO a);    \
> > > +} while (0)
> > > +#define v2printk(a...) do {            \
> > > +       if (verbose > 1)                \
> > > +               printk(KERN_INFO a);    \
> > > +       touch_nmi_watchdog();           \
> >
> > This touch_nmi_watchdog() is pretty wonky. I guess maybe the
> > assumption is that the "verbose level 2" prints are so chatty that the
> > printing might prevent us from touching the NMI watchdog in the way
> > that we normally do and thus we need an extra one here?
> >
> > ...but, in that case, I think the old code was _wrong_ and that the
> > intention was that the touch_nmi_watchdog() should only be if "verose
> > > 1" as the indentation implied. There doesn't feel like a reason to
> > touch the watchdog if we're not doing anything slow.
>
> No idea. It was like this in Jason's original version from 2008.

Yeah, I noticed the same. I'd be curious what Daneil (or Jason if he's
reading) says. I suppose i could always wait until your patch lands
and then send a new patch that puts it inside the "if" statement and
we can debate it then.

-Doug
