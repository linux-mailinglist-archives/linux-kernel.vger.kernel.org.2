Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD243FC84C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 15:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235830AbhHaNfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 09:35:11 -0400
Received: from outbound-smtp50.blacknight.com ([46.22.136.234]:42519 "EHLO
        outbound-smtp50.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230385AbhHaNfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 09:35:08 -0400
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp50.blacknight.com (Postfix) with ESMTPS id 4E26EFA9A1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 14:34:12 +0100 (IST)
Received: (qmail 12446 invoked from network); 31 Aug 2021 13:34:12 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 31 Aug 2021 13:34:12 -0000
Date:   Tue, 31 Aug 2021 14:34:10 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, vbabka@suse.cz, sfr@canb.auug.org.au,
        peterz@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] mm/page_alloc.c: remove meaningless VM_BUG_ON() in
 pindex_to_order()
Message-ID: <20210831133410.GC4128@techsingularity.net>
References: <20210830141051.64090-1-linmiaohe@huawei.com>
 <20210830141051.64090-2-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20210830141051.64090-2-linmiaohe@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2021 at 10:10:46PM +0800, Miaohe Lin wrote:
> It's meaningless to VM_BUG_ON() order != pageblock_order just after
> setting order to pageblock_order. Remove it.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Acked-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs
