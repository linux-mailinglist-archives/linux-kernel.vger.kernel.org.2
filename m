Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81FBA3A6733
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 14:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233380AbhFNM4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 08:56:39 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:38960 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233218AbhFNM4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 08:56:34 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6746721983;
        Mon, 14 Jun 2021 12:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623675271; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zSv+sJ04/VrDDdXP1Ew6xJk3kC/8M6pl/QyYQ0sfx/g=;
        b=zPiPQ4cMCHnjijKoZx3/uHdLJdbamgesELOq/WtUi4NuWTcPSqp0LXPrIHhf01wbfJ/FEK
        hVNf0UMNF4EKMBvP69RI6MvEXFxPd8QHW7BqBclANJ3hUxi9JmpzQtV9cqctDZLL4ofw3j
        YuKScwfIAzsgbhpeguSlAnQCR0gboqc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623675271;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zSv+sJ04/VrDDdXP1Ew6xJk3kC/8M6pl/QyYQ0sfx/g=;
        b=1JkZwNDxW/Q5eWgFNs7jDLcifx/lXbTpjhqQy/WX2zalr8oDNXALbpB5GQSrfTbPqvWjcg
        VNASNmz/2JHNsMBw==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 3F4A4118DD;
        Mon, 14 Jun 2021 12:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623675271; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zSv+sJ04/VrDDdXP1Ew6xJk3kC/8M6pl/QyYQ0sfx/g=;
        b=zPiPQ4cMCHnjijKoZx3/uHdLJdbamgesELOq/WtUi4NuWTcPSqp0LXPrIHhf01wbfJ/FEK
        hVNf0UMNF4EKMBvP69RI6MvEXFxPd8QHW7BqBclANJ3hUxi9JmpzQtV9cqctDZLL4ofw3j
        YuKScwfIAzsgbhpeguSlAnQCR0gboqc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623675271;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zSv+sJ04/VrDDdXP1Ew6xJk3kC/8M6pl/QyYQ0sfx/g=;
        b=1JkZwNDxW/Q5eWgFNs7jDLcifx/lXbTpjhqQy/WX2zalr8oDNXALbpB5GQSrfTbPqvWjcg
        VNASNmz/2JHNsMBw==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id 9/TWDodRx2DhRAAALh3uQQ
        (envelope-from <vbabka@suse.cz>); Mon, 14 Jun 2021 12:54:31 +0000
Subject: Re: [RFC v2 33/34] mm, slub: use migrate_disable() on PREEMPT_RT
From:   Vlastimil Babka <vbabka@suse.cz>
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
 <390fc59e-17ed-47eb-48ff-8dae93c9a718@suse.cz>
Message-ID: <0edf0478-17ed-4120-22e1-b61ad9bddeec@suse.cz>
Date:   Mon, 14 Jun 2021 14:54:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <390fc59e-17ed-47eb-48ff-8dae93c9a718@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/14/21 1:33 PM, Vlastimil Babka wrote:
> On 6/14/21 1:16 PM, Sebastian Andrzej Siewior wrote:
> But now that I dig into this in detail, I can see there might be another
> instance of this imbalance bug, if CONFIG_PREEMPTION is disabled, but
> CONFIG_PREEMPT_COUNT is enabled, which seems to be possible in some debug
> scenarios. Because then preempt_disable()/preempt_enable() still manipulate the
> preempt counter and compiling them out in __slab_alloc() will cause imbalance.
> 
> So I think the guards in __slab_alloc() should be using CONFIG_PREEMPT_COUNT
> instead of CONFIG_PREEMPT to be correct on all configs. I dare not remove them
> completely :)

Yep, it's possible to get such scenario with PREEMPT_VOLUNTARY plus
PROVE_LOCKING - CONFIG_PREEMPTION is disabled but CONFIG_PREEMPT_COUNT is
enabled, and RCU then complains in the page allocator due to the unpaired
preempt_disable() before entering it.

I've pushed a new branch revision with this fixed:

https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/?h=slub-local-lock-v2r3
 

