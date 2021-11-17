Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4207245478C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 14:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237660AbhKQNj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 08:39:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237753AbhKQNjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 08:39:46 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97214C061570
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 05:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eHkEvT3ZHgcRZrhBZlX9Bj7hWYFwUL+rtMAlwH0z8uU=; b=HHzHSJfAf1iPLoNv+YYr8B2A7h
        a2nQtcn+R9MaqKUCUW0tYafhjnEM+6WTXZYdyClseQ0E2kYRd425CUFvFq6fUn/HkOEgvpMmJoKBU
        HvpzCsptTf5X9Veap4nCmoH3VIBCapkfCbH5gWtGhZ31EY2lSp5RoYHaMWiErsGc0oCRbp3eytRQN
        gQMus1wMn44iGdVTiYRmXqRCq19MxIWvKT9S+BJvRzNleKB8p4XTqZKb3ZRUsRG0d8fRfykvfuKGw
        6jyO7CIOvfhoS8Bqjc7NGlwpCLQJ9dwZRTWdOUgo5BlSEHEV/fPWcV2JZW5GtEUBva7JO+NGpOI14
        u0D1UKeQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mnL71-007ddC-28; Wed, 17 Nov 2021 13:36:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8A402300129;
        Wed, 17 Nov 2021 14:36:29 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 74DB82C7C11D5; Wed, 17 Nov 2021 14:36:29 +0100 (CET)
Date:   Wed, 17 Nov 2021 14:36:29 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        mazhenhua <mazhenhua@xiaomi.com>,
        Hillf Danton <hdanton@sina.com>,
        Maria Yu <quic_aiquny@quicinc.com>
Subject: Re: [PATCH v5] locking/rwsem: Make handoff bit handling more
 consistent
Message-ID: <YZUFXeqgqJwEuDdG@hirez.programming.kicks-ass.net>
References: <20211116012912.723980-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211116012912.723980-1-longman@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2021 at 08:29:12PM -0500, Waiman Long wrote:
> There are some inconsistency in the way that the handoff bit is being
> handled in readers and writers.
> 
> Firstly, when a queue head writer set the handoff bit, it will clear it
> when the writer is being killed or interrupted on its way out without
> acquiring the lock. That is not the case for a queue head reader. The
> handoff bit will simply be inherited by the next waiter.
> 
> Secondly, in the out_nolock path of rwsem_down_read_slowpath(), both
> the waiter and handoff bits are cleared if the wait queue becomes empty.
> For rwsem_down_write_slowpath(), however, the handoff bit is not checked
> and cleared if the wait queue is empty. This can potentially make the
> handoff bit set with empty wait queue.
> 
> To make the handoff bit handling more consistent and robust, extract
> out handoff bit clearing code into the new rwsem_del_waiter() helper
> function.  The common function will only use atomic_long_andnot() to
> clear bits when the wait queue is empty to avoid possible race condition.
> If the first waiter with handoff bit set is killed or interrupted to
> exit the slowpath without acquiring the lock, the next waiter will
> inherit the handoff bit.
> 
> While at it, simplify the trylock for loop in rwsem_down_write_slowpath()
> to make it easier to read.
> 
> Fixes: 4f23dbc1e657 ("locking/rwsem: Implement lock handoff to prevent lock starvation")
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---

Zhenhua Ma, would you be able to confirm this works for you and provide
a Tested-by? 
