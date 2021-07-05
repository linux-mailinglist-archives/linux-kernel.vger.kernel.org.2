Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 409A33BC110
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 17:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbhGEPlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 11:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233304AbhGEPlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 11:41:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 811C4C0A54D7
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jul 2021 08:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JT89CnNztpCRm65snzgKJDmEIG8nalFqjLQsFNStPn4=; b=CQHtJctBB09VUQakzJ4Zed/6+6
        2S4fgUhvBLr8kRtshzINIoCaVYZ0YeSX9k72rdH+zeF5RjO5uVwJFpEIz9F2RnGXfUxS2vpcYJm2p
        2ApDsBi1IVviZ0u0Q1u9DpMB2IJDTztTne1FeYdrQf/RLWAPdrTVdqNAzR298QU6GtKioXRo+KMmd
        QCqQiE7AhpySbr2VQR9RKCfTjsEAv8x9Rqztjl6jZmWssJ8rXpLcDbzOtxLtzACgR5V6LdfmkRgjO
        KIZ1NZSEZt5wfW6DcpeifPq8Hj0wJrA/SQouWKiEYPF8vBGmFZ4y6eO6uGUUdLPBLOxfnQdr0kdL9
        txtEHolA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m0Qag-00AMmO-JJ; Mon, 05 Jul 2021 15:33:10 +0000
Date:   Mon, 5 Jul 2021 16:32:58 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Christoph Hellwig <hch@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] mm/vmalloc: Use batched page requests in bulk-allocator
Message-ID: <YOMmKo1FMNz048zV@casper.infradead.org>
References: <20210705145547.41206-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210705145547.41206-1-urezki@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 05, 2021 at 04:55:47PM +0200, Uladzislau Rezki (Sony) wrote:
> +			if (gfpflags_allow_blocking(gfp))
> +				cond_resched();

How does one call vmalloc() with gfp flags that _don't_ allow blocking?
They have to allow a GFP_KERNEL allocation of the page tables.
So I think this should be an unconditional cond_resched().
