Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 739383AD0F7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 19:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233693AbhFRRLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 13:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232740AbhFRRLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 13:11:43 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43713C061574
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 10:09:33 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id o19so8052750qtp.5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 10:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4NOrwzxRJlcGICPYrhUba54bgGdQ7/VU92/Q3ir7evY=;
        b=lTO79RcKMGPliGX8pcleoEMngI6k/CwfeVJMXEyzDQKx1czuTjHNBfJjSOyag22fbM
         cbC6ZH0lwWDpXS3Up2fYwjFAiVdo5tigdUb2bCpdbswuNYk6JtPaiqLk2VNPcOJTTjj3
         G7GLJDz4zE1mXtTC2rna8924cjBkSJzQ3zM0C3+6T8hHEJu1j9l7KTlNC83+Muo58oqa
         yWw/SmkPqoWLN8ZWdppvgzxakOB3mx4zxog3eOHeq//GX39iOsZ23S6tcEoJI9GLJsDU
         pepSvQcBKH1en2jXZGO2E8bOodjc2BJrPUM9cMXAu4I783iWxxhKa0hmSISOzCC2GvF0
         mOvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4NOrwzxRJlcGICPYrhUba54bgGdQ7/VU92/Q3ir7evY=;
        b=OQNgdf1K343JQ0Jw7MUp4uMC7wO6ISkgfqn7ZNE2451+WQQOeJGm5Wg9oEQdUXpNND
         nfhs8OEffVL6ZflZQFZLT0/qC4V79ZBUsVHC/La0EGTKVhiCRkb+nXSvTOs6zODsZpej
         bJUv+J+3bo2TgKt043NDg3T8p4QqADp3teNciI8S1d8mQQrd4pzhomhTLyHcxuvA4eTm
         PnBxxehUq9zDXEXqRZZon2yexsyvlzRS90XWqfpCMnAtvyUfOINQoreHvI4OVhFG7dwY
         CtI+CRhsqIrEiF890ETwyFMGE+ywKNhtDtZs6FPwzLAQDPEKvnPYri/5L/IYw3Ga2RB4
         2rQw==
X-Gm-Message-State: AOAM5317tfVS8GWgd00A+J0Woc6S2f5rftq7KCQ2oBP6h8rIQhl39aKT
        oKOA89HsFK/Bj1sYpQCh1G1N2A==
X-Google-Smtp-Source: ABdhPJw4e+jfpVDo37iUkRBB/jk3NpOfIkAm19e9INoUu3m8YmPekAemW3VXjAuhd7KzOj9bG/XkOw==
X-Received: by 2002:ac8:6641:: with SMTP id j1mr11458339qtp.103.1624036172483;
        Fri, 18 Jun 2021 10:09:32 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id u18sm5521044qta.38.2021.06.18.10.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 10:09:31 -0700 (PDT)
Date:   Fri, 18 Jun 2021 13:09:30 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Dave Chinner <david@fromorbit.com>, Roman Gushchin <guro@fb.com>,
        Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 4/4] vfs: keep inodes with page cache off the inode
 shrinker LRU
Message-ID: <YMzTSteDJkZkVziO@cmpxchg.org>
References: <20210614211904.14420-1-hannes@cmpxchg.org>
 <20210614211904.14420-4-hannes@cmpxchg.org>
 <20210615062640.GD2419729@dread.disaster.area>
 <YMj2YbqJvVh1busC@cmpxchg.org>
 <20210616012008.GE2419729@dread.disaster.area>
 <YMmD9xhBm9wGqYhf@cmpxchg.org>
 <20210616183043.cdd36c5ca6bee8614c609a90@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210616183043.cdd36c5ca6bee8614c609a90@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 06:30:43PM -0700, Andrew Morton wrote:
> On Wed, 16 Jun 2021 00:54:15 -0400 Johannes Weiner <hannes@cmpxchg.org> wrote:
> > On Wed, Jun 16, 2021 at 11:20:08AM +1000, Dave Chinner wrote:
> > > On Tue, Jun 15, 2021 at 02:50:09PM -0400, Johannes Weiner wrote:
> > > > On Tue, Jun 15, 2021 at 04:26:40PM +1000, Dave Chinner wrote:
> > > > > On Mon, Jun 14, 2021 at 05:19:04PM -0400, Johannes Weiner wrote:
> > > > > > @@ -1123,6 +1125,9 @@ static int __remove_mapping(struct address_space *mapping, struct page *page,
> > > > > >  			shadow = workingset_eviction(page, target_memcg);
> > > > > >  		__delete_from_page_cache(page, shadow);
> > > > > >  		xa_unlock_irq(&mapping->i_pages);
> > > > > > +		if (mapping_shrinkable(mapping))
> > > > > > +			inode_add_lru(mapping->host);
> > > > > > +		spin_unlock(&mapping->host->i_lock);
> > > > > >  
> > > > > 
> > > > > No. Inode locks have absolutely no place serialising core vmscan
> > > > > algorithms.
> > > > 
> > > > What if, and hear me out on this one, core vmscan algorithms change
> > > > the state of the inode?
> > > 
> > > Then the core vmscan algorithm has a layering violation.
> > 
> > You're just playing a word game here.
> 
> Don't think so.  David is quite correct in saying that vmscan shouldn't
> mess with inode state unless it's via address_space_operations?

It seemed to me the complaint was more about vmscan propagating this
state into the inode in general - effecting fs inode acquisitions and
LRU manipulations from the page reclaim callstack - regardless of
whether they are open-coded or indirect through API functions?

Since I mentioned better encapsulation but received no response...
