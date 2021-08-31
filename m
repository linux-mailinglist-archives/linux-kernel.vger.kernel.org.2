Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ADFB3FC96C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 16:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234953AbhHaOMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 10:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232008AbhHaOMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 10:12:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D11C061575
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 07:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=V706oC8QQbvzl3+pjYtFFnX45qzIKr47GJsjg77W3Gw=; b=FjL6Q8guCtNYReVS5N2XkrKLZr
        YiJ7/S6fEyMTlljHveHfh2+xBOyV8Q2di1WEjLglnHG8Xmal9sjtaJ58fas8pGvX86u9fTfVHiiP/
        bhfZ2I3/pXsjdayEPkig3B12NdsLTmTACzuanURMxt3x7KLNuEIrApraYnYaI7yTEnLJV6CGHuae7
        3E9dGEqWIw1jkN4vY2PCbcHXIXxs8SFvwaYzoJUSqJMArbP+IAfjRvnKowH70Kgnmer9QcZOVPhi4
        8I/gn9R2mQEoeoap7LB/dbxnwxImRKqnenUFjuW3VKqBrhQVRBhiNfgBQD7dT84jSBwpNQSsYHXlj
        acyOz8kg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mL4SL-001HBs-6Y; Tue, 31 Aug 2021 14:09:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 24132300299;
        Tue, 31 Aug 2021 16:09:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D2F5120AEBF29; Tue, 31 Aug 2021 16:09:39 +0200 (CEST)
Date:   Tue, 31 Aug 2021 16:09:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Li RongQing <lirongqing@baidu.com>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [Resend][PATCH] sched/fair: micro-optimize pick_next_entity()
Message-ID: <YS44IzVARx2ZaEUo@hirez.programming.kicks-ass.net>
References: <1629872869-19829-1-git-send-email-lirongqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1629872869-19829-1-git-send-email-lirongqing@baidu.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2021 at 02:27:49PM +0800, Li RongQing wrote:
> Only check the skip buddy when next buddy and last buddy
> are not picked up, this can save the cycles of checking
> the skip buddy and computation of the second buddy, when
> next and last buddy will be picked up
> for example, yield_to_task_fair() set both next and skip
> buddy

Is that actually measurable?

But looking at it, should we not, instead, move the whole ->skip thing to
the bottom, so we unconditionally check it vs the result of
->next/->last ?

Imagine ->next == ->skip, then we want to avoid running it and not have
->next win.

