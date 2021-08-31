Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1676F3FC884
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 15:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238446AbhHaNoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 09:44:15 -0400
Received: from outbound-smtp19.blacknight.com ([46.22.139.246]:44421 "EHLO
        outbound-smtp19.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239099AbhHaNoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 09:44:09 -0400
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp19.blacknight.com (Postfix) with ESMTPS id 82FDD1C3BC4
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 14:43:12 +0100 (IST)
Received: (qmail 29075 invoked from network); 31 Aug 2021 13:43:12 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 31 Aug 2021 13:43:12 -0000
Date:   Tue, 31 Aug 2021 14:43:11 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, vbabka@suse.cz, sfr@canb.auug.org.au,
        peterz@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] mm/page_alloc.c: avoid accessing uninitialized pcp
 page migratetype
Message-ID: <20210831134311.GG4128@techsingularity.net>
References: <20210830141051.64090-1-linmiaohe@huawei.com>
 <20210830141051.64090-6-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20210830141051.64090-6-linmiaohe@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2021 at 10:10:50PM +0800, Miaohe Lin wrote:
> If it's not prepared to free unref page, the pcp page migratetype is
> unset. Thus We will get rubbish from get_pcppage_migratetype() and
> might list_del &page->lru again after it's already deleted from the
> list leading to grumble about data corruption.
> 
> Fixes: 3dcbe270d8ec ("mm/page_alloc: avoid conflating IRQs disabled with zone->lock")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Acked-by: Mel Gorman <mgorman@techsingularity.net>

This fix is fairly important. Take this patch out and send it on its own
so it gets picked up relatively quickly. It does not belong in a series
that is mostly cosmetic cleanups.


-- 
Mel Gorman
SUSE Labs
