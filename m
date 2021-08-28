Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F92A3FA350
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 05:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233194AbhH1DLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 23:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233158AbhH1DLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 23:11:08 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B411C0613D9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 20:10:18 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id q11so13230760wrr.9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 20:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rtst-co-kr.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=y527krCDKEsx0ChQP3KqPNsQAyNPKFXncMJNmo17VWs=;
        b=dgsNlA3g3eXW2MkNa/+cZhqT/7ECRL9+46yAuRJlZUpoh6PhGCsQjdIeqz7GTF+eHc
         HRySG3VjgQeTYhUzXiPQTl75oX8CdG8yOTMeSTC3wB1S0PJmtzMR306lXDSOnTbjFoSc
         npvri3Z14MKg+/w5U6LIDi8RnQyVG4yiHS3rwzMMZWWkCB78vElcBedD7UXx00WvD82J
         x+QAX4sAoIb0gUO8bafwUqgxVIL0EOE8qn+hUeRTHBuauk3fzs+6tMUS3NSsJOjzt31R
         9vktrqUdkfSdfWGZGvilAQyUIZUv8JQwVK65cbk3mx34028K12a92Cmzz0Konq40iebJ
         yDvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=y527krCDKEsx0ChQP3KqPNsQAyNPKFXncMJNmo17VWs=;
        b=hrwYUMpyANgS3XcyPdciE29mUn6cHBT/wz8MQcns+J2fdIjvo13vgaberIVTE8dyer
         uvzy+6PNwkAelYWIHitLtrr2SEZYLRaqO608/MbHfrMw+PBYRwj51uX8Dx4Aca7RaSX3
         q89mPNyCyLyhCgm20F9PJ8gcCNIUCzCacZg3Af+GxcO8Ep0AESdEOsysBoGEJ2tssX8N
         zqyQzBoz2qpyRd+zyTLALI6YYHW7JPVviAAKNF40P1T+D1rUHAwUpia75cTKXl6dtRBV
         AOS0CkqsBm/klcKolCct0vKhuSXE9q/sorOFpzHpLectFPuKfHvdblGPzPmzq4jfN9o3
         VFKg==
X-Gm-Message-State: AOAM5303Jtx+4oiZ2JwXZ2S4wSRWZ8VsbfdC7O5hXICmkXlvwnLtveKT
        /44+KDF3R2/pzLlEwir+7UtbDVigf0PDakOfa8F+cA==
X-Google-Smtp-Source: ABdhPJy9gONy2gALGHWfXhx9Yau7+ZLZy0pqdCTKgLmcruFnoO3c99DOpMYDV7uYMmyyOTty7ZcEeGcN2Gp2tvByCfo=
X-Received: by 2002:adf:ba4d:: with SMTP id t13mr13576388wrg.424.1630120216876;
 Fri, 27 Aug 2021 20:10:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210817064353.GA669425@ubuntu> <CAJk_X9gbnx5edLmxKUfZYyDMQYKeotO3undgQygmp1skn2HjSQ@mail.gmail.com>
 <20210826230658.GB4335@Peter> <CAJk_X9i68vPWDEf2x6WtV73XRCuhyZF_26KtK=J+Z76ZyQe8PQ@mail.gmail.com>
 <20210828013811.GA3590@Peter>
In-Reply-To: <20210828013811.GA3590@Peter>
From:   Jeaho Hwang <jhhwang@rtst.co.kr>
Date:   Sat, 28 Aug 2021 12:10:05 +0900
Message-ID: <CAJk_X9i=rJ88eHoW5fyzvO83neeP0qDUYKi+-1OkrgD96b4GdQ@mail.gmail.com>
Subject: Re: [PATCH v2] usb: chipidea: add loop timeout for hw_ep_set_halt()
To:     Peter Chen <peter.chen@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux team <team-linux@rtst.co.kr>,
        =?UTF-8?B?67OA66y06rSRKEJ5ZW9uIE1vbyBLd2FuZykv7J6Q64+Z7ZmU7JewKUF1dG9tYXRpb24gUGxhdGZvcm0=?=
         =?UTF-8?B?7Jew6rWs7YyA?= <mkbyeon@lselectric.co.kr>,
        =?UTF-8?B?7LWc6riw7ZmNKENob2kgS2kgSG9uZykv7J6Q64+Z7ZmU7JewKUF1dG9tYXRpb24gUGxhdGZvcm3sl7A=?=
         =?UTF-8?B?6rWs7YyA?= <khchoib@lselectric.co.kr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2021=EB=85=84 8=EC=9B=94 28=EC=9D=BC (=ED=86=A0) =EC=98=A4=EC=A0=84 10:38, =
