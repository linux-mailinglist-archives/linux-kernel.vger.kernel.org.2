Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF42F38AE9A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241206AbhETMmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241955AbhETMlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:41:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21210C0611EA
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=r9GR7msVdIEp3a4rq9cpsOCHYoC70zlaenAZiGtT+tk=; b=KLQf3eixwTu2GrcJ/dqnzHwq49
        t22XDmAw5cxkLn18JPDoYk/HBuxipOHK5s66zUsynb/kBtDog3sAkeuEkmiiNEt1KGG9g0Bhk70Q+
        7oUmoIallZ7meR5UoBvyABv7aQJO/kEYvpt+LO9oYQQgvwQFLZlcj6yCjNR0trsDFesHE7bVK9jag
        AQX+e96f+xuS0nKsrNG1Ol3JefZL01uq/wYnGYr/yAY6gLNT0YkhpBOl6jl872GovxfGk67/GKwnN
        6d2VH9unjF6QnxJcTVbMn9cx/m4NBkXIRhAekHL3Z7M1pzeb7CW2prMKHGc34xdBb6Q2XrX5j0A2W
        NeaYucSg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1ljhHw-00FwX2-4q; Thu, 20 May 2021 11:57:11 +0000
Date:   Thu, 20 May 2021 12:56:28 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Aaron Tomlin <atomlin@redhat.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        mhocko@suse.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm/page_alloc: bail out on fatal signal during
 reclaim/compaction retry attempt
Message-ID: <YKZObDpduqwWi/Zm@casper.infradead.org>
References: <YKVn69o1UizH0kJD@casper.infradead.org>
 <20210519201743.3260890-1-atomlin@redhat.com>
 <20210519213455.97ff95f0124b4120787f8314@linux-foundation.org>
 <9b11dcd8-bc3b-aae9-feb1-43543bf9e22f@suse.cz>
 <20210520114257.huqhkqsdrhohn3u5@ava.usersys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210520114257.huqhkqsdrhohn3u5@ava.usersys.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 12:42:57PM +0100, Aaron Tomlin wrote:
> On Thu 2021-05-20 12:20 +0200, Vlastimil Babka wrote:
> > On 5/20/21 6:34 AM, Andrew Morton wrote:
> > > 
> > > What observed problems motivated this change?
> > > 
> > > What were the observed runtime effects of this change?
> > 
> > Yep those details from the previous thread should be included here.
> 
> Fair enough.
> 
> During kernel crash dump/or vmcore analysis: I discovered in the context of
> __alloc_pages_slowpath() the value stored in the no_progress_loops variable
> was found to be 31,611,688 i.e. well above MAX_RECLAIM_RETRIES; and a fatal
> signal was pending against current.

While this is true, it's not really answering Andrew's question.
What we want as part of the commit message is something like:

"A customer experienced a low memory situation and sent their task a
fatal signal.  Instead of dying promptly, it looped in the page
allocator failing to make progress because ..."

> 
>      #6 [ffff00002e78f7c0] do_try_to_free_pages+0xe4 at ffff00001028bd24
>      #7 [ffff00002e78f840] try_to_free_pages+0xe4 at ffff00001028c0f4
>      #8 [ffff00002e78f900] __alloc_pages_nodemask+0x500 at ffff0000102cd130
> 
>                                                              //      w28 = *(sp + 148)      /* no_progress_loops */
>      0xffff0000102cd1e0 <__alloc_pages_nodemask+0x5b0>:      ldr     w0, [sp,#148]
>                                                              //      w0 = w0 + 0x1
>      0xffff0000102cd1e4 <__alloc_pages_nodemask+0x5b4>:      add     w0, w0, #0x1
>                                                              //      *(sp + 148) = w0
>      0xffff0000102cd1e8 <__alloc_pages_nodemask+0x5b8>:      str     w0, [sp,#148]
>                                                              //      if (w0 >= 0x10)
>                                                              //          goto __alloc_pages_nodemask+0x904
>      0xffff0000102cd1ec <__alloc_pages_nodemask+0x5bc>:      cmp     w0, #0x10
>      0xffff0000102cd1f0 <__alloc_pages_nodemask+0x5c0>:      b.gt    0xffff0000102cd534
> 
>  - The stack pointer was 0xffff00002e78f900
> 
>      crash> p *(int *)(0xffff00002e78f900+148)
>      $1 = 31611688
> 
>      crash> ps 521171
>         PID    PPID  CPU       TASK        ST  %MEM     VSZ    RSS  COMM
>      > 521171      1  36  ffff8080e2128800  RU   0.0 34789440  18624  special
> 
>      crash> p &((struct task_struct *)0xffff8080e2128800)->signal.shared_pending
>      $2 = (struct sigpending *) 0xffff80809a416e40
> 
>      crash> p ((struct sigpending *)0xffff80809a416e40)->signal.sig[0]
>      $3 = 0x804100
> 
>      crash> sig -s 0x804100
>      SIGKILL SIGTERM SIGXCPU
> 
>      crash> p ((struct sigpending *)0xffff80809a416e40)->signal.sig[0] & 1U << (9 - 1)
>      $4 = 0x100
> 
> 
> Unfortunately, this incident was not reproduced, to date.
> 
> 
> 
> 
> 
> Kind regards,
> 
> -- 
> Aaron Tomlin


