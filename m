Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB3EF3F91F2
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 03:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243933AbhH0BgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 21:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243823AbhH0BgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 21:36:07 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0CEC0613C1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 18:35:18 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id q11so7888264wrr.9
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 18:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rtst-co-kr.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=18ypDOXtM2xNCCo882vf44y8cLDJPW0q76qObPVn3dk=;
        b=c46xvlnMH+zCi1LISxsaR0doJCE5JlR1h01UYT1ezAfv7uDw5suqjOL6EHIUz/eo26
         gwTpUWr5FO6h2FuZdT/GdXalwH0qe84NX+fnND9f1CsTrX+DfirGEeTjDAxxXgRszZUM
         XHSbF0z08cUbqT0KO6OZKbyzFmerPuKmK1UW7nGuvv6LZ5uEs3Fngo7125J7Ne6LEkP1
         cyjeiurf5WjaSTKA9QjH7vjjsVep1yYllXNGVHZ22s/6fA1pYWfbjLRZ8Yyx+lW49Bkf
         xXY4h4WmrfTrvxAYRvgINrQIW3PFmlcfhQqJDGjS4XpyWxOZV90ua77Hd8Puayk8dMbv
         l5qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=18ypDOXtM2xNCCo882vf44y8cLDJPW0q76qObPVn3dk=;
        b=F7wMjus9Pzhq2yS0xqIJX6pZSYLtliqo5kGsUfm+TmrNLulf35lMLXvYpsx8ZD9E6S
         4FBeU3PYQae3ZWY9hIrZtCkT5GP6FsLYuLsasCn3AlO9ZkXZDHGkyDD1Kr8tXW+YqtsC
         Fp1dFKYrsF4AH+8xK7VNpejGHo+wzdIo6+X1JNi+4rUFThedctn0+k+oc7QySvdZSU6n
         QtxSscrPag/EgVBNJ5w36yw6sP4X3qBJr/hChXNkF5I6isI3aw33qmk98y1orT0P8O1F
         EihL4cOqpiC607BBIbmPo3/TPsnG11ZQAyRB5kvTBa9uLOihee6BF47dYK4ThoOZQA2z
         cODQ==
X-Gm-Message-State: AOAM530ntEEaquB/51b0gjGoy5rZ13NCBdLaCw3Y0tOp06Sb4DK9rhWf
        p6ESNIJmJ1sEOo7ptIHUjtUsPA1fy0ssZxymXPfxpA==
X-Google-Smtp-Source: ABdhPJxdGxsxQ3J7lHyUzdsMMckf9f58k3f7HFiYcDYgAJ71rrqgqVLmWbujTZXH1gEIkeYq1A8ELMxehZUcODnQ1/k=
X-Received: by 2002:a05:6000:178b:: with SMTP id e11mr7143288wrg.151.1630028117005;
 Thu, 26 Aug 2021 18:35:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210817064353.GA669425@ubuntu> <CAJk_X9gbnx5edLmxKUfZYyDMQYKeotO3undgQygmp1skn2HjSQ@mail.gmail.com>
 <20210826230658.GB4335@Peter>
In-Reply-To: <20210826230658.GB4335@Peter>
From:   Jeaho Hwang <jhhwang@rtst.co.kr>
Date:   Fri, 27 Aug 2021 10:35:05 +0900
Message-ID: <CAJk_X9i68vPWDEf2x6WtV73XRCuhyZF_26KtK=J+Z76ZyQe8PQ@mail.gmail.com>
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

2021=EB=85=84 8=EC=9B=94 27=EC=9D=BC (=EA=B8=88) =EC=98=A4=EC=A0=84 8:08, P=
eter Chen <peter.chen@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On 21-08-24 17:31:44, Jeaho Hwang wrote:
> > 2021=EB=85=84 8=EC=9B=94 17=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 3:4=
4, Jeaho Hwang <jhhwang@rtst.co.kr>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> > >
> > > If ctrl EP priming is failed (very rare case in standard linux),
> > > hw_ep_set_halt goes infinite loop. waiting 100 times was enough
> > > for zynq7000.
> > >
> >
> > Hi Peter.
> > I found from zynq7000 TRM that the hardware clears Stall bit if a
> > setup packet is received on a control endpoint.
> > I think hw_ep_set_halt goes infinite loop since:
> >
> > 1. hw_ep_prime for control EP which is called from
> > isr_tr_complete_handler -> isr_setup_status_phase is failed due to a
> > setup packet received.
>
> How do you know that? Do you observe the new setup packet on the bus
> before the current status stage? Usually, the host doesn't begin new setu=
p
> transfer before current setup transfer has finished.
>
> Peter
>

I found an error return from the second ENDPTSETUPSTAT checking
routine, then setting the stall bit(TXS) kept failing. So I guessed it
is due to a setup packet received.
I didn't observe the setup packet by e.g. HW probes. Any other reason
to produce that symptom?

For reminder, only reproduced on preemp_rt kernel and with Windows(10)
RNDIS host.

thanks.

 191 static int hw_ep_prime(struct ci_hdrc *ci, int num, int dir, int is_ct=
rl)
 192 {
 193     int n =3D hw_ep_bit(num, dir);
 194
 195     /* Synchronize before ep prime */
 196     wmb();
 197
 198     if (is_ctrl && dir =3D=3D RX && hw_read(ci, OP_ENDPTSETUPSTAT, BIT=
(num)))
 199         return -EAGAIN;
 200
 201     hw_write(ci, OP_ENDPTPRIME, ~0, BIT(n));
 202
 203     while (hw_read(ci, OP_ENDPTPRIME, BIT(n)))
 204         cpu_relax();
 205     if (is_ctrl && dir =3D=3D RX && hw_read(ci, OP_ENDPTSETUPSTAT, BIT=
(num)))
 206         return -EAGAIN;
             ~~~~~~~~~~~~~~~~
 207
 208     /* status shoult be tested according with manual but it doesn't wo=
rk */
 209     return 0;
 210 }

> > 2. in isr_tr_complete_handler it tries to call _ep_set_halt if either
> > isr_tr_complete_low or isr_setup_status_phase returns error.
> > 3. Since the control EP got a setup packet, HW resets TXS bit just as
> > the driver sets inside hw_ep_set_halt so it goes infinite loop.
> >
> > Does it make sense? If it is right, we shouldn't call _ep_set_halt if
> > the err is -EAGAIN, which could be returned ONLY due to the setup
> > packet issue described above.
> > And the loop timeout is not required anymore.
> >
> > Can I ask your opinion on this, Peter and USB experts?
> >
> > Thanks.
> >
