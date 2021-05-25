Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27EE5390781
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 19:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233957AbhEYR0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 13:26:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:45592 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233866AbhEYR0R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 13:26:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1621963486; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aYyeinUAq0H1U93rCYr+guudzE86Z5+s4i82KHGINMI=;
        b=NQF509v5vB4KfKsbys/q0DSbhGkjYiLUf9BIYfndTecQChmKIqd0uz+LwfzpEAuFnjwE8j
        A92MIdBvMbAJU+2e/f74mAc2peK2iWNebQf5ojro4Y4pLh+wykCxpkyLESt4fRbUnfjEzL
        DEcNXFZhRfkEFEBgcrbcNu2Et52ohUI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1621963486;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aYyeinUAq0H1U93rCYr+guudzE86Z5+s4i82KHGINMI=;
        b=brrEX2/5HORQBhzlvcrc/7INEzj963Khh8LAk46gx4vJ8uYYDhn4EU3CKGLx1NxYBDeKoS
        11qZxR3xa7Dmb+CA==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 80ABEAF32;
        Tue, 25 May 2021 17:24:46 +0000 (UTC)
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>
References: <20210524233946.20352-1-vbabka@suse.cz>
 <20210524233946.20352-10-vbabka@suse.cz>
 <20210525123536.GR30378@techsingularity.net>
 <f2e9187a-dea8-ef55-b815-9ac295b46919@suse.cz>
Subject: Re: [RFC 09/26] mm, slub: move disabling/enabling irqs to
 ___slab_alloc()
Message-ID: <1c9027d9-c6d7-f05d-49a4-a6396a59280c@suse.cz>
Date:   Tue, 25 May 2021 19:24:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <f2e9187a-dea8-ef55-b815-9ac295b46919@suse.cz>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/25/21 2:47 PM, Vlastimil Babka wrote:
> On 5/25/21 2:35 PM, Mel Gorman wrote:
>> 
>> Why did you use migrate_disable instead of preempt_disable? There is a
>> fairly large comment in include/linux/preempt.h on why migrate_disable
>> is undesirable so new users are likely to be put under the microscope
>> once Thomas or Peter notice it.
> 
> I understood it as while undesirable, there's nothing better for now.

Ah I now recalled the more important reason. By my understanding of
Documentation/locking/locktypes.rst it's not possible on PREEMPT_RT to do a
preempt_disable() and then take a spin_lock (or local_lock) which is a mutex on
RT and needs preemption enabled to take it. And one of the goals is that
list_lock would not have to be raw_spinlock on RT anymore.

>> I think you are using it so that an allocation request can be preempted by
>> a higher priority task but given that the code was disabling interrupts,
>> there was already some preemption latency.
> 
> Yes, and the disabled interrupts will get progressively "smaller" in the series.
> 
>> However, migrate_disable
>> is more expensive than preempt_disable (function call versus a simple
>> increment).
> 
> That's true, I think perhaps it could be reimplemented so that on !PREEMPT_RT
> and with no lockdep/preempt/whatnot debugging it could just translate to an
> inline migrate_disable?

Correction: I meant "translate to an inline preempt_disable" which would then
not change anything for !PREEMPT_RT.

