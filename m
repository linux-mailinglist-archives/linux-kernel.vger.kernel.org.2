Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 145D74397D7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 15:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232779AbhJYNvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 09:51:35 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:39340 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbhJYNvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 09:51:31 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 384531FD3A;
        Mon, 25 Oct 2021 13:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1635169748; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v+x+7fcw/+YytMUhFAnt+FKGGNMBk+QUr2gwfDdTJ7Q=;
        b=LndAzJXJfTth62Dc+rcWv8dmONm65/jechL4fZsahPBHLAwFzaZdaJWkpCH7WJElLxEo/L
        GYbfYDbLPOZxtr/iCEh7gEhPEwk5ICwQX4P5O3JB2CMT2va8qF+Gm35uzG4v18ygiD72Pd
        TfC75gYaM0AsE7YSsKPmBVpYunXWtTo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1635169748;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v+x+7fcw/+YytMUhFAnt+FKGGNMBk+QUr2gwfDdTJ7Q=;
        b=sLATxKaezlxIHcFmGZSSU/gMd2CT82OENGn+fJ2LZcuAuZ6zjjud/WdD4839lZv1FAeO/Y
        qNpTg+bAqTbAo1Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 14A6313BB8;
        Mon, 25 Oct 2021 13:49:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YHVVBNS1dmFtZgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 25 Oct 2021 13:49:08 +0000
Message-ID: <91d4688e-db6e-0ba3-e747-e995f255634b@suse.cz>
Date:   Mon, 25 Oct 2021 15:49:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To:     Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
References: <20211012180148.1669685-1-hannes@cmpxchg.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 00/11] PageSlab: eliminate unnecessary compound_head()
 calls
In-Reply-To: <20211012180148.1669685-1-hannes@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/21 20:01, Johannes Weiner wrote:
> PageSlab() currently imposes a compound_head() call on all callsites
> even though only very few situations encounter tailpages. This short
> series bubbles tailpage resolution up to the few sites that need it,
> and eliminates it everywhere else.
> 
> This is a stand-alone improvement. However, it's inspired by Willy's
> patches to split struct slab from struct page. Those patches currently
> resolve a slab object pointer to its struct slab as follows:
> 
> 	slab = virt_to_slab(p);		/* tailpage resolution */
> 	if (slab_test_cache(slab)) {	/* slab or page alloc bypass? */
> 		do_slab_stuff(slab);
> 	} else {
> 		page = (struct page *)slab;
> 		do_page_stuff(page);
> 	}
> 
> which makes struct slab an ambiguous type that needs to self-identify
> with the slab_test_cache() test (which in turn relies on PG_slab in
> the flags field shared between page and slab).
> 
> It would be preferable to do:
> 
> 	page = virt_to_head_page(p);	/* tailpage resolution */
> 	if (PageSlab(page)) {		/* slab or page alloc bypass? */
> 		slab = page_slab(page);
> 		do_slab_stuff(slab);
> 	} else {
> 		do_page_stuff(page);
> 	}

I agree with this. Also not fond of introducing setting PG_slab on all tail
pages as willy proposed. But also would like to avoid the tree-wide changes
to PageSlab tailpage resolution that this series is doing.

What we could do is what you suggest above, but the few hotpaths in slab
itself would use a __PageSlab() variant that just doesn't do tailpage
resolution. The rest of tree could keep doing PageSlab with tailpage
resolution for now, and then we can improve on that later. Would that be
acceptable?

With that I'm proposing to take over willy's series (as he asked for that in
the cover letter) which would be modified in the above sense. And maybe in
other ways I can't immediately predict.

But I do want to at least try an approach where we would deal with the
"boundary" functions first (that need to deal with struct page) and then
convert the bulk of "struct page" to "struct slab" at once with help of a
coccinelle semantic patch. I'm hoping that this wouldn't thus be a
"slapdash" conversion, while avoiding a large series of incremental patches
- because the result of such automation wouldn't need such close manual
review as human-written patches do.

> and leave the ambiguity and the need to self-identify with struct
> page, so that struct slab is a strong and unambiguous type, and a
> non-NULL struct slab encountered in the wild is always a valid object
> without the need to check another dedicated flag for validity first.
> 
> However, because PageSlab() currently implies tailpage resolution,
> writing the virt->slab lookup in the preferred way would add yet more
> unnecessary compound_head() call to the hottest MM paths.
> 
> The page flag helpers should eventually all be weaned off of those
> compound_head() calls for their unnecessary overhead alone. But this
> one in particular is now getting in the way of writing code in the
> preferred manner, and bleeding page ambiguity into the new types that
> are supposed to eliminate specifically that. It's ripe for a cleanup.
> 
> Based on v5.15-rc4.
> 
>  arch/ia64/kernel/mca_drv.c |  2 +-
>  drivers/ata/libata-sff.c   |  2 +-
>  fs/proc/page.c             | 12 +++++++-----
>  include/linux/net.h        |  2 +-
>  include/linux/page-flags.h | 10 +++++-----
>  mm/kasan/generic.c         |  2 +-
>  mm/kasan/kasan.h           |  2 +-
>  mm/kasan/report.c          |  4 ++--
>  mm/kasan/report_tags.c     |  2 +-
>  mm/memory-failure.c        |  6 +++---
>  mm/memory.c                |  3 ++-
>  mm/slab.h                  |  2 +-
>  mm/slob.c                  |  4 ++--
>  mm/slub.c                  |  6 +++---
>  mm/util.c                  |  2 +-
>  15 files changed, 32 insertions(+), 29 deletions(-)
> 
> 
> 

