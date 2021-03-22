Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED1273448CE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 16:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbhCVPI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 11:08:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:37530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231732AbhCVPHm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 11:07:42 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F6876192E;
        Mon, 22 Mar 2021 15:07:38 +0000 (UTC)
Date:   Mon, 22 Mar 2021 11:07:37 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, valentin.schneider@arm.com,
        tglx@linutronix.de, mingo@kernel.org, bigeasy@linutronix.de,
        swood@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vincent.donnefort@arm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] cpumask: Introduce DYING mask
Message-ID: <20210322110737.221f4b78@gandalf.local.home>
In-Reply-To: <20210321193037.7o3mqcmwjthbos7n@e107158-lin>
References: <20210310145258.899619710@infradead.org>
        <20210310150109.151441252@infradead.org>
        <20210321193037.7o3mqcmwjthbos7n@e107158-lin>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Mar 2021 19:30:37 +0000
Qais Yousef <qais.yousef@arm.com> wrote:

> On 03/10/21 15:53, Peter Zijlstra wrote:
> > --- a/kernel/cpu.c
> > +++ b/kernel/cpu.c
> > @@ -160,6 +160,9 @@ static int cpuhp_invoke_callback(unsigne
> >  	int (*cb)(unsigned int cpu);
> >  	int ret, cnt;
> >  
> > +	if (bringup != !cpu_dying(cpu))  
> 
> nit: this condition is hard to read

Would
	if (bringup == !!cpu_dying(cpu))

read better?

-- Steve

> 
> > +		set_cpu_dying(cpu, !bringup);  

