Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0E6C38FF80
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 12:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbhEYKsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 06:48:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:55232 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231126AbhEYKsG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 06:48:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1621939596; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jjvp4FFV8P0pSJeVKurW+lAKVzi5/eK1z7artcT6SQU=;
        b=DL1DZTZPzv7ojiUAv7Emg8Io2L6tFK3/0JUe0XVCmkeFh92XneL9/I9/AWPXXgVqEyZKWs
        /Oq6ggnSZEGRmjgHQv08eaEdrRrB1NmhbvG3UaJReOrg6lX+cRmUJtjSiw66qxXXDCSy69
        JM6TsQUp8UkvZ5pXcwZUUnHJ1WiRBOk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1621939596;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jjvp4FFV8P0pSJeVKurW+lAKVzi5/eK1z7artcT6SQU=;
        b=UXISO0JwK5MFuBFEflL5jCOMutYiXgWiKT1K7DuKwCxmxwrbvxBEKTHp/v9OokwHDvKKVR
        iCDep8BgTaTI+kDw==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 284C8AEA3;
        Tue, 25 May 2021 10:46:36 +0000 (UTC)
Subject: Re: [PATCH 2/2] mm: slub: use DEFINE_RAW_SPINLOCK init
 object_map_lock
To:     Yejune Deng <yejune.deng@gmail.com>, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yejune Deng <yejunedeng@gmail.com>
References: <1621938235-11947-1-git-send-email-yejunedeng@gmail.com>
 <1621938235-11947-2-git-send-email-yejunedeng@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <427f87d6-b506-a225-1887-cf8c13d99634@suse.cz>
Date:   Tue, 25 May 2021 12:46:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <1621938235-11947-2-git-send-email-yejunedeng@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/25/21 12:23 PM, Yejune Deng wrote:
> Use DEFINE_RAW_SPINLOCK instead of DEFINE_SPINLOCK object_map_lock
> that won't be preempted on mainline and PREEMPT_RT kernels.
> 
> Signed-off-by: Yejune Deng <yejunedeng@gmail.com>

RT tree also has such patch, with IMHO more thorough description:

https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/tree/patches/0002-mm-slub-Make-object_map_lock-a-raw_spinlock_t.patch?h=linux-5.12.y-rt-patches

I was planning to include that in the next version of my series as that
will indeed be necessary.

> ---
>  mm/slub.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index c2f63c3..995f3d0 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -445,7 +445,7 @@ static inline bool cmpxchg_double_slab(struct kmem_cache *s, struct page *page,
>  
>  #ifdef CONFIG_SLUB_DEBUG
>  static unsigned long object_map[BITS_TO_LONGS(MAX_OBJS_PER_PAGE)];
> -static DEFINE_SPINLOCK(object_map_lock);
> +static DEFINE_RAW_SPINLOCK(object_map_lock);
>  
>  #if IS_ENABLED(CONFIG_KUNIT)
>  static bool slab_add_kunit_errors(void)
> @@ -481,7 +481,7 @@ static unsigned long *get_map(struct kmem_cache *s, struct page *page)
>  
>  	VM_BUG_ON(!irqs_disabled());
>  
> -	spin_lock(&object_map_lock);
> +	raw_spin_lock(&object_map_lock);
>  
>  	bitmap_zero(object_map, page->objects);
>  
> @@ -494,7 +494,7 @@ static unsigned long *get_map(struct kmem_cache *s, struct page *page)
>  static void put_map(unsigned long *map) __releases(&object_map_lock)
>  {
>  	VM_BUG_ON(map != object_map);
> -	spin_unlock(&object_map_lock);
> +	raw_spin_unlock(&object_map_lock);
>  }
>  
>  static inline unsigned int size_from_object(struct kmem_cache *s)
> 

