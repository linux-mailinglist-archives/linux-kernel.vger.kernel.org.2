Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24D473A271A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 10:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbhFJIeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 04:34:17 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:44176 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbhFJIeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 04:34:12 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1B0DE1FD37;
        Thu, 10 Jun 2021 08:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623313935; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OeAO0bqW50FXm34lxR7plvPCmDbRwpAchjw0krk6Plk=;
        b=knI7HCq6TTN2dfs+hCsTzmfhOxtcDoXx7S67sSKKFnO2etfBoRDSK+HjvwoPflVDuLJ4vz
        tuYOSCf5FHI8OsMiSJbz8ZoUMbf47nC72YS0HwX7p21flISGe323b7zJSyj1nrsqHjwycr
        tMNH2mabp+qp0VdWhU3XS683JWXUFVM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623313935;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OeAO0bqW50FXm34lxR7plvPCmDbRwpAchjw0krk6Plk=;
        b=f/oIQ2VAqmm2/ojemgNGACPMRyz+K93+H/HrSdoDL/UKKzyTHrFic48I1WsdjH5zUkS73r
        QcGvsMuM7oNSMRCQ==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id E3558118DD;
        Thu, 10 Jun 2021 08:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623313935; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OeAO0bqW50FXm34lxR7plvPCmDbRwpAchjw0krk6Plk=;
        b=knI7HCq6TTN2dfs+hCsTzmfhOxtcDoXx7S67sSKKFnO2etfBoRDSK+HjvwoPflVDuLJ4vz
        tuYOSCf5FHI8OsMiSJbz8ZoUMbf47nC72YS0HwX7p21flISGe323b7zJSyj1nrsqHjwycr
        tMNH2mabp+qp0VdWhU3XS683JWXUFVM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623313935;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OeAO0bqW50FXm34lxR7plvPCmDbRwpAchjw0krk6Plk=;
        b=f/oIQ2VAqmm2/ojemgNGACPMRyz+K93+H/HrSdoDL/UKKzyTHrFic48I1WsdjH5zUkS73r
        QcGvsMuM7oNSMRCQ==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id ETl0Ng7OwWCbGgAALh3uQQ
        (envelope-from <vbabka@suse.cz>); Thu, 10 Jun 2021 08:32:14 +0000
To:     Cyrill Gorcunov <gorcunov@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>
References: <20210609113903.1421-1-vbabka@suse.cz>
 <20210609113903.1421-30-vbabka@suse.cz> <YMFAu5kuhZbZquiI@grain>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [RFC v2 29/34] mm: slub: Move flush_cpu_slab() invocations
 __free_slab() invocations out of IRQ context
Message-ID: <ea99ecc5-365d-95d5-df88-e32a07b67b3a@suse.cz>
Date:   Thu, 10 Jun 2021 10:32:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <YMFAu5kuhZbZquiI@grain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/10/21 12:29 AM, Cyrill Gorcunov wrote:
> On Wed, Jun 09, 2021 at 01:38:58PM +0200, Vlastimil Babka wrote:
>> +static DEFINE_MUTEX(flush_lock);
>> +static DEFINE_PER_CPU(struct slub_flush_work, slub_flush);
>> +
>>  static void flush_all(struct kmem_cache *s)
>>  {
>> -	on_each_cpu_cond(has_cpu_slab, flush_cpu_slab, s, 1);
>> +	struct slub_flush_work *sfw;
>> +	unsigned int cpu;
>> +
>> +	cpus_read_lock();
>> +	mutex_lock(&flush_lock);
>> +
> 
> Hi, Vlastimil! Could you please point why do you lock cpus first and
> mutex only after? Why not mutex_lock + cpus_read_lock instead?

Good question! I must admit I didn't think about it much and just followed the
order that was in the original Sebastian's patch [1]
But there was a good reason for this order as some paths via
__kmem_cache_shutdown() and __kmem_cache_shrink() were alreadu called under
cpus_read_lock. Meanwhile mainline (me, actually) removed those, so now it
doesn't seem to be a need to keep this order anymore and we could switch it.

Thanks,
Vlastimil

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/tree/patches/0005-mm-slub-Move-flush_cpu_slab-invocations-__free_slab-.patch?h=linux-5.12.y-rt-patches


