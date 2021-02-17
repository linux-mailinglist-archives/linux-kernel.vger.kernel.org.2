Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6925831DB15
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 15:01:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233076AbhBQOAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 09:00:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:54500 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229707AbhBQOAe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 09:00:34 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613570388; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kpok43AkS6LfrrRyrP7m0YdEzZi5ynjrVsviXupBxkY=;
        b=GjOD4Nrr7GreaIY8cM6LFiUsfif620HT2e+wgR5W9K18oMGEmpBZOmFl8/W5BP9th28I+8
        cyNzoUXR4ytaKYSrGwSnq3PA7wzJXdxQkBbbqapmzaIoR9O/ayFsYQWlkj3wpTSMevU1s+
        pwQFrc0d2hI6LkF/Ftkgv/HDYcEXkFM=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 23627B761;
        Wed, 17 Feb 2021 13:59:48 +0000 (UTC)
Date:   Wed, 17 Feb 2021 14:59:40 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: Make alloc_contig_range handle free hugetlb pages
Message-ID: <YC0gzBX8ubV6x5NK@dhcp22.suse.cz>
References: <20210217100816.28860-1-osalvador@suse.de>
 <20210217100816.28860-2-osalvador@suse.de>
 <YC0agxVWYRKGm5IO@dhcp22.suse.cz>
 <182f6a4a-6f95-9911-7730-8718ab72ece2@redhat.com>
 <YC0fIhEHRDOVzK8U@dhcp22.suse.cz>
 <5f50c810-3f49-a162-6d1d-cf621c515f45@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f50c810-3f49-a162-6d1d-cf621c515f45@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 17-02-21 14:53:37, David Hildenbrand wrote:
> On 17.02.21 14:50, Michal Hocko wrote:
[...]
> > Do we have any real life examples? Or does this fall more into, let's
> > optimize an existing implementation category.
> > 
> 
> It's a big TODO item I have on my list and I am happy that Oscar is looking
> into it. So yes, I noticed it while working on virtio-mem. It's real.

Do not take me wrong, I am not opposing to the functionality. I am
asking for the specific usecase.

-- 
Michal Hocko
SUSE Labs
