Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4E0435D42
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 10:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbhJUItF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 04:49:05 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:51830 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbhJUItD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 04:49:03 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 413E61FDA8;
        Thu, 21 Oct 2021 08:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634806007; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qVXU5eYkR1kdveY7nv6uj6Itzvxe/ABhRxe4MKA7/sA=;
        b=QCtVrKqh589J4ZyDsEGd/K5pcaoVXbJDzdxTAUECMLtRuOI3nwbBlT06QAyH/3Bl63Wy3w
        ij5TRID16GrFQ6zUplPr0BgsItjz7hTPmKJxhB1Gma7GB0u80JUpMimXc5VuCz2Z2UDzdv
        ClMZPCWabPNe0fWlyd1ytaWN6izoG+U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634806007;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qVXU5eYkR1kdveY7nv6uj6Itzvxe/ABhRxe4MKA7/sA=;
        b=tPUcfJib4B0JokiXZPBgHJMK54+t9EoCMhPXDnk3goCZHHc4ErhkjcaVKueoG2qhKNsMGH
        XpwnIBZxXHH7owDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1151D13BDA;
        Thu, 21 Oct 2021 08:46:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id juQoA/cocWGdIAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 21 Oct 2021 08:46:47 +0000
Message-ID: <cf8ef7b4-ca18-064f-9c5d-01047e40446b@suse.cz>
Date:   Thu, 21 Oct 2021 10:46:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-kernel@vger.kernel.org
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>,
        Dave Taht <dave.taht@gmail.com>
References: <20211020135535.517236-1-42.hyeyoo@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [RFC PATCH] mm, slob: Rewrite SLOB using segregated free list
In-Reply-To: <20211020135535.517236-1-42.hyeyoo@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/20/21 15:55, Hyeonggon Yoo wrote:
> Hello linux-mm, I rewrote SLOB using segregated free list,
> to understand SLOB and SLUB more. It uses more kilobytes
> of memory (48kB on 32bit tinyconfig) and became 9~10x faster.
> 
> But after rewriting, I thought I need to discuss what SLOB is for.
> According to Matthew, SLOB is for small machines whose
> memory is 1~16 MB.
> 
> I wonder adding 48kB on SLOB memory for speed/lower latency
> is worth or harmful.
> 
> So.. questions in my head now:
>     - Who is users of SLOB?
>     - Is it harmful to add some kilobytes of memory into SLOB?
>     - Is it really possible to run linux under 10MB of RAM?
>     	(I failed with tinyconfig.)
>     - What is the boundary to make decision between SLOB and SLUB?
> 
> Anyway, below is my work.
> Any comments/opinions will be appreciated!
> 
> SLOB uses sequential fit method. the advantages of this method
> is the fact that it is simple and does not have complex metadata.
> 
> But big downside of sequential fit method is its high latency
> in allocation/deallocation and fast fragmentation.
> 
> High latency comes from iterating pages and also iterating objects
> in the page to find suitable free object. And fragmentation easily
> happens because objects of difference size is allocated in same page.
> 
> This patch tries to minimize both its latency and fragmentation by
> re-implmenting SLOB using segregated free list method and adding
> support for slab merging. it looks like lightweight SLUB but more
> compact than SLUB.

My immediate reaction is that we probably don't want to turn SLOB into
lightweight SLUB. SLOB choses the tradeoff of low memory usage over speed
and shifting it towards more speed kinda defeats this purpose. Also it's a
major rewrite, so without a very clear motivation there will be resistance
to that.

SLUB itself could be probably tuned to less memory overhead if needed. Most
of the debug options effectively disable percpu slabs, we could add a mode
that disables them without the rest of the debugging overhead. Allocation
order can be lowered (although some object sizes might benefit from less
fragmentation with a higher order).

> One notable difference is after this patch SLOB uses kmalloc_caches
> like SL[AU]B.
> 
> Below is performance impacts of this patch.
> 
> Memory usage was measured on 32 bit + tinyconfig + slab merging.
> 
> Before:
>     MemTotal:          29668 kB
>     MemFree:           19364 kB
>     MemAvailable:      18396 kB
>     Slab:                668 kB
> 
> After:
>     MemTotal:          29668 kB
>     MemFree:           19420 kB
>     MemAvailable:      18452 kB
>     Slab:                716 kB
> 
> This patch adds about 48 kB after boot.
> 
> hackbench was measured on 64 bit typical buildroot configuration.
> After this patch it's 9~10x faster than before.
> 
> Before:
>     memory usage:
>         after boot:
>             Slab:               7908 kB
>         after hackbench:
>             Slab:               8544 kB
> 
>     Time: 189.947
>     Performance counter stats for 'hackbench -g 4 -l 10000':
>          379413.20 msec cpu-clock                 #    1.997 CPUs utilized
>            8818226      context-switches          #   23.242 K/sec
>             375186      cpu-migrations            #  988.859 /sec
>               3954      page-faults               #   10.421 /sec
>       269923095290      cycles                    #    0.711 GHz
>       212341582012      instructions              #    0.79  insn per cycle
>         2361087153      branch-misses
>        58222839688      cache-references          #  153.455 M/sec
>         6786521959      cache-misses              #   11.656 % of all cache refs
> 
>      190.002062273 seconds time elapsed
> 
>        3.486150000 seconds user
>      375.599495000 seconds sys
> 
> After:
>     memory usage:
>        after boot:
>            Slab:               7560 kB
>         after hackbench:
>            Slab:               7836 kB

Interesting that the memory usage in this test is actually lower with your
patch.

> hackbench:
>     Time: 20.780
>     Performance counter stats for 'hackbench -g 4 -l 10000':
>           41509.79 msec cpu-clock                 #    1.996 CPUs utilized
>             630032      context-switches          #   15.178 K/sec
>               8287      cpu-migrations            #  199.640 /sec
>               4036      page-faults               #   97.230 /sec
>        57477161020      cycles                    #    1.385 GHz
>        62775453932      instructions              #    1.09  insn per cycle
>          164902523      branch-misses
>        22559952993      cache-references          #  543.485 M/sec
>          832404011      cache-misses              #    3.690 % of all cache refs
> 
>       20.791893590 seconds time elapsed
> 
>        1.423282000 seconds user
>       40.072449000 seconds sys

That's significant, but also hackbench is kind of worst case test, so in
practice the benefit won't be that prominent.

> Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> ---
