Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B59B310C5B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 15:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbhBEOAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 09:00:35 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:41611 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbhBEN6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 08:58:12 -0500
X-Originating-IP: 90.89.227.234
Received: from xps13 (lfbn-tou-1-1424-234.w90-89.abo.wanadoo.fr [90.89.227.234])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 3637960005;
        Fri,  5 Feb 2021 13:57:17 +0000 (UTC)
Date:   Fri, 5 Feb 2021 14:57:16 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc:     richard@nod.at, vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, rdunlap@infradead.org
Subject: Re: [PATCH] drivers: mtd: Better word replace a not so good word in
 the file mtd_blkdevs.c
Message-ID: <20210205145716.4083e083@xps13>
In-Reply-To: <YB1J53adyW4BBK3g@ArchLinux>
References: <20210205124151.1386271-1-unixbhaskar@gmail.com>
        <20210205142618.116852a0@xps13>
        <YB1J53adyW4BBK3g@ArchLinux>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bhaskar,

Bhaskar Chowdhury <unixbhaskar@gmail.com> wrote on Fri, 5 Feb 2021
19:06:39 +0530:

> On 14:26 Fri 05 Feb 2021, Miquel Raynal wrote:
> >Hi Bhaskar,
> >
> >Bhaskar Chowdhury <unixbhaskar@gmail.com> wrote on Fri,  5 Feb 2021
> >18:11:51 +0530:
> >  
> >> s/fucking/invite/
> >>
> >>
> >> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> >> ---
> >>  drivers/mtd/mtd_blkdevs.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
> >> index fb8e12d590a1..756a0995e474 100644
> >> --- a/drivers/mtd/mtd_blkdevs.c
> >> +++ b/drivers/mtd/mtd_blkdevs.c
> >> @@ -523,7 +523,7 @@ int register_mtd_blktrans(struct mtd_blktrans_ops *t  
> r)
> >>  	int ret;
> >>
> >>  	/* Register the notifier if/when the first device type is
> >> -	   registered, to prevent the link/init ordering from fucking
> >> +	   registered, to prevent the link/init ordering from invite
> >>  	   us over. */  
> >
> >invite us over?
> >
> >I'm not a native English speaker but this does not bring any value to
> >my ears. Worse, I don't even get the point. Better rewrite the comment
> >entirely than just swapping "fucking" with a random word, no?
> >  
> Got your point , and I do understand "fuck" and "fucking" is so strong word
> that it is really difficult to replace with something else.
> 
> But..but you suggestion to rewrite the comments sounds good Miquel ...wish I
> could have that much time in hand to replace every sentence having that word
> ...all the patched sent with that word replaces...please step forward and
>  make
> and send patches .
> 
> Today I sent 10 patches replacing that word(weather that make sense or not)
> you can see those in the ML ...please pick up as you wish and send patches.

There are currently 21 uses of "fuck[ing]". It's not a mountain to
climb. Nor a race.

> I was simply replacing the word ..never bother about the meaning it
> conveys..doesn't matter really.

Are you kidding? What is the purpose of a comment if no one understands
it after a blind change?

> 
> so...
> 
