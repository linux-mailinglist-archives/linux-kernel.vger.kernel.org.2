Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F01E3FB4D7
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 13:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236564AbhH3Lxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 07:53:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:41624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236511AbhH3Lxv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 07:53:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E7D4D61153;
        Mon, 30 Aug 2021 11:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630324377;
        bh=p7pJj9eRCF/dNAutIgicMrOIDXY7IqZaj/mUfhWD540=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m4WNTJD6VthqPU/J/hoTTLStpT7A7sA1aet/60ZicMkgd2VgchNtPxvJBi12B9iat
         OBk/Zikyvzq0S9J1KNlprjRVTOouzfA02EQqmjNN0WYSV2a9g7qpT+u37ALB0h9MpF
         3JUjhRefThL/KimBzWSj1Tb+kBLGOUGNKYtck65eSAYkxBs4c4dWyD/cbMqoOazBIK
         P42qxsGdyaQe8uUmNunzOoFNXdldEywtSPNQs+gjYLxsSeKx4/KzOWUh03vzIbfdfE
         qlzrZyhtm5xBnQCJt5aVKoQKdjwTaNQYCNCUww9ImOB4F4N+GOC8jkPF1xB97Tzcyj
         hWTi0Xdv8nElw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1mKfqK-0005rZ-TU; Mon, 30 Aug 2021 13:52:49 +0200
Date:   Mon, 30 Aug 2021 13:52:48 +0200
From:   Johan Hovold <johan@kernel.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v4] staging: greybus: Convert uart.c from IDR to XArray
Message-ID: <YSzGkNfG6HOayiXi@hovoldconsulting.com>
References: <20210829092250.25379-1-fmdefrancesco@gmail.com>
 <YSyg/Db1So0LDGR+@hovoldconsulting.com>
 <2879439.WEJLM9RBEh@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2879439.WEJLM9RBEh@localhost.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Please wrap your mails at 72 columns or so. ]

On Mon, Aug 30, 2021 at 01:10:54PM +0200, Fabio M. De Francesco wrote:
> On Monday, August 30, 2021 11:12:28 AM CEST Johan Hovold wrote:
> > On Sun, Aug 29, 2021 at 11:22:50AM +0200, Fabio M. De Francesco wrote:
> > > Convert greybus/uart.c from IDR to XArray. The abstract data type XArray
> > > is more memory-efficient, parallelisable, and cache friendly. It takes
> > > advantage of RCU to perform lookups without locking. Furthermore, IDR is
> > > deprecated because XArray has a better (cleaner and more consistent) API.
> > 
> > Where does it say that IDR is deprecated? Almost all drivers use IDR/IDA
> > and its interfaces are straight-forward. In most cases we don't care
> > about a possible slight increase in efficiency either, and so also in
> > this case. Correctness is what matters and doing these conversions risks
> > introducing regressions.
> > 
> > And I believe IDR use XArray internally these days anyway.
> 
> Please read the following message by Matthew Wilcox for an
> authoritative response to your doubts about efficiency of XArray and
> IDR deprecation:

> https://lore.kernel.org/lkml/20210503182629.GE1847222@casper.infradead.org/
> 
> In particular he says that "[] The advantage of the XArray over the
> IDR is that it has a better API (and the IDR interface is
> deprecated).".

Whether the API is better is debatable. As I said, almost no drivers use
the new XArray interface, and perhaps partly because the new interface
isn't as intuitive as has been claimed (e.g. xa_load() instead of
ida_find()). And IDR/IDA isn't marked/documented as deprecated as far as
I know.

Your commit message sounds like ad for something, and is mostly
irrelevant for the case at hand.

> > > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > > ---
> > > 
> > > v3->v4: 
> > > 	Remove mutex_lock/unlock around xa_load(). These locks seem to
> > > 	be unnecessary because there is a 1:1 correspondence between
> > > 	a specific minor and its gb_tty and there is no reference
> > > 	counting. I think that the RCU locks used inside xa_load()
> > > 	are sufficient to protect this API from returning an invalid
> > > 	gb_tty in case of concurrent access. Some more considerations 
> > > 	on this topic are in the following message to linux-kernel list:
> > > 	https://lore.kernel.org/lkml/3554184.2JXonMZcNW@localhost.localdomain/
> > 
> > This just doesn't make sense (and a valid motivation would need to go in
> > the commit message if there was one).
> 
> OK, I'll take your words on it. Alex Elder wrote that he guess the
> mutex_lock/unlock() around xa_load() are probably not necessary. As I
> said I don't yet have knowledge of this kind of topics, so I was just
> attempting to find out a reason why. Now I know that my v1 was correct
> in having those Mutexes as the original code with IDR had.

This is partly why doing such conversions is a bad idea in the first
place. You need to understand the code that you're changing.

You don't know the code and risk introducing bugs, we need to spend time
reviewing it, and in the end we gain close to nothing at best.

Johan
