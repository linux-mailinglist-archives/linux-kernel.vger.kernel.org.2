Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0953A4B8F
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 02:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbhFLACs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 20:02:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:44954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230060AbhFLACo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 20:02:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E2907613C3;
        Sat, 12 Jun 2021 00:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1623456046;
        bh=EXvSHSawD5EP+Frh8RZr50LfY51+rl5iUmXUlmQ3PVA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tIUgpGHTbI8g9xmTcrlCFE8eoFsp1WcvRvKVLl8jrFTpfZ+uL5veyFljQhQXizWFV
         P+6rbO17nT0kpv++si/Qze32jb8rcUA7Oc7WqekTskH38ikvhhZmxTixtBn4opzukq
         yj9XCwXFkYzAbnQuYtpueR35aPKFj85HvoNxIjN0=
Date:   Fri, 11 Jun 2021 17:00:45 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     chengkaitao <pilgrimtao@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, smcdef@gmail.com,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH] mm: delete duplicate order checking, when stealing
 whole pageblock
Message-Id: <20210611170045.b79a238fa3fc4bc9e4cd1140@linux-foundation.org>
In-Reply-To: <20210611063834.11871-1-chengkaitao@didiglobal.com>
References: <20210611063834.11871-1-chengkaitao@didiglobal.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jun 2021 14:38:34 +0800 chengkaitao <pilgrimtao@gmail.com> wrote:

> From: chengkaitao <pilgrimtao@gmail.com>
> 
> 1. Already has (order >= pageblock_order / 2) here, we don't neet
> (order >= pageblock_order)
> 2. set function can_steal_fallback to inline
> 
> ...
>
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -2619,18 +2619,8 @@ static void change_pageblock_range(struct page *pageblock_page,
>   * is worse than movable allocations stealing from unmovable and reclaimable
>   * pageblocks.
>   */
> -static bool can_steal_fallback(unsigned int order, int start_mt)
> +static inline bool can_steal_fallback(unsigned int order, int start_mt)
>  {
> -	/*
> -	 * Leaving this order check is intended, although there is
> -	 * relaxed order check in next check. The reason is that
> -	 * we can actually steal whole pageblock if this condition met,
> -	 * but, below check doesn't guarantee it and that is just heuristic
> -	 * so could be changed anytime.
> -	 */
> -	if (order >= pageblock_order)
> -		return true;
> -
>  	if (order >= pageblock_order / 2 ||
>  		start_mt == MIGRATE_RECLAIMABLE ||
>  		start_mt == MIGRATE_UNMOVABLE ||

Well, that redundant check was put there deliberately, as the comment
explains.

The reasoning is perhaps a little dubious, but it seems that the
compiler has optimized away the redundant check anyway (your patch
doesn't alter code size).

