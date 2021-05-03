Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C56B33716E6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 16:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbhECOr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 10:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbhECOry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 10:47:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F04C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 May 2021 07:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CvIdh7PoFsgHHMy8MB6WlNW0ViD/jbS56DUb0aHqAdU=; b=WzosU/8RxawiSVl+UxrFbsmPxJ
        2+BTBjzbLI4k/FmeaycFkYTayiJvpTZDaFKNmduGO12Z73xy2olESINQwHv4ewuTEAT2wQ4LWg769
        Xp1FkanoC0LYu3FRPugR4AU2Ne42pb2fKDLoItVFDNvBlbhI500/Y3Bi2E/YhPU0erkHRt18BWh64
        Nu54nq+mKtTMxbhWmOwyiV4Oa0e6ISVHKRBnVJYCSBT9pE9C49adTQLIZJDAqNuWUnF+Dgpn4BU7+
        DMaj4CpePIvnplkOCNgiuq+5leCRazDgwVpxGA2rTefXK3KW6N6geukB0liHucVYM/r6hSEIYJBLi
        NJkht+5g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1ldZoz-00FC9Y-V4; Mon, 03 May 2021 14:45:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4981030022C;
        Mon,  3 May 2021 16:45:16 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3311E2D69371E; Mon,  3 May 2021 16:45:16 +0200 (CEST)
Date:   Mon, 3 May 2021 16:45:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Quentin Perret <qperret@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Android Kernel Team <kernel-team@android.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Patrick Bellasi <patrick.bellasi@matbug.net>
Subject: Re: [PATCH v3] sched: Fix out-of-bound access in uclamp
Message-ID: <YJAMfE/cV8zL4tHJ@hirez.programming.kicks-ass.net>
References: <20210430151412.160913-1-qperret@google.com>
 <CAKfTPtCxVc+KSOJW0a3xK1mGc-qWH0v3wmAuqeB467t+wza78g@mail.gmail.com>
 <562004ff-9f60-bf37-df4c-547415ae2cd5@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <562004ff-9f60-bf37-df4c-547415ae2cd5@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 03, 2021 at 12:55:34PM +0200, Dietmar Eggemann wrote:
> On 30/04/2021 17:27, Vincent Guittot wrote:
> > On Fri, 30 Apr 2021 at 17:14, Quentin Perret <qperret@google.com> wrote:
> >>
> >> Util-clamp places tasks in different buckets based on their clamp values
> >> for performance reasons. However, the size of buckets is currently
> >> computed using a rounding division, which can lead to an off-by-one
> >> error in some configurations.
> >>
> >> For instance, with 20 buckets, the bucket size will be 1024/20=51. A
> >> task with a clamp of 1024 will be mapped to bucket id 1024/51=20. Sadly,
> >> correct indexes are in range [0,19], hence leading to an out of bound
> >> memory access.
> >>
> >> Clamp the bucket id to fix the issue.
> >>
> >> Fixes: 69842cba9ace ("sched/uclamp: Add CPU's clamp buckets refcounting")
> >> Suggested-by: Qais Yousef <qais.yousef@arm.com>
> >> Signed-off-by: Quentin Perret <qperret@google.com>
> > 
> > Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

Thanks!
