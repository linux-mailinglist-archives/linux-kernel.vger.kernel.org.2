Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27F6C36B79E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 19:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235472AbhDZRLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 13:11:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:54656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234794AbhDZRL0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 13:11:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3E67961026;
        Mon, 26 Apr 2021 17:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619457044;
        bh=Jgkf3vXL6pilfzbtNfsbpM+YZxy2eA+ySeDR+u9ODNk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sVe0lAXlU5E1Gbo0Nx/F9iG7KkJ/bKamT0iPc4tzMER2/4yQ3YCHXWjbMtmO7NPfU
         TqPdGPhGVnL632R1FW6thtDZlzUvpe78g7tMEi2wp3G0V4BUp2sexeL88t3AnGzNt9
         AQGy4ltdtusUNbuwLBxxDbVsIA3OeXw57wM9EgT0=
Date:   Mon, 26 Apr 2021 19:10:41 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Kangjie Lu <kjlu@umn.edu>,
        Andrew Jeffery <andrew@aj.id.au>
Subject: Re: [PATCH 111/190] Revert "gpio: aspeed: fix a potential NULL
 pointer dereference"
Message-ID: <YIb0Ea+gAthuUsj5@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-112-gregkh@linuxfoundation.org>
 <CAMpxmJXn9E7PfRKok7ZyTx0Y+P_q3buArg8YR7wV=+A9Sid2_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMpxmJXn9E7PfRKok7ZyTx0Y+P_q3buArg8YR7wV=+A9Sid2_Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 03:53:44PM +0200, Bartosz Golaszewski wrote:
> On Wed, Apr 21, 2021 at 3:07 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This reverts commit 6cf4511e9729c00a7306cf94085f9cc3c52ee723.
> >
> > Commits from @umn.edu addresses have been found to be submitted in "bad
> > faith" to try to test the kernel community's ability to review "known
> > malicious" changes.  The result of these submissions can be found in a
> > paper published at the 42nd IEEE Symposium on Security and Privacy
> > entitled, "Open Source Insecurity: Stealthily Introducing
> > Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> > of Minnesota) and Kangjie Lu (University of Minnesota).
> >
> > Because of this, all submissions from this group must be reverted from
> > the kernel tree and will need to be re-reviewed again to determine if
> > they actually are a valid fix.  Until that work is complete, remove this
> > change to ensure that no problems are being introduced into the
> > codebase.
> >
> > Cc: Kangjie Lu <kjlu@umn.edu>
> > Cc: Andrew Jeffery <andrew@aj.id.au>
> > Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  drivers/gpio/gpio-aspeed.c | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
> > index b966f5e28ebf..91d0fdf8469d 100644
> > --- a/drivers/gpio/gpio-aspeed.c
> > +++ b/drivers/gpio/gpio-aspeed.c
> > @@ -1231,8 +1231,6 @@ static int __init aspeed_gpio_probe(struct platform_device *pdev)
> >
> >         gpio->offset_timer =
> >                 devm_kzalloc(&pdev->dev, gpio->chip.ngpio, GFP_KERNEL);
> > -       if (!gpio->offset_timer)
> > -               return -ENOMEM;
> >
> >         rc = devm_gpiochip_add_data(&pdev->dev, &gpio->chip, gpio);
> >         if (rc < 0)
> > --
> > 2.31.1
> >
> 
> Hi Greg,
> 
> I'm sorry you need to waste your time on this cr*p.

Thanks, me too :(

> This patch wasn't wrong though, so I'd recommend it's left in the tree.

Now dropped from my queue, thanks for the review!

greg k-h
