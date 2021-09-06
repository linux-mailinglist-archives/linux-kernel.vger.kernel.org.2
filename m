Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5C06401CE1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 16:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243256AbhIFOTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 10:19:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:60942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243272AbhIFOTJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 10:19:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 572136056C;
        Mon,  6 Sep 2021 14:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630937884;
        bh=hRvZG2jGovd6t+G7bkhjFrbCukybBbUh2vhvknEvXf4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=r3q/cFblpj5hV+jOJCFi2BVnRi/u4V+4frW4Yrohr0l9akt/p+qGRwTSUANsPvEZc
         Gf+lu3NoB1CXg646VKFaKQUUKfZUSXDRQ8Zzr2bXRNA3HRfoEDS9+jJkM9McM+/b7M
         TvYdr/9sgraaXRjSMrmIAd5w6MhqEGVEwazIvqjth0oBBRei3C2w/B1spF/BTDJ0RQ
         8UQ8/trVR/mo+G37aY115YTh0UbVzZNjESRtvpIr/LVfDhEAit9rF4l4/k0is1W8ln
         Z1Xtv7W1nZ3mQ4kqpn+xdVEe+UN3y8IzoTZtZWtopdCNuUWQ1ak5dqWqxU/zjgWvsc
         4TyPkZc6jqb6A==
Message-ID: <fdd8cdb1b2a54d348c13f07273a369a2461ba5b7.camel@kernel.org>
Subject: Re: 5.4.143-rt63 fscache_cookie_hash initialisation
From:   Tom Zanussi <zanussi@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Gregor Beck <gregor.beck@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        "williams@redhat.com" <williams@redhat.com>
Date:   Mon, 06 Sep 2021 09:18:04 -0500
In-Reply-To: <20210906083608.u6ghkljbdiz6js3c@linutronix.de>
References: <CAEvSrY+XS2+xYTDT=up6VwLer8STS1KmNbP43PjZ4Z=qKvL4-w@mail.gmail.com>
         <20210906083608.u6ghkljbdiz6js3c@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-09-06 at 10:36 +0200, Sebastian Andrzej Siewior wrote:
> On 2021-09-06 09:55:59 [+0200], Gregor Beck wrote:
> Your proposed change is
> 
> > index 5508d92e3f8f..cba2a226897f 100644
> > --- a/fs/fscache/cookie.c
> > +++ b/fs/fscache/cookie.c
> > @@ -963,6 +963,6 @@ void __init fscache_cookie_init(void)
> > {
> >        int i;
> > 
> > -       for (i = 0; i < (1 << fscache_cookie_hash_shift) - 1; i++)
> > +       for (i = 0; i < ARRAY_SIZE(fscache_cookie_hash); i++)
> >                INIT_HLIST_BL_HEAD(&fscache_cookie_hash[i]);
> > }
> > 
> 
> So that -1 at the end killed us.
> 
> fscache-initialize-cookie-hash-table-raw-spinlocks.patch was removed
> in
> the v5.6-RT series so this should be applied to 5.4 and 4.19.
> 

OK, thanks, I'll add this to the current 5.4 update.

Tom

> Sebastian

