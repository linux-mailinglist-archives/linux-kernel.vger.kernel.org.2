Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 609E7372864
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 12:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbhEDKBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 06:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbhEDKBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 06:01:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498ADC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 03:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4WDiq347S09u8iGZzcZW6y2AlAX+jwMyhKi24vMcM9Y=; b=EeB78OFyHaLemmLhhKDVjUaQAh
        /MoQEhQkrEPessfqCep38yuO5JzFzYXAeHqByqSvRlk4qMt4jQPApmZrobEB9Kmg497VQ7yGutlJ5
        4jwTEK12JeLDnujJdC7LxN+HvUzPy6q9UPbPemab3iEh8dcTVPJqNYZGXd8DW65h1gScb+ZUsezxT
        GaIYRMenHV1U1TLmTzJoAj/M2XMXICv6C4bWubP5oOTFAeuxC6czKLAG3dRbS1DhE8Nn8NNQ29HP6
        WPUzFfAe1fixvJTmojeG+Iugb3I0VvO/Y5VdJP76txOQI4zf9D7ad3ftrgCDiRCjFPfoaHTSVBKDP
        ZGHXP4Iw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1ldrpu-00GQ4v-OH; Tue, 04 May 2021 09:59:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 022BB3001D0;
        Tue,  4 May 2021 11:59:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D1BB12B9BCA93; Tue,  4 May 2021 11:59:23 +0200 (CEST)
Date:   Tue, 4 May 2021 11:59:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Pierre Gondois <Pierre.Gondois@arm.com>
Cc:     linux-kernel@vger.kernel.org, xuewen.yan@unisoc.com,
        qperret@qperret.net, Lukasz.Luba@arm.com, dietmar.eggemann@arm.com,
        Vincent.Donnefort@arm.com, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com
Subject: Re: [PATCH v3 0/2] sched/fair: find_energy_efficient_cpu()
 enhancements
Message-ID: <YJEa+wipZJj/msSF@hirez.programming.kicks-ass.net>
References: <20210504090743.9688-1-Pierre.Gondois@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210504090743.9688-1-Pierre.Gondois@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 04, 2021 at 10:07:41AM +0100, Pierre Gondois wrote:
> Pierre Gondois (2):
>   sched/fair: Only compute base_energy_pd if necessary
>   sched/fair: Fix negative energy delta in find_energy_efficient_cpu()
> 
>  kernel/sched/fair.c | 68 ++++++++++++++++++++++++++-------------------
>  1 file changed, 39 insertions(+), 29 deletions(-)

Thanks!
