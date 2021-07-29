Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73B7F3DA62E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 16:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234683AbhG2ORe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 10:17:34 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:37084 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234459AbhG2ORc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 10:17:32 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 102B62003A;
        Thu, 29 Jul 2021 14:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627568247; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=esxEqsZ+wim6rej+gqT3oSNZBGX2GHfaW0zHlZ8O3ns=;
        b=K0wRHrtk/fKD4wHMDQ/cRmXbUT99VJGnHFjthN9eAdLklXvuW+jw694dNfOvEzb5hd0ANK
        wI+fmooDVk1r5fH9izVjN7A6RKqdYMh01phq+1DBg2EwmaYnd23xM945sBzld09B3NH1gi
        eFZfR0wgdeJtRTvJOpMdoUaiL4My/Og=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627568247;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=esxEqsZ+wim6rej+gqT3oSNZBGX2GHfaW0zHlZ8O3ns=;
        b=hFWQlNENf8Pt23k2OqZ00ZmTkscT8RIutKd3QWVafTgXljsowuSDHsMhtm/TPIS+ffXZ02
        vmRqqsPygVC0RRDw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id D45C8136BF;
        Thu, 29 Jul 2021 14:17:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id iyqkMna4AmFZGAAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Thu, 29 Jul 2021 14:17:26 +0000
Subject: Re: [RFC v2 00/34] SLUB: reduce irq disabled scope and make it RT
 compatible
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
 <20210702182944.lqa7o2a25to6czju@linutronix.de>
 <35b26e48-a96a-41b0-826e-43e43660c9d6@suse.cz>
 <20210729134939.iulryxjarhjmpugz@linutronix.de>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <627eddeb-3dc0-056e-ae07-f14c4b1a1b8e@suse.cz>
Date:   Thu, 29 Jul 2021 16:17:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210729134939.iulryxjarhjmpugz@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/29/21 3:49 PM, Sebastian Andrzej Siewior wrote:

> now that I'm slowly catching up…

> 

> On 2021-07-02 22:25:05 [+0200], Vlastimil Babka wrote:

>> > - perf_5.10 stat -r 10 hackbench -g200 -s 4096 -l500

>> > Old:

>> > |         464.967,20 msec task-clock                #   27,220 CPUs utilized            ( +-  0,16% )

>> > New:

>> > |         422.865,71 msec task-clock                #    4,782 CPUs utilized            ( +-  0,34% )

>> 

>> The series shouldn't significantly change the memory allocator

>> interaction, though.

>> Seems there's less cycles, but more time elapsed, thus more sleeping -

>> is it locks becoming mutexes on RT?

> 

> yes, most likely since the !RT parts are mostly unchanged.

> 

>> My second guess - list_lock remains spinlock with my series, thus RT

>> mutex, but the current RT tree converts it to raw_spinlock. I'd hope

>> leaving that one as non-raw spinlock would still be much better for RT

>> goals, even if hackbench (which is AFAIK very slab intensive) throughput

>> regresses - hopefully not that much.

> 

> Yes, the list_lock seems to be the case. I picked your

> slub-local-lock-v3r0 and changed the list_lock (+slab_lock()) to use

> raw_spinlock_t and disable interrupts and CPUs utilisation went to

> ~23CPUs (plus a bunch of warnings which probably made it a little slower

> again).


I forgot to point that out in the cover letter, but with v3 this change to
raw_spinlock_t is AFAICS no longer possible (at least with
CONFIG_SLUB_CPU_PARTIAL) because in put_cpu_partial() we now take the local_lock
and it can be called from get_partial_node() which takes the list_lock.



> The difference between a sleeping lock (spinlock_t) and a mutex is

> that we attempt not to preempt a task that acquired a spinlock_t even if

> it is running for some time and the scheduler would preempt it (like it

> would do if the task had a mutex acquired. These are the "lazy preempt"

> bits in the RT patch).

> 

> By making the list_lock a raw_spinlock_t a lot of IRQ-flags dancing

> needs to be done as the page-allocator must be entered with enabled

> interrupts.


Hm but SLUB should never call the page allocator from under list_lock in my series?



> And then there is the possibility that you may need to free

> some memory even if you allocate memory which requires some extra steps

> on RT due to the IRQ-off part. All this vanishes by keeping list_lock a

> spinlock_t.

> The kernel-build test on /dev/shm remained unchanged so that is good.

> Unless there is a real-world use-case, that gets worse, I don't mind

> keeping the spinlock_t here. I haven't seen tglx complaining so far.



Good. IIRC hackbench is very close to being a slab microbenchmark, so
regressions there are expected, but should not translate to notable real world
regressions.



> Sebastian

> 

