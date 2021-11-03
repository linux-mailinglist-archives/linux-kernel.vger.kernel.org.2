Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE2304448CC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 20:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbhKCTRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 15:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbhKCTRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 15:17:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B275C061714
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 12:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=umVR0keNkS2UpdTDJLTibW+h8rMr6o3BNZfkH6UmL48=; b=pyjGUN2BuGsm3EgukKxwqY7GOJ
        HrXc37aP07LX0ODtwW+vxnF5VaNhP481iARxy4xGWWosUjZ7N6898ensPPRHcILwf5JtPu/mmmeZD
        KIzbOwe8LSoBqDIVWiUBkBPsA6WjhislKnkUe9chTSBczWdABUK9+7ZZi4VQjbm28gBZvf70yuSXQ
        4C7lCluyldy68qY64OpICWAH2iKaCEDhOEUBavktWjZnaMdRf96mYXNWsDtJJrFy5LsYHQSPV23mh
        ZOw3vRscEr8qc0e2vZsvwsAZcWqU5k5ZPFe0676Syf/Mb7dUTYloyUONcpMigGWbNZ6zbcV7VLbQT
        tlJENPTg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1miLee-005Pgd-ST; Wed, 03 Nov 2021 19:11:06 +0000
Date:   Wed, 3 Nov 2021 19:10:36 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Jimmy Shiu <jimmyshiu@google.com>
Cc:     mingo@redhat.com, joaodias@google.com, wvw@google.com,
        Minchan Kim <minchan@google.com>,
        Will McVicker <willmcvicker@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] SCHED: attribute page lock and waitqueue functions as
 sched
Message-ID: <YYLerEPg02MpQFWs@casper.infradead.org>
References: <20211103184708.1778294-1-jimmyshiu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211103184708.1778294-1-jimmyshiu@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2021 at 02:47:03AM +0800, Jimmy Shiu wrote:
> +++ b/mm/filemap.c
> @@ -1271,7 +1271,7 @@ static inline bool folio_trylock_flag(struct folio *folio, int bit_nr,
>  /* How many times do we accept lock stealing from under a waiter? */
>  int sysctl_page_lock_unfairness = 5;
>  
> -static inline int folio_wait_bit_common(struct folio *folio, int bit_nr,
> +static inline __sched int folio_wait_bit_common(struct folio *folio, int bit_nr,

It's not clear to me whether folio_wait_bit_common() needs to be marked
as __sched or whether marking its callers is sufficient, but I'm pretty
sure you forgot to mark put_and_wait_on_page_locked() as __sched, which
is an important one as it's now where we wait for readahead to finish
when reading a file.

