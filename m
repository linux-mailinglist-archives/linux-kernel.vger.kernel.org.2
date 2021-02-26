Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F19793268F6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 21:54:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbhBZUwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 15:52:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbhBZUwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 15:52:33 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30184C061574
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 12:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+udi+amsuo05IzVe+P9jhzY7ydKiUiOHNE7tYtPijPo=; b=ltlrfKs/tgZ+46eyE+BCDfcOCA
        J7sUTEbAy8u8GPVXJccQYwlZhFGRrVORtpHlHks86G1tlin3p59e3/ktqx0wrS0ACz/jYWQ8HI0z7
        n0axc0QzaKGM2mcAAorWuF5uV8szCENe4rFvjMO/FFgu2FdNtDWLm135bq/WbuL6VmFoXXd29gRmD
        b/wF9uWCrtVgzHcHlh+lq+2q5OQKhacw6WGgJCXbpPvVoU1bJf1Eur3yO6ICpVQ1pENRQ95SjS0Df
        Xy/Ia17eYdw/0k2eDBDdRKL258S+VZE8l3+RAtmucbmUCxzPoDH7ftwuOESeneQvafc/Xc/WD6Bwi
        CDdOU5iw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lFk5L-00CUjl-2O; Fri, 26 Feb 2021 20:51:41 +0000
Date:   Fri, 26 Feb 2021 20:51:39 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] Fix zero_user_segments() with start > end
Message-ID: <20210226205139.GI2723601@casper.infradead.org>
References: <87eeh2erm0.fsf@mail.parknet.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87eeh2erm0.fsf@mail.parknet.co.jp>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 27, 2021 at 01:11:35AM +0900, OGAWA Hirofumi wrote:
> zero_user_segments() is used from __block_write_begin_int(), for
> example like the following
> 
> 	zero_user_segments(page, 4096, 1024, 512, 918)
> 
> But new zero_user_segments() implements for HIGMEM + TRANSPARENT_HUGEPAGE 
> doesn't handle "start > end" case correctly, and hits BUG_ON(). (we
> can fix __block_write_begin_int() instead though, it is the old and
> multiple usage)

Why don't we just take out the BUG_ON instead?  The function doesn't
actually do the wrong thing.

> Also it calls kmap_atomic() unnecessary while start == end == 0.

I'm OK with that.  It always used to do that.

> Cc: <stable@vger.kernel.org>
> Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

Fixes: 0060ef3b4e6d ("mm: support THPs in zero_user_segments")

