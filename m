Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7FC38FEFE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 12:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbhEYK0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 06:26:05 -0400
Received: from outbound-smtp45.blacknight.com ([46.22.136.57]:48757 "EHLO
        outbound-smtp45.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231475AbhEYK0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 06:26:03 -0400
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp45.blacknight.com (Postfix) with ESMTPS id 33D1AFAA06
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 11:24:33 +0100 (IST)
Received: (qmail 8878 invoked from network); 25 May 2021 10:24:33 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.23.168])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 25 May 2021 10:24:32 -0000
Date:   Tue, 25 May 2021 11:24:30 +0100
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
Subject: Re: [RFC 03/26] mm, slub: don't disable irq for
 debug_check_no_locks_freed()
Message-ID: <20210525102430.GL30378@techsingularity.net>
References: <20210524233946.20352-1-vbabka@suse.cz>
 <20210524233946.20352-4-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20210524233946.20352-4-vbabka@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021 at 01:39:23AM +0200, Vlastimil Babka wrote:
> In slab_free_hook() we disable irqs around the debug_check_no_locks_freed()
> call, which is unnecessary, as irqs are already being disabled inside the call.
> This seems to be leftover from the past where there were more calls inside the
> irq disabled sections. Remove the irq disable/enable operations.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Looks like it was needed for kmemcheck which went away back in 4.15 so

Acked-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs
