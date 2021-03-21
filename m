Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E310634345D
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 20:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbhCUTbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 15:31:00 -0400
Received: from foss.arm.com ([217.140.110.172]:43418 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229930AbhCUTam (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 15:30:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C87E0ED1;
        Sun, 21 Mar 2021 12:30:41 -0700 (PDT)
Received: from e107158-lin (unknown [10.1.195.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E0A383F718;
        Sun, 21 Mar 2021 12:30:39 -0700 (PDT)
Date:   Sun, 21 Mar 2021 19:30:37 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     valentin.schneider@arm.com, tglx@linutronix.de, mingo@kernel.org,
        bigeasy@linutronix.de, swood@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vincent.donnefort@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] cpumask: Introduce DYING mask
Message-ID: <20210321193037.7o3mqcmwjthbos7n@e107158-lin>
References: <20210310145258.899619710@infradead.org>
 <20210310150109.151441252@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210310150109.151441252@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/10/21 15:53, Peter Zijlstra wrote:
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -160,6 +160,9 @@ static int cpuhp_invoke_callback(unsigne
>  	int (*cb)(unsigned int cpu);
>  	int ret, cnt;
>  
> +	if (bringup != !cpu_dying(cpu))

nit: this condition is hard to read

> +		set_cpu_dying(cpu, !bringup);

since cpu_dying() will do cpumask_test_cpu(), are we saving  much if we
unconditionally call set_cpu_dying(cpu, !bringup) which performs
cpumask_{set, clear}_cpu()?

> +
>  	if (st->fail == state) {
>  		st->fail = CPUHP_INVALID;
>  		return -EAGAIN;

Thanks

--
Qais yousef
