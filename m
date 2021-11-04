Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5ED4450FA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 10:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbhKDJTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 05:19:38 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:34114 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbhKDJTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 05:19:36 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7BAFE218B8;
        Thu,  4 Nov 2021 09:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1636017418; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cnmN7XsFGspLlK0PAiomJNKlrkssbDZe/ikrw5j15PU=;
        b=aUsnRBMHd0qPSKQxreO1VhHURoINKN6BAwu1IYILWzDrlsol7R+1NXtFSW4wridF2a798m
        7R84rQn1F4H+PKYjyirs+Begx2H7cJO/cor0SGQDGfuLKRYkRU6EhWjma39EH+iCriWBvX
        BTdfPYvCCa6JgxjWP8GNZdnl7NLwAm0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1636017418;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cnmN7XsFGspLlK0PAiomJNKlrkssbDZe/ikrw5j15PU=;
        b=0wp3IQzm4yDADf4Y84tG1P0SzsfZQrmqQc83vwCGDpo8pE4HrPCIDqSj7SrFu/KWKbN2Ln
        iDgxlyB+SVnpTdBg==
Received: from suse.de (unknown [10.163.32.246])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A0D9C2C157;
        Thu,  4 Nov 2021 09:16:56 +0000 (UTC)
Date:   Thu, 4 Nov 2021 09:16:54 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     Jimmy Shiu <jimmyshiu@google.com>
Cc:     mingo@redhat.com, joaodias@google.com, wvw@google.com,
        Minchan Kim <minchan@google.com>,
        Will McVicker <willmcvicker@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] SCHED: attribute page lock and waitqueue functions as
 sched
Message-ID: <20211104091654.GV3891@suse.de>
References: <20211103184708.1778294-1-jimmyshiu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20211103184708.1778294-1-jimmyshiu@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2021 at 02:47:03AM +0800, Jimmy Shiu wrote:
> trace_sched_blocked_trace in CFS is really useful for debugging via
> trace because it tell where the process was stuck on callstack.
> 
> For example,
>            <...>-6143  ( 6136) [005] d..2    50.278987: sched_blocked_reason: pid=6136 iowait=0 caller=SyS_mprotect+0x88/0x208
>            <...>-6136  ( 6136) [005] d..2    50.278990: sched_blocked_reason: pid=6142 iowait=0 caller=do_page_fault+0x1f4/0x3b0
>            <...>-6142  ( 6136) [006] d..2    50.278996: sched_blocked_reason: pid=6144 iowait=0 caller=SyS_prctl+0x52c/0xb58
>            <...>-6144  ( 6136) [006] d..2    50.279007: sched_blocked_reason: pid=6136 iowait=0 caller=vm_mmap_pgoff+0x74/0x104
> 
> However, sometime it gives pointless information like this.
>     RenderThread-2322  ( 1805) [006] d.s3    50.319046: sched_blocked_reason: pid=6136 iowait=1 caller=__lock_page_killable+0x17c/0x220
>      logd.writer-594   (  587) [002] d.s3    50.334011: sched_blocked_reason: pid=6126 iowait=1 caller=wait_on_page_bit+0x194/0x208
>   kworker/u16:13-333   (  333) [007] d.s4    50.343161: sched_blocked_reason: pid=6136 iowait=1 caller=__lock_page_killable+0x17c/0x220
> 

/me peers at coffee

Maybe I'm blind but aside from Matthew's concerns, this
appears to rely on an Android patch that is not upstream
https://android.googlesource.com/kernel/msm/+/c9f00aa0e25e397533c198a0fcf6246715f99a7b%5E!/

-- 
Mel Gorman
SUSE Labs
