Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04BAC38C5F9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 13:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbhEULtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 07:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbhEULs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 07:48:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4902EC061763
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 04:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7zi9Mu6WcsowR0XFLEPxmhm73QEFbxhQlh8Qiw0zCGA=; b=DQJS4wmrZMw88UhIzP8UpdE5Zt
        oENnC+faFOhr3f/cC+vrqBpwZ8by5m4fC5aiIzZ4HTBC18hjY7ptrH9T0z9nNzEnbrRuM73O1T1vF
        OHYGQTk6mzITPIASr5FgiKlzbGD4UhEZ82fyxowZ9YgtQLepwJfPyIUpJd1vTfWvKrxoIFMQySP8o
        vmaCISID4N+eXhyHEWAO5S4Ppppw9Ny5ytz0S3cP9Iqt2iCU1ayquCH0KLQs9wkTYUI+3SLHDWOza
        1ZEuarvxhfpal02MJtOLlqD7uR98O8Oww2jl89vZjoOxymT3LZ8HJmtoB665Y0X7HTS9yAHsYTBgz
        FBRs/1XA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lk3YX-00GvKt-G6; Fri, 21 May 2021 11:43:37 +0000
Date:   Fri, 21 May 2021 12:43:05 +0100
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
Subject: Re: [PATCH] mm/vmalloc: Fallback to a single page allocator
Message-ID: <YKecydxDtWLTDuKg@casper.infradead.org>
References: <20210521111033.2243-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210521111033.2243-1-urezki@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 01:10:33PM +0200, Uladzislau Rezki (Sony) wrote:
> +static inline unsigned int
> +vm_area_alloc_pages(gfp_t gfp, int nid, unsigned int page_order,
> +	unsigned long nr_small_pages, struct page **pages)

(at least) two tabs here, please, otherwise the argument list is at
the same indentation as the code which trips up my parser.  some people
like to match the opening bracket, but that always feels like more work
than it's worth.  fwiw, i'd format it like this:

static inline unsigned int vm_area_alloc_pages(gfp_t gfp, int nid,
		unsigned int order, unsigned long nr_pages, struct page **pages)
{
...

(yes, i renamed some of the variables there; overly long variable names
are painful)

The rest of the patch looks good.

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
