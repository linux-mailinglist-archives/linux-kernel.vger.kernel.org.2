Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4330E404766
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 10:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232089AbhIII5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 04:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbhIII5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 04:57:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10FC9C061575
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 01:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=i8KnKvv3IIBy6PnDZORdb3gm6ewAqTInpJG7KkupSvs=; b=PcR+GRvAkg1r0xnrbVagKnx1J0
        cbpkfHpd3OWnrtA5aGihJ3wo6zopEOhrl17oteaQ+EzcGtvwSIxwRexScD+C1K4Flf3beim+dU1wo
        xEZwPuNhPxWNNeXzpf3XzunwwEZeX2PqXKZWsgl9C8AmXAFjTcQSCX/SO+pRGu18nppt4xbCEilzV
        6iNRxSslIgFhAfRe2kiRaJREOcIk3wm7LaLbLbo8DtPZJt/eiMyMZijsEwimbNWxK4KrGZbAv5lNq
        Vbu1PuManR4RHVKsdUNk1dCg4UcnM/1bFDM0Zn0ApH2z+43nnul8mlzQeRZMqLhgUssB7qPynlYyC
        izRDWN8A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mOFq1-009eNF-4O; Thu, 09 Sep 2021 08:55:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CC16E300047;
        Thu,  9 Sep 2021 10:55:15 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B3BEE2C625915; Thu,  9 Sep 2021 10:55:15 +0200 (CEST)
Date:   Thu, 9 Sep 2021 10:55:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Stephane Eranian <eranian@google.com>
Cc:     linux-kernel@vger.kernel.org, acme@redhat.com, jolsa@redhat.com,
        kim.phillips@amd.com, namhyung@kernel.org, irogers@google.com
Subject: Re: [PATCH v1 00/13] perf/x86/amd: Add AMD Fam19h Branch Sampling
 support
Message-ID: <YTnL814pES+YWWnm@hirez.programming.kicks-ass.net>
References: <20210909075700.4025355-1-eranian@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210909075700.4025355-1-eranian@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2021 at 12:56:47AM -0700, Stephane Eranian wrote:
> This patch series adds support for the AMD Fam19h 16-deep branch sampling
> feature as described in the AMD PPR Fam19h Model 01h Revision B1 section 2.1.13.

Yay..

> BRS interacts with the NMI interrupt as well. Because enabling BRS is expensive,
> it is only activated after P event occurrences, where P is the desired sampling period.
> At P occurrences of the event, the counter overflows, the CPU catches the NMI interrupt,
> activates BRS for 16 branches until it saturates, and then delivers the NMI to the kernel.

WTF... ?!? Srsly? You're joking right?

Also, can you please fix you MUA to wrap at 78 chars like normal people?
