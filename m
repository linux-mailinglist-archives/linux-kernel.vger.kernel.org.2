Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15C2B444A98
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 23:03:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbhKCWGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 18:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbhKCWGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 18:06:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3344C061714;
        Wed,  3 Nov 2021 15:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=XfqOcxMTNpce/H2cBChjbLc+Fz6a0SnCl4wsO4N8gnY=; b=l9KDMuDTY6G4Q8mwbSHvRaQUC2
        x9bxYxR/3FGTLD3rIADdw/By9FKQUhsioU96mw/u4mWT5P0UFJVRj80k2tJ4tqfQcKpLN/dyHCuPh
        zdg0pKopSL8ffZPqLNf2w9jlAP+B7aSsu0mrjkXbqRGiV51iEswNzmtj3UfBSyvSLW93cuNVPXVl4
        gHV90gdVY1VEKlxDV13Nm5OZnVqtDrGJaaaUscj46xZbQu1IyoVGMHe0lAQuDWLfHJpeEQt4x46uP
        8LFt7NOvYVtY50ixpzCeM0Kibam+0BoOv8ocZc+kmfdvoQHegXFbji4RjaxjdHFLu4RVGP8u+y1HQ
        mSYb6Qew==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1miOKJ-005Ufv-2C; Wed, 03 Nov 2021 22:02:15 +0000
Date:   Wed, 3 Nov 2021 22:01:47 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] mm/mremap_pages: Save a few cycles in 'get_dev_pagemap()'
Message-ID: <YYMGyx8Kpq/Nx4WL@casper.infradead.org>
References: <b4a47154877853cc64be3a35dcfd594d40cc2bce.1635975283.git.christophe.jaillet@wanadoo.fr>
 <YYMCI2S03+azi7nK@casper.infradead.org>
 <5da6ef93-97c6-6165-8a73-eb1050589ba7@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5da6ef93-97c6-6165-8a73-eb1050589ba7@wanadoo.fr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2021 at 10:54:09PM +0100, Christophe JAILLET wrote:
> Le 03/11/2021 à 22:41, Matthew Wilcox a écrit :
> > On Wed, Nov 03, 2021 at 10:35:34PM +0100, Christophe JAILLET wrote:
> > > Use 'percpu_ref_tryget_live_rcu()' instead of 'percpu_ref_tryget_live()' to
> > > save a few cycles when it is known that the rcu lock is already
> > > taken/released.
> > 
> > If this is really important, we can add an __xa_load() which doesn't
> > take the RCU read lock.
> 
> There are a few:
>    rcu_read_lock();
>    mem = xa_load(...);
>    rcu_read_unlock();
> patterns here and there.

If that's all they are, then the rcu_read_lock() and unlock can be
deleted.

if they're actually

	rcu_read_lock()
	mem = xa_load(...);
	try_get_ref(mem);
	rcu_read_unlock();

then of course they can't be.

> I don't have any numbers of if saving some rcu_read_lock/rcu_read_unlock
> would be useful in these cases.
> 
> The only numbers I have are in [1].
> 
> [1]: https://lore.kernel.org/linux-kernel/cover.1634822969.git.asml.silence@gmail.com/

It may not be worth hyperoptimising the slow path like this patch ...
