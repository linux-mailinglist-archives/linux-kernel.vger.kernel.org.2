Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D614A355711
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 16:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345360AbhDFOzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 10:55:17 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:36682 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345351AbhDFOzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 10:55:15 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AKflF6aOhSqd3icBcT07w55DYdL4zR+YMi2QD?=
 =?us-ascii?q?/3taDTRIb82VkN2vlvwH1RnyzA0cQm0khMroAsS9aFvm39pQ7ZMKNbmvGDPntm?=
 =?us-ascii?q?yhMZ144eLZqQHIMxbVstRQ3aIIScNDIfX7B1RikILe6A63D94vzLC8gcaVrM3Z?=
 =?us-ascii?q?yGpgShwvTqlm4RtwBArzKDwOeCBtA50lGJ2AovdWvjbIQwVeUu2XJFkgG9LCqd?=
 =?us-ascii?q?rCiY78bXc9ayIPxQGSgVqTmdrHOjeC2BN2aVJy6JMD1USArADj/KWktJiAu1Th?=
 =?us-ascii?q?/kve9Y5fltek6vYrPr3qtuEvJj/hihmlae1aMtXs0gwdmv2l61ohjbD30nQdFv?=
 =?us-ascii?q?lz8H/YcyWUphbgymDboVMTwkLi0lORjD/fp9X4TlsBeqh8rL9eGyG412MQ+PVH?=
 =?us-ascii?q?lI5b1WOQsJRaSTnamj7m2tTOXxZ20mKpvHsLi4co/jFieLpbTIUUgZ0U/UtTHp?=
 =?us-ascii?q?tFNjn98pobHO5nC9yZzOpKcGmdc2vSsgBUsZCRd0V2Oi3DblkJu8ST3TQTtmt+?=
 =?us-ascii?q?1VEkyMsWmWpF054hVZ9e5aDhPr5znL9DCu8aBJgNS9spcI+SMCjgUBjMOGWdLR?=
 =?us-ascii?q?DMD6ccIU/ArJbx/fE7/+evdJsUzIYjmZjIXV9C3FRCOn7GOImr5tlm4xrNSGKy?=
 =?us-ascii?q?UXDG0cdF/aV0vbX6Wf7qPES4ORATuvrlh89aLtzQWv61Np4TKeTkN3HSFYFA2B?=
 =?us-ascii?q?C7X5FTLHIZQdAEo9pTYSPMnuv7bqnR8sDLevfaI7TgVRw+XHnkP3cFVD/vYMNa?=
 =?us-ascii?q?7k6qXXf8iAPLW2zkf1H++Z4YKtmVw8EjjKw2cqFcuAkcjlq0ouuRLydZj6AwdE?=
 =?us-ascii?q?xiZK/8nrijvmmw92bQ52BvMh5QZ3wloonIYjdvn0snIkn0ebEMt5GjYmhUxmKA?=
 =?us-ascii?q?PQI6ZdjRChRjq1N+/r+XI5ScyTs5Mc+uNnuXghIo1Te3ZqZZvpfGxM/+PrskE5?=
 =?us-ascii?q?4tWcVKZH32Pi0wvTwvlUBuR0svQFTFGjbnlKO/5aZkf933Rp1bmwekIcldtHTF?=
 =?us-ascii?q?k16TzPtfDEczVyKyUMKRnAYlTydVgFo06KMEnL+cg1+UWBYCqfV9P1tWZGuNBr?=
 =?us-ascii?q?VaSAyDeYVPg7juPBp9VGGQmFWh+mYOU3uv80UZnWr6KyKIPfnNH1pGo3hdu5ya?=
 =?us-ascii?q?hW9cZyGYf0hqbGp9vpA4HWPaumxr2evOYqaoyWOeZh8Dxe4aWQu1FQc6M0drx9?=
 =?us-ascii?q?qt0gSSlyvHHXI6xo82NuiYFa89adjoqwOQAZzNkbtDE+5f/Z5jOtyruugXUfiH?=
 =?us-ascii?q?cwvQKD/jEesm1wGcu35NAlgDlFA01ffznBH15mmx23AyRfDbJVhgSrkBZ8uR9G?=
 =?us-ascii?q?jpXbKJ149lhdU+sa+xPwzKG6K74LCSayQGJgLYoGawQe1ts5xSsK4ovLZ4HpXQ?=
 =?us-ascii?q?U1LzpQN69QR7KN2xmFIVQax97ryEJ5RmeNYKfTlFulUuj9aCISIQw0XLK/57eU?=
 =?us-ascii?q?toiXDVP9mEueWV7bUuB1CMvwv2Nx2U9TZH8/LMQiuE0vobBssLUBprQVl57G4n?=
 =?us-ascii?q?+uWIM5DUAkGtcepI+VKhKH+zcLNHUsG+aMYthwc/58vNhvOdcirzxRvZsjR6KL?=
 =?us-ascii?q?9f6mrPe7LJPCucXepTt8GgMVuCgqG28Ne+gTf+Rzy8cVkZj+R+BD0tR9UGjCIj?=
 =?us-ascii?q?go0x2jWzTaKyoltNqSog3Q1a?=
