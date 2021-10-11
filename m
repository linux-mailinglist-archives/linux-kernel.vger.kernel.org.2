Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1C41428792
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 09:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234455AbhJKHXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 03:23:03 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:51854 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233650AbhJKHXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 03:23:02 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C690A22034;
        Mon, 11 Oct 2021 07:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633936861; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VUVi+DxairWD+VkQf6dH9WAeeHTskkzQRsj/8RNh5ZQ=;
        b=e+sA/i1b0HA9+DgdWnHb+992RjMBeptf4qC24uRPj20INlmN1iLK8xqG4NLBEzv9C8+G/0
        mi0Zqdh8Kwcdoc/Jz6JELeM9FCVOFO+udoUGj1+cr58UCyxx2xN7DczCCDZZ9vjB7c/0rG
        pI2ArVYPSh9AedbIuZTiXYUojOPkh9M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633936861;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VUVi+DxairWD+VkQf6dH9WAeeHTskkzQRsj/8RNh5ZQ=;
        b=AeGVcYTz5CK7qE3jozxGrnPapF50VMSkVj76p2omY9m/4t+XiiB7a5DNHES7CQo9+hM3iD
        AUk8G6L7+f7G4gDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A5C5813BAF;
        Mon, 11 Oct 2021 07:21:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id muCxJ93lY2ElWAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 11 Oct 2021 07:21:01 +0000
Message-ID: <904b6e72-cc2e-2e4d-5601-dacab734bf15@suse.cz>
Date:   Mon, 11 Oct 2021 09:21:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To:     David Rientjes <rientjes@google.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20211008133602.4963-1-42.hyeyoo@gmail.com>
 <30a76d87-e0af-3eec-d095-d87e898b31cf@google.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm, slub: Use prefetchw instead of prefetch
In-Reply-To: <30a76d87-e0af-3eec-d095-d87e898b31cf@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/21 00:49, David Rientjes wrote:
> On Fri, 8 Oct 2021, Hyeonggon Yoo wrote:
> 
>> It's certain that an object will be not only read, but also
>> written after allocation.
>> 
> 
> Why is it certain?  I think perhaps what you meant to say is that if we 
> are doing any prefetching here, then access will benefit from prefetchw 
> instead of prefetch.  But it's not "certain" that allocated memory will be 
> accessed at all.

I think the primary reason there's a prefetch is freelist traversal. The
cacheline we prefetch will be read during the next allocation, so if we
expect there to be one soon, prefetch might help. That the freepointer is
part of object itself and thus the cache line will be probably accessed also
after the allocation, is secondary. Yeah this might help some workloads, but
perhaps hurt others - these things might look obvious in theory but be
rather unpredictable in practice. At least some hackbench results would help...

>> Use prefetchw instead of prefetchw. On supported architecture
> 
> If we're using prefetchw instead of prefetchw, I think the diff would be 
> 0 lines changed :)
> 
>> like x86, it helps to invalidate cache line when the object exists
>> in other processors' cache.
>> 
>> Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
>> ---
>>  mm/slub.c | 7 +++----
>>  1 file changed, 3 insertions(+), 4 deletions(-)
>> 
>> diff --git a/mm/slub.c b/mm/slub.c
>> index 3d2025f7163b..2aca7523165e 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -352,9 +352,9 @@ static inline void *get_freepointer(struct kmem_cache *s, void *object)
>>  	return freelist_dereference(s, object + s->offset);
>>  }
>>  
>> -static void prefetch_freepointer(const struct kmem_cache *s, void *object)
>> +static void prefetchw_freepointer(const struct kmem_cache *s, void *object)

I wouldn't rename the function itself, unless we have both  variants for
different situations (we don't). That it uses prefetchw() is internal detail
at this point.

>>  {
>> -	prefetch(object + s->offset);
>> +	prefetchw(object + s->offset);
>>  }
>>  
>>  static inline void *get_freepointer_safe(struct kmem_cache *s, void *object)
>> @@ -3195,10 +3195,9 @@ static __always_inline void *slab_alloc_node(struct kmem_cache *s,
>>  			note_cmpxchg_failure("slab_alloc", s, tid);
>>  			goto redo;
>>  		}
>> -		prefetch_freepointer(s, next_object);
>> +		prefetchw_freepointer(s, next_object);
>>  		stat(s, ALLOC_FASTPATH);
>>  	}
>> -
>>  	maybe_wipe_obj_freeptr(s, object);
>>  	init = slab_want_init_on_alloc(gfpflags, s);
>>  
>> -- 
>> 2.27.0
>> 
>> 
> 

