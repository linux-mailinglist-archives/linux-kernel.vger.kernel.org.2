Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7D38391E4A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 19:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234588AbhEZRmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 13:42:40 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:51472 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhEZRmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 13:42:39 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 268361FD29;
        Wed, 26 May 2021 17:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622050866; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ANZCgAVJTkGUpqDp4fC/2nwLSoD1Lxi4nB0Czr/Ru98=;
        b=ybr8mpJOKZhb6clAQ14ucbgY85c1gAWEc0Pq4S+2fiAJJODhZNz/7sU/d/ChYsEqWSlHBO
        7AysAhdNmR59awZvO86p/+tCRF8Ol3uEXNBV9aJQAX0mmnDeb4/uaVTd9+/ekLjqwrUbA6
        +QUHIO1orMa0G/bghEsdx/JeEEsmGHE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622050866;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ANZCgAVJTkGUpqDp4fC/2nwLSoD1Lxi4nB0Czr/Ru98=;
        b=1tqNz5Z3UPqOu8ZjjVpqyE/vWfdNkTaZEUpa4Vf7PMz+euLh3BnHOqD0Yx+hGA6PYa3ggr
        lEEhXEvx6VOYiuDg==
Received: from director2.suse.de (director2.suse-dmz.suse.de [192.168.254.72])
        by imap.suse.de (Postfix) with ESMTPSA id 0FD9311A98;
        Wed, 26 May 2021 17:41:06 +0000 (UTC)
Subject: Re: [PATCH 1/6] mm/page_alloc: Delete vm.percpu_pagelist_fraction
To:     Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Hillf Danton <hdanton@sina.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
References: <20210525080119.5455-1-mgorman@techsingularity.net>
 <20210525080119.5455-2-mgorman@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <7b821c1f-ecc2-5e09-3c06-a63945d697ea@suse.cz>
Date:   Wed, 26 May 2021 19:41:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210525080119.5455-2-mgorman@techsingularity.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/25/21 10:01 AM, Mel Gorman wrote:
> The vm.percpu_pagelist_fraction is used to increase the batch and high
> limits for the per-cpu page allocator (PCP). The intent behind the sysctl
> is to reduce zone lock acquisition when allocating/freeing pages but it has
> a problem. While it can decrease contention, it can also increase latency
> on the allocation side due to unreasonably large batch sizes. This leads
> to games where an administrator adjusts percpu_pagelist_fraction on the
> fly to work around contention and allocation latency problems.
> 
> This series aims to alleviate the problems with zone lock contention while
> avoiding the allocation-side latency problems. For the purposes of review,
> it's easier to remove this sysctl now and reintroduce a similar sysctl
> later in the series that deals only with pcp->high.
> 
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>
