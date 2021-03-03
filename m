Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9AA32BCD4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:08:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359665AbhCCOuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 09:50:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1843034AbhCCKYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 05:24:40 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59730C0698E3;
        Wed,  3 Mar 2021 01:27:51 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id u18so7516530plc.12;
        Wed, 03 Mar 2021 01:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s6hjvIUW2bHosaip4kPRUurnF/6m14XdG9Exrn+bnXA=;
        b=QmtZTimjkEL4C+AdQxJ7CUItbuqw8SrBlSivDznS7YkiJhJEV5USAeC2IA1aCzI/4I
         4453Sfz+7TEAqJG8WLtM0mO1yeoeoHdwLp2GQyYDNRCvPtkNUCnTzjEA8y/dlO7uxZp4
         p4yxBtmyyiUZoG6++yupi3oTHuSDhzi0qQT427mCH2SVh92xentLIzj2dArvNUgJ6ee/
         wvmpL+pKs6gHymG+KnmNwjRTXPwZLu8T0HaS8ij2NrDRphi8LqTCLi0OpVJCRTa52Ld5
         +zjvwli6SI/ZciKZSyGydqdGG4R6WOVVnJfIFb6w93GmUc0T5HPj+ybZXJw5ef6aKk+l
         yPzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s6hjvIUW2bHosaip4kPRUurnF/6m14XdG9Exrn+bnXA=;
        b=UkKckDARoDp6HKPyfizY/vLol6iuhkiUWIBZr8Luv0ttLuanggKj3U3ZLOw+64SUqB
         nkNWeeUZkrdYSpUKFK2jjv4Cqr7GQyExOmjdaCR/HfKK+oVJmprCnB7PVKYN47dcUsoF
         qM8H2QkWz6AhJqJtrVUg6P5vuclxSWVlrcWn3Af/17QTWzEFj3PJ3n0RkQ/NsR+FfPxm
         WbxpLvjiZaU2hsrbxmHLenBKzNi5Ts1xMKm8s2GRMp/2YY8KFyB4D2xbGPzaoO4kmOr9
         D9+5xGU6bn9jNm6dr43Ymr23PyDyauNMAk71dCBQvr1Mvc3vtrQWrdeOQGgcykw+64gE
         NYHA==
X-Gm-Message-State: AOAM531V9rxor9UE6qnf49HlXBc+vUdqXd8EBjrSjoyYe+S9AadWbYrr
        WAU5ydHZKqH246DXWh+hD8UGiPMC0p7Iw2eNE0o=
X-Google-Smtp-Source: ABdhPJxBHtBkJYB3Vi2vDSobGNT6l9vpi3k8ps++zZkMsJYxt1s9S/JIUNVwIMQU2XRRpBIy5Gu3rBWKh20PvrI63GY=
X-Received: by 2002:a17:90a:c84:: with SMTP id v4mr8889364pja.228.1614763670630;
 Wed, 03 Mar 2021 01:27:50 -0800 (PST)
MIME-Version: 1.0
References: <CAHp75VfpnGEZcnrQLFYaFQ-HuxTmPw5OnewKmRGfXQf__ztjww@mail.gmail.com>
 <87r1lgx8fo.fsf@meer.lwn.net> <CAHp75Vc0SwC=WxUOiokUik1G4uPE6bHfX_F_ckgp-eEJaVuWhA@mail.gmail.com>
 <87mtw4x7rw.fsf@meer.lwn.net> <CAHp75VcG544HZ1j_6jvZoba6kEjKXXfZ8deJWmwNQ08mC35NrA@mail.gmail.com>
 <20210303094426.1c3f6ff3@coco.lan>
In-Reply-To: <20210303094426.1c3f6ff3@coco.lan>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 3 Mar 2021 11:27:34 +0200
Message-ID: <CAHp75Vc3DkW=T=kDhqNYFNTguLrHdb3nF4pS5_VjquNMJOXUvA@mail.gmail.com>
Subject: Re: anonymous enums in kernel doc
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Documentation List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 3, 2021 at 10:44 AM Mauro Carvalho Chehab
<mchehab@kernel.org> wrote:
> Em Tue, 16 Feb 2021 19:12:58 +0200
> Andy Shevchenko <andy.shevchenko@gmail.com> escreveu:
> > On Tue, Feb 16, 2021 at 7:05 PM Jonathan Corbet <corbet@lwn.net> wrote:
> > > Andy Shevchenko <andy.shevchenko@gmail.com> writes:
> > > > On Tue, Feb 16, 2021 at 6:51 PM Jonathan Corbet <corbet@lwn.net> wrote:
> > > >>
> > > >> > Mauro, can you do some test cases in your workflow against anonymous
> > > >> > enum in ernel doc, please?
> > > >> >
> > > >> > They are broken again, please fix the script!
> > > >> >
> > > >> > drivers/pinctrl/intel/pinctrl-intel.c:204: warning: wrong kernel-doc
> > > >> > identifier on line:
> > > >> > * enum - Locking variants of the pad configuration
> > > >> >
> > > >> > Above is simply a wrong statement.
> > > >>
> > > >> The real problem, perhaps, is that there seems to be little point in
> > > >> adding kerneldoc comments for anonymous enums; where are you going to
> > > >> use that documentation?
> > > >
> > > > I had been explicitly told during review (IIRC by maintainers) to make
> > > > it such, while the initial version was exactly like you are thinking
> > > > of. So, I'm not the right person to be asked :-)
> >
> > Just for a reference [1].
> >
> > > >>  The error message could perhaps be changed to
> > > >> say that; meanwhile, perhaps this one could be fixed with an action like
> > > >> s%/**%/*% ?
> > > >
> > > > See above. I think regression comes from the kernel doc script,
> > > > earlier it was okay. That said, the author of kernel doc changes has
> > > > to submit a patch to amend the driver and maintainers will review it.
> > >
> > > kerneldoc now warns about various incorrect things that it used to just
> > > silently pass over.  There is no regression here, just a new diagnostic
> > > to point out something that was never going to work right.  Unless you
> > > have a good idea for what kerneldoc should do with a block like that?
> >
> > As it does, put description of individual fields and prepend it with a
> > common part.
> >
> > So,
> >
> > enum - Bla bla bla
> >  @FOO: ABC
> >  @BAR: DEF
> > Description
> >
> > Should go in the doc for the corresponding file like (as an example)
> >
> > Anonymous enumeration Bla bla bla
> > Description
> >
> > FOO ABC
> > BAR DEF
> >
> > (not sure about indentation, emphasizing and separators, but I think
> > you got the idea).
> >
> > > (An alternative fix, of course, would be to give the enum a name so it
> > > can actually be used for type checking.)
> >
> > That enum is not used as an enum, it provides the logically unified constants.
>
> What's the problem of giving it a name?

Because why should I do this? It's a perfect C language which has no
issues so far.

> You could call it as "intel_pinctrl_pad" or something similar.
>
> > Personally I don't see why the kernel doc can't digest this.
>
> It is not hard to add support for this special case. Just sent a
> patch.

Thanks, I will test it!

> Yet, this adds additional complexity on an script that it is
> already complex enough.

> > [1]: https://patchwork.ozlabs.org/project/linux-gpio/patch/20190808132128.13359-1-andriy.shevchenko@linux.intel.com/

-- 
With Best Regards,
Andy Shevchenko
