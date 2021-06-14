Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB4023A65E3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 13:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233034AbhFNLn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 07:43:58 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:49840 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235822AbhFNLfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 07:35:47 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4FCF61FD33;
        Mon, 14 Jun 2021 11:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623670424; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IQ/Zr+B5rceGHvOw/tPouQhqXtR9UafewGuLuc3uVLI=;
        b=EPdzRnbEbEW10p6To68pPtyz4dSwKpPg6ArCbcPhdwJ8yVAjqRMJxOx2fsCQ34ct6O4DNV
        fj1OH5l9LWfcAc0UeFcw2VRZCh8lgPvr0xGQl3EOWChNl1J413McyZnPXYp7UHLGbY3dTL
        sQRsJU9U51k86P6/J1y2qyNnv4NvMtI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623670424;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IQ/Zr+B5rceGHvOw/tPouQhqXtR9UafewGuLuc3uVLI=;
        b=xiHIjsfqqTWgNLLq3VIdpd7zPgtlbVvo+NR6S+n6SSrWGwSQh3Lp8GlI19qg3f2icTTngE
        TxLG8l5HX3Ya4cCA==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 23B87118DD;
        Mon, 14 Jun 2021 11:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623670424; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IQ/Zr+B5rceGHvOw/tPouQhqXtR9UafewGuLuc3uVLI=;
        b=EPdzRnbEbEW10p6To68pPtyz4dSwKpPg6ArCbcPhdwJ8yVAjqRMJxOx2fsCQ34ct6O4DNV
        fj1OH5l9LWfcAc0UeFcw2VRZCh8lgPvr0xGQl3EOWChNl1J413McyZnPXYp7UHLGbY3dTL
        sQRsJU9U51k86P6/J1y2qyNnv4NvMtI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623670424;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IQ/Zr+B5rceGHvOw/tPouQhqXtR9UafewGuLuc3uVLI=;
        b=xiHIjsfqqTWgNLLq3VIdpd7zPgtlbVvo+NR6S+n6SSrWGwSQh3Lp8GlI19qg3f2icTTngE
        TxLG8l5HX3Ya4cCA==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id +684CJg+x2BFFQAALh3uQQ
        (envelope-from <vbabka@suse.cz>); Mon, 14 Jun 2021 11:33:44 +0000
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>
References: <20210609113903.1421-1-vbabka@suse.cz>
 <20210609113903.1421-34-vbabka@suse.cz>
 <c553c26f-1f9c-e5ab-b71b-b2b5eeb59ad2@suse.cz>
 <20210614111619.l3ral7tt2wasvlb4@linutronix.de>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [RFC v2 33/34] mm, slub: use migrate_disable() on PREEMPT_RT
Message-ID: <390fc59e-17ed-47eb-48ff-8dae93c9a718@suse.cz>
Date:   Mon, 14 Jun 2021 13:33:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210614111619.l3ral7tt2wasvlb4@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/14/21 1:16 PM, Sebastian Andrzej Siewior wrote:
> On 2021-06-14 13:07:14 [+0200], Vlastimil Babka wrote:
>> > +#ifdef CONFIG_PREEMPT_RT
>> > +#define slub_get_cpu_ptr(var)	get_cpu_ptr(var)
>> > +#define slub_put_cpu_ptr(var)	put_cpu_ptr(var)
>> 
>> After Mel's report and bisect pointing to this patch, I realized I got the
>> #ifdef wrong and it should be #ifnded
> 
> So if you got the ifdef wrong (and kept everything as-is) then you
> tested the RT version on !RT. migrate_disable() behaves on !RT as on RT.
> As per changelog you don't use migrate_disable() unconditionally because
> it increases the overhead on !RT.

Correct.

> I haven't looked at the series and I have just this tiny question: why
> did migrate_disable() crash for Mel on !RT and why do you expect that it
> does not happen on PREEMPT_RT?

Right, so it's because __slab_alloc() has this optimization to avoid re-reading
'c' in case there is no preemption enabled at all (or it's just voluntary).

#ifdef CONFIG_PREEMPTION
        /*
         * We may have been preempted and rescheduled on a different
         * cpu before disabling preemption. Need to reload cpu area
         * pointer.
         */
        c = slub_get_cpu_ptr(s->cpu_slab);
#endif

Mel's config has CONFIG_PREEMPT_VOLUNTARY, which means CONFIG_PREEMPTION is not
enabled.

But then later in ___slab_alloc() we have

        slub_put_cpu_ptr(s->cpu_slab);
        page = new_slab(s, gfpflags, node);
        c = slub_get_cpu_ptr(s->cpu_slab);

And this is not hidden under CONFIG_PREEMPTION, so with the #ifdef bug the
slub_put_cpu_ptr did a migrate_enable() with Mel's config, without prior
migrate_disable().

If there wasn't the #ifdef PREEMPT_RT bug:
- this slub_put_cpu_ptr() would translate to put_cpu_ptr() thus
preempt_enable(), which on this config is just a barrier(), so it doesn't matter
that there was no matching preempt_disable() before.
- with PREEMPT_RT the CONFIG_PREEMPTION would be enabled, so the
slub_get_cpu_ptr() would do a migrate_disable() and there's no imbalance.

But now that I dig into this in detail, I can see there might be another
instance of this imbalance bug, if CONFIG_PREEMPTION is disabled, but
CONFIG_PREEMPT_COUNT is enabled, which seems to be possible in some debug
scenarios. Because then preempt_disable()/preempt_enable() still manipulate the
preempt counter and compiling them out in __slab_alloc() will cause imbalance.

So I think the guards in __slab_alloc() should be using CONFIG_PREEMPT_COUNT
instead of CONFIG_PREEMPT to be correct on all configs. I dare not remove them
completely :)
