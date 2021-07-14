Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C68D3C884D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 18:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239941AbhGNQFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 12:05:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55537 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234548AbhGNQEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 12:04:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626278522;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iDdwf1XmUeNAele69YuflW7I8JQTNLYYUbHmho8CJjk=;
        b=TTl4qoNO3uCYrYJXA+rBZNzXFtZk+hqW7EVu/5H93Y06uGouqmwj9pEemrHgJQE8hK+mmU
        zcbLkSOOXe2gB8rAA9nG2Qop/YpW0w/5fNd0VnhV4r+Cpy9aN7ZivTcGp5TR5KDBsrarH1
        duthdyNaHMskUB/T1Ya0nJRTJaOF3Uk=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-560-Dq8iti9TO7OzRPDUpfHWcw-1; Wed, 14 Jul 2021 12:02:01 -0400
X-MC-Unique: Dq8iti9TO7OzRPDUpfHWcw-1
Received: by mail-qk1-f199.google.com with SMTP id i190-20020a3786c70000b02903b54f40b442so1604129qkd.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 09:02:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iDdwf1XmUeNAele69YuflW7I8JQTNLYYUbHmho8CJjk=;
        b=d0mOU6gShMp8wOdEexmjYrYuuAjvcDbu3UxWEPtWZzGgb/eCdFAH/KWLdJWHwI3lSF
         AKhtaKhW+tE23loISjta4QPqgmOStoIptnRP4mE7qmj8tr739N59sEKwNDVal7FAguML
         SC9/hlbU318XS2JxBEJCgVP/YsTCeV23RMVKZUMTSKwFSlRoKxUdjKiF1YlZfoZN9T3Y
         TmLvp6UJMs8XFBEGDp+DW/XpWGi50/LyHN8MKVSVb1J3GwDzH9cw45OYCkdHJliAD0ec
         XMTcsx+Ei7NrQpguVNctyc1Jt+frOV3muLfQN2tTEigEvXhvOzUcvjTsEpyZrgziAqrk
         vuYA==
X-Gm-Message-State: AOAM531BHTtR8kAnrb4Ez6ag9/FE199Y1C3voDytX31C9sJWDopqVfv3
        lO/tidHYO7nKT/IQCwMRoWq4NqBWVwGU6h/vkOrr0dUlom6N3l6BIfrbC3TZmW6YaBejl5zeqr+
        r2AuSsecvJQCcQXP5F7DgehcL
X-Received: by 2002:a05:622a:d1:: with SMTP id p17mr9872837qtw.141.1626278519915;
        Wed, 14 Jul 2021 09:01:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxmBx7ehtHLFv1+6C/w89oUyoBrHdc2FU7lSB7HgqiXueL1nKb1EkEmByVFXTV9sw1ZSVVFYA==
X-Received: by 2002:a05:622a:d1:: with SMTP id p17mr9872799qtw.141.1626278519654;
        Wed, 14 Jul 2021 09:01:59 -0700 (PDT)
Received: from t490s (bras-base-toroon474qw-grc-65-184-144-111-238.dsl.bell.ca. [184.144.111.238])
        by smtp.gmail.com with ESMTPSA id y4sm1227470qkc.27.2021.07.14.09.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 09:01:58 -0700 (PDT)
Date:   Wed, 14 Jul 2021 12:01:57 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Tiberiu Georgescu <tiberiu.georgescu@nutanix.com>
Cc:     akpm@linux-foundation.org, catalin.marinas@arm.com,
        peterz@infradead.org, chinwen.chang@mediatek.com,
        linmiaohe@huawei.com, jannh@google.com, apopple@nvidia.com,
        christian.brauner@ubuntu.com, ebiederm@xmission.com,
        adobriyan@gmail.com, songmuchun@bytedance.com, axboe@kernel.dk,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, ivan.teterevkov@nutanix.com,
        florian.schmidt@nutanix.com, carl.waldspurger@nutanix.com,
        Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [RFC PATCH 0/1] pagemap: report swap location for shared pages
