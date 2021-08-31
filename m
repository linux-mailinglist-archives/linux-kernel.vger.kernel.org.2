Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D29D3FC735
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 14:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234224AbhHaMUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 08:20:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:52908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239083AbhHaMTb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 08:19:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7FC4F60200;
        Tue, 31 Aug 2021 12:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630412315;
        bh=RKmHEBBqe+fABZVLSlBOdZnAUww2NeSx7NR1sqNQevs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q3akqxME9qMngNOJsq4ob1d5h8OMuZBOJr8QNYr8ONAZAnjIWPGzMKUPevc883mxN
         Nvz15u+l1Wpnzb1ylKnwuqA+20/70LTIhRs3vtWwoGOhXgU5v3C+Dr2Vg3XL503UxD
         Eb3+SnVuzgsVCfDZDgiTBw3oMoPReS+lIpxHnYkBIR/l9pHXV3Pi9hwLFrwqEC0IVZ
         XbzEG7Psb8RelEUc1/03EKOyFmIgPn+Ucs1NddFguIkgNZg9a/6P0TK+fRH/NULso8
         juU66L4h5DF7xY8mi1xC5LDXCWjc13wpXzTgi9vrCeCz40u2Z2xb8hLVfrVA+vh+0b
         DzU9mIm9vSyyg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1mL2ii-0004il-2r; Tue, 31 Aug 2021 14:18:28 +0200
Date:   Tue, 31 Aug 2021 14:18:28 +0200
From:   Johan Hovold <johan@kernel.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Alex Elder <elder@linaro.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alex Elder <elder@kernel.org>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, greybus-dev@lists.linaro.org
Subject: Re: [greybus-dev] [PATCH v4] staging: greybus: Convert uart.c from
 IDR to XArray
Message-ID: <YS4eFP3xXdAugyYL@hovoldconsulting.com>
References: <20210829092250.25379-1-fmdefrancesco@gmail.com>
 <f7a25eb1-20f4-5031-a156-9e5dc019ad28@linaro.org>
 <YS3jSsGSs0yAw/Ba@hovoldconsulting.com>
 <6155058.TBsaUTXu4T@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6155058.TBsaUTXu4T@localhost.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2021 at 01:50:05PM +0200, Fabio M. De Francesco wrote:
> On Tuesday, August 31, 2021 10:07:38 AM CEST Johan Hovold wrote:

> > Since most people can't really test their changes to Greybus perhaps it
> > isn't the best example of code that can be safely modified. But yeah,
> > parts of it are still in staging and, yes, staging has been promoted as
> > place were some churn is accepted.

> I cannot test my changes to Greybus, but I think that trivial changes are 
> just required to build. To stay on the safe side I had left those 
> mutex_lock() around xa_load(). I wasn't sure about it, but since the original 
> code had the Mutexes I thought it wouldn't hurt to leave them there.

But if you weren't sure that your patch was correct, you can't also
claim that it was trivial. Patches dealing with locking and concurrency
usually are not.

I too had go look up the XArray interface and review the Greybus uart
code (which is broken and that doesn't make it easier for any of us).

So no, this wasn't trivial, it carries a cost and should therefore in
the end also have some gain. And what that was wasn't clear from the
commit message (since any small efficiency gain is irrelevant in this
case).

Sorry you got stuck in the middle. Perhaps you can see it as a
first-hand experience of some of the trade offs involved when doing
kernel development.

And remember that a good commit message describing the motivation for
the change (avoiding boiler-plate marketing terms) is a good start if
you want to get your patches accepted.

Johan
