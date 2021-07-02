Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1F5C3BA4A7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 22:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbhGBU2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 16:28:07 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:51292 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbhGBU2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 16:28:06 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9D43F2230C;
        Fri,  2 Jul 2021 20:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1625257532; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mabE+0eVvsCIBGarxQAzMzsRg+px+iJI6Z/84g0W3y0=;
        b=KlsCJ2kcsyOpcoIaegCkGDM++OMkRwObGt5DA3BSZ80lgQ5wXyFoRaqEYsSnHeahs+GOCN
        aomKcB7Sg3up8eIwyOqv0QLBSTToWLIjo9MqWVI60ijg2hDgRKmCKo8qTmXThpazvxS3tH
        I92OOm1YSqPxaSC6rHAkQXlcTVXZkfQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1625257532;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mabE+0eVvsCIBGarxQAzMzsRg+px+iJI6Z/84g0W3y0=;
        b=KBOnFJ7/WBYOni2zmCrVkRd2qOEWPVuamcpMUYovFREiP5nQ6RX4/gc57yQXojoXTZoU2e
        ItXh+XqjUq6MR1Cg==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 0E27D11C84;
        Fri,  2 Jul 2021 20:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1625257532; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mabE+0eVvsCIBGarxQAzMzsRg+px+iJI6Z/84g0W3y0=;
        b=KlsCJ2kcsyOpcoIaegCkGDM++OMkRwObGt5DA3BSZ80lgQ5wXyFoRaqEYsSnHeahs+GOCN
        aomKcB7Sg3up8eIwyOqv0QLBSTToWLIjo9MqWVI60ijg2hDgRKmCKo8qTmXThpazvxS3tH
        I92OOm1YSqPxaSC6rHAkQXlcTVXZkfQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1625257532;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mabE+0eVvsCIBGarxQAzMzsRg+px+iJI6Z/84g0W3y0=;
        b=KBOnFJ7/WBYOni2zmCrVkRd2qOEWPVuamcpMUYovFREiP5nQ6RX4/gc57yQXojoXTZoU2e
        ItXh+XqjUq6MR1Cg==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id ZBWEODt232AMfAAALh3uQQ
        (envelope-from <vbabka@suse.cz>); Fri, 02 Jul 2021 20:25:31 +0000
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
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <35b26e48-a96a-41b0-826e-43e43660c9d6@suse.cz>
Date:   Fri, 2 Jul 2021 22:25:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210702182944.lqa7o2a25to6czju@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/2/21 8:29 PM, Sebastian Andrzej Siewior wrote:
> I replaced my slub changes with slub-local-lock-v2r3.
> I haven't seen any complains from lockdep or so which is good. Then I
> did this with RT enabled (and no debug):

Thanks for testing!

> - A "time make -j32" run of allmodconfig on /dev/shm.
>   Old:
> | real    20m6,217s
> | user    568m22,553s
> | sys     48m33,126s
> 
>   New:
> | real    20m9,049s
> | user    569m32,096s
> | sys     48m47,670s
> 
>   These 3 seconds here are probably in the noise range.
> 
> - perf_5.10 stat -r 10 hackbench -g200 -s 4096 -l500
> Old:
> |         464.967,20 msec task-clock                #   27,220 CPUs utilized            ( +-  0,16% )
> |          7.683.944      context-switches          #    0,017 M/sec                    ( +-  0,86% )
> |            931.380      cpu-migrations            #    0,002 M/sec                    ( +-  4,94% )
> |            219.569      page-faults               #    0,472 K/sec                    ( +-  0,39% )
> |  1.104.727.599.918      cycles                    #    2,376 GHz                      ( +-  0,18% )
> |    941.428.898.087      stalled-cycles-frontend   #   85,22% frontend cycles idle     ( +-  0,24% )
> |    729.016.546.572      stalled-cycles-backend    #   65,99% backend cycles idle      ( +-  0,32% )
> |    340.133.571.519      instructions              #    0,31  insn per cycle
> |                                                   #    2,77  stalled cycles per insn  ( +-  0,12% )
> |     73.746.821.314      branches                  #  158,607 M/sec                    ( +-  0,13% )
> |        377.838.006      branch-misses             #    0,51% of all branches          ( +-  1,01% )
> | 
> |            17,0820 +- 0,0202 seconds time elapsed  ( +-  0,12% )
> 
> New:
> |         422.865,71 msec task-clock                #    4,782 CPUs utilized            ( +-  0,34% )
> |         14.594.238      context-switches          #    0,035 M/sec                    ( +-  0,43% )
> |          3.737.926      cpu-migrations            #    0,009 M/sec                    ( +-  0,46% )
> |            218.474      page-faults               #    0,517 K/sec                    ( +-  0,74% )
> |    940.715.812.020      cycles                    #    2,225 GHz                      ( +-  0,34% )
> |    716.593.827.820      stalled-cycles-frontend   #   76,18% frontend cycles idle     ( +-  0,39% )
> |    550.730.862.839      stalled-cycles-backend    #   58,54% backend cycles idle      ( +-  0,43% )
> |    417.274.588.907      instructions              #    0,44  insn per cycle
> |                                                   #    1,72  stalled cycles per insn  ( +-  0,17% )
> |     92.814.150.290      branches                  #  219,488 M/sec                    ( +-  0,17% )
> |        822.102.170      branch-misses             #    0,89% of all branches          ( +-  0,41% )
> | 
> |             88,427 +- 0,618 seconds time elapsed  ( +-  0,70% )
> 
> So this is outside of the noise range.
> I'm not sure where this is coming from. My guess would be higher lock
> contention within the memory allocator.

The series shouldn't significantly change the memory allocator
interaction, though.
Seems there's less cycles, but more time elapsed, thus more sleeping -
is it locks becoming mutexes on RT?

My first guess - the last, local_lock patch. What would happen if you
take that one out? Should be still RT-compatible. If it improves a lot,
maybe that conversion to local_lock is not worth it then.

My second guess - list_lock remains spinlock with my series, thus RT
mutex, but the current RT tree converts it to raw_spinlock. I'd hope
leaving that one as non-raw spinlock would still be much better for RT
goals, even if hackbench (which is AFAIK very slab intensive) throughput
regresses - hopefully not that much.

>> The remaining patches to upstream from the RT tree are small ones related to
>> KConfig. The patch that restricts PREEMPT_RT to SLUB (not SLAB or SLOB) makes
>> sense. The patch that disables CONFIG_SLUB_CPU_PARTIAL with PREEMPT_RT could
>> perhaps be re-evaluated as the series also addresses some latency issues with
>> percpu partial slabs.
> 
> With that series the PARTIAL slab can be indeed enabled. I have (had) a
> half done series where I had PARTIAL enabled and noticed a slight
> increase in latency so made it "default y on !RT". It wasn't dramatic
> but appeared to be outside of noise.
> 
> Sebastian
> 

