Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3776544429A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 14:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbhKCNpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 09:45:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:50422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230152AbhKCNpL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 09:45:11 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85BFF61051;
        Wed,  3 Nov 2021 13:42:34 +0000 (UTC)
Date:   Wed, 3 Nov 2021 09:42:32 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, mingo@redhat.com, ziy@nvidia.com,
        shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 3/3] mm: compaction: Fix the migration stats in
 trace_mm_compaction_migratepages()
Message-ID: <20211103094232.32a14cf0@gandalf.local.home>
In-Reply-To: <6fac1a89862b6a8bda4314d1f51380862a6fa986.1635936218.git.baolin.wang@linux.alibaba.com>
References: <cover.1635936218.git.baolin.wang@linux.alibaba.com>
        <6fac1a89862b6a8bda4314d1f51380862a6fa986.1635936218.git.baolin.wang@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  3 Nov 2021 18:51:16 +0800
Baolin Wang <baolin.wang@linux.alibaba.com> wrote:

> @@ -2398,10 +2399,10 @@ bool compaction_zonelist_suitable(struct alloc_context *ac, int order,
>  
>  		err = migrate_pages(&cc->migratepages, compaction_alloc,
>  				compaction_free, (unsigned long)cc, cc->mode,
> -				MR_COMPACTION, NULL);
> +				MR_COMPACTION, &nr_succeeded);
>  
> -		trace_mm_compaction_migratepages(cc->nr_migratepages, err,
> -							&cc->migratepages);
> +		trace_mm_compaction_migratepages(cc->nr_migratepages,
> +						 nr_succeeded);

Also, I'm surprised you don't just pass in 'cc' and do the dereferencing in
the trace event macro. Accessing the pointers from the trace event and not
dereferencing them to the tracepoint function moves the changes out of line
here and helps with I$.

You could improve some of the other tracepoints that dereference 'cc' as
well in that file.

But as for this change, I'm good with it.

For the tracing aspect:

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve


>  
>  		/* All pages were either migrated or will be released */
>  		cc->nr_migratepages = 0;
