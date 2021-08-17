Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FFA23EEF4F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 17:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237767AbhHQPnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 11:43:11 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:58642 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbhHQPnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 11:43:10 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 223A521E5D;
        Tue, 17 Aug 2021 15:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629214956; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A9YvSBvAdkQ5Or8dySpWifyuVuQlz4bDIY5JTd0kN3s=;
        b=k8mG3aJANSRlhBJBMZ05SXTGsPAcT2Xs6NxqQdGO/rvT3MCKRSCT+YLCdLgroQayBBu6Zp
        zC0nYmwhy+wzP4cS8arHwa636oTw7qLufsftmgK+LuCRjssLX6ud/5cIux+opKkkkWB2/2
        xqDqKRB9MkoXa+VzRqB7m0k50XyEiRk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629214956;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A9YvSBvAdkQ5Or8dySpWifyuVuQlz4bDIY5JTd0kN3s=;
        b=HbQQcq7uS4IMaUCxFYfKzb1a2hlHvJbjBi/2dNjDbORF4XQRS+ksNBlcWgDB5vvzYoc6sU
        y+PPsbzrMyVu31Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 68A6E13E05;
        Tue, 17 Aug 2021 15:42:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Vvn9FevYG2HCTgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 17 Aug 2021 15:42:35 +0000
Subject: Re: [PATCH v4 35/35] mm, slub: convert kmem_cpu_slab protection to
 local_lock
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Jann Horn <jannh@google.com>
References: <20210805152000.12817-1-vbabka@suse.cz>
 <20210805152000.12817-36-vbabka@suse.cz>
 <20210817153937.hxnuh7mqp6vuiyws@linutronix.de>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <0120f82e-9251-9597-442f-8c582134a0d1@suse.cz>
Date:   Tue, 17 Aug 2021 17:41:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210817153937.hxnuh7mqp6vuiyws@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/17/21 5:39 PM, Sebastian Andrzej Siewior wrote:
> On 2021-08-05 17:20:00 [+0200], Vlastimil Babka wrote:
>> @@ -2849,7 +2891,11 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>>  
>>  load_freelist:
>>  
>> -	lockdep_assert_irqs_disabled();
>> +#ifdef CONFIG_PREEMPT_RT
>> +	lockdep_assert_held(this_cpu_ptr(&s->cpu_slab->lock.lock));
>> +#else
>> +	lockdep_assert_held(this_cpu_ptr(&s->cpu_slab->lock));
>> +#endif
> 
> Could you please make this hunk only
> 
> 	lockdep_assert_held(this_cpu_ptr(&s->cpu_slab->lock));
> 
> i.e. the non-RT version?

Does it mean that version works fine on RT now?

>>  	/*
>>  	 * freelist is pointing to the list of objects to be used.
> 
> 
> Sebastian
> 

