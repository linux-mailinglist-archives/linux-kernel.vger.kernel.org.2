Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2A823F59DE
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 10:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235404AbhHXIcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 04:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235291AbhHXIcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 04:32:05 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90EF1C061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 01:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QH8JNXZkrt8s4hsAYqDo1WCumi79b4TMcLNFHKDCAwo=; b=CDzbDA0oFuslVn4rtBtlJeklas
        7SL5a/JqAKbJ+jd9cPvKXrtO9C2G5Z2fLqkvDK9pytayt3jhYbi6Eo0HKHIwLD6WsPd8GxuW2NIFM
        AqBYQPMHrvG5240e+vvvf739Ul8LMqjJfMX9P1ouDJcXGOGrZfY9ZidPoRu3lyuXksnSGjy1Y4NJX
        leL6/z529MlW/09dDgTvCfNewZO4vBv0L9bPOpGRfregwcTdolKXkUSCRG7oknaeP0HV2urpCh8OT
        OZyZ6BDQAqVwOmSE1aXKfsq9BXvnncboFuOxKD9we4jwshYYIFeUxTFIxDNDRWybOxLjt1uu6KGLp
        8Lk350UA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mIRq1-00CXZc-Cn; Tue, 24 Aug 2021 08:31:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 00C46300399;
        Tue, 24 Aug 2021 10:31:16 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9DCCC20CCE56B; Tue, 24 Aug 2021 10:31:16 +0200 (CEST)
Date:   Tue, 24 Aug 2021 10:31:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dave Jones <davej@codemonkey.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: 5.14-rc breaks iotop swap io monitoring.
Message-ID: <YSSuVO47ieWDfWMQ@hirez.programming.kicks-ass.net>
References: <20210824031648.GA2725@codemonkey.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210824031648.GA2725@codemonkey.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23, 2021 at 11:16:48PM -0400, Dave Jones wrote:
> I just noticed that in 5.14-rc running iotop, it complains on startup
> that "CONFIG_TASK_DELAY_ACCT not enabled in kernel, cannot determine
> SWAPIN and IO %" and sure enough a bunch of columns show up as
> 'unavailable'.
> 
> My suspicion is this commit, which I've not confirmed yet as it doesn't
> cleanly revert.  I'll poke at it some more in the morning, but figured
> I'd bring it up sans-evidence in the hope that I'll wake up to someone
> having an Ah-ha moment.

If you need DELAYACCT I'm thinking:

  e4042ad49235 ("delayacct: Default disabled")

and

  0cd7c741f01d ("delayacct: Add sysctl to enable at runtime")

might be more relevant..
