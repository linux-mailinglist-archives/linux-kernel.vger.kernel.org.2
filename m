Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA4C37BCD4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 14:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbhELMvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 08:51:16 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:52986 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230037AbhELMvN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 08:51:13 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 14CCo0vc021169;
        Wed, 12 May 2021 14:50:00 +0200
Date:   Wed, 12 May 2021 14:50:00 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tools/nolibc: Implement msleep()
Message-ID: <20210512125000.GB20883@1wt.eu>
References: <20210512114728.19015-1-broonie@kernel.org>
 <20210512115949.GA20883@1wt.eu>
 <20210512121858.GA6343@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210512121858.GA6343@sirena.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12, 2021 at 01:18:58PM +0100, Mark Brown wrote:
> On Wed, May 12, 2021 at 01:59:49PM +0200, Willy Tarreau wrote:
> > On Wed, May 12, 2021 at 12:47:28PM +0100, Mark Brown wrote:
> 
> > >  - Return the number of seconds remaining if the delay does not
> > >    complete.
> 
> > But why returning the number of seconds instead of milliseconds ?
> > The common use case is this:
> 
> >      delay = delay_before_next_event();
> >      while ((ret = msleep(delay)) > 0)
> >             delay -= ret;
> 
> It seemed to be what you were asking for and I didn't have strong enough
> opinions for it to be worth pushing back.

Sorry if I wasn't clear then, but I proposed this example which should
return the number of ms left:

        if (sys_select(0, 0, 0, 0, &my_timeval) < 0)
                return my_timeval.tv_sec * 1000 + (my_timeval.tv_usec + 999) / 1000;
        else
                return 0;

In any case all of this is not critical but I'm fairly convinced that
your addition is useful, especially if done like this, which is why I
was asking.

Willy
