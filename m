Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB74E33735B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 14:04:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233382AbhCKNEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 08:04:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233014AbhCKNDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 08:03:40 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88DD7C061574;
        Thu, 11 Mar 2021 05:03:40 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id m7so2744396iow.7;
        Thu, 11 Mar 2021 05:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3Z2pPn/+mgSna0fy0QdjgPCa/QMt444fJT7SataGADQ=;
        b=UHPfISDhXEU6YsOqntLTiQ5sCDD8bmgPFwUp7CSZkbXNhBUh6B5flbCCxHfEFVBRiy
         pQRhPCDQkVXV3kSgz1bFK2Vy4vnYpDe9zmruW23Qj7WoPE8zfgA7RsPE9P/S4xamdvia
         aPq/M1NKdjcbgIe7VIzCW0KUJvGw+Zvb8noaP29KJV/DE7PHM0GkXA2I3QxTZ2fdEqRL
         avp0EM9ykZ0iJHnd9aC3oXj4ZiygjP6QJANBgLCzEoqz1v0QFS26J3yTmVhw5Q8MnKVU
         NK7/f7hLB94oPZy+dXYYhtKvY1MzEQY+ntj6bxw0yMvuueuFGkRsJ7n9okaYTxULOPMV
         nSwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3Z2pPn/+mgSna0fy0QdjgPCa/QMt444fJT7SataGADQ=;
        b=J1fIvySMFF0fFljOMD5s2goWgje3hrMCs2RpP2Kpi6BR+3+gUs0y1cRfE5wAh/lzU/
         seDzJ/0PgY31d4gjqRghHTgBgiRxHHWVdPa2u8fvv29FTokHNqGe16YwrGuErO4A7iEd
         JxLKWd7p6EIDtSmjzbmpfxKTvJ76D2pU9+rcOBqw25Owni2VDO3TWbz1f9ev8OSfwnTP
         Rs9EtZkL9YEBun38QUzAcFtSP7U9PMtfLV2fUGLBATB+cGHl8JqW30smChDbC+cSyyb7
         l7jTMxFokZK0nTE1bfPW/EGDHc4+00ee12T41Cbl4tCM0mgreNRGzVwIGcc9NOdcqCGc
         GdFw==
X-Gm-Message-State: AOAM533ONYeQ58bD1B7dpKf8OIPC9wLY29/pjkHHGfwEVM8on12LiiAi
        gMwDnaPCiG+/7YCAEJDw+ukZYf1YynQgG+PYNTI=
X-Google-Smtp-Source: ABdhPJwRAzuev2BWWFHijQ533wgwWUA060o1bf6cK1DacKsHHNmB8SrdLgXvW2BAJ9HnwSAQZo3ilh337tUjCLwwg1M=
X-Received: by 2002:a05:6638:e93:: with SMTP id p19mr3477812jas.10.1615467819949;
 Thu, 11 Mar 2021 05:03:39 -0800 (PST)
MIME-Version: 1.0
References: <1614758717-18223-1-git-send-email-dillon.minfei@gmail.com>
 <1614758717-18223-6-git-send-email-dillon.minfei@gmail.com>
 <b5f96460-dcdf-f40a-89d7-89def5669d7b@foss.st.com> <CAL9mu0+YFC97OBNLH-gip+MFKfdX4rAaxsFB4rMNrgjmhc5=Rw@mail.gmail.com>
 <d2549995-2b46-3f9a-e3d5-0e2bc21465d7@pengutronix.de>
In-Reply-To: <d2549995-2b46-3f9a-e3d5-0e2bc21465d7@pengutronix.de>
From:   dillon min <dillon.minfei@gmail.com>
Date:   Thu, 11 Mar 2021 21:03:04 +0800
Message-ID: <CAL9mu0LgE9nfs-e6J5Yuzd+kCJLyhovUz94vc6qQATa9Br42xg@mail.gmail.com>
Subject: Re: [Linux-stm32] [PATCH 5/8] ARM: dts: stm32: introduce
 stm32h7-pinctrl.dtsi to support stm32h75x
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux@armlinux.org.uk, Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        afzal.mohd.ma@gmail.com, linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ahmad,

Thanks for discussing.

On Thu, Mar 11, 2021 at 8:55 PM Ahmad Fatoum <a.fatoum@pengutronix.de> wrot=
e:
>
> Hello Dillon,
>
> On 11.03.21 13:23, dillon min wrote:
> > For stm32h7's new board support , I guess following the stm32f7/stm32f4=
's style
> > is a reasonable way to do it, but add a little optimization=E3=80=82
> > which means :
> > old structure
> > stm32h7-pinctrl.dtsi --> stm32h743-pinctrl.dtsi  (referenced by
> > stm32h743i-disco, -eval)
> >                                 |--> stm32h750-pinctrl.dtsi
> > (referenced by stm32h750i-art-pi, etc)
> > add art-pi other board's pin definition in stm32h750-pinctrl.dtsi with
> > xxx_pins_a, xxx_pins_b
> > xxx_pins_a used for art-pi, xxx_pins_b used for other boards.
> >
> > after more boards add in support, there will be more xxx_pin_c, .... de=
fined
> >
> > as the pin map is according to the hardware schematic diagram io connec=
tion.
> > so, why not move xxx_pin_x to a board specific place. such as
> > stm32h750i-art-pi.dts
> >
> > new structure:
> > 1, rename stm32h743-pinctrl.dtsi to stm32h7-pinctrl.dtsi (only
> > preserve gpioa...k,)
> > 2, move xxx_pins_x from stm32h7-pinctrl.dtsi to
> > stm32h7xx-disco/eval/art-pi/etc.dts (as they depends on hardware
> > schematic)
> >
> > stm32h7-pinctrl.dtsi --> stm32h743i-discon.dts
> >                                 |--> stm32h743i-eval.dts
> >                                 |--> stm32h750i-art-pi.dts
> >                                 |--> stm32h7xxx.dts
> > would you agree this ?
>
> If the optimization you intend is reducing DTB size, you can flag
> all pinctrl groups with /omit-if-no-ref/ to have dtc throw them
> away if they are unused.
Thanks for your advice, actually, DTB size is not my first consideration.
different board pin configuration place to one dtsi files, it's a little ha=
rd
to maintain when a lot of boards add in.

>
> (But in general, I am in favor of having board-specific configuration
>  in the board dts)
Yes, same to me.
>
> Cheers,
> Ahmad
>
> --
> Pengutronix e.K.                           |                             =
|
> Steuerwalder Str. 21                       | http://www.pengutronix.de/  =
|
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    =
|
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 =
|