Peter Chen <peter.chen@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On 21-08-27 10:35:05, Jeaho Hwang wrote:
> > 2021=EB=85=84 8=EC=9B=94 27=EC=9D=BC (=EA=B8=88) =EC=98=A4=EC=A0=84 8:0=
8, Peter Chen <peter.chen@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> > >
> > > On 21-08-24 17:31:44, Jeaho Hwang wrote:
> > > > 2021=EB=85=84 8=EC=9B=94 17=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84=
 3:44, Jeaho Hwang <jhhwang@rtst.co.kr>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=
=B1:
> > > > >
> > > > > If ctrl EP priming is failed (very rare case in standard linux),
> > > > > hw_ep_set_halt goes infinite loop. waiting 100 times was enough
> > > > > for zynq7000.
> > > > >
> > > >
> > > > Hi Peter.
> > > > I found from zynq7000 TRM that the hardware clears Stall bit if a
> > > > setup packet is received on a control endpoint.
> > > > I think hw_ep_set_halt goes infinite loop since:
> > > >
> > > > 1. hw_ep_prime for control EP which is called from
> > > > isr_tr_complete_handler -> isr_setup_status_phase is failed due to =
a
> > > > setup packet received.
> > >
> > > How do you know that? Do you observe the new setup packet on the bus
> > > before the current status stage? Usually, the host doesn't begin new =
setup
> > > transfer before current setup transfer has finished.
> > >
> > > Peter
> > >
> >
> > I found an error return from the second ENDPTSETUPSTAT checking
> > routine, then setting the stall bit(TXS) kept failing. So I guessed it
> > is due to a setup packet received.
> > I didn't observe the setup packet by e.g. HW probes. Any other reason
> > to produce that symptom?
>
> I guess two possible reasons for that:
> - The new setup is coming after priming
> - The interrupt occurs after prime, and when the back from interrupt,
> other thread for USB transfer is scheduled, eg, usb_ep_queue from RNDIS
>
> From your experiments and observation, it seems the first reason is not p=
ossible.

I will check if any other thread calls udc. but the only workload
using RNDIS was the host side ping sender.
Thanks for the advice.

> Did your get failure with UP system?

I'm sorry I don't understand what UP system means.

>
> Peter
>
> >
> > For reminder, only reproduced on preemp_rt kernel and with Windows(10)
> > RNDIS host.
> >
> > thanks.
> >
> >
> > > > 2. in isr_tr_complete_handler it tries to call _ep_set_halt if eith=
er
> > > > isr_tr_complete_low or isr_setup_status_phase returns error.
> > > > 3. Since the control EP got a setup packet, HW resets TXS bit just =
as
> > > > the driver sets inside hw_ep_set_halt so it goes infinite loop.
> > > >
> > > > Does it make sense? If it is right, we shouldn't call _ep_set_halt =
if
> > > > the err is -EAGAIN, which could be returned ONLY due to the setup
> > > > packet issue described above.
> > > > And the loop timeout is not required anymore.
> > > >
> > > > Can I ask your opinion on this, Peter and USB experts?
> > > >
> > > > Thanks.
> > > >
>
> --
>
> Thanks,
> Peter Chen
>


--=20
=ED=99=A9=EC=9E=AC=ED=98=B8, Jay Hwang, linux team manager of RTst
010-7242-1593
