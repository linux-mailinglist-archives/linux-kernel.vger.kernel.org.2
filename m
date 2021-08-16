Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3FE43EE066
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 01:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235511AbhHPXXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 19:23:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:51822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235219AbhHPXXi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 19:23:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 033A660F35;
        Mon, 16 Aug 2021 23:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1629156186;
        bh=n+wwokIPkrGhwwnxslCZ/pC5W06miwa1WJrK0dzO5qQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Rz1K4gONy6IHigGB2ZtfXfsxPM1VzZmGHGohRt0wMliWtdVeEd9c5m+r7xoeS9+02
         stEGXvuvOH+MUx0XKujtKKUsapHTqfPcWMWTDWn9ZD8lQhfLP40MebGLKriwv9rCIo
         c/QBtihgA4AC7Keo3D5SbHbjlgrV84ISc+qQ9SSM=
Date:   Mon, 16 Aug 2021 16:23:05 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>, Zi Yan <ziy@nvidia.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Rientjes <rientjes@google.com>
Subject: Re: [PATCH RESEND 0/8] hugetlb: add demote/split page functionality
Message-Id: <20210816162305.b19bfa3f3ba7431a62ff205f@linux-foundation.org>
In-Reply-To: <20210816224953.157796-1-mike.kravetz@oracle.com>
References: <20210816224953.157796-1-mike.kravetz@oracle.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Aug 2021 15:49:45 -0700 Mike Kravetz <mike.kravetz@oracle.com> wrote:

> This is a resend of PATCHes sent here [4].  There was some discussion
> and interest when the RFC [5] was sent, but little after that.  The
> resend is just a rebase of [4] to next-20210816 with a few typos in
> commmit messages fixed.
> 
> Original Cover Letter
> ---------------------
> The concurrent use of multiple hugetlb page sizes on a single system
> is becoming more common.  One of the reasons is better TLB support for
> gigantic page sizes on x86 hardware.  In addition, hugetlb pages are
> being used to back VMs in hosting environments.
> 
> When using hugetlb pages to back VMs in such environments, it is
> sometimes desirable to preallocate hugetlb pools.  This avoids the delay
> and uncertainty of allocating hugetlb pages at VM startup.  In addition,
> preallocating huge pages minimizes the issue of memory fragmentation that
> increases the longer the system is up and running.
> 
> In such environments, a combination of larger and smaller hugetlb pages
> are preallocated in anticipation of backing VMs of various sizes.  Over
> time, the preallocated pool of smaller hugetlb pages may become
> depleted while larger hugetlb pages still remain.  In such situations,
> it may be desirable to convert larger hugetlb pages to smaller hugetlb
> pages.
> 
> Converting larger to smaller hugetlb pages can be accomplished today by
> first freeing the larger page to the buddy allocator and then allocating
> the smaller pages.  However, there are two issues with this approach:
> 1) This process can take quite some time, especially if allocation of
>    the smaller pages is not immediate and requires migration/compaction.
> 2) There is no guarantee that the total size of smaller pages allocated
>    will match the size of the larger page which was freed.  This is
>    because the area freed by the larger page could quickly be
>    fragmented.
> 
> To address these issues, introduce the concept of hugetlb page demotion.
> Demotion provides a means of 'in place' splitting a hugetlb page to
> pages of a smaller size.  For example, on x86 one 1G page can be
> demoted to 512 2M pages.  Page demotion is controlled via sysfs files.
> - demote_size   Read only target page size for demotion

Should this be "write only"?  If not, I'm confused.

If "yes" then "write only" would be a misnomer - clearly this file is
readable (looks at demote_size_show()).

> - demote        Writable number of hugetlb pages to be demoted

So how does this interface work?  Write the target size to
`demote_size', write the number of to-be-demoted larger pages to
`demote' and then the operation happens?

If so, how does one select which size pages should be selected for
the demotion?

And how does one know the operation has completed so the sysfs files
can be reloaded for another operation?

> Only hugetlb pages which are free at the time of the request can be demoted.
> Demotion does not add to the complexity surplus pages.  Demotion also honors
> reserved huge pages.  Therefore, when a value is written to the sysfs demote
> file, that value is only the maximum number of pages which will be demoted.
> It is possible fewer will actually be demoted.
> 
> If demote_size is PAGESIZE, demote will simply free pages to the buddy
> allocator.
> 
> Real world use cases
> --------------------
> There are groups today using hugetlb pages to back VMs on x86.  Their
> use case is as described above.  They have experienced the issues with
> performance and not necessarily getting the excepted number smaller huge

("expected")

> pages after free/allocate cycle.
> 

It seems odd to add the interfaces in patch 1 then document them in
patch 5.  Why not add-and-document in a single patch?
