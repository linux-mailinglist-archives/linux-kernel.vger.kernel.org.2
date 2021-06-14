Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71E613A5BC3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 05:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232332AbhFNDJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 23:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232302AbhFNDJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 23:09:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4237DC061766
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jun 2021 20:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JHrnyC6e0QERmPWlioeyQvVVGt7nsW+8Fii9fRqjx6A=; b=JC4not4aVvO20tRDG+g6nIS/T2
        mSB/+INjffV+cNeT7w1QFHtil1GsZdhqN91noq1Q8SU17K/q/QPjg34GycdB2vlX2hc4KjDmkTFtV
        du1mtR74UnGUcVS0+GScnbkLIpXMmVMNnfrsqDIdQNMaaQkRua2KN0GtzY2zJ7d1UKmMQkDUqKysD
        TGKpCEKma/1U1DPa0RnM4AdzOgTzyRoouzk71BPkzbu6jREJDKr3zmStDJmg58pLaR30v577Y8ddA
        9k54hqYfPfJQinDyNtEud0UDoDbvg3OXtvXPdO0C6HSb9VIQwQM87Qu5sNUvHeS59rVH6RMgZX5jZ
        qU2j0ITA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lscvo-004yby-EC; Mon, 14 Jun 2021 03:06:33 +0000
Date:   Mon, 14 Jun 2021 04:06:32 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Ding Hui <dinghui@sangfor.com.cn>,
        Tony Luck <tony.luck@intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/6] mm/hwpoison: introduce MF_MSG_PAGETABLE
Message-ID: <YMbHuOdObj3GtHqV@casper.infradead.org>
References: <20210614021212.223326-1-nao.horiguchi@gmail.com>
 <20210614021212.223326-4-nao.horiguchi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210614021212.223326-4-nao.horiguchi@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2021 at 11:12:09AM +0900, Naoya Horiguchi wrote:
> +++ v5.13-rc5_patched/include/ras/ras_event.h
> @@ -357,6 +357,7 @@ TRACE_EVENT(aer_event,
>  	EM ( MF_MSG_KERNEL, "reserved kernel page" )			\
>  	EM ( MF_MSG_KERNEL_HIGH_ORDER, "high-order kernel page" )	\
>  	EM ( MF_MSG_SLAB, "kernel slab page" )				\
> +	EM ( MF_MSG_PAGETABLE, "page table page page" )			\

Did you intend to double the word "page"?

> +++ v5.13-rc5_patched/mm/memory-failure.c
> @@ -708,6 +708,7 @@ static const char * const action_page_types[] = {
>  	[MF_MSG_KERNEL]			= "reserved kernel page",
>  	[MF_MSG_KERNEL_HIGH_ORDER]	= "high-order kernel page",
>  	[MF_MSG_SLAB]			= "kernel slab page",
> +	[MF_MSG_PAGETABLE]		= "page table page",

... you didn't here.
