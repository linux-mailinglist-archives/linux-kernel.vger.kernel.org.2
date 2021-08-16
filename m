Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF3463EDDF9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 21:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbhHPTjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 15:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbhHPTje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 15:39:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27098C061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 12:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HK2ZFnceD4MGP7RS84uFdlWNKcf4FPa/uPZZD88rUwE=; b=i/cQTEecxY0aNKFZ/qiSS1T0SJ
        q4fsdo7Fk3fjAY0WPvrRjEjAigTJiDVUVSZAd8ycyK7H0i/Ks+Gdhl+cLtlG8nhR93oH9lFe3xo6o
        K+SQrcL1uyHD6V4ouKsDorVrwt8Mk3rge5QaMfoMLpD7hNjhJSaTdW+/MfrCRmy+zP7lDVs6f9QWK
        /aeY1Pp3OSL4fBgy5mSJlpX6g3uNaPyjh8w4J1pT9jk86HjZu0dVJMGg6YOnDRF53FH/RYhDWARTq
        q1SAUj8Q9Wbx5weGKfJfvm73ARBiY0pKTIPaz72oyheJU8puBrUbBS+Cnap0UWrj/iH+sZQruMvkQ
        ZNKWHFJA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mFiQi-001jqC-SS; Mon, 16 Aug 2021 19:37:57 +0000
Date:   Mon, 16 Aug 2021 20:37:52 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Yang Shi <shy828301@gmail.com>
Cc:     naoya.horiguchi@nec.com, osalvador@suse.de, tdmackey@twitter.com,
        akpm@linux-foundation.org, corbet@lwn.net, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: hwpoison: don't drop slab caches for offlining
 non-LRU page
Message-ID: <YRq+kCOW4zb4vfxA@casper.infradead.org>
References: <20210816180909.3603-1-shy828301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210816180909.3603-1-shy828301@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2021 at 11:09:08AM -0700, Yang Shi wrote:
> But the most disappointing thing is all the effort doesn't make the page
> offline, it just returns:
> 
> soft_offline: 0x1469f2: unknown non LRU page type 5ffff0000000000 ()

It's a shame it doesn't call dump_page().  There might be more
interesting information somewhere in struct page that would help us
figure out what kind of page it was in your environment.  For example,
it might be a page table page or a page allocated for vmalloc(), and
in both those cases, there are things we might be able to do (we'd
certainly be able to figure out that it isn't worth shrinking slab!)
