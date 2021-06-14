Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94E8A3A65BE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 13:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236083AbhFNLmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 07:42:04 -0400
Received: from outbound-smtp20.blacknight.com ([46.22.139.247]:35657 "EHLO
        outbound-smtp20.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236495AbhFNLdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 07:33:25 -0400
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp20.blacknight.com (Postfix) with ESMTPS id 089BE1C3EEC
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 12:31:20 +0100 (IST)
Received: (qmail 12703 invoked from network); 14 Jun 2021 11:31:19 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.255])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 14 Jun 2021 11:31:19 -0000
Date:   Mon, 14 Jun 2021 12:31:18 +0100
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
Subject: Re: [RFC v2 00/34] SLUB: reduce irq disabled scope and make it RT
 compatible
Message-ID: <20210614113118.GG30378@techsingularity.net>
References: <20210609113903.1421-1-vbabka@suse.cz>
 <20210614094902.GF30378@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20210614094902.GF30378@techsingularity.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2021 at 10:49:02AM +0100, Mel Gorman wrote:
> On Wed, Jun 09, 2021 at 01:38:29PM +0200, Vlastimil Babka wrote:
> > Changes since RFC v1 [1]:
> > * Addressed feedback from Christoph and Mel, added their acks.
> > * Finished RT conversion, including adopting 2 patches from the RT tree.
> > * The optional local_lock conversion has to sacrifice lockless fathpaths on RT
> > * Added some more cleanup patches to the front.
> > 
> > This series was initially inspired by Mel's pcplist local_lock rewrite, and
> > also by interest to better understand SLUB's locking and the new locking
> > primitives and their RT variants and implications. It should make SLUB more
> > preemption-friendly and fully RT compatible, hopefully without noticeable
> > regressions on !RT kernels, as the fast paths are not affected there.
> > 
> > Series is based on 5.13-rc5 and also available as a git branch:
> > https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/?h=slub-local-lock-v2r1
> > 
> 
> This failed to boot for me inside KVM.
> 

Bisection pointed to "mm, slub: use migrate_disable() on PREEMPT_RT".
Off-list, Vlastimil noted that the #ifdef was wrong and the patch below
booted. Wider battery of tests is queued but will take a few days to
complete.

---8<---
mm, slub: use migrate_disable() on PREEMPT_RT -fix

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/slub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index caa206213e72..f0359b0c8154 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -119,7 +119,7 @@
  * We could simply use migrate_disable()/enable() but as long as it's a
  * function call even on !PREEMPT_RT, use inline preempt_disable() there.
  */
-#ifdef CONFIG_PREEMPT_RT
+#ifndef CONFIG_PREEMPT_RT
 #define slub_get_cpu_ptr(var)	get_cpu_ptr(var)
 #define slub_put_cpu_ptr(var)	put_cpu_ptr(var)
 #else

-- 
Mel Gorman
SUSE Labs
