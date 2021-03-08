Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54F2533087F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 07:55:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235076AbhCHGzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 01:55:20 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:11516 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229494AbhCHGyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 01:54:52 -0500
X-IronPort-AV: E=Sophos;i="5.81,231,1610406000"; 
   d="scan'208";a="496617192"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Mar 2021 07:54:51 +0100
Date:   Mon, 8 Mar 2021 07:54:51 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Joe Perches <joe@perches.com>
cc:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        kernelnewbies <kernelnewbies@kernelnewbies.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        cocci <cocci@systeme.lip6.fr>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: linux-kernel janitorial RFP: Mark static arrays as const
In-Reply-To: <dd39a6974e6cef241ecfd1014d683a42cc722366.camel@perches.com>
Message-ID: <alpine.DEB.2.22.394.2103080752250.3383@hadrien>
References: <053b06c47f08631675c295b5c893b90be4248347.camel@perches.com>  <a15e5c4d-a60f-14b9-90e5-4e600771aa9d@prevas.dk>  <a186c9d063663ac6de66db944d1925146393bec5.camel@perches.com>  <alpine.DEB.2.22.394.2103072011480.2930@hadrien>
 <dd39a6974e6cef241ecfd1014d683a42cc722366.camel@perches.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-899039469-1615186491=:3383"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-899039469-1615186491=:3383
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT



On Sun, 7 Mar 2021, Joe Perches wrote:

> On Sun, 2021-03-07 at 20:14 +0100, Julia Lawall wrote:
> >
> > On Wed, 3 Mar 2021, Joe Perches wrote:
> >
> > > On Wed, 2021-03-03 at 10:41 +0100, Rasmus Villemoes wrote:
> > > > On 02/03/2021 18.42, Joe Perches wrote:
> > > > > Here is a possible opportunity to reduce data usage in the kernel.
> > > > >
> > > > > $ git grep -P -n '^static\s+(?!const|struct)(?:\w+\s+){1,3}\w+\s*\[\s*\]' drivers/ | \
> > > > >   grep -v __initdata | \
> > > > >   wc -l
> > > > > 3250
> > > > >
> > > > > Meaning there are ~3000 declarations of arrays with what appears to be
> > > > > file static const content that are not marked const.
> > > > >
> > > > > So there are many static arrays that could be marked const to move the
> > > > > compiled object code from data to text minimizing the total amount of
> > > > > exposed r/w data.
> > > >
> > > > You can add const if you like, but it will rarely change the generated
> > > > code. gcc is already smart enough to take a static array whose contents
> > > > are provably never modified within the TU and put it in .rodata:
> > >
> > > At least some or perhaps even most of the time, true, but the gcc compiler
> > > from v5 through at least v10 seems inconsistent about when it does the
> > > appropriate conversion.
> > >
> > > See the example I posted:
> > > https://lore.kernel.org/lkml/6b8b250a06a98ce42120a14824531a8641f5e8aa.camel@perches.com/
> > >
> > > It was a randomly chosen source file conversion btw, I had no prior
> > > knowledge of whether the text/data use would change.
> > >
> > > I'm unsure about clang consistently moving static but provably const arrays
> > > from data to text.  I rarely use clang.  At least for v11 it seems to be
> > > better though.  I didn't try 10.1.
> >
> > I tried the relevnt drivers in drivers/input/joystick.  I got only one
> > driver that changed with gcc 9.3, which was
> > drivers/input/joystick/analog.c.  It actually got larger:
> >
> > original:
> >
> >    text    data     bss     dec     hex filename
> >   22607   10560     320   33487    82cf drivers/input/joystick/analog.o
> >
> > after adding const:
> >
> >    text    data     bss     dec     hex filename
> >   22728   10816     320   33864    8448 drivers/input/joystick/analog.o
> >
> > This was the only case where bss was not 0, but I don't know if there is a
> > connection.
>
> You really need consider using defconfig so whatever object code
> does not have tracing/debugging support.
>
> For instance, this code with defconfig and analog joystick:
>
> Original:
>
> $ size drivers/input/joystick/analog.o
>    text	   data	    bss	    dec	    hex	filename
>    8115	    261	    224	   8600	   2198	drivers/input/joystick/analog.o
>
> with const:
>
> $ size drivers/input/joystick/analog.o
>    text	   data	    bss	    dec	    hex	filename
>    8179	    201	    224	   8604	   219c	drivers/input/joystick/analog.o

Thanks for the suggestion.  It occurred to me that in one case my
transformation was wrong, because the array was multi-level, and a sub
array was being stored in a structure field that was not declared as
const.  So the argument that the compiler would figure out to put the
array in .rodata didn't make sense.  But I still go the same sizes for
that file.  So I'll try the whole thing again.

thanks,
julia
--8323329-899039469-1615186491=:3383--
