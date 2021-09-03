Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB373400572
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 21:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350602AbhICTDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 15:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239381AbhICTDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 15:03:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F383C061575
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 12:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aH/w/+Cnoi5Txr0//vfK/74qoG/0s9SMxp4KCpOEQNc=; b=Udk67ofuMPuRnJfAeSghwUmZR3
        8t2sYr5DhN6waO8X8Bk9jTiLqDqp/m3y25qQbEUaE9ESWhBa3JP3YY/8NyHm0CWcZ8CxHCt64yDyG
        xwitDvpshWWmP7kquY3hSizYINAjhsTo242vfIpX0aAMtuNWDc1vjOfPf4neM4XVMwSOzEVbcruYO
        M57mbCbwWmtkwZ1ePynw+AyjNPd0sjBICUmFpvdT1yBkslO54lt/cQpkA37n/54mbLRP/krQdAblY
        zrsCsdQMYsmkqJwDdvGA6M1Np8lDW5YUR903PZCRYBIbnDgFmg4yjacx4C3MXH929iDE5DNDGsxQy
        6gi3G0sA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mMERa-004hkO-HP; Fri, 03 Sep 2021 19:01:49 +0000
Date:   Fri, 3 Sep 2021 20:01:42 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org,
        Shijie Huang <shijie@amperemail.onmicrosoft.com>,
        song.bao.hua@hisilicon.com, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk, Frank Wang <zwang@amperecomputing.com>
Subject: Re: Is it possible to implement the per-node page cache for
 programs/libraries?
Message-ID: <YTJxFgD0kKPs51dz@casper.infradead.org>
References: <a2f423cf-9413-6bc8-e4d8-92374fc0449e@amperemail.onmicrosoft.com>
 <YS7yjcqA6txFHd99@casper.infradead.org>
 <1630552995.2mupnzoqzs.astroid@bobo.none>
 <YTCktV3KF9PzIACU@casper.infradead.org>
 <1630652670.aplcvu6g23.astroid@bobo.none>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1630652670.aplcvu6g23.astroid@bobo.none>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 03, 2021 at 05:10:31PM +1000, Nicholas Piggin wrote:
> Excerpts from Matthew Wilcox's message of September 2, 2021 8:17 pm:
> > On Thu, Sep 02, 2021 at 01:25:36PM +1000, Nicholas Piggin wrote:
> >> > I have been thinking about this a bit; one of our internal performance
> >> > teams flagged the potential performance win to me a few months ago.
> >> > I don't have a concrete design for text replication yet; there have been
> >> > various attempts over the years, but none were particularly compelling.
> >> 
> >> What was not compelling about it?
> > 
> > It wasn't merged, so clearly it wasn't compelling enough?
> 
> Ha ha. It sounded like you had some reasons you didn't find it 
> particularly compelling :P

I haven't studied it in detail, but it seems to me that your patch (from
2007!) chooses whether to store pages or pcache_desc pointers in i_pages.
Was there a reason you chose to do it that way instead of having per-node
i_mapping pointers?  (And which way would you choose to do it now, given
the infrastructure we have now?)
