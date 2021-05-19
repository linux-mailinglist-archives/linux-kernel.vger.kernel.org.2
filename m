Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86A893889B4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 10:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244206AbhESIuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 04:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238703AbhESIuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 04:50:05 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39D6C06175F;
        Wed, 19 May 2021 01:48:46 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id o14-20020a4a384e0000b029020ec48a2358so753219oof.13;
        Wed, 19 May 2021 01:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FfSUR09C1mHiwJhD3QNYQuarzezJOYlVWsneR6uo6gQ=;
        b=Jm4Dv6mZdZvRgrowObSeo84niFMzgAfsuB6DzP7V9cHEu7sf9U4BfAsPlqP7hN49aX
         s+SbN2pfJfyCOLpyIrztipE8q0YpsExXUKldMsaFEfT4zTzmyy199n1fqVJdr/4jvR6s
         0DqaxSkXRlVbQuIyBuo4c8mMed9fj1V82yIBRoytp61gcALRZBxk3cy67UkFSJ9hzMKd
         sixgfX5xDIHR9a2Hif2imyyavZmpKlzPOvgKYEloRYJ5BujyF5ZzxmPA6DEw69COZQDX
         5kQp5Bn29IrbvHEl6RUsUC12TvJ/VEARJ3gLIn/76/CY4mIjtR/zre84vTH/EDN+6nO1
         2fmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FfSUR09C1mHiwJhD3QNYQuarzezJOYlVWsneR6uo6gQ=;
        b=QXEOOVak/K2lSI46Rw7rcSxZnPAOsXcpMxz00dUBCYmybGmb/BBQueTCyShjXqbCGk
         FbaZYP2bp5U/nBXKUwVf6Jl84LjYLfLHbhHIEXm+9a4Qn9Q/MhPWlMN4pxGvL3VeIqdZ
         M3E1IUx/6/C1RkUSeASK4XxMEQLiZPs6j/r5BWUFuzDN0eDTqOqpWzMAk7c/W4w3ujaf
         EPEcSF9QU/ewYm2yipFNzVXf53hM/ydsWldou9kXqb8fAg2RBOqjZduGybB+W+q5whab
         if/i/LDbEbWQZzCM9zNMo2kjjCgdseW0eFgti8jvPpCdoG5/YDAhSWROv4cJ9WGZSg6K
         L/5Q==
X-Gm-Message-State: AOAM530EimlUBn21McX8jF8nHgI7rGwOWdohGV8zzeoqjyvFBKlcezTW
        WD6Wy4wTEToBqLUEJQBOPtP974HHBLkG0IPd2e4=
X-Google-Smtp-Source: ABdhPJwbehFOzUdzhgvmwhFQguT5fPIJrpKC2NkbqdUm90wAvdYbvDbdEZnp7TCipMhI4QTRIGq/ZMvk8tsPQ7vzTHU=
X-Received: by 2002:a4a:8311:: with SMTP id f17mr8075257oog.83.1621414126064;
 Wed, 19 May 2021 01:48:46 -0700 (PDT)
MIME-Version: 1.0
References: <6cffd7eebba54ed8acd043d51d212ec1@rohde-schwarz.com>
 <CAL=kjP0xOQ32xLytyVm9=d+9rnKzV2dW2VJQ6c8MAwTK7rg2Kw@mail.gmail.com> <20210508142947.GB810516@rowland.harvard.edu>
