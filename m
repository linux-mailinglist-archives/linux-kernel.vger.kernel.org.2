Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (unknown [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3134E3F90D9
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 01:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243724AbhHZXI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 19:08:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:42698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231251AbhHZXI5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 19:08:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2DF7D60F5B;
        Thu, 26 Aug 2021 23:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630019289;
        bh=IMA+A6VQxP3Oshzm8C8sQVzXlmWGiuyfa8ab5GnWOLo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rM4rj6HwT2XUNYE1WzBAl3wLU+I+tJ9Mb1dbzAMjhqSE2Ihem9k15uEOgfNLBM3u1
         wwOsBacUO4fIgWp6OYaTylrNvl034uakiDiZlyzc47kjdA/JVMQk3gjZh3HTZNBqYi
         W/takFBs6871E3X8w3kZ0K7hVMhiTCg6Drwa6U0RSzmi1OtMPrJpmpWCbjkmwkXpBN
         EGccWwqVx4FBfqyBehOkRzNrYsQTOLtQXVOUqk2c7PUZ/taZoGzDGgKqw63cm1FdyZ
         uthrVE9Q7IVVSltVfEOycrTYB/eHLXq6xUU+sJ20JmBPvLGZ/fprlKf5irG05ZOEqQ
         R1pszfJI9jZpA==
Date:   Fri, 27 Aug 2021 07:07:58 +0800
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
Message-ID: <20210826230658.GB4335@Peter>
References: <20210817064353.GA669425@ubuntu>
 <CAJk_X9gbnx5edLmxKUfZYyDMQYKeotO3undgQygmp1skn2HjSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJk_X9gbnx5edLmxKUfZYyDMQYKeotO3undgQygmp1skn2HjSQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-08-24 17:31:44, Jeaho Hwang wrote:
> 2021년 8월 17일 (화) 오후 3:44, Jeaho Hwang <jhhwang@rtst.co.kr>님이 작성:
> >
> > If ctrl EP priming is failed (very rare case in standard linux),
> > hw_ep_set_halt goes infinite loop. waiting 100 times was enough
> > for zynq7000.
> >
> 
> Hi Peter.
> I found from zynq7000 TRM that the hardware clears Stall bit if a
> setup packet is received on a control endpoint.
> I think hw_ep_set_halt goes infinite loop since:
> 
> 1. hw_ep_prime for control EP which is called from
> isr_tr_complete_handler -> isr_setup_status_phase is failed due to a
> setup packet received.

How do you know that? Do you observe the new setup packet on the bus
before the current status stage? Usually, the host doesn't begin new setup
transfer before current setup transfer has finished.

Peter

> 2. in isr_tr_complete_handler it tries to call _ep_set_halt if either
> isr_tr_complete_low or isr_setup_status_phase returns error.
> 3. Since the control EP got a setup packet, HW resets TXS bit just as
> the driver sets inside hw_ep_set_halt so it goes infinite loop.
> 
> Does it make sense? If it is right, we shouldn't call _ep_set_halt if
> the err is -EAGAIN, which could be returned ONLY due to the setup
> packet issue described above.
> And the loop timeout is not required anymore.
> 
> Can I ask your opinion on this, Peter and USB experts?
> 
> Thanks.
> 
> > Signed-off-by: Jeaho Hwang <jhhwang@rtst.co.kr>
> >
> > diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
> > index 8834ca613721..d73fadb18f32 100644
> > --- a/drivers/usb/chipidea/udc.c
> > +++ b/drivers/usb/chipidea/udc.c
> > @@ -209,6 +209,9 @@ static int hw_ep_prime(struct ci_hdrc *ci, int num, int dir, int is_ctrl)
> >         return 0;
> >  }
> >
> > +/* enough for zynq7000 evaluation board */
> > +#define HW_EP_SET_HALT_COUNT_MAX 100
> > +
> >  /**
> >   * hw_ep_set_halt: configures ep halt & resets data toggle after clear (execute
> >   *                 without interruption)
> > @@ -221,6 +224,7 @@ static int hw_ep_prime(struct ci_hdrc *ci, int num, int dir, int is_ctrl)
> >   */
> >  static int hw_ep_set_halt(struct ci_hdrc *ci, int num, int dir, int value)
> >  {
> > +       int count = HW_EP_SET_HALT_COUNT_MAX;
> >         if (value != 0 && value != 1)
> >                 return -EINVAL;
> >
> > @@ -232,9 +236,9 @@ static int hw_ep_set_halt(struct ci_hdrc *ci, int num, int dir, int value)
> >                 /* data toggle - reserved for EP0 but it's in ESS */
> >                 hw_write(ci, reg, mask_xs|mask_xr,
> >                           value ? mask_xs : mask_xr);
> > -       } while (value != hw_ep_get_halt(ci, num, dir));
> > +       } while (value != hw_ep_get_halt(ci, num, dir) && --count > 0);
> >
> > -       return 0;
> > +       return count ? 0 : -EAGAIN;
> >  }
> >
> >  /**
> > --
> > 2.25.1
> >

-- 

Thanks,
Peter Chen

