Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE1B3356BCD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 14:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352026AbhDGMLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 08:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241241AbhDGMLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 08:11:03 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE07BC06175F
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 05:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=N4OmVmg67y1fM0fowTqNR4d36ChAKSePTQrWroxjXz4=; b=Eij/U3Y3vRC1MhFFzM6jLkMmYJ
        7JScTuWUtNfVaAWbjg35DjmQdkm4H1M0ECnfUt+sRUCYRFkD2TuF3KYedWg7TrCdCyD3J8F/4JvFE
        v/0JfnGObvWNec+Hbi2pQw5rMiF8IK47H/uj/8pPTJK5YqSghJOx9Y7Cr5Dc4a9LLSfCYQW8phMgm
        IMX5hVq5K2m5buyGhf8c7nXZT6I4ara16eEQQ/KaI2L0sCwWC913/eWWPcqI8e/J6WTxnjN0wmnl0
        uLxFVL4L0BM8T6O4m3Nle67TyvJ5D1q3x6xrkZieFvrgX58UI2MDGajfTYLZGmCB1gSYHdc2sH8lY
        ssIx6l0Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lU71B-004wPf-QL; Wed, 07 Apr 2021 12:10:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1490F300219;
        Wed,  7 Apr 2021 14:10:45 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E303224403DB9; Wed,  7 Apr 2021 14:10:44 +0200 (CEST)
Date:   Wed, 7 Apr 2021 14:10:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Rik van Riel <riel@surriel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: Re: [PATCH v3] sched/fair: bring back select_idle_smt, but
 differently
Message-ID: <YG2hRBnf16raGy63@hirez.programming.kicks-ass.net>
References: <20210321150358.71ef52b1@imladris.surriel.com>
 <20210322110306.GE3697@techsingularity.net>
 <20210326151932.2c187840@imladris.surriel.com>
 <CAKfTPtBvy3Wv=-d5tjrirO3ukBgqV5vM709+_ee+H8LWJsnoLw@mail.gmail.com>
 <1e21aa6ea7de3eae32b29559926d4f0ba5fea130.camel@surriel.com>
 <YG1cfgTH2gj9hxAx@hirez.programming.kicks-ass.net>
 <20210407094106.GC3697@techsingularity.net>
 <YG2GMW0EjsqqnET6@hirez.programming.kicks-ass.net>
 <20210407104717.GD3697@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407104717.GD3697@techsingularity.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 11:47:17AM +0100, Mel Gorman wrote:

> Ok, cpusets do split domains. I can't imagine the logic of splitting SMT
> siblings across cpusets but if it's possible, it has to be checked and
> protecting that with cpusets_enabled() would be a little overkill and
> possibly miss some other corner case :(

Quite. The logic is that some people can't be arsed to look at how the
topology is enumerated and simply split logical CPUs by a random number.

Imagine we have 4 cores, with 2 threads each, for 8 logical CPUs.

Suppose you want a partition of 6 'cpus' and 2 spares. Hoping for a 3:1
core split.

If things are enumerated like: core0{smt0, smt1}, core1{smt0, smt1} ...
then 0-5 will get you 3 whole cores.

If OTOH things are enumerated like: smt0{core0, core1, core2, core3},
smt1{...} then 0-5 will get you the loonie side of the moon.

Funny thing is that x86 can iterate either way depending on how the BIOS
monkey filled out the tables.
