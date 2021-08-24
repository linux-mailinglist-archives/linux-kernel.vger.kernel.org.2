Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4730D3F60C8
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 16:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237865AbhHXOoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 10:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237801AbhHXOoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 10:44:07 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE58C061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 07:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=C+HHO6xh5P+m9CtfF749Nx2HnFWM0I1tulwvdN8dN7o=; b=nIBNcvqo4iROUGsGcjj52aiOkO
        KF0Q00MVn9Bb8i/khlGOAZRfr662PdiYGvEvLqXHokaKNuyrQp5GGQJ+znbsaxnUXNFYKquJPHsMR
        QFwppMJNyvTYN+zFnjbs7/10Unfh8T3IUoFZ2oa+tkg9zM+zHJNWrG4NFRdmmSfCB5YXh0n5SPoSP
        dZlwtp65204hNsxI+OCsi3sjoQGC+BbUk95UYgGScLrwoPsGK+mLZizx09L1fNvvW7fI6D3ir8QJV
        dl/pFxWl5hMvYjg/laMZkpo16v1PlX4vAWG5UxITXky33UVaYqs3h+OotaSgWYAQAvxB3b5bXAIlq
        0SxWIVyg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mIXdp-00CcEj-Kz; Tue, 24 Aug 2021 14:43:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6E4AC30018A;
        Tue, 24 Aug 2021 16:43:03 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 374A42C5E0D9B; Tue, 24 Aug 2021 16:43:03 +0200 (CEST)
Date:   Tue, 24 Aug 2021 16:43:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     CGEL <cgel.zte@gmail.com>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org,
        Jing Yangyang <jing.yangyang@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH linux-next] kernel:fair: fix boolreturn.cocci warnings
Message-ID: <YSUFdxEZahuIuzB4@hirez.programming.kicks-ass.net>
References: <20210824062359.59474-1-deng.changcheng@zte.com.cn>
 <YSSqusBah2AzUD7V@hirez.programming.kicks-ass.net>
 <YSSsWaXD5VX+HJNS@hirez.programming.kicks-ass.net>
 <20210824094128.58898319@oasis.local.home>
 <20210824094244.2a7ebe0f@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210824094244.2a7ebe0f@oasis.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021 at 09:42:44AM -0400, Steven Rostedt wrote:
> On Tue, 24 Aug 2021 09:41:28 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > Doesn't hurt to just take the patch and then you wont have to spend
> > time on new robots flagging this as a "bug".
> 
> Or if you don't want to give credit to theses silly robots, just go
> through the code yourself, and make one big cleanup. It's really
> trivial work.

I fundamentally disagree with the patches. 0 is a perfectly fine
spelling of false. And if they'd spend half a minute using google, I'm
sure they would have found me proclaiming as such.

Why should I waste time on people that can't be arsed to do their
homework?
