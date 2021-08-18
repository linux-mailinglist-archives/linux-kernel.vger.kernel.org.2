Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FDCF3EFCD9
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 08:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238565AbhHRGe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 02:34:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:53814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240341AbhHRGeW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 02:34:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A39EA60720;
        Wed, 18 Aug 2021 06:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629268428;
        bh=WDjreO9KjgVxhBZPJa6vuaWjorAkBuh+Zu8+NT8TZas=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E11axgplfzmQ/N8EMvsAXDcK82JReE8/vQCZqCZy90xy0cf2yGcus8ntkrofeTomg
         WIaLLDnfrdlPNHLqrYXDZOoZmQWjqmMWcQjSeHZFAxFnbeW3Tu1tJa+othFznbZ92i
         PAJEuvbwOW8YbS1ltZYrlWJIA++3+KblZIv4vMJc=
Date:   Wed, 18 Aug 2021 08:33:45 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Joe Perches <joe@perches.com>,
        Michael Straube <straube.linux@gmail.com>,
        Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: refactor
 rtw_is_cckrates{only}_included()
Message-ID: <YRypyev4Ku3eI9w8@kroah.com>
References: <20210816193125.15700-1-straube.linux@gmail.com>
 <11a09af791c5453175a6bdac1c51bd9fcb0685bd.camel@perches.com>
 <YRwEyrSLTPl/KY9t@kroah.com>
 <2509261.CYLKgzzBkz@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2509261.CYLKgzzBkz@localhost.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2021 at 08:23:18AM +0200, Fabio M. De Francesco wrote:
> Said that, since operator precedence is one of the first topic that every developer
> learn in a course on C and that expressions like *ptr++ are used everywhere in
> the kernel you are sending a dangerous message...

Operator precedence is something that no one should have to memorize or
remember.  Expressions like *ptr++ on it's own is fine, but combine it
with an assignment and then you need to think about stuff like "did it
increment before or after assigning" and the like.

And really, why?  You are doing nothing to make the code easier to
maintain by doing this.  The compiler isn't going to magically make
better code because of this.  Be explicit and obvious about what you
want the code to do, because in 10+ years when you have to look at it
again to find where to fix a problem, you want it to be really obvious
what is happening.

> It looks like you don't trust people here to be able to do anything more than 
> trivial clean-ups. If someone here at linux-staging is not able to understand 
> the precedence of operators, please stand up and speak!

I want kernel code to be simple and obvious and easy to maintain.

And yes, I do NOT remember the precedence of all C operators, and no one
should be forced to either.  And I am someone who has read or written C
code for almost every day for the past 30 years.

So keep the code simple and obvious for everyone to read and understand.
The original use of the array and then moving to the next one was just
that, simple and obvious.

Do not do unneeded optimizations just because you can, it will always
come back to hurt you, or someone else, in the end.

thanks,

greg k-h
