Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 021C23DF98B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 04:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234098AbhHDCEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 22:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234422AbhHDCEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 22:04:09 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D601AC0613D5
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 19:03:57 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id i10-20020a05600c354ab029025a0f317abfso2885511wmq.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 19:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rtst-co-kr.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zBi/4DyBrAJ54JI+6NAqWr7rfcLuXLpDmtkvpW0MEpg=;
        b=VxDyckCan+nlsyElYFpgIKhlFvfJGmh1LuwKJz4W6++ZOdvSj9BPr5P3TEqAGJR7WT
         S8V0yyRtbvkPce1pk2NlJIqFRImxTRTF738Az2uxnigUtcFsVzeb5qyk1L3HMViwo7C2
         wWKZZMGMDFJ3thdVsMyUykfojFTDnQ78QDGSPjROs4482uO0PTuPqDBye2t9IfRWCJTW
         n2lqMoMrW6HPPrxgRO3r/RFaQsKxtxeLXxoKTIGjo1T64wiWS+ufwnz3Iq3FOt0mZpq2
         AJaRlbejOeTlxBVy4Ip4RoRD0SwNXa6CEpuIuOk+77s41jFCazDd/OAH3NKGMwHg3LHa
         1uRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zBi/4DyBrAJ54JI+6NAqWr7rfcLuXLpDmtkvpW0MEpg=;
        b=gl6IFaIOc2tDJA937tlQDDziAtmSd5/x3RuyVb5byziV4Mr0aqKb0iuUDkO80ROHCp
         jrpHKq3lVyWtabssZIfIJFCJzG3a5iBkhKIP4pjtiYhwNJep/dja5gUmpfsAYnyM0JuB
         AxJpUPQ2exmdpjlLPRrzDBR3A39BtJxfTs6lR5gmUVdYUOduHJhWvIwJu/YUGWIcNleC
         qClEsA/Eh8Gil44+DKhEI7wl9714TqxDWPBM/rJ9kRP4am3bDp/eC5DkgLDOGsooLH68
         Eb9tSSg/Ewxj6uMDAPawG+F+su3qaXyxn4oDYa6Fp3Mgb3U5GKa6Mpy8ibWni5bl30c6
         A//A==
X-Gm-Message-State: AOAM533s8jlY7WQy50OE/RcxQ0bTN/wYRUGryv/R8b//u1GKJuTyCqc7
        zWhUmBzM+erjZB95X9SD1L04ivLRjxlZ4F3Rsd3Gwg==
X-Google-Smtp-Source: ABdhPJxY3QjySiiv+DNCAckxM779d1JXngFScYhhyH3gGzgY6c3A8dX9XcgtDZyEc7ALNTMY2deeQ769daP3dbmKuII=
X-Received: by 2002:a7b:c094:: with SMTP id r20mr24399561wmh.107.1628042636306;
 Tue, 03 Aug 2021 19:03:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAJk_X9hBB_edByfEvueSyWgKjpYGZbS2rPLPCSpRrPr+icFz_Q@mail.gmail.com>
 <20210804013252.GA16420@nchen>
In-Reply-To: <20210804013252.GA16420@nchen>
From:   Jeaho Hwang <jhhwang@rtst.co.kr>
Date:   Wed, 4 Aug 2021 11:03:44 +0900
Message-ID: <CAJk_X9gwa+4CZRemKqW7XZzxd438EQHA-Ngp4MdmPVgHM0Q5fg@mail.gmail.com>
Subject: Re: Chipidea USB device goes infinite loop due to interrupt while hw_ep_prime
To:     Peter Chen <peter.chen@kernel.org>
Cc:     linux-usb@vger.kernel.org,
        =?UTF-8?B?67OA66y06rSRKEJ5ZW9uIE1vbyBLd2FuZykv7J6Q64+Z7ZmU7JewKUF1dG9tYXRpb24gUGxhdGZvcm0=?=
         =?UTF-8?B?7Jew6rWs7YyA?= <mkbyeon@lselectric.co.kr>,
        Linux team <team-linux@rtst.co.kr>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi. linux-usb and linux-rt experts.
>
> On 21-08-02 17:35:01, Jeaho Hwang wrote:
> > Hi.
> >
> > We found an infinite loop inside the function hw_ep_set_halt
> > (drivers/usb/chipidea/udc.c) if a cablle is repeatedly
> > connnected/disconnected while ping through RNDIS with chipidea USB devi=
ce.
> >
> > Using ftrace tracing, we found that hw_ep_set_halt is called due to err=
or
> > return of hw_ep_prime(drivers/usb/chipidea/udc.c:202) which is called f=
rom
> > isr_tr_complete_handler -> isr_setup_status_phase -> _ep_queue.
> >
> > The comment of function hw_ep_prime says (execute without interruption)=
 but
> > timer interrupt is occurred while hw_ep_prime is executing. We believe =
that
> > the interrupt causes an error return of hw_ep_prime. We tried to protec=
t
> > hw_ep_prime from irqs and then no case of the infinite loop is occurred=
.
> >
> > I want ask if it is appropriate way that turning off irq inside (thread=
ed)
> > irq handlers. And should we explicitly turn off irqs before calling
> > hw_ep_prime?
> >
>
> Jeaho, do you use RT-Linux or standard Linux? The function hw_ep_prime is
> only called at udc_irq which is registered as top-half irq handlers.
> Why the timer interrupt is occurred when hw_ep_prime is executing?

We use preempt_RT so timer interrupt could be occurred. Now I found
out that forced threaded irq handler disables local irq on standard
linux so It is a linux-rt issue. Then should I make patch which
disables local irqs during hw_ep_prime for RT kernel and suggest it to
linux-rt maintainers?

Thanks for a kind answer Peter.

>
> --
>
> Thanks,
> Peter Chen
>


--=20
=ED=99=A9=EC=9E=AC=ED=98=B8, Jay Hwang, linux team manager of RTst
010-7242-1593
