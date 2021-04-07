Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 058D2356AD0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 13:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235043AbhDGLKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 07:10:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:55446 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232994AbhDGLJ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 07:09:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9AF7BB11B;
        Wed,  7 Apr 2021 11:09:47 +0000 (UTC)
Subject: Re: [PATCH v1 0/5] percpu: partial chunk depopulation
To:     Roman Gushchin <guro@fb.com>, Dennis Zhou <dennis@kernel.org>
Cc:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210401214301.1689099-1-guro@fb.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <9da8492f-2ffb-2d4f-c937-93df28f0215a@suse.cz>
Date:   Wed, 7 Apr 2021 13:09:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210401214301.1689099-1-guro@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/1/21 11:42 PM, Roman Gushchin wrote:
> In our production experience the percpu memory allocator is sometimes struggling
> with returning the memory to the system. A typical example is a creation of
> several thousands memory cgroups (each has several chunks of the percpu data
> used for vmstats, vmevents, ref counters etc). Deletion and complete releasing
> of these cgroups doesn't always lead to a shrinkage of the percpu memory.
> 
> The underlying problem is the fragmentation: to release an underlying chunk
> all percpu allocations should be released first. The percpu allocator tends
> to top up chunks to improve the utilization. It means new small-ish allocations
> (e.g. percpu ref counters) are placed onto almost filled old-ish chunks,
> effectively pinning them in memory.
> 
> This patchset pretends to solve this problem by implementing a partial

Really "pretends"? :) Or did you mean "attempts"?
