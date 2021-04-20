Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B01E7365F07
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 20:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233344AbhDTSKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 14:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232879AbhDTSKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 14:10:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E6CC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 11:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SPTMAO5GTaDQ+7NUwJdz95Zoo+fxOIqSbvNGNaKE5VM=; b=WZ1N1anmpOgQWJZdY7LRbc672x
        rjSJ0EpV7jJHpIS3UBxWs0G1IgPY1YmwX8SaYO8yuILXbJPlKc3pG92GvC7EXBfqqyMqMVr5MEA+G
        44HhCJwEgHBJd+UcKD2J4z5lLF9nZcNrhhnDsHQ2D0NyTUWNkRH+lwSev36rXJE5ZQLo5ZJwm6ejw
        UFT/XAsMqf5XUHBjJPeG7O/k6yc9I22HrNxUkFQvcO5WweI0JdGMVQja3OuVSv7m22Jbbdqh1M3PZ
        UvUEML3cNwTEMKzoZeAFam9hR/IMNQH6g/ZgRqHaVsQX2OE1Kn9vS5MuwzkIAofsurLcstOui2CsI
        ycWNi+GA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lYumE-00FTmN-0Q; Tue, 20 Apr 2021 18:07:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BC5B730013E;
        Tue, 20 Apr 2021 20:07:08 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 80FE4201F6C23; Tue, 20 Apr 2021 20:07:08 +0200 (CEST)
Date:   Tue, 20 Apr 2021 20:07:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        tglx@linutronix.de, mingo@kernel.org, bigeasy@linutronix.de,
        swood@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, qais.yousef@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] sched: Use cpu_dying() to fix balance_push vs
 hotplug-rollback
Message-ID: <YH8YTJfCkFJcGu30@hirez.programming.kicks-ass.net>
References: <87r1jfmn8d.mognet@arm.com>
 <YHU/a9HvGLYpOLKZ@hirez.programming.kicks-ass.net>
 <YHgAYef83VQhKdC2@hirez.programming.kicks-ass.net>
 <87a6pzmxec.mognet@arm.com>
 <20210419105541.GA40111@e120877-lin.cambridge.arm.com>
 <20210420094632.GA165360@e120877-lin.cambridge.arm.com>
 <YH7jSPZx0BhyHoLe@hirez.programming.kicks-ass.net>
 <YH7niBZDWjsz+jBa@hirez.programming.kicks-ass.net>
 <YH7r+AoQEReSvxBI@hirez.programming.kicks-ass.net>
 <20210420165340.GA231208@e120877-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210420165340.GA231208@e120877-lin.cambridge.arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20, 2021 at 05:53:40PM +0100, Vincent Donnefort wrote:
> All good with that snippet on my end.
> 
> I wonder if balance_push() shouldn't use the cpu_of() accessor
> instead of rq->cpu.

That might be a personal quirk of mine, but for code that is under
CONFIG_SMP (as all balancing code must be) I tend to prefer the more
explicit rq->cpu usage. cpu_of() obviously also works.

> Otherwise,
> 
> + Reviewed-by: Vincent Donnefort <vincent.donnefort@arm.com>

Thanks!, now I get to write a Changelog :-)
