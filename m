Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF96C419E5E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 20:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236276AbhI0Sfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 14:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236129AbhI0Sfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 14:35:32 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679F8C061604
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 11:33:53 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id i25so81930402lfg.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 11:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OkJDRTajjBYXZ9Lg7Znrw7BKNW4OCn6XI+sAVpYq6QI=;
        b=qdXZo0VKKvGxILef7JmwcenBcQKasiE54pz+WtZ2c1nuNKo0FWwkU4SAgC8IVJn75f
         mjCpRzf2uF1ul1E1lLRt6og0U0UE8lupicpoy8MsJhx87RW7ZRF2/IiAQk3X1EUkad/H
         SVS+td1Hcckzl3bVIQ07SGPH73T8NApdeMk8LCcoF2OmE1LvJCngQws8nZxjbVLviqFi
         MxSH0Z+tnuLGIuvHGzZCKU2j4H7he35g2cRq+JBRytRejIalREMLXhS8wizSW8YBtCx5
         yBzTEMlPIXVM4MsxAAcqg2DzUqMznWk6dIwbo5IJOFQPk0OMFQy66/jsTIEPNfLt13Kq
         kzEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OkJDRTajjBYXZ9Lg7Znrw7BKNW4OCn6XI+sAVpYq6QI=;
        b=z+lpo0qd+EjUXlnVHwTiIQG5NExrU37Hy4tkK6ubcvS6rn3SB3yVlSh8qarU1SHXNU
         T11CQxBkxYK6cl9urhswnGjU8Z/sq0GenjVEe6glvWno3CHStWURiMzC7bbZfyUj7jRH
         RqtojvlLTPYG8dcBNbeQ6OKdCFvcJpUhJ+bGNC0bFbVi9AQ5JJkC6vpULgiFZb4+jcPs
         tEvCP3n8wXyaqrSGzLRI8i0fd1QN4W7y/sgVLknGphBB1gg9Xqov9tT8EbXdd0yLzwg0
         qsFZTK+VkZj8q9fAJZ+t+RwM/+4JRbP2Q++xEZwsR78FSIySeUiipYydowZcFcFEY2GD
         AZwA==
X-Gm-Message-State: AOAM533DiAYZx2yeOhwxiNrJ/N3LvrOeHRAqKY2wdsZ30ikTq/bphXxh
        feK7p3u6iqn/vhuq3WlNED5IVA==
X-Google-Smtp-Source: ABdhPJzWZh6daO8VsDoVks7ChKfKV/MwaTxKX73LmO60ysmNU0X0sNpEippMfCo/ilGu6AoJUJdENA==
X-Received: by 2002:ac2:561c:: with SMTP id v28mr1153727lfd.457.1632767631753;
        Mon, 27 Sep 2021 11:33:51 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id n9sm1672309lfu.88.2021.09.27.11.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 11:33:51 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id E89C5102FE0; Mon, 27 Sep 2021 21:33:50 +0300 (+03)
Date:   Mon, 27 Sep 2021 21:33:50 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: Struct page proposal
Message-ID: <20210927183350.obd756wnsctukf63@box.shutemov.name>
References: <YUvWm6G16+ib+Wnb@moria.home.lan>
 <bc22b4d0-ba63-4559-88d9-a510da233cad@suse.cz>
 <YVIH5j5xkPafvNds@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YVIH5j5xkPafvNds@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2021 at 07:05:26PM +0100, Matthew Wilcox wrote:
> On Mon, Sep 27, 2021 at 07:48:15PM +0200, Vlastimil Babka wrote:
> > On 9/23/21 03:21, Kent Overstreet wrote:
> > > So if we have this:
> > > 
> > > struct page {
> > > 	unsigned long	allocator;
> > > 	unsigned long	allocatee;
> > > };
> > > 
> > > The allocator field would be used for either a pointer to slab/slub's state, if
> > > it's a slab page, or if it's a buddy allocator page it'd encode the order of the
> > > allocation - like compound order today, and probably whether or not the
> > > (compound group of) pages is free.
> > 
> > The "free page in buddy allocator" case will be interesting to implement.
> > What the buddy allocator uses today is:
> > 
> > - PageBuddy - determine if page is free; a page_type (part of mapcount
> > field) today, could be a bit in "allocator" field that would have to be 0 in
> > all other "page is allocated" contexts.
> > - nid/zid - to prevent merging accross node/zone boundaries, now part of
> > page flags
> > - buddy order
> > - a list_head (reusing the "lru") to hold the struct page on the appropriate
> > free list, which has to be double-linked so page can be taken from the
> > middle of the list instantly
> > 
> > Won't be easy to cram all that into two unsigned long's, or even a single
> > one. We should avoid storing anything in the free page itself. Allocating
> > some external structures to track free pages is going to have funny
> > bootstrap problems. Probably a major redesign would be needed...
> 
> Wait, why do we want to avoid using the memory that we're allocating?

Intel TDX and AMD-SEV have concept of unaccpeted memory. You cannot use
the memory until it got "accepted". The acceptance is costly and I made a
patchset[1] to pospone the accaptance until the first allocation. So pages
are on free list, but page type indicate that it has to go though
additional step on allocation.

[1] https://lore.kernel.org/all/20210810062626.1012-1-kirill.shutemov@linux.intel.com/

-- 
 Kirill A. Shutemov
