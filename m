Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A31E54113EE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 14:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237504AbhITMDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 08:03:54 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:60098 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237457AbhITMDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 08:03:47 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A60BA2004D;
        Mon, 20 Sep 2021 12:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1632139339; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E3VEwLtbeq2LahYBGf7CCRXDQTpGMp+ylgVcG2T5Nng=;
        b=XG4tYBuFPVm0vU/Dwj0zsxON1aBIDWLl2u0hPN09bPMJxFyVbF+uo+hbaHLJa65OLy7agF
        C/Y3Rns7dvzrrZlAYaEvm+BIUR4AyUFKKiw3dcjL5waknxCnb9KzITn2xkpsd+gYsj6vpN
        4gY4u59sAulwAB16urgdzR1H5wq3nB0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1632139339;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E3VEwLtbeq2LahYBGf7CCRXDQTpGMp+ylgVcG2T5Nng=;
        b=CSH2GlwKpad4K4krz4Z/5HrphP1fJrQgCsdnu7URS1Jc6x++904X03Q4pdxyqaoFnuJDU/
        +DTRIXx5MYVPRNCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7BD4E13483;
        Mon, 20 Sep 2021 12:02:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 73yVHUt4SGE6HwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 20 Sep 2021 12:02:19 +0000
Message-ID: <a9f9ae14-7805-68f7-cf19-e9e03c87152f@suse.cz>
Date:   Mon, 20 Sep 2021 14:02:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [RFC PATCH] Introducing lockless cache built on top of slab
 allocator
Content-Language: en-US
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
References: <20210919164239.49905-1-42.hyeyoo@gmail.com>
 <YUeM2J7X/i0CHjrz@casper.infradead.org>
 <20210920010938.GA3108@kvm.asia-northeast3-a.c.our-ratio-313919.internal>
 <YUfpniK6ZVeNhaX2@casper.infradead.org>
 <432da236-4d8c-1013-cd57-42c352281862@suse.cz>
 <20210920115536.GA3117@kvm.asia-northeast3-a.c.our-ratio-313919.internal>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20210920115536.GA3117@kvm.asia-northeast3-a.c.our-ratio-313919.internal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/21 13:55, Hyeonggon Yoo wrote:
> On Mon, Sep 20, 2021 at 11:07:36AM +0200, Vlastimil Babka wrote:
>> I guess making it opt-in only for caches where performance improvement was
>> measured would make it easier to add, as for some caches it would mean no
>> improvement, but increased memory usage. But of course it makes the API more
>> harder to use.
> 
> Do you mean "lockless cache" it should be separate from slab because some caches
> doesn't benefit at all?

I meant it seems to be a valid approach to have a special kmem_cache flag
and allocation function variants, as you discussed. That covers the "some
caches don't benefit at all" while being an integral part of the allocator,
so others don't have to build ad-hoc solutions on top of it, and possibly it
can be also more optimized given access to the SLUB internals.

>> I'd be careful about the name "lockless", as that's ambiguous. Is it "mostly
>> lockless" therefore fast, but if the cache is empty, it will still take
>> locks as part of refill?
> 
> It is actually "mostly lockless" so it is ambiguous.
> Can you suggest a name? like try_lockless or anything?

"cached" instead of "lockless" ?

>> Or is it lockless always, therefore useful in
>> contexts that can take no locks, but then the caller has to have fallbacks
>> in case the cache is empty and nothing is allocated?
>> 
>> [1] https://lore.kernel.org/linux-mm/20100804024531.914852850@linux.com/T/#u
> 

