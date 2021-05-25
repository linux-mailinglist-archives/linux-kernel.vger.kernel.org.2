Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42DC0390077
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 14:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232215AbhEYMBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 08:01:34 -0400
Received: from outbound-smtp38.blacknight.com ([46.22.139.221]:51591 "EHLO
        outbound-smtp38.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231712AbhEYMBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 08:01:30 -0400
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp38.blacknight.com (Postfix) with ESMTPS id 156D21B12
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 13:00:00 +0100 (IST)
Received: (qmail 3817 invoked from network); 25 May 2021 11:59:59 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.23.168])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 25 May 2021 11:59:59 -0000
Date:   Tue, 25 May 2021 12:59:58 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vlastimil Babka <vbabka@suse.cz>
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
Subject: Re: [RFC 06/26] mm, slub: dissolve new_slab_objects() into
 ___slab_alloc()
Message-ID: <20210525115958.GP30378@techsingularity.net>
References: <20210524233946.20352-1-vbabka@suse.cz>
 <20210524233946.20352-7-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20210524233946.20352-7-vbabka@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021 at 01:39:26AM +0200, Vlastimil Babka wrote:
> The later patches will need more fine grained control over individual actions
> in ___slab_alloc(), the only caller of new_slab_objects(), so dissolve it
> there. This is a preparatory step with no functional change.
> 
> The only minor change is moving WARN_ON_ONCE() for using a constructor together
> with __GFP_ZERO to new_slab() which makes it somewhat less frequent, but still
> able to catch a misuse.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

The goto in the previous patch makes a bit more sense now

Acked-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs
