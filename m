Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32BF03FA2F7
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 03:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233113AbhH1BjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 21:39:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:34944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233077AbhH1BjL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 21:39:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B9A2760F5B;
        Sat, 28 Aug 2021 01:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630114701;
        bh=CaTmkgpWyAlI4JG546Tj5Ii/4kGb6Z2e3LCZmdZp6IA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jdG8uA0gzGhrOKJmZ1dlXDKYJ/Ymp5IiQT1/VWFfurOPQVOPsIV0SKbbcloPZyLQ8
         s1RxartxUmYHgQsZ0R//VEKHSzXjPT+rhwS93PSw6RFSH6oLP+RGEi3K2nKot0lzeP
         LJcWcjxvPMXodhhRh+y/ysRV8buVUgsf+gq/jnGd6KUHPcm7vdME57H9La48q9LIKT
         HXIZQMG3GW+J3AjcQe7fBXiPalC3KmW19/cNaALyr21g0R+mGUcj1DxDJ7ArV68Dc7
         //wI4aYPqJYmeV02pfONZun5cZode/eupwwrFEZGTE5OenL+2DU5zjuHkn3kUYEMYG
         +gMCkHuifrtdg==
Date:   Sat, 28 Aug 2021 09:38:11 +0800
From:   Peter Chen <peter.chen@kernel.org>
To:     Jeaho Hwang <jhhwang@rtst.co.kr>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux team <team-linux@rtst.co.kr>,
        =?utf-8?B?67OA66y06rSRKEJ5ZW9uIE1vbyBLd2FuZykv7J6Q64+Z7ZmU7JewKUF1dG9t?=
         =?utf-8?B?YXRpb24gUGxhdGZvcm3sl7DqtaztjIA=?= 
        <mkbyeon@lselectric.co.kr>,
        =?utf-8?B?7LWc6riw7ZmNKENob2kgS2kgSG9uZykv7J6Q64+Z7ZmU7JewKUF1dG9tYXRp?=
         =?utf-8?B?b24gUGxhdGZvcm3sl7DqtaztjIA=?= 
        <khchoib@lselectric.co.kr>
Subject: Re: [PATCH v2] usb: chipidea: add loop timeout for hw_ep_set_halt()
Message-ID: <20210828013811.GA3590@Peter>
References: <20210817064353.GA669425@ubuntu>
 <CAJk_X9gbnx5edLmxKUfZYyDMQYKeotO3undgQygmp1skn2HjSQ@mail.gmail.com>
 <20210826230658.GB4335@Peter>
 <CAJk_X9i68vPWDEf2x6WtV73XRCuhyZF_26KtK=J+Z76ZyQe8PQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJk_X9i68vPWDEf2x6WtV73XRCuhyZF_26KtK=J+Z76ZyQe8PQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-08-27 10:35:05, Jeaho Hwang wrote:
> 2021년 8월 27일 (금) 오전 8:08, Peter Chen <peter.chen@kernel.org>님이 작성:
> >
> > On 21-08-24 17:31:44, Jeaho Hwang wrote:
> > > 2021년 8월 17일 (화) 오후 3:44, Jeaho Hwang <jhhwang@rtst.co.kr>님이 작성:
> > > >
> > > > If ctrl EP priming is failed (very rare case in standard linux),
> > > > hw_ep_set_halt goes infinite loop. waiting 100 times was enough
> > > > for zynq7000.
> > > >
> > >
> > > Hi Peter.
> > > I found from zynq7000 TRM that the hardware clears Stall bit if a
> > > setup packet is received on a control endpoint.
> > > I think hw_ep_set_halt goes infinite loop since:
> > >
> > > 1. hw_ep_prime for control EP which is called from
> > > isr_tr_complete_handler -> isr_setup_status_phase is failed due to a
> > > setup packet received.
> >
> > How do you know that? Do you observe the new setup packet on the bus
> > before the current status stage? Usually, the host doesn't begin new setup
> > transfer before current setup transfer has finished.
> >
> > Peter
> >
> 
> I found an error return from the second ENDPTSETUPSTAT checking
> routine, then setting the stall bit(TXS) kept failing. So I guessed it
> is due to a setup packet received.
> I didn't observe the setup packet by e.g. HW probes. Any other reason
> to produce that symptom?

I guess two possible reasons for that:
- The new setup is coming after priming
- The interrupt occurs after prime, and when the back from interrupt,
other thread for USB transfer is scheduled, eg, usb_ep_queue from RNDIS 

From your experiments and observation, it seems the first reason is not possible.
Did your get failure with UP system?

Peter

> 
> For reminder, only reproduced on preemp_rt kernel and with Windows(10)
> RNDIS host.
> 
> thanks.
> 
>  191 static int hw_ep_prime(struct ci_hdrc *ci, int num, int dir, int is_ctrl)
>  192 {
>  193     int n = hw_ep_bit(num, dir);
>  194
>  195     /* Synchronize before ep prime */
>  196     wmb();
>  197
>  198     if (is_ctrl && dir == RX && hw_read(ci, OP_ENDPTSETUPSTAT, BIT(num)))
>  199         return -EAGAIN;
>  200
>  201     hw_write(ci, OP_ENDPTPRIME, ~0, BIT(n));
>  202
>  203     while (hw_read(ci, OP_ENDPTPRIME, BIT(n)))
>  204         cpu_relax();
>  205     if (is_ctrl && dir == RX && hw_read(ci, OP_ENDPTSETUPSTAT, BIT(num)))
>  206         return -EAGAIN;
>              ~~~~~~~~~~~~~~~~
>  207
>  208     /* status shoult be tested according with manual but it doesn't work */
>  209     return 0;
>  210 }
> 
> > > 2. in isr_tr_complete_handler it tries to call _ep_set_halt if either
> > > isr_tr_complete_low or isr_setup_status_phase returns error.
> > > 3. Since the control EP got a setup packet, HW resets TXS bit just as
> > > the driver sets inside hw_ep_set_halt so it goes infinite loop.
> > >
> > > Does it make sense? If it is right, we shouldn't call _ep_set_halt if
> > > the err is -EAGAIN, which could be returned ONLY due to the setup
> > > packet issue described above.
> > > And the loop timeout is not required anymore.
> > >
> > > Can I ask your opinion on this, Peter and USB experts?
> > >
> > > Thanks.
> > >

-- 

Thanks,
Peter Chen

