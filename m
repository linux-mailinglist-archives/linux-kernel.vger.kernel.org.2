Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 832A033F3B1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 15:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbhCQOuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 10:50:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:48116 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231951AbhCQOuB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 10:50:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615992595; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Tek4PfCVWiuyin6G0ewc2/R9tv/tX0ZabWGaRWUeMFQ=;
        b=P78fHpKrigGwrusKUCB6W7i47Y1VCFMQmjrWooHYPEVW7mHQ98t4SaWikOgDTCMColWDrb
        px+zrer2zjMLMuoHrtNwPRjrcwbn13SRdt35UQLj90yhO1nR3b9MTG0Y6EkusRp1L1C4Pc
        4HyFvKLrQ7EKZUOHx9aKd9yOoXBdtto=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2D5ABACA8;
        Wed, 17 Mar 2021 14:49:55 +0000 (UTC)
Date:   Wed, 17 Mar 2021 15:49:54 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/5] mm,page_alloc: Bail out earlier on -ENOMEM in
 alloc_contig_migrate_range
Message-ID: <YFIXElOEfMuVEOZh@dhcp22.suse.cz>
References: <20210317111251.17808-1-osalvador@suse.de>
 <20210317111251.17808-2-osalvador@suse.de>
 <YFIMtFu/g3jtGqA8@dhcp22.suse.cz>
 <89830f41-b3f2-a158-a173-8c14101edcaa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89830f41-b3f2-a158-a173-8c14101edcaa@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 17-03-21 15:42:43, David Hildenbrand wrote:
> On 17.03.21 15:05, Michal Hocko wrote:
> > On Wed 17-03-21 12:12:47, Oscar Salvador wrote:
> > > Currently, __alloc_contig_migrate_range can generate -EINTR, -ENOMEM or -EBUSY,
> > > and report them down the chain.
> > > The problem is that when migrate_pages() reports -ENOMEM, we keep going till we
> > > exhaust all the try-attempts (5 at the moment) instead of bailing out.
> > > 
> > > migrate_pages() bails out right away on -ENOMEM because it is considered a fatal
> > > error. Do the same here instead of keep going and retrying.
> > 
> > I suspect this is not really a real life problem, right? The allocation
> > would be more costly in the end but this is to be expected under a heavy
> > memory pressure.
> > 
> > That being said, bailing out early makes sense to me. But now that
> > you've made me look into the migrate_pages excellent error state reporting
> > I suspect we have a bug here. Note the
> > "Returns the number of pages that were not migrated, or an error code."
> > 
> > but I do not see putback_movable_pages for ret > 0 so it seems we might
> > leak some pages.
> 
> At least in __alloc_contig_migrate_range() we seem to always leave the loop
> with ret <= 0 and do a putback_movable_pages() with ret < 0.
> 
> Which code are you referring to?

OK, my bad. I have managed to confuse myself around the retry bailout
which indeed overrides the return value. So there is no bug. Sorry about
the noise but I still believe making migrate_pages less tricky with
error handling would be an improvement.

Thanks!
-- 
Michal Hocko
SUSE Labs
