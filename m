Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 540E33E2461
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 09:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239110AbhHFHp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 03:45:29 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:45070 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238601AbhHFHp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 03:45:28 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BE6312236C;
        Fri,  6 Aug 2021 07:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628235911; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XydYnpc/ls5Im9aJguL/IFsvkaJWo5CzHRaUo1rP4fg=;
        b=zs1SFy6zUm/lB9EgyDvbcRcfVvTba1V3FNEw8cjNvaFI82nmKYw7NRXbxruqQjxRMxpvXg
        s/KOlugwd1kTgFSV3maXoThKrIKqJ+eh+VyKY/I47Pe3zd+vYZBHGEKJaMk9gn3WE15Dzl
        +l3JifFaTsJhzwDf6KDAc1APQpE/XwU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628235911;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XydYnpc/ls5Im9aJguL/IFsvkaJWo5CzHRaUo1rP4fg=;
        b=+VrSlps7ivv7Q7Bc4P0TErE0eBwkbpf2hTDCk9GEZN8pdpffvlizIK630SrQ8k76iFcZrw
        t+3HFgfFXW4+YwDw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 8560F13990;
        Fri,  6 Aug 2021 07:45:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id AR5FH4foDGGdGAAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Fri, 06 Aug 2021 07:45:11 +0000
To:     Mike Galbraith <efault@gmx.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Jann Horn <jannh@google.com>
References: <20210805152000.12817-1-vbabka@suse.cz>
 <20210805164210.2zxpzn2sdogf4kx3@linutronix.de>
 <a36ad3a060da4f02808b2692891afbe35292e15b.camel@gmx.de>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v4 00/35] SLUB: reduce irq disabled scope and make it RT
 compatible
Message-ID: <918557ec-3d8c-3d54-bce9-730f3a9cdc2d@suse.cz>
Date:   Fri, 6 Aug 2021 09:45:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <a36ad3a060da4f02808b2692891afbe35292e15b.camel@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/6/21 7:14 AM, Mike Galbraith wrote:
> On Thu, 2021-08-05 at 18:42 +0200, Sebastian Andrzej Siewior wrote:
>>
>> There was throughput regression in RT compared to previous releases
>> (without this series). The regression was (based on my testing) only
>> visible in hackbench and was addressed by adding adaptiv spinning to
>> RT-mutex. With that we almost back to what we had before :)
> 
> Numbers on my box say a throughput regression remains (silly fork bomb
> scenario.. yawn), which can be recouped by either turning on all
> SL[AU]B features or converting the list_lock to a raw lock.

I'm surprised you can still do that raw lock in v3/v4 because there's now a path
where get_partial_node() takes the list_lock and can call put_cpu_partial()
which takes the local_lock. But seems your results below indicate that this was
without CONFIG_SLUB_CPU_PARTIAL so that would still work.

> They also
> seem to be saying that if you turned on PREEMPT_RT because you care
> about RT performance first and foremost (gee), you'll do neither of
> those, because either will eliminate an RT performance progression.

That was my assumption, that there would be some tradeoff and RT is willing to
sacrifice some throughput here... which should be only visible if your benchmark
is close to slab microbenchmark, as hackbench is.

Thanks again!
