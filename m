Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AEA939D659
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 09:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbhFGHx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 03:53:26 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:43898 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhFGHxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 03:53:24 -0400
Received: from relay2.suse.de (unknown [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 52B6A21A6E;
        Mon,  7 Jun 2021 07:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623052292; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4NT4tA15Kh2qCvhPPggvZbVmruQWfYW04SuZbrBoVAs=;
        b=STYpI1vFrANTBQnqKzXLAEPgUwzTjWefqYRZlHuDkLXe1VkAqJfoTf9bOEXOG6fH8B7wHc
        v7AFnEz6LKr2igzamTg4DukabHg2nvjhoSACUD1tq76XpIUNTM+xjX0O6Xpk9D3nQeY/i6
        aKbyyCxdGP/ijP1I0vnLVTGAEO5bKNI=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 2318CA3B85;
        Mon,  7 Jun 2021 07:51:31 +0000 (UTC)
Date:   Mon, 7 Jun 2021 09:51:30 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v1] memory-hotplug.rst: complete admin-guide overhaul
Message-ID: <YL3QApMe/9R/xfLU@dhcp22.suse.cz>
References: <20210525102604.8770-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210525102604.8770-1-david@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Sorry this somehow slipped through cracks]

On Tue 25-05-21 12:26:04, David Hildenbrand wrote:
> The memory hot(un)plug documentation is outdated and incomplete. Most of
> the content dates back to 2007, so it's time for a major overhaul.
> 
> Let's rewrite, reorganize and update most parts of the documentation. In
> addition to memory hot(un)plug, also add some details regarding
> ZONE_MOVABLE, with memory hotunplug being one of its main consumers.
> 
> The style of the document is also properly fixed that e.g., "restview"
> renders it cleanly now.
> 
> In the future, we might add some more details about virt users like
> virtio-mem, the XEN balloon, the Hyper-V balloon and ppc64 dlpar.

I haven't really checked the diff but rather looked at the final
outcome. I have to say I like it a lot. Some places are going a bit too
technical for an admin-guide but they are in minority (e.g. locking or
altmap reference). If somebody feels strong then this could get into its
own file but I wouldn't lose sleep over that.

I would make one thing slightly more explicit though
diff --git a/Documentation/admin-guide/mm/memory-hotplug.rst b/Documentation/admin-guide/mm/memory-hotplug.rst
index c95f5c2b30dd..5b462aba89cc 100644
--- a/Documentation/admin-guide/mm/memory-hotplug.rst
+++ b/Documentation/admin-guide/mm/memory-hotplug.rst
@@ -568,6 +568,10 @@ Even with ZONE_MOVABLE, there are some corner cases where offlining a memory
 Further, when running into out of memory situations while migrating pages, or
 when still encountering permanently unmovable pages within ZONE_MOVABLE
 (-> BUG), memory offlining will keep retrying until it eventually succeeds.
+The offlining context can be terminated by a fatal signal. A timeout based
+offlining can be easily implemented by 
+        
+        % timeout $TIMEOUT offline_block | failure_handling
 
 Locking Internals
 =================


In the future I would find some examples of a failure cases we have seen
so far. E.g. offlining failure with dump_page example.

> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Muchun Song <songmuchun@bytedance.com>
> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: linux-doc@vger.kernel.org
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks a lot David!
-- 
Michal Hocko
SUSE Labs
