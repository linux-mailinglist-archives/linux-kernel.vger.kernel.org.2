Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 135EC3AC9CD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 13:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbhFRL2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 07:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbhFRL2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 07:28:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25633C061574
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 04:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Y8KU4/SsLchxRv7QXNDtvc7VQKBPKOOaI6MCeMzU6W8=; b=fE7p0FfmWpLTddMFO7TYdxjIV7
        CxCiX2cg3YkrUybYzh3BZYw+1KNZFhiYJRkaXvyma6B3b7WEp57VMLwZpIa/owz4KJZVsexd72tPg
        DyhXn27UVZ107eJaHa6jWfjKEIohr8oOdqcsqdQRMJaF8kNoUKu/84WcuMGp7/WC9CXrkiBWxMHHD
        hvac1Nnb9qLC1Jj2Rxm3psDVZXzZc4CT0+xiRCSAo2N+frPnNtlrMQ6UcI9s0KQfYT1uJlPGciv3Y
        SYlwznZa0iM7yG0QXOAfWgSBXABIADm8c/8gDdK1BOojZ97DcmmCMc+OXNl5ADBK5e5ov5h/0Zf2e
        CbJmL1Sg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1luCdX-00ACZp-6B; Fri, 18 Jun 2021 11:26:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9B49F300268;
        Fri, 18 Jun 2021 13:26:10 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7B06C21BD53C4; Fri, 18 Jun 2021 13:26:10 +0200 (CEST)
Date:   Fri, 18 Jun 2021 13:26:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     Paul McKenney <paulmck@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: RCU vs data_race()
Message-ID: <YMyC0iux0wKzc1JG@hirez.programming.kicks-ass.net>
References: <YMxYR33XEfVg6AoD@hirez.programming.kicks-ass.net>
 <YMxgbuEdrq8k3eZp@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMxgbuEdrq8k3eZp@elver.google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2021 at 10:59:26AM +0200, Marco Elver wrote:
> On Fri, Jun 18, 2021 at 10:24AM +0200, Peter Zijlstra wrote:
> > Hi Paul,
> > 
> > Due to a merge conflict I had to look at some recent RCU code, and I saw
> > you went a little overboard with data_race(). How's something like the
> > below look to you?
> 
> I commented below. The main thing is just using the __no_kcsan function
> attribute if it's only about accesses within the function (and not
> also about called functions elsewhere).
> 
> Using the attribute also improves performance slightly (not that it
> matters much in a KCSAN-enabled kernel) due to no instrumentation.

Aah yes ofcourse! Much better still.

> > The idea being that we fundamentally don't care about data races for
> > debug/error condition prints, so marking every single variable access is
> > just clutter.
> 
> Having data_race() around the pr_* helpers seems reasonable, if you
> worry about future unnecessary markings that might pop up due to them.

Right, so I did them on WARN and higher, figuring that those really only
happen when there's smoething wrong and we're way past caring about
data races. Paul has a few pr_info() users that are heavy on
data_race(), but your __no_kcsan attribute suggestion helps with that.


