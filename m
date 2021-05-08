Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E34237709A
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 10:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbhEHIQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 May 2021 04:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbhEHIQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 May 2021 04:16:01 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F4CC061574;
        Sat,  8 May 2021 01:14:59 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id l6so11018534oii.1;
        Sat, 08 May 2021 01:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LU8jKR/glSZQ1rljYYLoBqW6kISM9gd4Gb/bFqyTUFc=;
        b=sT3t4e8FVRnAAgjl7dqCScSU/JgYZapOuA2/1w3xVreaHtZHrAQ3qw7slsqSgV9q9J
         b8owuzxeA+Uj8KS2NGiEKvbcgLBQQJAKiJY4gWL8SUMeVuhS2cquQ3SWhhqj8P6LtlgG
         f95jci2zWIIxxTJJ+tCxtkcP4eRtTROt1SYNJIPswMohZHJKsb1IXVOYFyYOwh5AGLOr
         2lxp+cYl/6U599Zk8zocJgodQlaUjMxFOK/D2h/nhFYY2aWce1gKXtGN4GnKY6JVyomt
         iDMNE6z0SCB6nUbX9//m4SXtE+MYOZ2WDTxKARbl6E+rtv1o0XqvBhINLlUkwcrN+DE1
         g7lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LU8jKR/glSZQ1rljYYLoBqW6kISM9gd4Gb/bFqyTUFc=;
        b=Y6jmTdV0huj0RGpvNivbuegosyXl6LEeiBZrQnucR5VSmqaXEdluA+x5WPGD5trL5Y
         Ymmerx1RmkVqtEFMz5zBF3BMjOZ1Z5HVUAwDv6JyhdHdtJ/JNZ/M/LZb/w6zW4Xhg8LV
         NRJcchOfeEjF5JQfccWCQvWIneaOwTpKuuLgcx2ifIa0tIpgHMyUzFC7Jck9KnTdWNNT
         SCL7kLaYZW7asA5mGWO2JSCaBjmIsuPuSAFnNieJF78knIyxFSCN/qi9E9xjQK2DkHvX
         D6JVG4Pwn6HnBLM50FJ5qM/8OZ/zQnYtus9iEL4bSLr4OEIr9muFWg4NFCYCQ3yBmFs/
         Spyg==
X-Gm-Message-State: AOAM532vyzm4wwCDi+Uh+XTyRMBkvYirMPLvL7QUaL0PQLrIzWzOlgd4
        gzT7bcnsAeb806dB8HHjHoMEaqNbDQ4cszsz2UA=
X-Google-Smtp-Source: ABdhPJxgQ1w8xN1tnzhwRFlVtK8F20JS1QGyM99KOeL+EB16/MZGoW9pb+91fjBX6chk4+LOGDZX9feyGd9uRk0CM5w=
X-Received: by 2002:a05:6808:906:: with SMTP id w6mr3352777oih.6.1620461698750;
 Sat, 08 May 2021 01:14:58 -0700 (PDT)
MIME-Version: 1.0
References: <6cffd7eebba54ed8acd043d51d212ec1@rohde-schwarz.com>
In-Reply-To: <6cffd7eebba54ed8acd043d51d212ec1@rohde-schwarz.com>
From:   dave penkler <dpenkler@gmail.com>
Date:   Sat, 8 May 2021 10:14:41 +0200
Message-ID: <CAL=kjP0xOQ32xLytyVm9=d+9rnKzV2dW2VJQ6c8MAwTK7rg2Kw@mail.gmail.com>
Subject: Re: Re: Re: Re: Re: [syzbot] INFO: rcu detected stall in tx
To:     Guido Kiener <Guido.Kiener@rohde-schwarz.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
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

On Thu, 6 May 2021 at 22:31, Guido Kiener
<Guido.Kiener@rohde-schwarz.com> wrote:
>
> > -----Original Message-----
> > From: Alan Stern
> > Sent: Thursday, May 6, 2021 8:32 PM
> > To: Kiener Guido 14DS1
> >
> > On Thu, May 06, 2021 at 05:44:55PM +0000, Guido Kiener wrote:
> > > > -----Original Message-----
> > > > From: Alan Stern
> > > > Sent: Thursday, May 6, 2021 3:49 PM
> > > > To: Kiener Guido 14DS1 <Guido.Kiener@rohde-schwarz.com>
> > > > >
> > > > > Thanks for your assessment. I agree with the general feeling. I
> > > > > counted about hundred specific usb drivers, so wouldn't it be
> > > > > better to fix the
> > > > problem in some of the host drivers (e.g. urb.c)?
> > > > > We could return an error when calling usb_submit_urb() on an erroneous
> > pipe.
> > > > > I cannot estimate the side effects and we need to check all
> > > > > drivers again how they deal with the error situation. Maybe there
> > > > > are some special driver
> > > > that need a specialized error handling.
> > > > > In this case these drivers could reset the (new?) error flag to
> > > > > allow calling usb_submit_urb() again without error. This could work, isn't it?
> > > >
> > > > That is feasible, although it would be an awkward approach.  As you
> > > > said, the side effects aren't clear.  But it might work.
> > >
> > > Otherwise I see only the other approach to change hundred drivers and
> > > add the cases EPROTO, EILSEQ and ETIME in each callback handler. The
> > > usbtmc driver already respects the EILSEQ and ETIME, and only EPROTO is
> > missing.
> > > The rest should be more a management task.
> > > BTW do you assume it is only a problem for INT pipes or is it also a
> > > problem for isochronous and bulk transfers?
> >
> > All of them.  Control too.
> >
> > > > Will you be able to test patches?
> > >
> > > I only can test the USBTMC function in some different PCs. I do not
> > > have automated regression tests for USB drivers or Linux kernels.
> > > Maybe there is company who could do that.
> >
> > Well then, if I do find time to write a patch, I'll ask you to try it out with the usbtmc
> > driver.
>
> You mean that you will do a patch in urb.c or a host driver? Or just add a line in usbtmc.c?
> Anyhow there is no hurry. On May 20 I will send you a mail if I'm able to
> provoke one of these hardware errors EPROTO, EILSQ, or ETIME. Otherwise
> it doesn't make sense to test it.
>
> -Guido

EPROTO is a link level issue and needs to be handled by the host driver.
When the host driver detects a protocol error while processing an URB
it completes the URB with EPROTO status and marks the endpoint as
halted.
When the class driver resubmits the URB and the if the host driver
finds the endpoint still marked as halted it should return EPIPE
status on the resubmitted URB
When the class driver and usbtmc in particular receives an URB with
EPIPE status it cleans up and does not resubmit.
Can someone from syzbot land please confirm whether usbtmc running on
the xhci host driver causes an RCU stall to be detected ?
-Dave
