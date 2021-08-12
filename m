Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6243EA332
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 12:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236620AbhHLK4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 06:56:36 -0400
Received: from outbound-smtp35.blacknight.com ([46.22.139.218]:36055 "EHLO
        outbound-smtp35.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236442AbhHLK4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 06:56:35 -0400
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp35.blacknight.com (Postfix) with ESMTPS id 58F9F1E45
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 11:56:09 +0100 (IST)
Received: (qmail 10232 invoked from network); 12 Aug 2021 10:56:09 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.255])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 12 Aug 2021 10:56:09 -0000
Date:   Thu, 12 Aug 2021 11:56:07 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Doug Berger <opendmb@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc: don't corrupt pcppage_migratetype
Message-ID: <20210812105607.GK6464@techsingularity.net>
References: <20210811182917.2607994-1-opendmb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20210811182917.2607994-1-opendmb@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2021 at 11:29:17AM -0700, Doug Berger wrote:
> When placing pages on a pcp list, migratetype values over
> MIGRATE_PCPTYPES get added to the MIGRATE_MOVABLE pcp list.
> 
> However, the actual migratetype is preserved in the page and
> should not be changed to MIGRATE_MOVABLE or the page may end
> up on the wrong free_list.
> 
> Fixes: df1acc856923 ("mm/page_alloc: avoid conflating IRQs disabled with zone->lock")
> Signed-off-by: Doug Berger <opendmb@gmail.com>

Oops, yes. The impact is that HIGHATOMIC or CMA pages getting bulk freed
from the PCP lists could potentially end up on the wrong buddy list.
There are various consequences but minimally NR_FREE_CMA_PAGES accounting
could get screwed up.

Thanks Doug

Acked-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs
