Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 654C83896D0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 21:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232137AbhESTfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 15:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232089AbhESTfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 15:35:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C015FC06175F
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 12:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wr3Ku9b6p1OcKYD36FL40EcvE+r2U3PE5PB9FmNodEs=; b=mPPtsrhsbyPiTB6GtS0B5RkZh6
        zT101ItlUS3Q3Eh8iqbahWXPa6CgN7YPLjar/KSdVp3ruNo1QXj8C4mugiTz6DhJQHL6MDtkNeMJp
        QUJaeZxa/pYXMXQ6ALaFbrBJYBGI1wLWEFRLPHrSk8DkdveV3Hl7ps/Ioz2eVF8xtq/An6CZn9zSV
        tMSw4QxJJp+I2/ll220djhSGcjOjBZwcJANSwqV7iyugpcKbna7VPFp8fuNcISO6VFN0ZtkA+QeO3
        gD6gI6TDwEuAtOa8EV03B4Y8Gky6P9nRuS8rsoEsc0FQhqUFL6QmGlVAMMRhNAXuopOK2Pn5/RSa9
        WvFWA4zA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1ljRwB-00FFDH-TK; Wed, 19 May 2021 19:33:13 +0000
Date:   Wed, 19 May 2021 20:32:59 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Aaron Tomlin <atomlin@redhat.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, vbabka@suse.cz,
        mhocko@suse.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/page_alloc: bail out on fatal signal during
 reclaim/compaction retry attempt
Message-ID: <YKVn69o1UizH0kJD@casper.infradead.org>
References: <20210519192321.3247175-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210519192321.3247175-1-atomlin@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2021 at 08:23:21PM +0100, Aaron Tomlin wrote:
> +++ b/mm/page_alloc.c
> @@ -4252,6 +4252,9 @@ should_compact_retry(struct alloc_context *ac, int order, int alloc_flags,
>  	if (!order)
>  		return false;
>  
> +	if (fatal_signal_pending(current))
> +		goto out;

I think 'goto out' will be confusing.  It'll output a tracepoint, which
isn't going to record that a fatal signal is pending, so it'll cause
some head scratching for someone looking through the traces.  I
think we should just return false here and skip the tracepoint.

But I'd defer to someone like Vlastimil or Michal who know this code far
better than I do.

