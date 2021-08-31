Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9B8C3FC865
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 15:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238446AbhHaNje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 09:39:34 -0400
Received: from outbound-smtp26.blacknight.com ([81.17.249.194]:55035 "EHLO
        outbound-smtp26.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238105AbhHaNj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 09:39:29 -0400
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp26.blacknight.com (Postfix) with ESMTPS id 8C6F9CAD17
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 14:38:32 +0100 (IST)
Received: (qmail 28652 invoked from network); 31 Aug 2021 13:38:32 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 31 Aug 2021 13:38:32 -0000
Date:   Tue, 31 Aug 2021 14:38:30 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, vbabka@suse.cz, sfr@canb.auug.org.au,
        peterz@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] mm/page_alloc.c: remove obsolete comment in
 free_pcppages_bulk()
Message-ID: <20210831133830.GE4128@techsingularity.net>
References: <20210830141051.64090-1-linmiaohe@huawei.com>
 <20210830141051.64090-4-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20210830141051.64090-4-linmiaohe@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2021 at 10:10:48PM +0800, Miaohe Lin wrote:
> It's also confusing now. Remove it.
> 

Why is the whole comment obsolete?

The second two paragraphs about "all pages pinned" and pages_scanned is
obsolete and can go but the first paragraph is valid.

-- 
Mel Gorman
SUSE Labs
