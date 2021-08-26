Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C52E73F89AD
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 16:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242778AbhHZOE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 10:04:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:60366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231638AbhHZOEy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 10:04:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B7C8C61038;
        Thu, 26 Aug 2021 14:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629986647;
        bh=hPzln00qZJMKbWdkC8Lbh+h8DjBU3h3+xeXqslz4LDs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SqercknMSmt3VsVTeJHzmphlHiRS1ZEBoehJZk7s/t+Gylp5Py8D1QyKNP9PYnO5L
         741Wud87bkXRj6/1OxLm9c2NoKz1uPGQRl/x8VqlLSmvVfgy9CG5Oy8QR0QQ77b8P9
         wGTFrSEAAmRjcvh6pddCm2yVSaI+9mWEyv1mQa6s=
Date:   Thu, 26 Aug 2021 16:04:03 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Martin Kaiser <martin@kaiser.cx>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: r8188eu: Remove _enter/_exit_critical_mutex()
Message-ID: <YSefUxSAwJGRLDYe@kroah.com>
References: <20210819221241.31987-1-fmdefrancesco@gmail.com>
 <YSdu00zpqfGkKc1e@kroah.com>
 <1729205.azBTxCciFU@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1729205.azBTxCciFU@localhost.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2021 at 03:55:37PM +0200, Fabio M. De Francesco wrote:
> On Thursday, August 26, 2021 12:37:07 PM CEST Greg Kroah-Hartman wrote:
> > On Fri, Aug 20, 2021 at 12:12:41AM +0200, Fabio M. De Francesco wrote:
> > > Remove _enter_critical_mutex() and _exit_critical_mutex(). They are
> > > unnecessary wrappers, respectively to mutex_lock_interruptible() and
> > > to mutex_unlock(). They also have an odd interface that takes an unused
> > > argument named pirqL of type unsigned long.
> > > The original code enters the critical section if the mutex API is
> > > interrupted while waiting to acquire the lock; therefore it could lead
> > > to a race condition. Use mutex_lock() because it is uninterruptible and
> > > so avoid that above-mentioned potential race condition.
> > > 
> > > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > > ---
> > 
> > You have changed the behavior of the code here, how have you tested that
> > this still works properly?
> > 
> > thanks,
> > 
> > greg k-h
> 
> I forgot to say in this commit message that I've not tested it. I said that in other 
> patches I've submitted during this days (it's because I'm on vacation and I haven't
> my device with me), I'm sorry that I forgot to say the same also when I submitted this.
> 
> I understand that I've changed the behaviour of the code. I did that because the old 
> code had mutex_lock_interruptible() that, if interrupted while waiting for acquiring
> the mutex, it led to a potential race condition.
> 
> In the first version of my patch I wrote:
> 
> -       _enter_critical_mutex(&pxmitpriv->ack_tx_mutex, NULL);
> +       if (mutex_lock_interruptible(&pxmitpriv->ack_tx_mutex))
> +               return -EINTR;
> 
> I didn't explain why I decided to check and handle a possible -EINTR. Since the original
> code had no checks of the return value from mutex_lock_interruptible() I thought it
> could potentially enter the critical section, so I decided to check the return value and
> exit if I have -EINTR. I guess it shouldn't be allowed to enter the critical section without
> proper locking.
> 
> Then I read another message of yours: "[] (my guess, one almost never needs
> interruptible locks in a driver)". I interpreted this as: you should change the code
> to use mutex_lock() (that is uninterruptible) because you don't need to use interruptible
> locks here. That's why at v3 I changed again the code above and used an uninterruptible
> mutex_lock(). That's it.
> 
> Now  let's go back to the question you asked with your last message. I must admit that,
> although I have been working here in staging for more or less four months, I still have 
> some problems to decode your quite terse style :) 
> 
> Can you please say what you mean with your question? is it (1) or (2)?
> 
> 1) The code is _plain_wrong_: go back to your v1, use the interruptible lock as you did there
> and return -EINTR if interrupted; in the while, also explain why you decided to check for 
> errors and what could happen if you don't test for -EINTR (i.e., explicitly say that you could 
> incur in race conditions if you entered the critical section with no locks acquired).
> 
> 2) The code _looks_good_, however I want t know if and how you tested it. 

This one, it looks right, but I want to make sure how you tested it and
verified that it still works properly.

No rush, resend when you are back and have a chance to do so.

thanks,

greg k-h
