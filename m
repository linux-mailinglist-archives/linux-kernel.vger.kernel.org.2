Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 699523CF705
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 11:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233007AbhGTI7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 04:59:02 -0400
Received: from outbound-smtp49.blacknight.com ([46.22.136.233]:41981 "EHLO
        outbound-smtp49.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229675AbhGTI7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 04:59:01 -0400
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp49.blacknight.com (Postfix) with ESMTPS id 0B060FB580
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 10:39:39 +0100 (IST)
Received: (qmail 29527 invoked from network); 20 Jul 2021 09:39:38 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.255])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 20 Jul 2021 09:39:38 -0000
Date:   Tue, 20 Jul 2021 10:39:37 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     akpm@linux-foundation.org, shy828301@gmail.com,
        cuibixuan@huawei.com, vbabka@suse.cz, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: mmap_lock: fix disabling preemption directly
Message-ID: <20210720093937.GV3809@techsingularity.net>
References: <20210720074228.76342-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20210720074228.76342-1-songmuchun@bytedance.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 20, 2021 at 03:42:28PM +0800, Muchun Song wrote:
> The commit 832b50725373 ("mm: mmap_lock: use local locks instead of
> disabling preemption") fix a bug by using local locks. But commit
> d01079f3d0c0 ("mm/mmap_lock: remove dead code for !CONFIG_TRACING
> configurations") changes those lines to original version. I guess
> it is introduced by the conflicts fixing on merging.
> 
> Fixes: d01079f3d0c0 ("mm/mmap_lock: remove dead code for !CONFIG_TRACING configurations")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Acked-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs
