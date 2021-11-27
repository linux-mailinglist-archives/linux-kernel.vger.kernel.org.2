Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C686745F766
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 01:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245735AbhK0AUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 19:20:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbhK0ASc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 19:18:32 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F002C061574
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 16:15:19 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id m25-20020a7bcb99000000b0033aa12cdd33so3213949wmi.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 16:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4CsSSZJr7IaMNsYiIfYeQFQHrKS4adoFzjlUrMJVCME=;
        b=AlzLFywdi7pDPtHxI7REvM3487+dBq/8vQFsjqjwHX/mDbKZLdIOx3Vx1FziUmxnJn
         2ixNtY0+ulDOaNR+B7EpJbf2Wqoki8VSlVDoPZGz1+c7SW551UCUDKKW3p0eaVXZV8FF
         zUFasbbgO6/2x5yf9Ca2xTSebyTkVQguaSLVxB6Ee7ie5X7+j8qc3I9Jh2d/RqMunH3Y
         FVKR5rXLbsPJ06JF2wpVn68MGLTO61lxamCZ3NEjEeam1/fX2Xb3kDaYawTKvCZ0ywg3
         k+VHK/ctwMXBBG8j7jj2vAq3YrQsrJTNUpoce2WZ0HiVwRCg39qDrbi9vvetTcNKaiQq
         OeEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4CsSSZJr7IaMNsYiIfYeQFQHrKS4adoFzjlUrMJVCME=;
        b=U7a8Ocg+/DUAovkNgPMMBuHhFhn8kMfMqRPNEOCvp4rNPfh5AubhVgfz0em+xnwWNo
         joNl0S98erLxyNdFFZa5XLoIFynrXF6aVKpwnuueh1540KSEJhHoFLtBArN5sgFZ7w1/
         5s2Gg58ZuWQ4Wrmm/YSbublcZdsduxwY1LuGF13G7nxW8MeZCzpMLS6S1vAu/Am8Y2pk
         NTSH1cx3XFbQCYHh3eRrypMe+cQOLQMIIPEOcraw68FFggeYmQCezcOGGc1pnRKRWcym
         5WqitKkg5ieS1QW0OKXMsDaKHdVYZUexfUhrnd6OXR/Hik1+K0gKcFDAcXcFCMUuNOjP
         69/Q==
X-Gm-Message-State: AOAM531VIhVzCBELVt5+kcmSfEwwbY4UjT09r9kkuCxSGJaluOycg59N
        kx5fxJh+F1QJ/oKDgqRK9SmRVSU2wsMPqNE/QdZH7EazXt4=
X-Google-Smtp-Source: ABdhPJyWibawhnlrJxg9/kMXWi/MQPXdBbkV+UAIHgYqq2chnlGMkIJPMoe2h8bg5xQCz0aXjAX+3EcuPUrLthmevlg=
X-Received: by 2002:a05:600c:3ba3:: with SMTP id n35mr19890854wms.88.1637972117262;
 Fri, 26 Nov 2021 16:15:17 -0800 (PST)
MIME-Version: 1.0
References: <20211125193852.3617-1-goldstein.w.n@gmail.com>
 <CANn89iLnH5B11CtzZ14nMFP7b--7aOfnQqgmsER+NYNzvnVurQ@mail.gmail.com>
 <CAFUsyfK-znRWJN7FTMdJaDTd45DgtBQ9ckKGyh8qYqn0eFMMFA@mail.gmail.com>
 <CANn89iJA1JOevgLSK019VYXKkLJsMjV-u9ZHvrgZ+XUypRWwfQ@mail.gmail.com>
 <CAFUsyfLeVGW8etXHuSGvYy_RoS3RGaA1L+NLKnpc7EsSMVORBg@mail.gmail.com>
 <CANn89iJxMhGfp364rPu6p_ZLrKnM1qWF_NWrw4_oL_KG+piByg@mail.gmail.com>
 <CAFUsyfJ33cKFQdUagHQ_b4N80CfBtGQZhyA4CN_JLgEmXEX=DA@mail.gmail.com>
 <CAFUsyf+TuU2Xe5Guy5yiFWsV-JZSjUJxcGZv=f0BYDSmODV+_w@mail.gmail.com>
 <CANn89iLjw7YeWNGNtVNi690adJfoSVwgLScrtx-zSyh=COZRsQ@mail.gmail.com>
 <CAFUsyfK5r+P6aQLBpYZoi0FSgvLwfawBUYTHtQL0TJRozujp3g@mail.gmail.com>
 <CANn89iKkK0eMQkOTSMGbvdtf+G=eRfXJG0Semju5h-C63QytaQ@mail.gmail.com> <CAFUsyf+9F9b2V-YDm8UdbnANrQ0_fYV6cGfRgPciASfvp9p=7w@mail.gmail.com>
In-Reply-To: <CAFUsyf+9F9b2V-YDm8UdbnANrQ0_fYV6cGfRgPciASfvp9p=7w@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 26 Nov 2021 16:15:05 -0800
Message-ID: <CANn89iJb_2666U4qgrqsjqEyT9_rA9SKRThbdy_--4_X8rFMYg@mail.gmail.com>
Subject: Re: [PATCH v1] x86/lib: Optimize 8x loop and memory clobbers in csum_partial.c
To:     Noah Goldstein <goldstein.w.n@gmail.com>
Cc:     tglx@linutronix.de, mingo@redhat.com,
        Borislav Petkov <bp@alien8.de>, dave.hansen@linux.intel.com,
        X86 ML <x86@kernel.org>, hpa@zytor.com, peterz@infradead.org,
        alexanderduyck@fb.com, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 26, 2021 at 12:33 PM Noah Goldstein <goldstein.w.n@gmail.com> wrote:
>
> On Fri, Nov 26, 2021 at 2:07 PM Eric Dumazet <edumazet@google.com> wrote:
> >
> > On Fri, Nov 26, 2021 at 11:50 AM Noah Goldstein <goldstein.w.n@gmail.com> wrote:
> > >
> > > Bright :) but it will need a BMI support check.
> >
> > Yes, probably not worth the pain.
>
> Making a V2 for my patch with your optimization for the loop case. Do you think
> 1 or 2 accum for the 32 byte case?
>

I would vote for something simpler, thus one accum, since this 32byte
block is only run one time ?

Thanks !
