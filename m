Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51BCA3978D4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 19:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234465AbhFARNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 13:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231918AbhFARNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 13:13:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E304C061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 10:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NPf5x5gUIVGWbZsyHctHSrCy7CgzrGDQAuJK0Pfsp3Y=; b=WlE4PI42i6Y6aDb/sYuOCvJ1gY
        RfLnhnWbAfBudWuf90hOxdqLJhVGrsOBAxt3Mgi/HNcUps/2Ki5MDTRa6FSqnfnH6uGhQb9a+eXfi
        6D6szn2br23LVELB59uzFnC3B6jYRDoIU+VM8xIeNFkkGkEaHyeV7NlGZTTcAbc5lbbyKbgDU6QpC
        RrEtd2GgWcxzRmoWJfDYAU9vyTS+4R9kjyx+I5fBeR6KAyXmfIVLBrCcuFZBhCvl0lxz3LebseLXG
        zNNI5twSQdFutcu+ImqvVCTTTJnftTiWA/Q+LglDxAiM4YWs7hT/MCxhVXr4KsMBJLaZKma1Srch+
        TtlFl8aQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lo7uy-00AEsQ-Pn; Tue, 01 Jun 2021 17:11:06 +0000
Date:   Tue, 1 Jun 2021 18:11:04 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Xu Yu <xuyu@linux.alibaba.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        gavin.dg@linux.alibaba.com, Greg Thelen <gthelen@google.com>,
        Wei Xu <weixugc@google.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm, thp: relax migration wait when failed to get tail
 page
Message-ID: <YLZqKJ4anEGpAZfp@casper.infradead.org>
References: <bc8567d7a2c08ab6fdbb8e94008157265d5d28a3.1622564942.git.xuyu@linux.alibaba.com>
 <alpine.LSU.2.11.2106010947370.1090@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2106010947370.1090@eggly.anvils>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2021 at 09:55:56AM -0700, Hugh Dickins wrote:
> On Wed, 2 Jun 2021, Xu Yu wrote:
> 
> > We notice that hung task happens in a conner but practical scenario when
> > CONFIG_PREEMPT_NONE is enabled, as follows.
> > 
> > Process 0                       Process 1                     Process 2..Inf
> > split_huge_page_to_list
> >     unmap_page
> >         split_huge_pmd_address
> >                                 __migration_entry_wait(head)
> >                                                               __migration_entry_wait(tail)
> >     remap_page (roll back)
> >         remove_migration_ptes
> >             rmap_walk_anon
> >                 cond_resched
> > 
> > Where __migration_entry_wait(tail) is occurred in kernel space, e.g.,
> > copy_to_user, which will immediately fault again without rescheduling,
> > and thus occupy the cpu fully.
> > 
> > When there are too many processes performing __migration_entry_wait on
> > tail page, remap_page will never be done after cond_resched.
> > 
> > This relaxes __migration_entry_wait on tail page, thus gives remap_page
> > a chance to complete.
> > 
> > Signed-off-by: Gang Deng <gavin.dg@linux.alibaba.com>
> > Signed-off-by: Xu Yu <xuyu@linux.alibaba.com>
> 
> Well caught: you're absolutely right that there's a bug there.
> But isn't cond_resched() just papering over the real bug, and
> what it should do is a "page = compound_head(page);" before the
> get_page_unless_zero()? How does that work out in your testing?

You do realise you're strengthening my case for folios by suggesting
that, don't you?  ;-)

I was going to suggest that it won't make any difference because the
page reference count is frozen, but the freezing happens after the call
to unmap_page(), so it may make a difference.

