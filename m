Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2311E3EE3EE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 03:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235973AbhHQBqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 21:46:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:39110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233327AbhHQBqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 21:46:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E94816023E;
        Tue, 17 Aug 2021 01:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1629164773;
        bh=p6EqPeFGcLwHb+izOknJr2kLygRCM8v8wG1Gz1UdcJk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fqvR2P6hR/V7Q0YlLIbZ/mxdx5m/3M6PsTbzo/TQ61FfgIQjy6jnXLDP4iOg5gQ93
         f266eeMQ6OBOAoD+PCQOU7Ef4lt82GpDi41rFtNJTSb3crp7hj98SlP6/NfCTv3pgD
         8tGOAnXxx4/sa+aChMS0qPPEBN/rfc8Lxjf05xiM=
Date:   Mon, 16 Aug 2021 18:46:11 -0700
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
Message-Id: <20210816184611.07b97f4c26b83090f5d48fab@linux-foundation.org>
In-Reply-To: <b4401912-b59a-2150-feef-468c2d25ba3e@oracle.com>
References: <20210816224953.157796-1-mike.kravetz@oracle.com>
        <20210816162749.22b921a61156a091f3e1d14d@linux-foundation.org>
        <b4401912-b59a-2150-feef-468c2d25ba3e@oracle.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Aug 2021 17:46:58 -0700 Mike Kravetz <mike.kravetz@oracle.com> wrote:

> > It really is a ton of new code.  I think we're owed much more detail
> > about the problem than the above.  To be confident that all this
> > material is truly justified?
> 
> The desired functionality for this specific use case is to simply
> convert a 1G huegtlb page to 512 2MB hugetlb pages.  As mentioned
> 
> "Converting larger to smaller hugetlb pages can be accomplished today by
>  first freeing the larger page to the buddy allocator and then allocating
>  the smaller pages.  However, there are two issues with this approach:
>  1) This process can take quite some time, especially if allocation of
>     the smaller pages is not immediate and requires migration/compaction.
>  2) There is no guarantee that the total size of smaller pages allocated
>     will match the size of the larger page which was freed.  This is
>     because the area freed by the larger page could quickly be
>     fragmented."
> 
> These two issues have been experienced in practice.

Well the first issue is quantifiable.  What is "some time"?  If it's
people trying to get a 5% speedup on a rare operation because hey,
bugging the kernel developers doesn't cost me anything then perhaps we
have better things to be doing.

And the second problem would benefit from some words to help us
understand how much real-world hurt this causes, and how frequently.
And let's understand what the userspace workarounds look like, etc.

> A big chunk of the code changes (aprox 50%) is for the vmemmap
> optimizations.  This is also the most complex part of the changes.
> I added the code as interaction with vmemmap reduction was discussed
> during the RFC.  It is only a performance enhancement and honestly
> may not be worth the cost/risk.  I will get some numbers to measure
> the actual benefit.

Cool.


