Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5219F3A9365
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 08:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbhFPG6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 02:58:33 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59186 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232220AbhFPG6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 02:58:08 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id BFCF521A32;
        Wed, 16 Jun 2021 06:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623826561; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=szaI6A0V86YU1pBq+/1uYb7ilG5wtJ06IV9rCzyE3Ww=;
        b=d45r73gc3zLjgf80Due47kUa5+gEAGEOQfFknYFmwa4nKWpPs+U0/GVisGM6BMU6tXP33Y
        N/jDhDdkZ72fxMv+8mSEk84Fq03TUyUYdOVIZy4ZVGc9JrClswOqQ9ukDRTA+S7kexPxzp
        dDNOGZ3UPE93a36tpIT/BXeDZaf4wKc=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 76F9CA3B93;
        Wed, 16 Jun 2021 06:56:01 +0000 (UTC)
Date:   Wed, 16 Jun 2021 08:56:01 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Punit Agrawal <punitagrawal@gmail.com>, senozhatsky@chromium.org,
        rostedt@goodmis.org, john.ogness@linutronix.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: Move EXPORT_SYMBOL() closer to vprintk definition
Message-ID: <YMmggRL/htxFK2VY@alley>
References: <20210614235635.887365-1-punitagrawal@gmail.com>
 <8c16059d-6e58-a3e4-25ef-7e2bcabecd86@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c16059d-6e58-a3e4-25ef-7e2bcabecd86@rasmusvillemoes.dk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2021-06-15 08:50:45, Rasmus Villemoes wrote:
> On 15/06/2021 01.56, Punit Agrawal wrote:
> > Commit 28e1745b9fa2 ("printk: rename vprintk_func to vprintk") while
> > improving readability by removing vprintk indirection, inadvertently
> > placed the EXPORT_SYMBOL() for the newly renamed function at the end
> > of the file.
> > 
> > For reader sanity, and as is convention move the EXPORT_SYMBOL()
> > declaration just after the end of the function.
> > 
> > Fixes: 28e1745b9fa2 ("printk: rename vprintk_func to vprintk")
> > Signed-off-by: Punit Agrawal <punitagrawal@gmail.com>
> > --
> > Hi,
> > 
> > The out-of-place EXPORT_SYMBOL() caused an unexpected conflict while
> > attempting to rebase the RT patches onto newer kernels.
> > 
> > Generally I avoid sending trivial changes on their own but this one is
> > a little hard to overlook. Also it felt like an obvious oversight in
> > the original patch.
> 
> Yes, indeed, sorry about that, and thanks for fixing it.

Yes, great catch.

> > Please consider merging.
> 
> Petr, as this is causing trouble for the -rt patchset, please consider
> if this could make it to Linus before v5.13 release.

Sure, I could do so. But could you please provide some more details
what exact problems it causes?

It looks like a cosmetic issue to me. It would be the only change
in the pull request. I would like to provide some reasonable
justification for it at this stage (for rc7).

Best Regards,
Petr
