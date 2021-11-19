Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58DBE45705B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 15:10:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235741AbhKSONZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 09:13:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235201AbhKSONZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 09:13:25 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61278C061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 06:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=94mWcmoxnEKNskCWvbxGNVC/SEQw3zHqxj1V18qgEUY=; b=iBlP9WUwheC0CmIGJ/W8lwcfi/
        KV3JTG8aX+Owlufg9SUSewukeU4ZIP4JH7CtMe8aX/m66jcgrSbZfjgMvif9T9S5I7PBxQE/Fix6e
        MldcBV4zHk+JTJoWsoDNl4PS93qFOPMJL00w4pSli7e0lbprAvOIzMLki1V5jHQdhs9igio2tmh6g
        uNMq5nsTM7F63o8chHInXMnFHLU1qKUFiEjyco/0tEdD/9qoj1FHvVNjndW9BHOi9WVvN1T7ZtVyl
        9LK9FQtedi0Ywe59EaqHqqOh8+UKWcTg/m0+2wbAojZfpubNB3aI4RthpKvQ5ZwPwlf7LqbFo0zru
        E0CYpMrw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mo4ao-009YSC-QL; Fri, 19 Nov 2021 14:10:19 +0000
Date:   Fri, 19 Nov 2021 14:10:18 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Thierry Reding <thierry.reding@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MM: discard __GFP_ATOMIC
Message-ID: <YZewStgII83phKtA@casper.infradead.org>
References: <163712397076.13692.4727608274002939094@noble.neil.brown.name>
 <YZUBIbALcSHn4Rub@casper.infradead.org>
 <163727727803.13692.15470049610672496362@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163727727803.13692.15470049610672496362@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2021 at 10:14:38AM +1100, NeilBrown wrote:
> On Thu, 18 Nov 2021, Matthew Wilcox wrote:
> > Surely this should be gfpflags_allow_blocking() instead of poking about
> > in the innards of gfp flags?
> 
> Possibly.  Didn't know about gfpflags_allow_blocking().  From a quick
> grep in the kernel, a whole lot of other people don't know about it
> either, though clearly some do.
> 
> Maybe we should reaname "__GFP_DIRECT_RECLAIM" to
> "__GFP_ALLOW_BLOCKING", because that is what most users seems to care
> about.

I tend towards the school of thought that the __GFP flags should make
sense to the implementation and users should use either GFP_ or functions.
When we see users adding or subtracting __GFP flags, that's a problem.

> If not, then we probably want a gfpflags_without_block() function that
> removes that flag, as lots of code wants to do that - and using the flag
> for one, and an inline for the other is not consistent.

It's not a _lot_ of code ...

block/bio.c
drivers/net/ethernet/mellanox/mlx4/icm.c
drivers/vhost/net.c
fs/btrfs/disk-io.c
fs/btrfs/volumes.c
fs/erofs/zdata.c
fs/fscache/cookie.c
fs/fscache/page.c
kernel/cgroup/cgroup.c
net/core/skbuff.c
net/core/sock.c
net/netlink/af_netlink.c

(excluding mm -- if mm wants to meddle with GFP flags, that's fine)

I think a lot of these are probably misguided, eg the filesystems should
probably be using GFP_NOFS to prevent recursion.
