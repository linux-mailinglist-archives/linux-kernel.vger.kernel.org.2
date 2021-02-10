Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 259A9316920
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 15:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbhBJO2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 09:28:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:40206 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229789AbhBJO23 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 09:28:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 20294B0D1;
        Wed, 10 Feb 2021 14:27:48 +0000 (UTC)
Date:   Wed, 10 Feb 2021 15:27:45 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     David Hildenbrand <david@redhat.com>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH] mm: remove lru_add_drain_all in alloc_contig_range
Message-ID: <20210210142745.GD3636@localhost.localdomain>
References: <20210209175048.361638-1-minchan@kernel.org>
 <accc057c-e639-7510-f722-4a4d166c80b6@redhat.com>
 <20210209190332.GA3363@localhost.localdomain>
 <49491777-6d61-db4d-5e90-7a8b9045faca@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49491777-6d61-db4d-5e90-7a8b9045faca@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 01:17:33PM +0100, Vlastimil Babka wrote:
> AFAICS, at the time page migration used putback_lru_page() to release the
> migration source page. This would put the page on lru pvec even if it was in
> fact not mapped anywhere anymore, and only the drain would actually free it.
> Seems Minchan optimized this in 2016 by c6c919eb90e0 ("mm: use put_page() to
> free page instead of putback_lru_page()")

Ok, I see. Thanks for this valuable information Vlastimil.

-- 
Oscar Salvador
SUSE L3
