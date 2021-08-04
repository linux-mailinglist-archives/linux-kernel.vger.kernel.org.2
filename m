Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBB113E00D0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 14:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237956AbhHDMFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 08:05:39 -0400
Received: from outbound-smtp01.blacknight.com ([81.17.249.7]:49513 "EHLO
        outbound-smtp01.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234765AbhHDMFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 08:05:38 -0400
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp01.blacknight.com (Postfix) with ESMTPS id BE0F3C4A88
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 13:05:24 +0100 (IST)
Received: (qmail 17282 invoked from network); 4 Aug 2021 12:05:24 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.255])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 4 Aug 2021 12:05:24 -0000
Date:   Wed, 4 Aug 2021 13:05:22 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Mike Galbraith <efault@gmx.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH v3 00/35] SLUB: reduce irq disabled scope and make it RT
 compatible
Message-ID: <20210804120522.GD6464@techsingularity.net>
References: <20210729132132.19691-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20210729132132.19691-1-vbabka@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 29, 2021 at 03:20:57PM +0200, Vlastimil Babka wrote:
> Changes since v2 [5]:
> * Rebase to 5.14-rc3
> * A number of fixes to the RT parts, big thanks to Mike Galbraith for testing
>   and debugging!
>   * The largest fix is to protect kmem_cache_cpu->partial by local_lock instead
>     of cmpxchg tricks, which are insufficient on RT. To avoid divergence
>     between RT and !RT, just do it everywhere. Affected mainly patch 25 and a
>     new patch 33. This also addresses a theoretical race raised earlier by Jann
>     Horn.
> * Smaller fixes reported by Sebastian Andrzej Siewior and Cyrill Gorcunov
> 
> Changes since RFC v1 [1]:
> * Addressed feedback from Christoph and Mel, added their acks.
> * Finished RT conversion, adopting 2 patches from the RT tree.
> * The local_lock conversion has to sacrifice lockless fathpaths on PREEMPT_RT
> * Added some more cleanup patches to the front.
> 
> This series was initially inspired by Mel's pcplist local_lock rewrite, and
> also interest to better understand SLUB's locking and the new primitives and RT
> variants and implications. It should make SLUB more preemption-friendly,
> especially for RT, hopefully without noticeable regressions, as the fast paths
> are not affected.
> 
> Series is based on 5.14-rc3 and also available as a git branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/?h=slub-local-lock-v3r1
> 

FWIW, I ran a corrected version of this series through a few tests. Some
small gains, no major regressions in terms of performance on a !PREEMPT_RT
configuration across 6 different machines.

-- 
Mel Gorman
SUSE Labs
