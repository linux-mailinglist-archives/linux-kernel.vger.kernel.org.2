Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 942A53C21B0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 11:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbhGIJlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 05:41:39 -0400
Received: from outbound-smtp31.blacknight.com ([81.17.249.62]:35739 "EHLO
        outbound-smtp31.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231494AbhGIJli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 05:41:38 -0400
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp31.blacknight.com (Postfix) with ESMTPS id 22FF9C0B38
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 10:38:54 +0100 (IST)
Received: (qmail 412 invoked from network); 9 Jul 2021 09:38:53 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.255])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 9 Jul 2021 09:38:53 -0000
Date:   Fri, 9 Jul 2021 10:38:52 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Yang Huan <link@vivo.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel@vivo.com,
        Uladzislau Rezki <urezki@gmail.com>
Subject: Re: [PATCH] mm/vmalloc: try alloc_pages_bulk first to get order 0
 pages fast
Message-ID: <20210709093852.GY3840@techsingularity.net>
References: <20210709092831.10602-1-link@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20210709092831.10602-1-link@vivo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 09, 2021 at 05:28:31PM +0800, Yang Huan wrote:
> Vmalloc may offen get pages by loop invoke alloc_pags, this is
> cost too much time in count watermark/cpuset or something.
> Let's just try alloc by alloc_pages_bulk, if failed, fullback in
> original path.
> 
> With my own test, simulate loop alloc_page and alloc_pages_bulk_array,
> get this:
> size		1M	10M	20M	30
> normal		44	1278	3665	5581
> test		34	889	2167	3300
> optimize	22%	30%	40%	40%
> And in my vmalloc top sort, zram/f2fs may alloc more than 20MB, so,
> It's worth to use alloc_pages_bulk.
> 
> Signed-off-by: Yang Huan <link@vivo.com>

Thanks. I suggest you take a look at the current merge window and check
if anything additional needs to be done after the vmalloc bulk allocation
by Uladzislau Rezki.

-- 
Mel Gorman
SUSE Labs
