Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3443237F97D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 16:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234326AbhEMOQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 10:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234254AbhEMOQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 10:16:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D30C061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 07:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ldkD/MCCMVjwjxuDDMNeDne6TaE3nCcY0it9FfXwvCU=; b=uKXX+1H/3+98XMqN0odMR1kgfP
        ACOL56wtYNxN5TVRAYpbubvwGX6w+DtzuoEaW37btjwTd0dwdN1zVKCfzXM36SCwqg1zkTthH0KPN
        +bgggiubcdIfAFQZmgjMLHgLiO7QOuBqj6pVWp/HxLdFqWgvOpyEPrSXV3Xw899SPy5PFhgR8Yozk
        unitwHuEnpBuxcAp89WlJg/7M3p3yUuF5xoID9M3ydts8vlcXmSNUGWLAQwSaAbm1DdWjdGHZKwJT
        HnO6Ho+EOJbQMwrHWOFO3fBRLP4nnPDCF04G1DaJbfxzRXW9K6BTdj+rwcFsIFGfVpazzhQ474h8o
        wiJaIK8Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lhC5q-009Uyr-Dy; Thu, 13 May 2021 14:13:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4882030019C;
        Thu, 13 May 2021 16:13:37 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 01F1A2D3CBAF5; Thu, 13 May 2021 16:13:36 +0200 (CEST)
Date:   Thu, 13 May 2021 16:13:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Tejun Heo <tj@kernel.org>, Quentin Perret <qperret@google.com>,
        Wei Wang <wvw@google.com>, Yun Hsiang <hsiang023167@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 0/2] Uclamp cgroup fixes
Message-ID: <YJ00EB3MeUo3Inoy@hirez.programming.kicks-ass.net>
References: <20210510145032.1934078-1-qais.yousef@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210510145032.1934078-1-qais.yousef@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 03:50:30PM +0100, Qais Yousef wrote:
> A couple of fixes for uclamp cgroup. The first one is addressing wrong
> implementation details that is restricting usability of uclamp in cgroup. The
> 2nd is fixing locking issues.
> 
> This is a resend since I forgot to CC LKML...
> 
> Qais Yousef (2):
>   sched/uclamp: Fix wrong implementation of cpu.uclamp.min
>   sched/uclamp: Fix locking around cpu_util_update_eff()
> 
>  kernel/sched/core.c | 28 ++++++++++++++++++++++++----
>  1 file changed, 24 insertions(+), 4 deletions(-)

Thanks!
