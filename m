Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9703BBDF3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 16:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbhGEODD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 10:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbhGEODC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 10:03:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13513C061574
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jul 2021 07:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sjky4rYlEzhl+pCrUmcoAskVdOo/cUdW8FV7J66+kUA=; b=Bt2boArPupO/ANOIXiDejnY9ho
        VxOG7LcNyw1+w8Gb0J3yza9MYCjGOyUbat0N8NLFD0IV9FX3+TYajzRL0fsPHK8Wkk6ijcgbRu9bV
        cZ1GW0QKpmZChWEJCzR1U4QCA5LBMtXBgO5Df1cxodsxNUJdqw4RFiqbaKNEox6poMpnKp5DS7rwb
        6gX5blQEg9FEraQrcL0RqXE57FdgK0mk5Iy9H+RFLgol1uqCFEAy43l8wTXAcXc1jd5gn+sxSfdd1
        72BpaxjSyR+lRo4MUG2skYW6boKkIOLbm+RsbTvH8ZwQ8Gylz6SvgndActxQn4MzpZHCOtL677+jw
        9OHf30AQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m0P8l-00AIU8-9Y; Mon, 05 Jul 2021 14:00:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D0C53300056;
        Mon,  5 Jul 2021 16:00:01 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BC9AD200D4021; Mon,  5 Jul 2021 16:00:01 +0200 (CEST)
Date:   Mon, 5 Jul 2021 16:00:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Xu, Yanfei" <yanfei.xu@windriver.com>
Cc:     mingo@redhat.com, longman@redhat.com, boqun.feng@gmail.com,
        will@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 1/4] locking/mutex: Use try_cmpxchg()
Message-ID: <YOMQYQr1loxIuZbU@hirez.programming.kicks-ass.net>
References: <20210630153516.832731403@infradead.org>
 <20210630154114.834438545@infradead.org>
 <cac55711-585a-4e08-3b5e-a6890e2f548d@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cac55711-585a-4e08-3b5e-a6890e2f548d@windriver.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 05, 2021 at 07:59:12PM +0800, Xu, Yanfei wrote:
> 
> 
> On 6/30/21 11:35 PM, Peter Zijlstra wrote:
> > For simpler and better code.
> > 
> > Signed-off-by: Peter Zijlstra (Intel)<peterz@infradead.org>
> > ---
> >   kernel/locking/mutex.c |   27 ++++++---------------------
> >   1 file changed, 6 insertions(+), 21 deletions(-)
> 
> Hi Peter,
> 
> I read the mutex codes today, and find there seems something wrong for the
> patch. Should we consider the race condition as blow?
> 
> From 4035f50c96e17cbe3febab768b64da5c000e5b76 Mon Sep 17 00:00:00 2001
> From: Yanfei Xu <yanfei.xu@windriver.com>
> Date: Mon, 5 Jul 2021 17:56:58 +0800
> Subject: [PATCH] locking/mutex: fix the endless loop when racing against
>  mutex.owner
> 
> if a race condition happened on mutex.owner after we fetch its value,
> atomic_long_try_cmpxchg_acquire/release invoked on &mutex.owner will
> return false. Then we need to reassign the temporary variable which
> saves mutex.owner value if in loop, or it will lead an endless loop.

No, when try_cmpxchg() fails it will update oldp. This is the reason old
is now a pointer too.
