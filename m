Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCA73095B7
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 15:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhA3OHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 09:07:47 -0500
Received: from mail.v3.sk ([167.172.186.51]:42944 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229468AbhA3OHn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 09:07:43 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id CFE99E0A80;
        Sat, 30 Jan 2021 14:02:52 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id w0XuzY4HszbM; Sat, 30 Jan 2021 14:02:52 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 1365AE0B3B;
        Sat, 30 Jan 2021 14:02:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id NSS8llP6gogb; Sat, 30 Jan 2021 14:02:51 +0000 (UTC)
Received: from localhost (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 43FBFE0A80;
        Sat, 30 Jan 2021 14:02:51 +0000 (UTC)
Date:   Sat, 30 Jan 2021 15:06:52 +0100
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Maen Suleiman <maen@marvell.com>, Lior Amsalem <alior@marvell.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Andrew Lunn <andrew@lunn.ch>, Nicolas Pitre <nico@fluxnic.net>,
        Eric Miao <eric.y.miao@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] docs: arm: marvell: turn the automatic links into
 labels
Message-ID: <20210130140652.GA190173@demiurge.local>
References: <20210129183950.75405-1-lkundrak@v3.sk>
 <20210129183950.75405-2-lkundrak@v3.sk>
 <87tuqzwa0j.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tuqzwa0j.fsf@meer.lwn.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 29, 2021 at 05:20:28PM -0700, Jonathan Corbet wrote:
> Lubomir Rintel <lkundrak@v3.sk> writes:
> 
> > Lines ending with obscenely long URLs at the end don't look good.
> >
> > Even if these links are not that long at this point, they will be when
> > replaced with an archive link in a subsequent patch -- let's prepare for
> > that.
> >
> > Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> > ---
> >  Documentation/arm/marvel.rst | 209 ++++++++++++++++++++++++-----------
> >  1 file changed, 143 insertions(+), 66 deletions(-)
> >
> > diff --git a/Documentation/arm/marvel.rst b/Documentation/arm/marvel.rst
> > index 16ab2eb085b86..716551f9b60a1 100644
> > --- a/Documentation/arm/marvel.rst
> > +++ b/Documentation/arm/marvel.rst
> > @@ -18,12 +18,12 @@ Orion family
> >          - 88F5181L
> >          - 88F5182
> >  
> > -               - Datasheet: http://www.embeddedarm.com/documentation/third-party/MV88F5182-datasheet.pdf
> > -               - Programmer's User Guide: http://www.embeddedarm.com/documentation/third-party/MV88F5182-opensource-manual.pdf
> > -               - User Manual: http://www.embeddedarm.com/documentation/third-party/MV88F5182-usermanual.pdf
> > +               - Datasheet: `MV88F5182-datasheet.pdf`_
> > +               - Programmer's User Guide: `MV88F5182-opensource-manual.pdf`_
> > +               - User Manual: `MV88F5182-usermanual.pdf`_
> >          - 88F5281
> >  
> > -               - Datasheet: http://www.ocmodshop.com/images/reviews/networking/qnap_ts409u/marvel_88f5281_data_sheet.pdf
> > +               - Datasheet: `marvel_88f5281_data_sheet.pdf`_
> >          - 88F6183
> >    Core:
> >  	Feroceon 88fr331 (88f51xx) or 88fr531-vd (88f52xx) ARMv5 compatible
> > @@ -32,37 +32,42 @@ Orion family
> >    Linux kernel plat directory:
> >  	arch/arm/plat-orion
> >  
> > +.. _MV88F5182-datasheet.pdf: http://www.embeddedarm.com/documentation/third-party/MV88F5182-datasheet.pdf
> > +.. _MV88F5182-opensource-manual.pdf: http://www.embeddedarm.com/documentation/third-party/MV88F5182-opensource-manual.pdf
> > +.. _MV88F5182-usermanual.pdf: http://www.embeddedarm.com/documentation/third-party/MV88F5182-usermanual.pdf
> > +.. _marvel_88f5281_data_sheet.pdf: http://www.ocmodshop.com/images/reviews/networking/qnap_ts409u/marvel_88f5281_data_sheet.pdf
> 
> So I see what you're trying to do, but this has the effect of prettying
> up the processed docs at the expense of making the plain-text version
> harder to read.  Somebody who wants to find one of these datasheets from
> the plain-text version has to skip further down in the file, hoping that
> they pick out the right one among a set of long, similar URLs.
> Honestly, I think we may be better off leaving them as they are.
> Failing that, the right thing to do is to keep the lines defining the
> URL labels right next to where they are referenced.
> 
> See what I'm getting at?

Yes. I've been considering the same, but concluded it's a still a better
idea to move the full URLs below because

1.) at this point the links are broken anyway and the basename is the
    only valuable part of the URL when looking for an actual document;
    and the basename stays in place
2.) the archive.org links that replace them in another patch are waaaay too
    long even for very large displays

However, even though I think this is perhaps marginally better, either
way works for me. Thus, unless you change your mind about it, I'll follow
up with a v2 that drops this patch and replaces the links in place.

Thank you
Lubo

> 
> Thanks,
> 
> jon
