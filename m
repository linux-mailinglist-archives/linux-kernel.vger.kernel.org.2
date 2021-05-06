Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77FFC375662
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 17:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235067AbhEFPTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 11:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbhEFPS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 11:18:56 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456BCC061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 08:17:57 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id o27so5233220qkj.9
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 08:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TnqymWt8DT7p/G3Ulxb2AlM+V3we7siDlvYQ85sUlP4=;
        b=T5Zs+/ZEWbNo/tIE2/cBZ1XPAqOn3QuSfuoVIoixc1phLbpeMaNVbXTUQtd/8pymk6
         a9ZQRn9LosPkR1SOAilSP7cNvxr+tfWYWUm2fuOXlGkFRqZjrzrQ4g2YjEhvW04D9tOE
         dWMEEUz+df8cce25S/MsAbfzW9GVuTbNU8RXoBrzdVIOXMT4IsCWBdCGB0FN2ihmBnSi
         5nnoOet1eVcc7PGExNbgSWZSo9CZ6ZjfnR+LnL6iM2p3vCueoUNXfhY9dVUYHlpE3lLp
         qAFnVvGX2hkGTfzeb+Dl2uCNk5aROr+aFC0nBKlGdp2TXDPEXn0/CHx2jcg+FREnv/j/
         5Dzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TnqymWt8DT7p/G3Ulxb2AlM+V3we7siDlvYQ85sUlP4=;
        b=f7BH4KWj2CtMBLHpwiQ941jHKJgXUzF7T4aMAWCppijHqNKvfriKIA6R6tjIaCzq5N
         BbgFzirbJJsVtUbpcCJA7WFr8dBZKAurBpy9KrDs9i+K5dn34c/RYsuHN6eXc347nCmK
         7s7j6akmq+KiXMLmX/U4e8e07jIrMxOL8dFGUaX48qc719Vy/4mGCFlm9Ycx3HPVzggz
         1gbFABdeQWg4S//E6c7bZL0jG3Fcscsqj16zZnk39ZMtwEN07ZtcE+Ex9mawQxgV2sO4
         YSGDz7IssBAIQAxO+ad7RRVZM8lZ6RterRET5RvdJbvOfOv4dV9YqIzrLns775xNIjOU
         mB8Q==
X-Gm-Message-State: AOAM530zqXfV4AXAihKdQoZCYNPuCeANhuWeiws8KcNq2K4+GeQGwjHi
        Oh3AT2BeGsgYQV1sBtVHRG/PXA==
X-Google-Smtp-Source: ABdhPJwaLJ6pZWp6/jCoVX1+5WZJhTT1qpGUrvvjeerJstNfEQCraV82M+xUumJh4eIQzkCfPQ/r+w==
X-Received: by 2002:a05:620a:381:: with SMTP id q1mr4746866qkm.243.1620314276515;
        Thu, 06 May 2021 08:17:56 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:4c4b])
        by smtp.gmail.com with ESMTPSA id a27sm2295146qtd.77.2021.05.06.08.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 08:17:55 -0700 (PDT)
Date:   Thu, 6 May 2021 11:17:54 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, mingo@kernel.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, bsingharora@gmail.com, pbonzini@redhat.com,
        maz@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        riel@surriel.com
Subject: Re: [PATCH 1/6] delayacct: Use sched_clock()
Message-ID: <YJQIopjVwzBjxg4n@cmpxchg.org>
References: <20210505105940.190490250@infradead.org>
 <20210505111525.001031466@infradead.org>
 <YJP2L1lUvUrur4pK@cmpxchg.org>
 <YJP6fWhwg95JZ1Kg@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJP6fWhwg95JZ1Kg@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 06, 2021 at 04:17:33PM +0200, Peter Zijlstra wrote:
> On Thu, May 06, 2021 at 09:59:11AM -0400, Johannes Weiner wrote:
> > On Wed, May 05, 2021 at 12:59:41PM +0200, Peter Zijlstra wrote:
> > > @@ -42,10 +42,9 @@ void __delayacct_tsk_init(struct task_st
> > >   * Finish delay accounting for a statistic using its timestamps (@start),
> > >   * accumalator (@total) and @count
> > >   */
> > > -static void delayacct_end(raw_spinlock_t *lock, u64 *start, u64 *total,
> > > -			  u32 *count)
> > > +static void delayacct_end(raw_spinlock_t *lock, u64 *start, u64 *total, u32 *count)
> > >  {
> > > -	s64 ns = ktime_get_ns() - *start;
> > > +	s64 ns = local_clock() - *start;
> > 
> > I don't think this is safe. These time sections that have preemption
> > and migration enabled and so might span multiple CPUs. local_clock()
> > could end up behind *start, AFAICS.
> 
> Only if you have really crummy hardware, and in that case the drift is
> bounded by around 1 tick. Also, this function actually checks: ns > 0.

Oh, I didn't realize it was that close. I just went off the dramatic
warnings on cpu_clock() :-) But yeah, that seems plenty accurate for
this purpose.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
