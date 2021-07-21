Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33F5D3D17F1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 22:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233756AbhGUThd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 15:37:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:48436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232808AbhGUThc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 15:37:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1300A61241;
        Wed, 21 Jul 2021 20:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1626898687;
        bh=KpKie0V9uJpTeQXpAAJt4nx7YvVtsE+ZBn1/F/fZfXI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VDltrvXEOVg5w7OY09xeW+N4MxtMN9jQ2OrPVJJsPdn+9/rlgOFK7U9uroEpYTkLd
         VdQOjrNeJxGGOuAUQxJDisPxQC1VVaDG26kMCo1YGLLmVJFbZCBaPeaNuEsJRKF9eJ
         tdU0RQ+uppYkUPsjPoZMkuKRjcahDmf7aFkM40WY=
Date:   Wed, 21 Jul 2021 13:18:06 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Charan Teja Reddy <charante@codeaurora.org>
Cc:     vbabka@suse.cz, rientjes@google.com, nigupta@nvidia.com,
        khalid.aziz@oracle.com, vinmenon@codeaurora.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH resend] mm: compaction: optimize proactive compaction
 deferrals
Message-Id: <20210721131806.5898dab3e329940fd8bd2db6@linux-foundation.org>
In-Reply-To: <1626869599-25412-1-git-send-email-charante@codeaurora.org>
References: <1626869599-25412-1-git-send-email-charante@codeaurora.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jul 2021 17:43:19 +0530 Charan Teja Reddy <charante@codeaurora.org> wrote:

> Vlastimil Babka figured out that when fragmentation score didn't go down
> across the proactive compaction i.e. when no progress is made, next wake
> up for proactive compaction is deferred for 1 <<
> COMPACT_MAX_DEFER_SHIFT, i.e. 64 times, with each wakeup interval of
> HPAGE_FRAG_CHECK_INTERVAL_MSEC(=500). In each of this wakeup, it just
> decrement 'proactive_defer' counter and goes sleep i.e. it is getting
> woken to just decrement a counter. The same deferral time can also
> achieved by simply doing the HPAGE_FRAG_CHECK_INTERVAL_MSEC <<
> COMPACT_MAX_DEFER_SHIFT thus unnecessary wakeup of kcompact thread is
> avoided thus also removes the need of 'proactive_defer' thread counter.
> 
> @@ -2902,23 +2903,30 @@ static int kcompactd(void *p)
>  
>  		trace_mm_compaction_kcompactd_sleep(pgdat->node_id);
>  		if (wait_event_freezable_timeout(pgdat->kcompactd_wait,
> -			kcompactd_work_requested(pgdat),
> -			msecs_to_jiffies(HPAGE_FRAG_CHECK_INTERVAL_MSEC))) {
> +			kcompactd_work_requested(pgdat), timeout)) {
>  
>  			psi_memstall_enter(&pflags);
>  			kcompactd_do_work(pgdat);
>  			psi_memstall_leave(&pflags);
> +			/*
> +			 * Reset the timeout value. The defer timeout by
> +			 * proactive compaction can effectively lost
> +			 * here but that is fine as the condition of the
> +			 * zone changed substantionally and carrying on
> +			 * with the previous defer is not useful.
> +			 */
> +			timeout = default_timeout;
>  			continue;

I find this comment hard to follow.  Is this better?

--- a/mm/compaction.c~mm-compaction-optimize-proactive-compaction-deferrals-fix
+++ a/mm/compaction.c
@@ -2909,11 +2909,11 @@ static int kcompactd(void *p)
 			kcompactd_do_work(pgdat);
 			psi_memstall_leave(&pflags);
 			/*
-			 * Reset the timeout value. The defer timeout by
-			 * proactive compaction can effectively lost
-			 * here but that is fine as the condition of the
-			 * zone changed substantionally and carrying on
-			 * with the previous defer is not useful.
+			 * Reset the timeout value. The defer timeout from
+			 * proactive compaction is lost here but that is fine
+			 * as the condition of the zone changing substantionally
+			 * then carrying on with the previous defer interval is
+			 * not useful.
 			 */
 			timeout = default_timeout;
 			continue;
_