In-Reply-To: <20210508142947.GB810516@rowland.harvard.edu>
From:   dave penkler <dpenkler@gmail.com>
Date:   Wed, 19 May 2021 10:48:29 +0200
Message-ID: <CAL=kjP1WegRkxuYuKSmvA6rZ1BrC5wE5KvLe0JjjE+wN4up8Xg@mail.gmail.com>
Subject: Re: Re: Re: Re: Re: [syzbot] INFO: rcu detected stall in tx
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Guido Kiener <Guido.Kiener@rohde-schwarz.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+e2eae5639e7203360018@syzkaller.appspotmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        USB list <linux-usb@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "luto@kernel.org" <luto@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 May 2021 at 16:29, Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Sat, May 08, 2021 at 10:14:41AM +0200, dave penkler wrote:
> > On Thu, 6 May 2021 at 22:31, Guido Kiener
> > <Guido.Kiener@rohde-schwarz.com> wrote:
> > >
> > > > -----Original Message-----
> > > > From: Alan Stern
> > > > Sent: Thursday, May 6, 2021 8:32 PM
> > > > To: Kiener Guido 14DS1
> > > >
> > > > On Thu, May 06, 2021 at 05:44:55PM +0000, Guido Kiener wrote:
> > > > > > -----Original Message-----
> > > > > > From: Alan Stern
> > > > > > Sent: Thursday, May 6, 2021 3:49 PM
> > > > > > To: Kiener Guido 14DS1 <Guido.Kiener@rohde-schwarz.com>
> > > > > > >
> > > > > > > Thanks for your assessment. I agree with the general feeling. I
> > > > > > > counted about hundred specific usb drivers, so wouldn't it be
> > > > > > > better to fix the
> > > > > > problem in some of the host drivers (e.g. urb.c)?
> > > > > > > We could return an error when calling usb_submit_urb() on an erroneous
> > > > pipe.
> > > > > > > I cannot estimate the side effects and we need to check all
> > > > > > > drivers again how they deal with the error situation. Maybe there
> > > > > > > are some special driver
> > > > > > that need a specialized error handling.
> > > > > > > In this case these drivers could reset the (new?) error flag to
> > > > > > > allow calling usb_submit_urb() again without error. This could work, isn't it?
> > > > > >
> > > > > > That is feasible, although it would be an awkward approach.  As you
> > > > > > said, the side effects aren't clear.  But it might work.
> > > > >
> > > > > Otherwise I see only the other approach to change hundred drivers and
> > > > > add the cases EPROTO, EILSEQ and ETIME in each callback handler. The
> > > > > usbtmc driver already respects the EILSEQ and ETIME, and only EPROTO is
> > > > missing.
> > > > > The rest should be more a management task.
> > > > > BTW do you assume it is only a problem for INT pipes or is it also a
> > > > > problem for isochronous and bulk transfers?
> > > >
> > > > All of them.  Control too.
> > > >
> > > > > > Will you be able to test patches?
> > > > >
> > > > > I only can test the USBTMC function in some different PCs. I do not
> > > > > have automated regression tests for USB drivers or Linux kernels.
> > > > > Maybe there is company who could do that.
> > > >
> > > > Well then, if I do find time to write a patch, I'll ask you to try it out with the usbtmc
> > > > driver.
> > >
> > > You mean that you will do a patch in urb.c or a host driver? Or just add a line in usbtmc.c?
> > > Anyhow there is no hurry. On May 20 I will send you a mail if I'm able to
> > > provoke one of these hardware errors EPROTO, EILSQ, or ETIME. Otherwise
> > > it doesn't make sense to test it.
> > >
> > > -Guido
> >
> > EPROTO is a link level issue and needs to be handled by the host driver.
>
> Are you referring to the host controller driver, or to the class device
> driver running on the host?  The host controller driver is responsible
> for creating the -EPROTO error code in the first place.  The class
> device driver is responsible for taking an appropriate action in
> response.
host controller driver
>
> > When the host driver detects a protocol error while processing an URB
> > it completes the URB with EPROTO status and marks the endpoint as
> > halted.
>
> Not true.  It does not mark the endpoint as halted, not unless it
> receives a STALL handshake from the device.  A STALL is not a protocol
> error.
>
> > When the class driver resubmits the URB and the if the host driver
> > finds the endpoint still marked as halted it should return EPIPE
> > status on the resubmitted URB
>
> Irrelevant.
Not at all. The point is that when an application is talking to an
instrument over the usbtmc driver, the underlying host controller and
its driver will detect and silence a babbling endpoint.
Hence no EPROTO loop will ensue in this case and therefore no changes
are needed in usbtmc.
>
> > When the class driver and usbtmc in particular receives an URB with
> > EPIPE status it cleans up and does not resubmit.
> > Can someone from syzbot land please confirm whether usbtmc running on
> > the xhci host driver causes an RCU stall to be detected ?
>
> That is not an easy thing to test, and syzbot is not capable of testing
> it.  You would need a USB device which could deliberately be set to
> create a protocol error; I don't know of any devices like that.
>
> Alan Stern
