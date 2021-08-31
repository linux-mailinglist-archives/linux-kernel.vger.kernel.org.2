Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF3C3FC857
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 15:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237960AbhHaNg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 09:36:59 -0400
Received: from outbound-smtp50.blacknight.com ([46.22.136.234]:40503 "EHLO
        outbound-smtp50.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237198AbhHaNg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 09:36:56 -0400
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp50.blacknight.com (Postfix) with ESMTPS id 352BCFA9A9
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 14:36:00 +0100 (IST)
Received: (qmail 1053 invoked from network); 31 Aug 2021 13:35:59 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 31 Aug 2021 13:35:59 -0000
Date:   Tue, 31 Aug 2021 14:35:58 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, vbabka@suse.cz, sfr@canb.auug.org.au,
        peterz@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] mm/page_alloc.c: simplify the code by using macro K()
Message-ID: <20210831133558.GD4128@techsingularity.net>
References: <20210830141051.64090-1-linmiaohe@huawei.com>
 <20210830141051.64090-3-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20210830141051.64090-3-linmiaohe@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2021 at 10:10:47PM +0800, Miaohe Lin wrote:
> Use helper macro K() to convert the pages to the corresponding size.
> Minor readability improvement.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Acked-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs
