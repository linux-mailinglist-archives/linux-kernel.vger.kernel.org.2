Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B742832BE05
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445955AbhCCQu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 11:50:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:47156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350195AbhCCMWK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 07:22:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 60AA664EDB;
        Wed,  3 Mar 2021 08:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614761070;
        bh=D4rBZkJRUX3LCLXa+cvsr19cocx6FJQsH84hlT/eZDg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UDd9M3IGP0q8tvAsZ9ho78vKWkU5is2I66XLUyKSs62zdyCO5dOguKY0bvcO8EhoJ
         26ViNy/bCkghNi6xKYhtp+bsWs5f/IuEzftr81s7ctVVvVvAZH2dF6StvsQVC6Jtg2
         fzcqWGlVp3xp7F3gs/tjz+0FTJKV6XVj/D03Vqq/Gl2nF8PXlovasMz33DjeRpZP/m
         qWX0qkhEnNI3kB7fPvYoP1ibI20DeW+LZVs/QgGoscYtMwB5MH2fh4jyHy7EtOvz92
         ScBNTMnP03KBAQdLKvaNUCgbm53EIzreMjr/PVhk0mOdiPrfbxbcH87HaCAx7WXAlx
         ueliHzSy1tHSg==
Date:   Wed, 3 Mar 2021 09:44:26 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Documentation List <linux-doc@vger.kernel.org>
Subject: Re: anonymous enums in kernel doc
Message-ID: <20210303094426.1c3f6ff3@coco.lan>
In-Reply-To: <CAHp75VcG544HZ1j_6jvZoba6kEjKXXfZ8deJWmwNQ08mC35NrA@mail.gmail.com>
References: <CAHp75VfpnGEZcnrQLFYaFQ-HuxTmPw5OnewKmRGfXQf__ztjww@mail.gmail.com>
        <87r1lgx8fo.fsf@meer.lwn.net>
        <CAHp75Vc0SwC=WxUOiokUik1G4uPE6bHfX_F_ckgp-eEJaVuWhA@mail.gmail.com>
        <87mtw4x7rw.fsf@meer.lwn.net>
        <CAHp75VcG544HZ1j_6jvZoba6kEjKXXfZ8deJWmwNQ08mC35NrA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, 16 Feb 2021 19:12:58 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> escreveu:

> On Tue, Feb 16, 2021 at 7:05 PM Jonathan Corbet <corbet@lwn.net> wrote:
> >
> > Andy Shevchenko <andy.shevchenko@gmail.com> writes:
> >  
> > > On Tue, Feb 16, 2021 at 6:51 PM Jonathan Corbet <corbet@lwn.net> wrote:  
> > >>  
> > >> > Mauro, can you do some test cases in your workflow against anonymous
> > >> > enum in ernel doc, please?
> > >> >
> > >> > They are broken again, please fix the script!
> > >> >
> > >> > drivers/pinctrl/intel/pinctrl-intel.c:204: warning: wrong kernel-doc
> > >> > identifier on line:
> > >> > * enum - Locking variants of the pad configuration
> > >> >
> > >> > Above is simply a wrong statement.  
> > >>
> > >> The real problem, perhaps, is that there seems to be little point in
> > >> adding kerneldoc comments for anonymous enums; where are you going to
> > >> use that documentation?  
> > >
> > > I had been explicitly told during review (IIRC by maintainers) to make
> > > it such, while the initial version was exactly like you are thinking
> > > of. So, I'm not the right person to be asked :-)  
> 
> Just for a reference [1].
> 
> > >>  The error message could perhaps be changed to
> > >> say that; meanwhile, perhaps this one could be fixed with an action like
> > >> s%/**%/*% ?  
> > >
> > > See above. I think regression comes from the kernel doc script,
> > > earlier it was okay. That said, the author of kernel doc changes has
> > > to submit a patch to amend the driver and maintainers will review it.  
> >
> > kerneldoc now warns about various incorrect things that it used to just
> > silently pass over.  There is no regression here, just a new diagnostic
> > to point out something that was never going to work right.  Unless you
> > have a good idea for what kerneldoc should do with a block like that?  
> 
> As it does, put description of individual fields and prepend it with a
> common part.
> 
> So,
> 
> enum - Bla bla bla
>  @FOO: ABC
>  @BAR: DEF
> Description
> 
> Should go in the doc for the corresponding file like (as an example)
> 
> Anonymous enumeration Bla bla bla
> Description
> 
> FOO ABC
> BAR DEF
> 
> (not sure about indentation, emphasizing and separators, but I think
> you got the idea).
> 
> > (An alternative fix, of course, would be to give the enum a name so it
> > can actually be used for type checking.)  
> 
> That enum is not used as an enum, it provides the logically unified constants.

What's the problem of giving it a name?

You could call it as "intel_pinctrl_pad" or something similar.

> Personally I don't see why the kernel doc can't digest this.

It is not hard to add support for this special case. Just sent a
patch.

Yet, this adds additional complexity on an script that it is
already complex enough.

> 
> [1]: https://patchwork.ozlabs.org/project/linux-gpio/patch/20190808132128.13359-1-andriy.shevchenko@linux.intel.com/
> 

Thanks,
Mauro