Message-ID: <YO8KdQYp4tNhci6o@t490s>
References: <20210714152426.216217-1-tiberiu.georgescu@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210714152426.216217-1-tiberiu.georgescu@nutanix.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2021 at 03:24:25PM +0000, Tiberiu Georgescu wrote:
> When a page allocated using the MAP_SHARED flag is swapped out, its pagemap
> entry is cleared. In many cases, there is no difference between swapped-out
> shared pages and newly allocated, non-dirty pages in the pagemap interface.
> 
> Example pagemap-test code (Tested on Kernel Version 5.14-rc1):
> 
> 	#define NPAGES (256)
> 	/* map 1MiB shared memory */
> 	size_t pagesize = getpagesize();
> 	char *p = mmap(NULL, pagesize * NPAGES, PROT_READ | PROT_WRITE,
> 			   MAP_ANONYMOUS | MAP_SHARED, -1, 0);
> 	/* Dirty new pages. */
> 	for (i = 0; i < PAGES; i++)
> 		p[i * pagesize] = i;
> 
> Run the above program in a small cgroup, which allows swapping:
> 
> 	/* Initialise cgroup & run a program */
> 	$ echo 512K > foo/memory.limit_in_bytes
> 	$ echo 60 > foo/memory.swappiness
> 	$ cgexec -g memory:foo ./pagemap-test
> 
> Check the pagemap report. This is an example of the current expected output:
> 
> 	$ dd if=/proc/$PID/pagemap ibs=8 skip=$(($VADDR / $PAGESIZE)) count=$COUNT | hexdump -C
> 	00000000  00 00 00 00 00 00 80 00  00 00 00 00 00 00 80 00  |................|
> 	*
> 	00000710  e1 6b 06 00 00 00 80 a1  9e eb 06 00 00 00 80 a1  |.k..............|
> 	00000720  6b ee 06 00 00 00 80 a1  a5 a4 05 00 00 00 80 a1  |k...............|
> 	00000730  5c bf 06 00 00 00 80 a1  90 b6 06 00 00 00 80 a1  |\...............|
> 
> The first pagemap entries are reported as zeroes, indicating the pages have
> never been allocated while they have actually been swapped out. It is
> possible for bit 55 (PTE is Soft-Dirty) to be set on all pages of the
> shared VMA, indicating some access to the page, but nothing else (frame
> location, presence in swap or otherwise).
> 
> This patch addresses the behaviour and modifies pte_to_pagemap_entry() to
> make use of the XArray associated with the virtual memory area struct
> passed as an argument. The XArray contains the location of virtual pages in
> the page cache, swap cache or on disk. If they are on either of the caches,
> then the original implementation still works. If not, then the missing
> information will be retrieved from the XArray.
> 
> The root cause of the missing functionality is that the PTE for the page
> itself is cleared when a swap out occurs on a shared page.  Please take a
> look at the proposed patch. I would appreciate it if you could verify a
> couple of points:
> 
> 1. Why do swappable and non-syncable shared pages have their PTEs cleared
>    when they are swapped out ? Why does the behaviour differ so much
>    between MAP_SHARED and MAP_PRIVATE pages? What are the origins of the
>    approach?

My understanding is linux mm treat this differently for file-backed memories,
MAP_SHARED is one of this kind.  For these memories, ptes can be dropped at any
time because it can be reloaded from page cache when faulted again.

Anonymous private memories cannot do that, so anonymous private memories keep
all things within ptes, including swap entry.

> 
> 2. PM_SOFT_DIRTY and PM_UFFD_WP are two flags that seem to get lost once
>    the shared page is swapped out. Is there any other way to retrieve
>    their value in the proposed patch, other than ensuring these flags are
>    set, when necessary, in the PTE?

uffd-wp has no problem on dropping them because uffd-wp does not yet support
shmem.  Shmem support is posted upstream but still during review:

https://lore.kernel.org/lkml/20210527201927.29586-1-peterx@redhat.com/

After that work they'll persist, then we won't have an issue using uffd-wp with
shmem swapping; the pagemap part is done in patch 25 of 27:

https://lore.kernel.org/lkml/20210527202340.32306-1-peterx@redhat.com/

However I agree soft-dirty seems to be still broken with it.

(Cc Hugh and Andrea too)

Thanks,

-- 
Peter Xu

