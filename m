Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D641A434BBE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 15:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbhJTNCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 09:02:12 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:44149
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229702AbhJTNCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 09:02:11 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3Aa/cxzankGqqFbF57j6JneJGJz3HpDfIr3DAb?=
 =?us-ascii?q?v31ZSRFFG/Fw9vre+MjzuiWetN98YhsdcJW7WZVoIkmskKKdg7NwAV7KZmCPhI?=
 =?us-ascii?q?LrFvAA0WKI+VPd8kPFmtK1mZ0QEZRWOZnASWJ3isv3+2CDfuoIytPvys+Vuds?=
 =?us-ascii?q?=3D?=
X-IronPort-AV: E=Sophos;i="5.84,326,1620684000"; 
   d="scan'208";a="396505127"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Oct 2021 14:59:55 +0200
Date:   Wed, 20 Oct 2021 14:59:55 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Karolina Drobnik <karolinadrobnik@gmail.com>
cc:     outreachy-kernel@googlegroups.com, gregkh@linuxfoundation.org,
        forest@alittletooquiet.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH] staging: vt6655: Rename `by_preamble_type`
 parameter
In-Reply-To: <6089e564f89ceaa7303bf3a4b4c864bf1389ac25.camel@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2110201456190.2930@hadrien>
References: <20211020084033.414994-1-karolinadrobnik@gmail.com>  <alpine.DEB.2.22.394.2110201051300.2930@hadrien> <6089e564f89ceaa7303bf3a4b4c864bf1389ac25.camel@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 20 Oct 2021, Karolina Drobnik wrote:

> On Wed, 2021-10-20 at 10:54 +0200, Julia Lawall wrote:
> > On Wed, 20 Oct 2021, Karolina Drobnik wrote:
> >
> > > Drop `by` prefix in the first parameter of `bb_get_frame_time`
> > > function.
> > > As the original argument, `byPreambleType`, was renamed to
> > > `preamble_type`,
> > > the parameter referring to it is now renamed to match the new
> > > naming
> > > convention.
> > > Update `bb_get_frame_time` comment to reflect that change.
> > >
> > > This patch is a follow-up work to this commit:
> > >     Commit 548b6d7ebfa4 ("staging: vt6655: Rename byPreambleType
> > > field")
> >
> > This is not going to be practical.  If the previous patch is
> > accepted, then this it not needed.
>
> This change was there before but Greg told me to do only one logical
> change per patch (which was a struct member rename), so I reverted it.
> I believe this is needed because this parameter still uses Hungarian
> notation, which is against the LK coding style. Also, it makes sense to
> update the name given my previous change.

Sorry, I think I was not clear.  It's not practical to explain constraints
on other patches in the log message.

>
> > there needs to be a vn+1 putting the patches together into a series.
>
> I didn't know that it should be send this way, especially given the
> fact that Outreachy applicants should first get 3-5 patches out before
> creating a patchset. Or has something changed in this regard?

I think that the 3-5 rule is not that important.  The important thing is
that if you want to make two different changes on the same file, either
the first one has to be accepted before you submit the second one, or they
have to be in a series.

> > > @@ -1691,7 +1691,7 @@ static const unsigned short
> > > awc_frame_time[MAX_RATE] = {
> > >   *
> > >   * Parameters:
> > >   *  In:
> > > - *      by_preamble_type  - Preamble Type
> > > + *      preamble_type     - Preamble Type
> > >   *      by_pkt_type        - PK_TYPE_11A, PK_TYPE_11B,
> > > PK_TYPE_11GB, PK_TYPE_11GA
> >
> > In the realm of small cleanups to this driver, the extra space in
> > front of the - above is a bit annoying.
>
> I can add this in but will that still count as a one logical change?

No.  It's a different change.  It's just a small whitespace issue, but
it's not triggered by the other changes you have made.

julia

> I described the comment update, will that suffice?
>
> > > @@ -1717,7 +1717,7 @@ unsigned int bb_get_frame_time(unsigned char
> > > by_preamble_type,
> > >         rate = (unsigned int)awc_frame_time[rate_idx];
> > >
> > >         if (rate_idx <= 3) {                /* CCK mode */
> > > -               if (by_preamble_type == 1) /* Short */
> > > +               if (preamble_type == 1) /* Short */
> >
> > I hope you will get around to replacing the 1 by the appropriate
> > constant and removing the "Short" comment.
>
> I plan to do so after correcting the name variable.
>
>
> On Wed, 2021-10-20 at 10:55 +0200, Greg KH wrote:
> > On Wed, Oct 20, 2021 at 09:40:33AM +0100, Karolina Drobnik wrote:
> > > Drop `by` prefix in the first parameter of `bb_get_frame_time`
> > > function.
> > > As the original argument, `byPreambleType`, was renamed to
> > > `preamble_type`,
> > > the parameter referring to it is now renamed to match the new
> > > naming
> > > convention.
> > > Update `bb_get_frame_time` comment to reflect that change.
> > >
> > > This patch is a follow-up work to this commit:
> > >     Commit 548b6d7ebfa4 ("staging: vt6655: Rename byPreambleType
> > > field")
> >
> > There is no need for these two lines in the changelog text.  They can
> > go
> > below --- if you want to have them.
>
> Thank you for clarifying this. I've been following the Submitting
> Patches docs[1] and thought this is needed.
>
>
> Thanks,
> Karolina
> -------------------------------------------------------------------
> [1]:
> https://elixir.bootlin.com/linux/latest/source/Documentation/process/submitting-patches.rst#L106
>
>
>
