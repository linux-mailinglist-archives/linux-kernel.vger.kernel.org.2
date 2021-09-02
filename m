Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69BF23FEC04
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 12:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242422AbhIBKUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 06:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233724AbhIBKUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 06:20:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20CEDC061575
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 03:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=F1fv2G30FfWBWVsuWT6e/tsR1DF6ayJ8NIFOVop+BfA=; b=T5401Ox/yvU0e0fN0ikGZcLrNS
        dMoZW8ROVI2K3+T+81tmiSb9A11PmpNAx9CAwhGmjxp1G4stxe5QdVQWPTwU/vvzfb32kxZQ52sFw
        n8/OI8bXnfSgHWgj00vOxb0mLkGjDsUAFu0cedWHeRjxiSGNKz/MrIc/NCRe7qsnwZsri3ki8PauF
        2fkJn7JuYoAAk+w8P//E8phcHdYIIhdqkG/WPbhdzStV92K6mt7UDRQ8ULLpOsyslfPSqFa5UDVzQ
        zyG+RcI0cUklIfHXAmh2ln1DuDYknfVJCrbEG8JXKuONZmfEKUPFG2Jj/Xui80HyCaW4ENBZ4RLKk
        O0WL+gLw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mLjmf-003MyD-Iu; Thu, 02 Sep 2021 10:18:06 +0000
Date:   Thu, 2 Sep 2021 11:17:25 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Shijie Huang <shijie@amperemail.onmicrosoft.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, song.bao.hua@hisilicon.com,
        torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        Frank Wang <zwang@amperecomputing.com>
Subject: Re: Is it possible to implement the per-node page cache for
 programs/libraries?
Message-ID: <YTCktV3KF9PzIACU@casper.infradead.org>
References: <a2f423cf-9413-6bc8-e4d8-92374fc0449e@amperemail.onmicrosoft.com>
 <YS7yjcqA6txFHd99@casper.infradead.org>
 <1630552995.2mupnzoqzs.astroid@bobo.none>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1630552995.2mupnzoqzs.astroid@bobo.none>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2021 at 01:25:36PM +1000, Nicholas Piggin wrote:
> > I have been thinking about this a bit; one of our internal performance
> > teams flagged the potential performance win to me a few months ago.
> > I don't have a concrete design for text replication yet; there have been
> > various attempts over the years, but none were particularly compelling.
> 
> What was not compelling about it?

It wasn't merged, so clearly it wasn't compelling enough?

> https://lists.openwall.net/linux-kernel/2007/07/27/112
> 
> What are the other attempts?

I found one from Dave Hansen in 2003:

https://lwn.net/Articles/45082/

I think somebody else may have posted a different one, but I don't
remember now.
