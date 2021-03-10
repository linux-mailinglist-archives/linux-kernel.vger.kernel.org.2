Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15EEA3342F9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 17:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbhCJQX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 11:23:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:53262 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229950AbhCJQXQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 11:23:16 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615393395; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZjcsPl8c1NpSuh6kdJ7LYMmcjRYGJQhsfZkCKKU6XuI=;
        b=vXpPk4nMksjsPTm6wnCe/gPNciZkJNGEefix5jvb3KFs6tXbBoy+hl+zdTf3kMMJ+cY5h8
        olKivXhawvrubG2/NzLPA+3ZCj2zZvbNQQhJIfnW/lZBTLERsZMXaRF/m3w1GbOM1R1/4a
        yiNcWczNI5F5gz9LJlaD+4SjW7Sqs68=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A8B15ABD7;
        Wed, 10 Mar 2021 16:23:15 +0000 (UTC)
Date:   Wed, 10 Mar 2021 17:23:09 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>, Zi Yan <ziy@nvidia.com>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH 0/3] hugetlb: add demote/split page functionality
Message-ID: <YEjyS+xyeNlMcW/l@dhcp22.suse.cz>
References: <20210309001855.142453-1-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210309001855.142453-1-mike.kravetz@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 08-03-21 16:18:52, Mike Kravetz wrote:
[...]
> Converting larger to smaller hugetlb pages can be accomplished today by
> first freeing the larger page to the buddy allocator and then allocating
> the smaller pages.  However, there are two issues with this approach:
> 1) This process can take quite some time, especially if allocation of
>    the smaller pages is not immediate and requires migration/compaction.
> 2) There is no guarantee that the total size of smaller pages allocated
>    will match the size of the larger page which was freed.  This is
>    because the area freed by the larger page could quickly be
>    fragmented.

I will likely not surprise to show some level of reservation. While your
concerns about reconfiguration by existing interfaces are quite real is
this really a problem in practice? How often do you need such a
reconfiguration?

Is this all really worth the additional code to something as tricky as
hugetlb code base?

>  include/linux/hugetlb.h |   8 ++
>  mm/hugetlb.c            | 199 +++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 204 insertions(+), 3 deletions(-)
> 
> -- 
> 2.29.2
> 

-- 
Michal Hocko
SUSE Labs
