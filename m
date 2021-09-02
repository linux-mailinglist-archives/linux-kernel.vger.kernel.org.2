Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2113FEF17
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 16:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345396AbhIBOEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 10:04:38 -0400
Received: from outbound-smtp56.blacknight.com ([46.22.136.240]:45031 "EHLO
        outbound-smtp56.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234398AbhIBOEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 10:04:37 -0400
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp56.blacknight.com (Postfix) with ESMTPS id 721B9FB454
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 15:03:37 +0100 (IST)
Received: (qmail 4898 invoked from network); 2 Sep 2021 14:03:37 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 2 Sep 2021 14:03:37 -0000
Date:   Thu, 2 Sep 2021 15:03:36 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, vbabka@suse.cz, sfr@canb.auug.org.au,
        peterz@infradead.org, david@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] mm/page_alloc.c: fix obsolete comment in
 free_pcppages_bulk()
Message-ID: <20210902140336.GL4128@techsingularity.net>
References: <20210902121242.41607-1-linmiaohe@huawei.com>
 <20210902121242.41607-4-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20210902121242.41607-4-linmiaohe@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2021 at 08:12:40PM +0800, Miaohe Lin wrote:
> The second two paragraphs about "all pages pinned" and pages_scanned is
> obsolete. And There are PAGE_ALLOC_COSTLY_ORDER + 1 + NR_PCP_THP orders
> in pcp. So the same order assumption is not held now.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Acked-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs
