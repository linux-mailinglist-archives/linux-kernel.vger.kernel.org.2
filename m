Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 259A3424FDC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 11:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240498AbhJGJRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 05:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbhJGJRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 05:17:32 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B58CC061746
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 02:15:39 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id z11so13985394lfj.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 02:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VauanTdZv3UHgHwISg3C/HfE8zoLg5XgnlLh83CWG9w=;
        b=E2OAB6TTPYTlDL0meHUx7URBdK8B6piIaknNEV73WUz4yAFaha46PnPUQyXeklJYI/
         SH3gu4mQIi6a6/1PU6/tlybRvtvkVgAFz4peVCNs2BgCWWhMAUs1SvOg438J4FQ6caOE
         FCYl+HSTT2J02uzrjHqrH3NaOZog2IQi1cIrH3Rlz3hFic9ABW0cCytjvTTXvAEJ1FpK
         UqscY49IEJp15SngF4FXDwDQgNDD1Xyxrx3sesiwo7Khq08Q0QW6lFoYuBssPRBeLlB9
         4eNuG9rmyOUrmlyRBHAHTJCeSbl7T2l8PC1Fu8m57njMvwQzfIElGDXo87dmjNDQgip/
         a7PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VauanTdZv3UHgHwISg3C/HfE8zoLg5XgnlLh83CWG9w=;
        b=Dj/cP4z+Vvf9Ha3pORliHFlKNen7oZyBb2hV2mJZmb/VC0V6OkcAzdbAKVusRq84sX
         TBA/kUIQr846pDpGGBQGiLQ5RBtrnTR30lvE1B+3Fb2Qp+ZWxw8Xldp9E+PwHIpnBU6B
         xyhy0VPzBM4PJ5MoeMRPNBvmPs1/DJWuvd48uqyx+Hg/APoeq2+F3Mzl0w1bj3noytZP
         pVSZS/szvZ5vyete+jmFBKGM2IQMGTYlY0nbmGU6jxecyRMVoOt/skZv5BMO1Zoqs9+6
         +otVj9jyphG3QSq/3vY2F3DfYg7uMw7ZzrLolVsZFkE0NAbx68fvlYN+ZpqUGQN9MpbA
         DLvg==
X-Gm-Message-State: AOAM533dF6u7CxYtZQ/UyDy8VojRRxPGOX7jFHcLGckKRgTX0TgRIHPx
        KEh+IkaRpy/CGBuYPP8WCVrtOg==
X-Google-Smtp-Source: ABdhPJzupbqgpetrQi3zSxVLO8EW0giR+9i3oadppQRYscjz5KhGI4kOosqfLtCZPUk2P2vxrJetJQ==
X-Received: by 2002:a05:6512:398b:: with SMTP id j11mr3005311lfu.529.1633598137145;
        Thu, 07 Oct 2021 02:15:37 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id s17sm1637867lfe.10.2021.10.07.02.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 02:15:36 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 335451030EC; Thu,  7 Oct 2021 12:15:35 +0300 (+03)
Date:   Thu, 7 Oct 2021 12:15:35 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Kent Overstreet <kent.overstreet@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        hannes@cmpxchg.org, willy@infradead.org, rientjes@google.com
Subject: Re: Compaction & folios
Message-ID: <20211007091535.7ocsvylljmfva2fy@box.shutemov.name>
References: <YV4o9SxfYuLm1i4d@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YV4o9SxfYuLm1i4d@moria.home.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2021 at 06:53:41PM -0400, Kent Overstreet wrote:
> So I have some observations on memory compaction & hugepages.
> 
> Right now, the working assumption in MM is that compaction is hard and
> expensive, and right now it is - because most allocations are order 0, with a
> small subset being hugepage order allocations. This means any time we need a
> hugepage, compaction has to move a bunch of order 0 pages around, and memory
> reclaim is no help here - when we reclaim memory, it's coming back as fragmented
> order 0 pages.
> 
> But what if compaction wasn't such a difficult, expensive operation?
> 
> With folios, and then folios for anonymous pages, we won't see nearly so many
> order 0 allocations anymore - we'll see a spread of allocation sizes based on a
> mixture of application usage patterns - something much closer to a poisson
> distribution, vs. our current very bimodal distribution. And since we won't be
> fragmenting all our allocations up front, memory reclaim will be freeing
> allocations in this same distribution.
> 
> Which means that any time an order n allocation fails, it's likely that we'll
> still have order n-1 pages free - and of those free order n-1 pages, one will
> likely have a buddy that's moveable and hasn't been fragmented - meaning the
> common case is that compaction will have to move _one_ (higher order) page -
> we'll almost never be having to move a bunch of 4k pages.
> 
> Another way of thinking of this is that memory reclaim will be doing most of the
> work that compaction has to do now to allocate a high order page. Compaction
> will go from an expensive, somewhat unreliable operation to one that mostly just
> works - it's going to be _much_ less of a pain point.
> 
> It may turn out that allocating hugepages still doesn't work as reliably as we'd
> like - but folios are still a big help even when we can't allocate a 2MB page,
> because we'll be able to fall back to an order 6 or 7 or 8 allocation, which is
> something we can't do now. And, since multiple CPU vendors now support
> coalescing contiguous PTE entries in the TLB, this will still get us most of the
> performance benefits of using hugepages.

Compaction at the moment built with assumption that compound pages are
PMD-mappable or larger and it doesn't make sense to move them:

		/*
		 * Regardless of being on LRU, compound pages such as THP and
		 * hugetlbfs are not to be compacted unless we are attempting
		 * an allocation much larger than the huge page size (eg CMA).
		 * We can potentially save a lot of iterations if we skip them
		 * at once. The check is racy, but we can consider only valid
		 * values and the only danger is skipping too much.
		 */
		if (PageCompound(page) && !cc->alloc_contig) {
			const unsigned int order = compound_order(page);

			if (likely(order < MAX_ORDER))
				low_pfn += (1UL << order) - 1;
			goto isolate_fail;
		}

It also will apply to folios with direct conversion.

It has to be reworked sooner rather than later if we want to be more
flexible on size of folios or we are risking getting compaction situation
worse.

-- 
 Kirill A. Shutemov
