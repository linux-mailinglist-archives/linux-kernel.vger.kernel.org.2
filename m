Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 924AB37B95A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 11:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbhELJi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 05:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbhELJi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 05:38:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC041C061574
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 02:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dXnrQikcCfOUvytGhAWySk6PCwU4Gt2ixLQp3WDf4AQ=; b=DSa92xT9ZL1WeODw4HG0VkoHN4
        x21MTl71QWsdRfG5umBGK1jbQeEfyH0i6v8KYdXR1kKipprtrjCMqc6lVlnNuKbmdgn8z5x+uGK7p
        3F+Tx0BTkseH4dGMLVL3BwIgSIWWq8s7/7yD+RB+gj5xN1Wpz6BIb6WMNQz0fCsY0rcq1Ewq9Ulk/
        sUyV2KsvaoI+PCphqGvci/AhqjswmV1SR6naoe4Pc7HUwlCGPeTXfgZSyv8FP0ykVA5WR+x7qnqjf
        pjFPsliiHCmLo6VGChLkpKoFOz869Je5v8eiIE8VpEkL6LkTGt7JhS0Vr4vPQ9TLkQvdN51saBSOs
        eXIZaX6A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lglCV-0088bR-EN; Wed, 12 May 2021 09:32:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BFBA13002C1;
        Wed, 12 May 2021 11:30:42 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AC35B2B86E5EC; Wed, 12 May 2021 11:30:42 +0200 (CEST)
Date:   Wed, 12 May 2021 11:30:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched/fair: Fix clearing of has_idle_cores flag
Message-ID: <YJugQn6XNGF9/c3h@hirez.programming.kicks-ass.net>
References: <1620746169-13996-1-git-send-email-ego@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1620746169-13996-1-git-send-email-ego@linux.vnet.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2021 at 08:46:09PM +0530, Gautham R. Shenoy wrote:
> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> 
> In commit 9fe1f127b913 ("sched/fair: Merge select_idle_core/cpu()"),
> in select_idle_cpu(), we check if an idle core is present in the LLC
> of the target CPU via the flag "has_idle_cores". We look for the idle
> core in select_idle_cores(). If select_idle_cores() isn't able to find
> an idle core/CPU, we need to unset the has_idle_cores flag in the LLC
> of the target to prevent other CPUs from going down this route.
> 
> However, the current code is unsetting it in the LLC of the current
> CPU instead of the target CPU. This patch fixes this issue.
> 
> Fixes: Commit 9fe1f127b913 ("sched/fair: Merge select_idle_core/cpu()")
> Acked-by: Mel Gorman <mgorman@techsingularity.net>
> Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
> Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>

Thanks!
