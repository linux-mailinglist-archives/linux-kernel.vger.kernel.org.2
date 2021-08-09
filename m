Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 294203E400E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 08:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233322AbhHIGcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 02:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233310AbhHIGcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 02:32:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82A8C061798
        for <linux-kernel@vger.kernel.org>; Sun,  8 Aug 2021 23:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OYrmxkbgyCtkM5MBp6xZVs6ZxMYa8f0w2YvZIHffc6k=; b=RI8fbF2ySxTiNEVkvCuWq95mcF
        wVUGTUP7Te52y/0USuDmD51ryTx49KB8nCwFDgne1LaYSxpU+I7uw7vSNUViBS5CAdaP4Ur4kBVup
        omn3WfzNdp+oigU+GFu1A7CaRCPcePCRPZuIQ7ibws0Qe+4JyWyTY28goY95u3/zfV9qTDVpfyI+b
        wAVk0aQBCf9IaAw7t+c1AruEcle50va+8q0G338BmpdMm7NUFgZJqHjzTyS2GGzkvqHRHio7ibEps
        u1ZMlbFL6xFwRbGPNq5jeO0ZKefl3PUjrOvDEuVcx5P4Qybnhre+jSmgPHKWUVwzkMvOmMOoUl3I7
        CI+bT/KA==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mCynP-00AheP-VD; Mon, 09 Aug 2021 06:30:07 +0000
Date:   Mon, 9 Aug 2021 07:29:59 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH 3/3] mm/gup: refactor and simplify try_get_page()
Message-ID: <YRDLZ5SBm76FByy1@infradead.org>
References: <20210808235018.1924918-1-jhubbard@nvidia.com>
 <20210808235018.1924918-4-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210808235018.1924918-4-jhubbard@nvidia.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 08, 2021 at 04:50:18PM -0700, John Hubbard wrote:
> +/*
> + * This has the same functionality as try_get_compound_head(), just with a
> + * slightly different API.
> + */
>  static inline __must_check bool try_get_page(struct page *page)
>  {
> +	return try_get_compound_head(page, 1) != NULL;

What about removing try_get_page entirely instead?

