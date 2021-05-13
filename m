Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB48A37F944
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 15:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234324AbhEMOBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 10:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234291AbhEMOAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 10:00:39 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B91CC061574;
        Thu, 13 May 2021 06:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cFsGIs15oBDKw+iLPP0hZSdU1N4tENkSw8f1oxY5fzM=; b=cDJDraJeRbdjgNKa4e7i3S7+o8
        bgPudq0Vbn+se9rolCLoeTJH6zJSqOlE1/4FOrFttWKepUAaU9LhDEKbgX1w9wYP0jx/EaL+mQ9Wz
        YsE8kagi7Miy2hfbDCYtIXy+ck5ocs68ipISLC5MCCOlBP06acErT4mUAzqKbtRvHBJlozcySc/eS
        huCNuUltphMbQD+A3111CU7xk2SEffqWR0Q/jHMfLx/qVvrsaSqWD6Ekp/LHU8sVrfkny/Jubv/JG
        6qpBPOkpqjFcVsDtEFjk5/BFnu11Zj3ZK2do5ggUasATutSar4KR+XCB29yHOFB0+Nmq+BwqpScqh
        bK2yYUXw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lhBs2-005gvu-Fb; Thu, 13 May 2021 13:59:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 76B3B3001E1;
        Thu, 13 May 2021 15:59:21 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 591F22D99D984; Thu, 13 May 2021 15:59:21 +0200 (CEST)
Date:   Thu, 13 May 2021 15:59:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Beata Michalska <beata.michalska@arm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        valentin.schneider@arm.com, dietmar.eggemann@arm.com,
        corbet@lwn.net, rdunlap@infradead.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 2/3] sched/topology: Rework CPU capacity asymmetry
 detection
Message-ID: <YJ0wuY1uDVbvTxRT@hirez.programming.kicks-ass.net>
References: <1620664258-11045-1-git-send-email-beata.michalska@arm.com>
 <1620664258-11045-3-git-send-email-beata.michalska@arm.com>
 <YJ0H5+P4uHJVh5qF@hirez.programming.kicks-ass.net>
 <20210513134832.GB15289@e120325.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210513134832.GB15289@e120325.cambridge.arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2021 at 02:48:32PM +0100, Beata Michalska wrote:

> > > Where:
> > >  arch_scale_cpu_capacity(L) = 512
> > >  arch_scale_cpu_capacity(M) = 871
> > >  arch_scale_cpu_capacity(B) = 1024
> > 
> > Low, High
> > Small, Big
> > 
> > But you appear to have picked: Low and Big, which just doesn't make any
> > sense. (Worse, L can also be Large :-)
> >
> (L)ittle, (M)edium, (B)ig
> I can re-arrange the abbreviations used here.

Duh, I must really be having a bad day for not thinking of Little. I
don't think you need to change this. S,M,L would be like a clothing
store, but steps away from the big.Little thing.

