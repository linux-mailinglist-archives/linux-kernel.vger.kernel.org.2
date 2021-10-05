Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7298E42208B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 10:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233174AbhJEIVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 04:21:25 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:49628 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233367AbhJEIVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 04:21:24 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 840E221BCF;
        Tue,  5 Oct 2021 08:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633421972; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hNwtCpdH8x2CNs+9d+1b7WmfBaR40WkJXzrsENFs2vM=;
        b=zAGJFrmv1FOiyXoFqNB0ypj1Y3YTOhyuVNz7C4UHlMtew8JEa0+P71+bV//pWqvlGQt988
        Fsmt9GPgEJ3OSZn5+JRgtFFeRUfrC9+U64Zcr8y+8I/W+nLUQ6BfPO5sFH3oX/8vdsMROQ
        ebR1BILzeHWQ68d7r1Un0dbUM9gn5cc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633421972;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hNwtCpdH8x2CNs+9d+1b7WmfBaR40WkJXzrsENFs2vM=;
        b=V0qXyZbuxwcXCTo6US79LggLmLKiA8/mOtGFypTLwltDGuE1xBO3iZOZeq98jXhkJ3RTtr
        TA6QYATx2OJVnIBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6093B13A78;
        Tue,  5 Oct 2021 08:19:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6iTIFpQKXGE/YQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 05 Oct 2021 08:19:32 +0000
Message-ID: <09ca489a-ecfb-dd5e-b057-dc9c59c8585e@suse.cz>
Date:   Tue, 5 Oct 2021 10:19:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Content-Language: en-US
To:     Christoph Lameter <cl@gentwo.de>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     linux-mm@kvack.org, Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <20210927090347.GA2533@linux.asia-northeast3-a.c.our-ratio-313919.internal>
 <8aa15f4b-71de-5283-5ebc-d8d1a323473d@suse.cz>
 <20211001003908.GA2657@linux.asia-northeast3-a.c.our-ratio-313919.internal>
 <alpine.DEB.2.22.394.2110041648220.294708@gentwo.de>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: Queueing is outside of SLUB nowdays
In-Reply-To: <alpine.DEB.2.22.394.2110041648220.294708@gentwo.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/21 16:56, Christoph Lameter wrote:
> On Fri, 1 Oct 2021, Hyeonggon Yoo wrote:
> 
>> Looking at other layers, they implemented queuing layer outside of SLUB.
>> See commit 795bb1c00dd ("net: bulk free infrastructure for NAPI context,
>> use napi_consume_skb") for example. They made skb cache because SLUB is
>> not suitable for intensive alloc/free.
>>
>> And because the queue is outside of slab, it can go lockless
>> depending on it's context. (But it's not easy to do so in slab because
>> slab is general purpose allocator.)
> 
> The queuing within in SLUB/SLAB is lockless.
> 
>> So current approach on place where slab's performance is critical
>> is implementing queuing layer on top of slab.
> 
> If you have to use object specific characteristics to optimize then yes
> you can optimize further. However, the slab allocators implement each
> their own form of queuing that is generic.
> 
>> Then new question arising:
>>     - Is that proper way to solve fundamental problem?
> 
> There is a problem?

If someone benefits from implementing a caching layer on top of SL*B, it
probably indicates a problem.

>>       - why not use SLAB if they need queuing?
> 
> SLAB is LIFO queuing whereas SLUB uses spatial considerations and queues
> within a page before going outside.

IIUC SLUB queueing works well for allocation (we just consume a per-cpu
freelist that nobody else can touch) but freeing uses the corresponding
page's freelist so the atomics are more expensive. In both cases the linked
freelists might be also worse for cache locality than an array of pointers.
So perhaps some workload still benefit from a array-based cache on top of
SLUB and it would be great if they didn't have to implement own solutions?

> Slab requires disabling interrupts,
> SLUB is optimized to rely on per cpu atomics and there are numerous other
> differences.
> 
>>       - how does this approach work on SLAB?
> 
> SLAB has a lockless layer that is only requiring disabling interrupts. It
> provides a generic queuing layer as well.
> 
> See my talk on Slab allocators awhile back.
> 
> https://www.youtube.com/watch?v=h0VMLXavx30
> 

