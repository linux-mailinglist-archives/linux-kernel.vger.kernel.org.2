Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B78A360F07
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 17:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233685AbhDOPbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 11:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbhDOPbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 11:31:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 941A2C061574
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 08:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uxFNx8Ls1EjAX5avuFuqLLc2lUBNPz30HeVoOn1uPWc=; b=ffatmZJhGimSLIXmb3ZAtXSywv
        eCgq7k6Azr3gDPUc5delTOvcRcZqsDOdai7Ynzwmoya8Es/c40PbkRVyJx6I/k5Y1qQyY2UQYYQCg
        CjkWO7fnhDsl0p54tIlLPel9aAitY4lv/wzNtjhqzip4xRcQhCq+kZ7ZgJf7XQ6xjB338UmTzhdNl
        ZA0yRlLcsdhzof4tMnszeql8DD3CPNDOsojg2UoHLM9Xa/vO3vnm0eZXXhJI4mak3p2xE6ijlvAjk
        +3kxT36sgH+oTMx/U87y4uJ1oFm9vfJASiCMYsjshTYN9MtbiFFAW+JN04IxrbX+dV4P7CsL24DT7
        YAt0e0Iw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lX3wO-008kng-U2; Thu, 15 Apr 2021 15:30:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 839E6300209;
        Thu, 15 Apr 2021 17:29:59 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6C6322C7727AE; Thu, 15 Apr 2021 17:29:59 +0200 (CEST)
Date:   Thu, 15 Apr 2021 17:29:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     tglx@linutronix.de, mingo@kernel.org, bigeasy@linutronix.de,
        swood@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vincent.donnefort@arm.com, qais.yousef@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] sched: Use cpu_dying() to fix balance_push vs
 hotplug-rollback
Message-ID: <YHhb99iRHXcxD2/e@hirez.programming.kicks-ass.net>
References: <20210310145258.899619710@infradead.org>
 <20210310150109.259726371@infradead.org>
 <871rclu3jz.mognet@e113632-lin.i-did-not-set--mail-host-address--so-tickle-me>
 <YHQ3Iy7QfL+0UoM0@hirez.programming.kicks-ass.net>
 <87r1jfmn8d.mognet@arm.com>
 <YHU/a9HvGLYpOLKZ@hirez.programming.kicks-ass.net>
 <YHgAYef83VQhKdC2@hirez.programming.kicks-ass.net>
 <87a6pzmxec.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a6pzmxec.mognet@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2021 at 03:32:11PM +0100, Valentin Schneider wrote:
> > So instead, make sure balance_push is enabled between
> > sched_cpu_deactivate() and sched_cpu_activate() (eg. when
> > !cpu_active()), and gate it's utility with cpu_dying().
> 
> I'd word that "is enabled below sched_cpu_activate()", since
> sched_cpu_deactivate() is now out of the picture.

I are confused (again!). Did you mean to say something like: 'is enabled
below SCHED_AP_ACTIVE' ?
