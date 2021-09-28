Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1716C41BA73
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 00:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243064AbhI1Weo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 18:34:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:51600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238632AbhI1Wen (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 18:34:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CEA7161391;
        Tue, 28 Sep 2021 22:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1632868383;
        bh=nqd+d1rQ4VI/NHuytxGymWHg99OvjAWcXpJLjVTFWSU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hfzhic+XohYPgPxc6pIxgwHmHhXfkow1zG9a3p3OnctJ5Y5fGGx1U27Tq9Ci5SKvc
         ALjZxynfLXWab4ONm2/XTZy5lGFsThL/hu8UcranEmKawB8ViP1ihUQrn/coMdoA+I
         J7P44Jx3BSrcJsPWyQBK7Gi/2+9QO76ALsrnArEY=
Date:   Tue, 28 Sep 2021 15:33:02 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Chen Wandun <chenwandun@huawei.com>
Cc:     <npiggin@gmail.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <edumazet@google.com>,
        <wangkefeng.wang@huawei.com>, <guohanjun@huawei.com>
Subject: Re: [PATCH] mm/vmalloc: fix numa spreading for large hash tables
Message-Id: <20210928153302.f87537b5faac8637c3c5eb53@linux-foundation.org>
In-Reply-To: <20210928121040.2547407-1-chenwandun@huawei.com>
References: <20210928121040.2547407-1-chenwandun@huawei.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Sep 2021 20:10:40 +0800 Chen Wandun <chenwandun@huawei.com> wrote:

> Eric Dumazet reported a strange numa spreading info in [1], and found
> commit 121e6f3258fe ("mm/vmalloc: hugepage vmalloc mappings") introduced
> this issue [2].
> 
> Dig into the difference before and after this patch, page allocation has
> some difference:
> 
> before:
> alloc_large_system_hash
>     __vmalloc
>         __vmalloc_node(..., NUMA_NO_NODE, ...)
>             __vmalloc_node_range
>                 __vmalloc_area_node
>                     alloc_page /* because NUMA_NO_NODE, so choose alloc_page branch */
>                         alloc_pages_current
>                             alloc_page_interleave /* can be proved by print policy mode */
> 
> after:
> alloc_large_system_hash
>     __vmalloc
>         __vmalloc_node(..., NUMA_NO_NODE, ...)
>             __vmalloc_node_range
>                 __vmalloc_area_node
>                     alloc_pages_node /* choose nid by nuam_mem_id() */
>                         __alloc_pages_node(nid, ....)
> 
> So after commit 121e6f3258fe ("mm/vmalloc: hugepage vmalloc mappings"),
> it will allocate memory in current node instead of interleaving allocate
> memory.
> 
> [1]
> https://lore.kernel.org/linux-mm/CANn89iL6AAyWhfxdHO+jaT075iOa3XcYn9k6JJc7JR2XYn6k_Q@mail.gmail.com/
> 
> [2]
> https://lore.kernel.org/linux-mm/CANn89iLofTR=AK-QOZY87RdUZENCZUT4O6a0hvhu3_EwRMerOg@mail.gmail.com/
> 
> Fixes: 121e6f3258fe ("mm/vmalloc: hugepage vmalloc mappings")
> Reported-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Chen Wandun <chenwandun@huawei.com>

This seems like it could cause significant performance regressions in
some situations?

If "yes" then wouldn't a cc:stable be appropriate?  And some (perhaps
handwavy) quantification of the slowdown would help people understand
why we're recommending a backport.

If "no" then why the heck do we have that feature in there anyway ;)

