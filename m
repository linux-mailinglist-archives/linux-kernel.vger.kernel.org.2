Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39CCD31DB03
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 14:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233055AbhBQNzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 08:55:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:51728 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232927AbhBQNzR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 08:55:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613570070; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cGZn21Gwdacac4lJmjWs7og7us1pnxGAs5d/KiaX3Wc=;
        b=CuQ9syD5a9/plxWcOzZtRtU/gUDxV/DyJ0MWCNEZtRqMzA8snhlchgrKXuAE2Q1zyxViaV
        9xFeI788BLis5xvMfejXS8fJoIkVbzlPDoFiCL6Uw6el5F4xYJQRz2cP9+CC345O21bZkR
        SnLE+caGcsCCV5znjNj/2XAkg36h4PY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D2997B761;
        Wed, 17 Feb 2021 13:54:30 +0000 (UTC)
Date:   Wed, 17 Feb 2021 14:54:24 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm: Make alloc_contig_range handle in-use hugetlb
 pages
Message-ID: <YC0gEBEeeDT1lZhD@dhcp22.suse.cz>
References: <20210217100816.28860-1-osalvador@suse.de>
 <20210217100816.28860-3-osalvador@suse.de>
 <YC0b39IfoI+c0ts1@dhcp22.suse.cz>
 <20210217134649.GB32488@linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210217134649.GB32488@linux>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 17-02-21 14:46:49, Oscar Salvador wrote:
> On Wed, Feb 17, 2021 at 02:36:31PM +0100, Michal Hocko wrote:
> > On Wed 17-02-21 11:08:16, Oscar Salvador wrote:
> > > In-use hugetlb pages can be migrated as any other page (LRU
> > > and Movable), so let alloc_contig_range handle them.
> > > 
> > > All we need is to succesfully isolate such page.
> > 
> > Again, this is missing a problem statement and a justification why we
> > want/need this.
> 
> Heh, I was poor in words.
> 
> "alloc_contig_range() will fail miserably if it finds a HugeTLB page within
>  the range without a chance to handle them. Since HugeTLB pages can be migrated
>  as any other page (LRU and Movable), it does not make sense to bail out.
>  Enable the interface to recognize in-use HugeTLB pages and have a chance
>  to migrate them"
> 
> What about something along those lines?

Is this a real life problem? I know we _can_ but I do not see any
reasoning _why_ should we care all that much.
-- 
Michal Hocko
SUSE Labs
