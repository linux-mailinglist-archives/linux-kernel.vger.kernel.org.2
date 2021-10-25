Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12EB243969F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 14:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbhJYMuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 08:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232474AbhJYMuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 08:50:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ACF5C061745
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 05:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rBk4yINinjndCjaTIVIUHmZlRoBlOJ4LjbAPqKnk+Nw=; b=kAN0SmAHX1IqeDtiEcCRMiXXUx
        Qb/qmqDul7PBnJZ5VoaXSMDvAnJ78DKxJQPe8BPpVTXOmjrPV3NK0cB16fVK4go/mGvglrE1MS5n1
        KJRkbkdvLp9YoF+tGsFhSkU1RIxLYx2/q56p9htd5ayvXICdhP1VLYzXSE29apCN2GuZznYL1kYkK
        oXErpw0wATfS7zY3aba5M9ejq3ptKTVnvm1JkhKTVJRZ9ro8O4TE4RQg3qsBfNyFmcU3Lcx1v070N
        bfWVNTBW2NaNsw1Bum6SGs/I692cDXLKa9KaQg/oGFdabGJ6jtijDfmkOdZbOxeXt5hPcR/KZ9fni
        o0NGDxgw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mezKW-00G7so-E5; Mon, 25 Oct 2021 12:44:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B5C9D300230;
        Mon, 25 Oct 2021 14:43:55 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9A0DB20C6C142; Mon, 25 Oct 2021 14:43:55 +0200 (CEST)
Date:   Mon, 25 Oct 2021 14:43:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched: Fix implicit type conversion
Message-ID: <YXami/C2FzwDiKxp@hirez.programming.kicks-ass.net>
References: <1635164377-2426740-1-git-send-email-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1635164377-2426740-1-git-send-email-jiasheng@iscas.ac.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2021 at 12:19:37PM +0000, Jiasheng Jiang wrote:
> The variable 'n' is defined as ULONG. However in the cpumask_next(),
> it is used as INT.
> That is vulnerable and may cause overflow.
> For example, if the value of 'n' is (2^31 - 1), then it can pass the

That would need nr_cpu_ids to be that large. How's that going to happen?
