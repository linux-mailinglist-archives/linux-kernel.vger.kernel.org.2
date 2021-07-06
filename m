Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38C733BC8BE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 11:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbhGFJ7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 05:59:20 -0400
Received: from outbound-smtp08.blacknight.com ([46.22.139.13]:43235 "EHLO
        outbound-smtp08.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231181AbhGFJ7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 05:59:20 -0400
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp08.blacknight.com (Postfix) with ESMTPS id F0F321C34FD
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jul 2021 10:56:40 +0100 (IST)
Received: (qmail 25785 invoked from network); 6 Jul 2021 09:56:40 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.255])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 6 Jul 2021 09:56:40 -0000
Date:   Tue, 6 Jul 2021 10:56:39 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Wang Qing <wangqing@vivo.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        Qiang.Zhang@windriver.com
Subject: Re: [PATCH V2] mm: add GFP_ATOMIC flag after local_lock_irqsave
Message-ID: <20210706095639.GS3840@techsingularity.net>
References: <1625563471-3873-1-git-send-email-wangqing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <1625563471-3873-1-git-send-email-wangqing@vivo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 06, 2021 at 05:24:31PM +0800, Wang Qing wrote:
> prep_new_page() will allocate memory in some scenarios. 
> 
> Call Trace:
> __dump_stack lib/dump_stack.c:79 [inline]
> dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:96
> ___might_sleep.cold+0x1f1/0x237 kernel/sched/core.c:9153
> prepare_alloc_pages+0x3da/0x580 mm/page_alloc.c:5179
> __alloc_pages+0x12f/0x500 mm/page_alloc.c:5375
> alloc_pages+0x18c/0x2a0 mm/mempolicy.c:2272
> stack_depot_save+0x39d/0x4e0 lib/stackdepot.c:303
> save_stack+0x15e/0x1e0 mm/page_owner.c:120
> __set_page_owner+0x50/0x290 mm/page_owner.c:181
> prep_new_page mm/page_alloc.c:2445 [inline]
> __alloc_pages_bulk+0x8b9/0x1870 mm/page_alloc.c:5313
> 
> So we add GFP_ATOMIC and remove GFP_KERNEL flag.
> 
> Reported-and-tested-by: syzbot+b07d8440edb5f8988eea@syzkaller.appspotmail.com
> Signed-off-by: Wang Qing <wangqing@vivo.com>

This will pass in the wrong flags to kasan potentially and the wrong GFP
mask will be stored in page_owner->gfp_mask. If you think this is the
best approach, the flags should be set to GFP_ATOMIC at the places page
owner allocates memory (stack_depot_save?). The caveat there is that
page owner tracking may be impaired if the atomic allocations fail. That
brings us back to either disabling the bulk allocator if page owner
tracking is enabled or doing the enabling/disabling only when page owner
tracking is enabled and goto the point where pagesets.lock is taken and
PCP looked up with a comment stating that it incurs a performance
penalty that is acceptable when page owner tracking is on.

-- 
Mel Gorman
SUSE Labs
