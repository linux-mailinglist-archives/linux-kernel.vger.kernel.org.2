Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89C353C794B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 23:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236200AbhGMV5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 17:57:42 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:53490 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234947AbhGMV5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 17:57:41 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id CB2C0228EE;
        Tue, 13 Jul 2021 21:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1626213289; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7m7U3YLQAoBrKCVRpaWup9niC4/1FuA9nV56j8TGzHo=;
        b=DrYgUv+Ff9O6RxojSf6OLXqqLzvojwJ+DJyZ/3F41l68R6zjiruWKazzGlx4BROIudOemu
        aumzmHISmjsVsAi3pvlVB2qpwrqqSTgTkBMEHQmeDMyArGBNQc+DRo0vvGnO+M26tDqnLM
        oeaNQxJqRqvZv3STvgfS8chw0E6Enwo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1626213289;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7m7U3YLQAoBrKCVRpaWup9niC4/1FuA9nV56j8TGzHo=;
        b=RhHSlIPleHyn9FITZ6aQA0EagBnzk1XfscKBPPvyOP7qB9KF4SfxzsabKViqeD7CEnIWyJ
        DxO5BBjM+iyDaVBg==
Received: from suse.de (unknown [10.163.43.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A9455A3B85;
        Tue, 13 Jul 2021 21:54:48 +0000 (UTC)
Date:   Tue, 13 Jul 2021 22:54:47 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [mm/vmalloc] 5c1f4e690e:
 BUG:sleeping_function_called_from_invalid_context_at_mm/page_alloc.c
Message-ID: <20210713215447.GA3741@suse.de>
References: <20210713142414.GA28943@xsang-OptiPlex-9020>
 <CAHk-=wiDif7SvA5DOWj9ssDuYHC4ujUFPd7ad-ydhY-WMLb-kQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAHk-=wiDif7SvA5DOWj9ssDuYHC4ujUFPd7ad-ydhY-WMLb-kQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2021 at 11:19:29AM -0700, Linus Torvalds wrote:
> On Tue, Jul 13, 2021 at 7:06 AM kernel test robot <oliver.sang@intel.com> wrote:
> >
> > [  131.014885] BUG: sleeping function called from invalid context at mm/page_alloc.c:4992
> 
> Strange. The call chain doesn't actually seem to be anything off: it's
> writev -> sock_write_iter -> sock_sendmsg -> netlink_sendmsg ->
> vmalloc.
> 
> All good to sleep as far as I can tell. The warning itself seems to be just
> 
>         might_sleep_if(gfp_mask & __GFP_DIRECT_RECLAIM);
> 
> in prepare_alloc_pages().
> 
> I don't see what's wrong with that commit, but it does seem to be very
> consistent, in that the parent doesn't have it:
> 

It's almost certainly going to be fixed by
https://lore.kernel.org/r/20210713152100.10381-2-mgorman@techsingularity.net
whenever it hits your tree as part of this series
https://lore.kernel.org/lkml/20210713152100.10381-1-mgorman@techsingularity.net/.
It should make its way through Andrew's tree before RC2 but if he is busy
I'll create a git pull request.

> which means that the might_sleep_if() happens _after_
> __alloc_pages_bulk() has disabled interrupts. That would explain it,
> but the stack_depot_save() thing actually makes that call chain really
> hard to read because it duplicates the addresses on the stack.
> 
> I don't see the nesting there, but that's what it kind of smells like to me.
> 
> Anybody?
> 

The problem is that PAGE_OWNER can recurse allocate from bulk allocation
context to store the caller stack. When I wrote the patch, I missed that
prep_new_page can allocate if PAGE_OWNER is active. The most relevant
part of the trace is

[  131.092667]  stack_depot_save+0x390/0x4c0

-- 
Mel Gorman
SUSE Labs
