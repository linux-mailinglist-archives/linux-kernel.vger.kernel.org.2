Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47E9F37980E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 21:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbhEJT6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 15:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbhEJT6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 15:58:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEFEFC061574
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 12:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1Kb38thZlbl33NciqGP4Ww1F/3vhXvHqKbnItEFr8wc=; b=XfONCcyx7NKtkbmdJHx54H0AvU
        GdvfPFweatTjTbhL2RbxGz15j87DKjGy3BmPobPwOcZNR0/TV5MrKlI8RGNVUCT8EnpSGyS17mY1Z
        MIiXBxYDMWGrUuCyONvBgOVKMZoTWDOpy7TgXXVuebLQ0EwXBLmk0fKK2AOLLHZJV7Yi74WHMoWHM
        3vwoXH2YLZQQMvkxCTvO/vdXXEt85Hj4JJp59V/hlaPyri7fDtjTXTKnLBMWCILxAvVBRB1hsfG0q
        P+RAqHsQhm397mc3JyTwlqE6jGaslwy+cOnCrQS0eXqZK+eH1F2HxHsYRh1d81VCVoWwmXI/wYBsd
        JcGtNrrw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lgC1O-006WlH-V3; Mon, 10 May 2021 19:57:00 +0000
Date:   Mon, 10 May 2021 20:56:54 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michel Lespinasse <michel@lespinasse.org>
Subject: Re: [PATCH] mm/mmap: Introduce unlock_range() for code cleanup
Message-ID: <YJmQBp9r5UgvQiWr@casper.infradead.org>
References: <20210510195020.2778501-1-Liam.Howlett@Oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210510195020.2778501-1-Liam.Howlett@Oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 07:50:22PM +0000, Liam Howlett wrote:
> Both __do_munmap() and exit_mmap() unlock a range of VMAs using almost
> identical code blocks.  Replace both blocks by a static inline function.
> 
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

> +static inline void unlock_range(struct vm_area_struct *start, unsigned long limit)

Seems like an unnecessary >80 column line ...

static inline
void unlock_range(struct vm_area_struct *start, unsigned long limit)

