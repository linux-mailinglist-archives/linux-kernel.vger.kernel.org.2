Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CAE9364A5F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 21:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241543AbhDSTSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 15:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241511AbhDSTSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 15:18:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D6B1C061761
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 12:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9/fEraF70YI9VanOxx+OKXfhihNuXb8qcr/HPIEoHGI=; b=tF+NQct7HNv4zy/32J/9etqqKk
        yY7vVd6/CR4zJD32dgOKISh9GbF0lE1sk62oScsIdFxlG4jP3+QRtQk/wtV/NNOVauRHNqEDUPvz7
        e3hZ3mPSe5Bbm2Qm4M6h2qyYnus0nZaOW8ORPSe4+q4yulJRDIQGiHKUsyX/wkm5lNguViqlhNEYw
        mSJ6gCzN1YYiBFisl7toX7u36z0DRMq8Bp9UfA1fAzmp8F07/lLs6QprHYA9PGkUP/b3nzn2vVi0t
        URE0X2s3BvAbno/YyK5PQ+QlTBk2ElvpBe1oIEvXpayAollnCvDUXeWGhE0FbEwBehLxs0UnBeCZg
        1PppmRcA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lYZOU-00EBFQ-2E; Mon, 19 Apr 2021 19:17:36 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8601C980D8D; Mon, 19 Apr 2021 21:17:12 +0200 (CEST)
Date:   Mon, 19 Apr 2021 21:17:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Luigi Rizzo <lrizzo@google.com>
Cc:     linux-kernel@vger.kernel.org, axboe@kernel.dk, paulmck@kernel.org
Subject: Re: [PATCH] smp: add a best_effort version of
 smp_call_function_many()
Message-ID: <20210419191712.GB26214@worktop.programming.kicks-ass.net>
References: <20210419184455.2987243-1-lrizzo@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210419184455.2987243-1-lrizzo@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 19, 2021 at 11:44:55AM -0700, Luigi Rizzo wrote:
> Regardless of the 'wait' argument, smp_call_function_many() must spin
> if any of the target CPUs have their csd busy waiting to be processed
> for a previous call. This may cause high tail latencies e.g. when some
> of the target CPUs are running functions that disable interrupts for a
> long time; getrusage() is one possible culprit.
> 
> Here we introduce a variant, __smp_call_function_many(), that adds
> a third 'best_effort' mode to the two existing ones (nowait, wait).
> In best effort mode, the call will skip CPUs whose csd is busy, and if
> any CPU is skipped it returns -EBUSY and the set of busy in the mask.
> This allows the caller to decide how to proceed, e.g. it might retry at
> a later time, or use a private csd, etc..
> 
> The new function is a compromise to avoid touching existing callers of
> smp_call_function_many(). If the feature is considered interesting, we
> could even replace the 'wait' argument with a ternary 'mode' in all
> smp_call_function_*() and derived methods.

I don't see a user of this... 
