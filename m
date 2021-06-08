Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6624B39F4E6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 13:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbhFHL2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 07:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbhFHL2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 07:28:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D0EC061574
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jun 2021 04:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2o9r3WkpADMUP0BuGa6cMOKznRI76lk1IA3qTo6QVlo=; b=sthqnt23N6SPAY1b8+5MKPQ8of
        S2iBGtQMbykXnCiZRgm2GIwDMzKnwkv2SLVbys0yfZcwlt4//3EWdo5cNa+zR/ggs1+NlC9/blFrN
        9WDDrU3KvUyH/idKZEDCXoZOabsTP2S3jVsSocbwRYp/4mBjdu6chh4iXouKPC1AWwN6ojgRnKU+B
        twROohpDoBx5eJ9N28hlL9OOgerfLWKDUl7EHAJF2QQT/Xmce87XE55ziaRoQSXg+aLNFc86sy/84
        8lfs1qxWaX3fKvmu0EY8wti2TJEuXlE0/3BSIFS/aJl0Ob8UBZOhBQ8bGNswQs3fDkioqjuqZOuYJ
        jW+bas5Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lqZrD-00GsGF-Sl; Tue, 08 Jun 2021 11:25:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1E2403001E3;
        Tue,  8 Jun 2021 13:25:19 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F0E8E200FB77B; Tue,  8 Jun 2021 13:25:18 +0200 (CEST)
Date:   Tue, 8 Jun 2021 13:25:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yejune Deng <yejune.deng@gmail.com>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair: use inclusive language in fair sched
Message-ID: <YL9Tnp6zgXA0i8x9@hirez.programming.kicks-ass.net>
References: <1623147509-31073-1-git-send-email-yejune.deng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1623147509-31073-1-git-send-email-yejune.deng@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08, 2021 at 06:18:29PM +0800, Yejune Deng wrote:
> This patch replaces some non-inclusive terms based on the proposal
> that accepted by Linus.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=49decddd39e5f6132ccd7d9fdc3d7c470b0061bb

Please do your homework.

https://lkml.kernel.org/r/YLSNzZbrdtZ6PPzH@hirez.programming.kicks-ass.net
