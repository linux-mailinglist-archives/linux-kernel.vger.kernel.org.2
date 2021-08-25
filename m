Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E21B53F7B74
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 19:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242271AbhHYRVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 13:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231685AbhHYRVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 13:21:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4262C061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 10:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Zp6w6glVdR7AU7wqwEOZ1YXWoEKYHTmoZwp8Fkv4Ees=; b=VUHTaHKYlk3MxAwhFt1+FoFlHT
        2Ve4Util9CT6Nk9mrTrXIyG6O5j1cCqQs9bj/hOmwAu4VbtrUQz3JA2BYykmyE9DrCLLj/qnPBfQP
        3u8tD+XSBtG6a/3VWwP+dXfatWU8H0qT0dPRteV8V3GaPwnr4jtY4hWX6U9ZiwJSTgZ+OGRo5IgSL
        RiXT4Gt+4l6mBjOU6oE4OmPbjtymUjxextnzhDBny/KZA8bqxezvlwGLjxvQLnxRjDuit2eTJtW3y
        47p/gbYutA0c5Ft4eRc+0MEbtH2MfQlih6j53gsAD3/gNqeZWtQD2RvRutTAbTIMvFazfrjwea9dj
        sxNHKKYg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mIwY7-00CVzK-CT; Wed, 25 Aug 2021 17:19:03 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3DCB1981362; Wed, 25 Aug 2021 19:18:50 +0200 (CEST)
Date:   Wed, 25 Aug 2021 19:18:50 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Li,Rongqing" <lirongqing@baidu.com>
Cc:     Michel Lespinasse <michel@lespinasse.org>,
        "dbueso@suse.de" <dbueso@suse.de>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?562U5aSN?= =?utf-8?Q?=3A?= [PATCH] rbtree: stop
 iteration early in rb_find_first
Message-ID: <20210825171850.GD17784@worktop.programming.kicks-ass.net>
References: <1629885588-10590-1-git-send-email-lirongqing@baidu.com>
 <YSYr7nqql825rHol@hirez.programming.kicks-ass.net>
 <20210825115332.GA4645@lespinasse.org>
 <20210825115859.GB4645@lespinasse.org>
 <YSZD6suya8fR/2uY@hirez.programming.kicks-ass.net>
 <90ea3457ddc7485fbc8db5f7ca5b07ab@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90ea3457ddc7485fbc8db5f7ca5b07ab@baidu.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2021 at 04:01:53PM +0000, Li,Rongqing wrote:
> 
> >>
> >>
> >>                         10
> >>                       /
> >>                      5
> >>                       \
> >>                        10
> >>
> >> The search would stop after visiting node 5, and miss the leaf which
> >> is the expected node to be returned.
> 
> thanks for explanation.
> 
> >Just to clarify; the current code *does* work here. The proposed patch
> >breaks it.
> 
> 
> true, my patch is wrong.
> 
> but rb_find_first seems have other issue.  when the key is equal, we should search right leaf, not left leaf

That again breaks the above case.
