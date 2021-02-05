Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49268310B90
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 14:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbhBENK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 08:10:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:41872 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232080AbhBENFN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 08:05:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0FCAEACD4;
        Fri,  5 Feb 2021 13:03:58 +0000 (UTC)
Subject: Re: [PATCH] mm/slub: embed __slab_alloc to its caller
To:     Abel Wu <abel.w@icloud.com>, Christoph Lameter <cl@linux.com>
Cc:     Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        hewenliang4@huawei.com, wuyun.wu@huawei.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210202080515.2689-1-abel.w@icloud.com>
 <alpine.DEB.2.22.394.2102021009470.50959@www.lameter.com>
 <9A811B32-6E3D-4FE1-98A5-A7922C32CDB4@icloud.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <30743bfa-fbbb-c091-3b6e-dc24975fc6c3@suse.cz>
Date:   Fri, 5 Feb 2021 14:03:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <9A811B32-6E3D-4FE1-98A5-A7922C32CDB4@icloud.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/3/21 2:41 AM, Abel Wu wrote:
>> On Feb 2, 2021, at 6:11 PM, Christoph Lameter <cl@linux.com> wrote:
>> 
>> On Tue, 2 Feb 2021, Abel Wu wrote:
>> 
>>> Since slab_alloc_node() is the only caller of __slab_alloc(), embed
>>> __slab_alloc() to its caller to save function call overhead. This
>>> will also expand the caller's code block size a bit, but hackbench
>>> tests on both host and guest didn't show a difference w/ or w/o
>>> this patch.
>> 
>> slab_alloc_node is an always_inline function. It is intentional that only
>> the fast path was inlined and not the slow path.
> 
> Oh I got it. Thanks for your excellent explanation.

BTW, there's a script in the Linux source to nicely see the effect of such changes:

./scripts/bloat-o-meter slub.o.before mm/slub.o
add/remove: 0/1 grow/shrink: 9/0 up/down: 1660/-1130 (530)
Function                                     old     new   delta
__slab_alloc                                 127    1130   +1003
__kmalloc_track_caller                       877     965     +88
__kmalloc                                    878     966     +88
kmem_cache_alloc                             778     862     +84
__kmalloc_node_track_caller                  996    1080     +84
kmem_cache_alloc_node_trace                  813     896     +83
kmem_cache_alloc_node                        800     881     +81
kmem_cache_alloc_trace                       786     862     +76
__kmalloc_node                               998    1071     +73
___slab_alloc                               1130       -   -1130
Total: Before=57782, After=58312, chg +0.92%

And yeah, bloating all the entry points wouldn't be nice.
Thanks,
Vlastimil
