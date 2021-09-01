Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AFDF3FDE4E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 17:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245738AbhIAPPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 11:15:12 -0400
Received: from outbound-smtp30.blacknight.com ([81.17.249.61]:60877 "EHLO
        outbound-smtp30.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245569AbhIAPPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 11:15:11 -0400
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp30.blacknight.com (Postfix) with ESMTPS id BEDA7BAF3F
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 16:14:13 +0100 (IST)
Received: (qmail 19088 invoked from network); 1 Sep 2021 15:14:13 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 1 Sep 2021 15:14:13 -0000
Date:   Wed, 1 Sep 2021 16:14:11 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, vbabka@suse.cz, sfr@canb.auug.org.au,
        peterz@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] mm/page_alloc.c: remove obsolete comment in
 free_pcppages_bulk()
Message-ID: <20210901151411.GH4128@techsingularity.net>
References: <20210830141051.64090-1-linmiaohe@huawei.com>
 <20210830141051.64090-4-linmiaohe@huawei.com>
 <20210831133830.GE4128@techsingularity.net>
 <884a4b72-95ab-0fca-6c74-d67535048736@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <884a4b72-95ab-0fca-6c74-d67535048736@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2021 at 03:49:03PM +0800, Miaohe Lin wrote:
> On 2021/8/31 21:38, Mel Gorman wrote:
> > On Mon, Aug 30, 2021 at 10:10:48PM +0800, Miaohe Lin wrote:
> >> It's also confusing now. Remove it.
> >>
> > 
> > Why is the whole comment obsolete?
> > 
> > The second two paragraphs about "all pages pinned" and pages_scanned is
> > obsolete and can go but the first paragraph is valid.
> > 
> 
> I think the first paragraph is invalid due to the below statement:
> "Assumes all pages on list are in same zone, and of same order."
> There are NR_PCP_LISTS lists and PAGE_ALLOC_COSTLY_ORDER + 1 + NR_PCP_THP
> orders in pcp. So I think it's obsolete.
> 

Ah.

> Should I delete this statement in the first paragraph only?
> 

Remove ", and of same order"

-- 
Mel Gorman
SUSE Labs
