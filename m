Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9B4363CE4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 09:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237837AbhDSHqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 03:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbhDSHqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 03:46:37 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF89C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 00:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=NsE5l7uKoP9LJcXeetBCx8Qr0TbzT5ZnbTo1mIkm78I=; b=RgrZozy4e/GPhLoaWqwzat/ZhW
        VOfrHKXbdIHCFRiltxPu261yr6YVMLwc+3xtnvAtuWW9fNTg4Cl0rpxpmcs7mBenzAGf4pitixTGi
        Ud0HVgDIMPCxUIDNcp9FIzAXI2zeA9Kd7KcvQAvqDIiLRz/MW84xzBcTPnXTwD6QReB8CShccj8WR
        j4va0PFto54i61KdGngasQtyhmdKY3vgRxa9u1GRryNi7xCEOXIZqdVvLHM6n6tmJEoBR4KduSgMq
        UwmN9gxXUmw8CLjWSr1NmYN3Kz1vOnz3xbx2lStICiu9gKEf/K/B2hUaAf4/z3HtV9D/qzmdpPY79
        sb2QIGqg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lYObI-009Nxr-Tb; Mon, 19 Apr 2021 07:45:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0411C300212;
        Mon, 19 Apr 2021 09:45:42 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CBEF1200D4310; Mon, 19 Apr 2021 09:45:42 +0200 (CEST)
Date:   Mon, 19 Apr 2021 09:45:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     =?utf-8?B?5ZGo5Lyg6auY?= <zhouchuangao@vivo.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Michal Hocko <mhocko@suse.com>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] kernel/hung_task: Add a whitelist and blacklist
 mechanism.
Message-ID: <YH01JvQErt6qfPac@hirez.programming.kicks-ass.net>
References: <YHryaegfV9jo6aiL@hirez.programming.kicks-ass.net>
 <AIUATwAUDmin4z7rh1*KA4pi.3.1618796786331.Hmail.zhouchuangao@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AIUATwAUDmin4z7rh1*KA4pi.3.1618796786331.Hmail.zhouchuangao@vivo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 19, 2021 at 09:46:26AM +0800, 周传高 wrote:
> 
> >On Sat, Apr 17, 2021 at 07:13:01AM -0700, zhouchuangao wrote:
> >> eg:
> >> In Android system, we usually and some processes to the whitelist.
> >> static task_t task_whitelist[] = {
> >> 	{"mdrt_thread", HUNG_TASK_WHITELIST},
> >> 	{"chre_kthread", HUNG_TASK_WHITELIST},
> >> 	{"scp_power_reset", HUNG_TASK_WHITELIST},
> >> 	{"ccci_fsm1", HUNG_TASK_WHITELIST},
> >> 	{"qos_ipi_recv", HUNG_TASK_WHITELIST},
> >> 	{NULL, 0},
> >> };
> >
> >What are these tasks doing that the hung-task detector fires on them?
> >Should you fix that instead?
> 
> These tasks are implemented by the SoC vendor, and normally they do
> not configure HUNG TASK, so we need to ignore these tasks if we use
> HUNG TASK. 

Then raise a bug against their crap software, don't try and work around
it in the kernel.

We're not going to upstream workarounds for crap vendor software.
