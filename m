Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77E5633D263
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 12:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237030AbhCPLDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 07:03:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:39298 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230406AbhCPLCv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 07:02:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 62934AE5C;
        Tue, 16 Mar 2021 11:02:50 +0000 (UTC)
Subject: Re: [PATCH v3 0/4] mm/slub: Fix count_partial() problem
To:     xlpang@linux.alibaba.com, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Roman Gushchin <guro@fb.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Shu Ming <sming56@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@gentwo.de>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Wen Yang <wenyang@linux.alibaba.com>,
        James Wang <jnwang@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <1615303512-35058-1-git-send-email-xlpang@linux.alibaba.com>
 <793c884a-9d60-baaf-fab8-3e5f4a024124@suse.cz>
 <1b4f7296-cd26-7177-873b-a35f5504ccfb@linux.alibaba.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <c5028ee5-6407-14ef-d060-1c8755ca213a@suse.cz>
Date:   Tue, 16 Mar 2021 12:02:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <1b4f7296-cd26-7177-873b-a35f5504ccfb@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/16/21 11:42 AM, Xunlei Pang wrote:
> On 3/16/21 2:49 AM, Vlastimil Babka wrote:
>> On 3/9/21 4:25 PM, Xunlei Pang wrote:
>>> count_partial() can hold n->list_lock spinlock for quite long, which
>>> makes much trouble to the system. This series eliminate this problem.
>> 
>> Before I check the details, I have two high-level comments:
>> 
>> - patch 1 introduces some counting scheme that patch 4 then changes, could we do
>> this in one step to avoid the churn?
>> 
>> - the series addresses the concern that spinlock is being held, but doesn't
>> address the fact that counting partial per-node slabs is not nearly enough if we
>> want accurate <active_objs> in /proc/slabinfo because there are also percpu
>> slabs and per-cpu partial slabs, where we don't track the free objects at all.
>> So after this series while the readers of /proc/slabinfo won't block the
>> spinlock, they will get the same garbage data as before. So Christoph is not
>> wrong to say that we can just report active_objs == num_objs and it won't
>> actually break any ABI.
> 
> If maintainers don't mind this inaccuracy which I also doubt its
> importance, then it becomes easy. For fear that some people who really
> cares, introducing an extra config(default-off) for it would be a good
> option.

Great.

>> At the same time somebody might actually want accurate object statistics at the
>> expense of peak performance, and it would be nice to give them such option in
>> SLUB. Right now we don't provide this accuracy even with CONFIG_SLUB_STATS,
>> although that option provides many additional tuning stats, with additional
>> overhead.
>> So my proposal would be a new config for "accurate active objects" (or just tie
>> it to CONFIG_SLUB_DEBUG?) that would extend the approach of percpu counters in
>> patch 4 to all alloc/free, so that it includes percpu slabs. Without this config
>> enabled, let's just report active_objs == num_objs.
> For percpu slabs, the numbers can be retrieved from the existing
> slub_percpu_partial()->pobjects, looks no need extra work.

Hm, unfortunately it's not that simple, the number there is a snapshot that can
become wildly inacurate afterwards.
