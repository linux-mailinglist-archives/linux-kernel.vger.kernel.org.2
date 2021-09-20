Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAF5F4111D4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 11:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236402AbhITJUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 05:20:08 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:37562 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232966AbhITJTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 05:19:45 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 90BD7200A9;
        Mon, 20 Sep 2021 09:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1632128857; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GxefN77fejNNXNAqyPi3T1kMi4HccQjMetP8mDr03sM=;
        b=KbGDApwCysahfDp4ht3j8oFcOzW9V+lNsWU8bUlG10RA+C3sPJovhVPL+8Mi/hk8xbxwvX
        4b8j0t6CWw1ch4z70k10gExno1UAXsusvuUdMo1lIChQUKfBLu6oHXOyVVFTVIsqCARlOu
        HTNRUJ6dR7vQWGqysLJq75k6WHSPTgQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1632128857;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GxefN77fejNNXNAqyPi3T1kMi4HccQjMetP8mDr03sM=;
        b=ZHeRt1RtsMQcQySCnnpl3U8w0ZtifDbI2ra2eV80ZkhLCxmYsQRn9dd0CSBdkuIrswNGid
        EQ06xDBttMhP/vDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4D1E313A81;
        Mon, 20 Sep 2021 09:07:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 33AUEllPSGHnNAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 20 Sep 2021 09:07:37 +0000
Message-ID: <432da236-4d8c-1013-cd57-42c352281862@suse.cz>
Date:   Mon, 20 Sep 2021 11:07:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
References: <20210919164239.49905-1-42.hyeyoo@gmail.com>
 <YUeM2J7X/i0CHjrz@casper.infradead.org>
 <20210920010938.GA3108@kvm.asia-northeast3-a.c.our-ratio-313919.internal>
 <YUfpniK6ZVeNhaX2@casper.infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [RFC PATCH] Introducing lockless cache built on top of slab
 allocator
In-Reply-To: <YUfpniK6ZVeNhaX2@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/21 03:53, Matthew Wilcox wrote:
> On Mon, Sep 20, 2021 at 01:09:38AM +0000, Hyeonggon Yoo wrote:
>> Hello Matthew, Thanks to give me a comment! I appreciate it.
>> Yeah, we can implement lockless cache using kmem_cache_alloc_{bulk, free}
>> but kmem_cache_alloc_{free,bulk} is not enough.
>> 
>> > I'd rather see this be part of the slab allocator than a separate API.
>> 
>> And I disagree on this. for because most of situation, we cannot
>> allocate without lock, it is special case for IO polling.
>> 
>> To make it as part of slab allocator, we need to modify existing data
>> structure. But making it part of slab allocator will be waste of memory
>> because most of them are not using this.
> 
> Oh, it would have to be an option.  Maybe as a new slab_flags_t flag.
> Or maybe a kmem_cache_alloc_percpu_lockless().

I've recently found out that similar attempts (introduce queueing to SLUB)
have been done around 2010. See e.g. [1] but there will be other threads to
search at lore too. Haven't checked yet while it wasn't ultimately merged, I
guess Christoph and David could remember (this was before my time).

I guess making it opt-in only for caches where performance improvement was
measured would make it easier to add, as for some caches it would mean no
improvement, but increased memory usage. But of course it makes the API more
harder to use.

I'd be careful about the name "lockless", as that's ambiguous. Is it "mostly
lockless" therefore fast, but if the cache is empty, it will still take
locks as part of refill? Or is it lockless always, therefore useful in
contexts that can take no locks, but then the caller has to have fallbacks
in case the cache is empty and nothing is allocated?

[1] https://lore.kernel.org/linux-mm/20100804024531.914852850@linux.com/T/#u