X-IronPort-AV: E=Sophos;i="5.81,309,1610406000"; 
   d="scan'208";a="501818310"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Apr 2021 16:55:05 +0200
Date:   Tue, 6 Apr 2021 16:55:05 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     FMDF <fmdefrancesco@gmail.com>
cc:     Greg KH <gregkh@linuxfoundation.org>,
        outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH v2] staging: rtl8723bs: hal: Remove
 camelcase in Hal8723BReg.h
In-Reply-To: <CAPj211u9MHgtjeZGUPsLxU3HkbJ8cr2EUL0v9HA7LE9-b1uUoA@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2104061652590.2882@hadrien>
References: <20210406130556.1417-1-fmdefrancesco@gmail.com> <YGxsExq2fcQvrN99@kroah.com> <CAPj211u9MHgtjeZGUPsLxU3HkbJ8cr2EUL0v9HA7LE9-b1uUoA@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 6 Apr 2021, FMDF wrote:

> On Tue, Apr 6, 2021 at 4:11 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, Apr 06, 2021 at 03:05:56PM +0200, Fabio M. De Francesco wrote:
> > > Remove camelcase in some symbols defined in Hal8723BReg.h. These symbols
> > > are not used anywhere else, therefore this patch does not break the driver.
> > >
> > > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > > ---
> > >  drivers/staging/rtl8723bs/hal/Hal8723BReg.h | 16 ++++++++--------
> > >  1 file changed, 8 insertions(+), 8 deletions(-)
> >
> > If this is "v2", you need to put below the --- line what changed from
> > v1.
>
> It is a v2 only because you made me notice that I forgot to cc
> linux-staging and linux-kernel.
> So I sent it again, but probably I shouldn't have changed the version
> number because nothing else had changed.
>
> > Please fix up and send a v3.
> >
>
> No problem at all. I can explain in the patch v3 what I wrote above.
> May you please confirm that a patch v3 is the correct solution even
> when nothing changes in the code?

When Greg acknowledges your patch, everyone who is concerned with the
patch should see it.  So he needs to pick up the right version of the
patch that has everyone in CC.  He can use the version number to choose
the most recent one.

The version numbers don't appear anywhere once the code is committed.  So
it's not a problem to move up to the next version for any reason.  On the
other hand, if you skip a version, it can be a problem, because someone
may wonder if they missed some useful information.

julia

>
> Thanks for your help,
>
> Fabio
>
> > thanks,
> >
> > greg k-h
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/CAPj211u9MHgtjeZGUPsLxU3HkbJ8cr2EUL0v9HA7LE9-b1uUoA%40mail.gmail.com.
>
