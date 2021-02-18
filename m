Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6BA31EFE9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 20:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232446AbhBRTdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 14:33:25 -0500
Received: from foss.arm.com ([217.140.110.172]:54422 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233380AbhBRSwY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 13:52:24 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D7A21FB;
        Thu, 18 Feb 2021 10:51:37 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3957A3F694;
        Thu, 18 Feb 2021 10:51:36 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Lingutla Chandrasekhar <clingutla@codeaurora.org>,
        linux-kernel@vger.kernel.org
Cc:     juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org,
        pkondeti@codeaurora.org, peterz@infradead.org, mingo@kernel.org,
        Lingutla Chandrasekhar <clingutla@codeaurora.org>
Subject: Re: [PATCH] sched/fair: Ignore percpu threads for imbalance pulls
In-Reply-To: <jhjim6qsq8g.mognet@arm.com>
References: <20210217120854.1280-1-clingutla@codeaurora.org> <jhjim6qsq8g.mognet@arm.com>
User-Agent: Notmuch/0.21 (http://notmuchmail.org) Emacs/26.3 (x86_64-pc-linux-gnu)
Date:   Thu, 18 Feb 2021 18:51:24 +0000
Message-ID: <jhj35xtryz7.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/02/21 14:50, Valentin Schneider wrote:
> @@ -7539,6 +7539,9 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
>       if (throttled_lb_pair(task_group(p), env->src_cpu, env->dst_cpu))
>               return 0;
>
> +	if (kthread_is_per_cpu(p))
> +		return 0;
> +

That's missing a (p->flags & PF_KTHREAD), but you get the idea...
