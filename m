Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3F94259AD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 19:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242798AbhJGRnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 13:43:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:56680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242002AbhJGRnB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 13:43:01 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 081526121F;
        Thu,  7 Oct 2021 17:41:05 +0000 (UTC)
Date:   Thu, 7 Oct 2021 13:41:03 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     pmladek@suse.com, keescook@chromium.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, peterz@infradead.org,
        valentin.schneider@arm.com, mathieu.desnoyers@efficios.com,
        qiang.zhang@windriver.com, robdclark@chromium.org,
        christian@brauner.io, dietmar.eggemann@arm.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] kernel/kthread: show a warning if kthread's comm
 is truncated
Message-ID: <20211007134103.4da8a8ab@gandalf.local.home>
In-Reply-To: <20211007120752.5195-5-laoar.shao@gmail.com>
References: <20211007120752.5195-1-laoar.shao@gmail.com>
        <20211007120752.5195-5-laoar.shao@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  7 Oct 2021 12:07:52 +0000
Yafang Shao <laoar.shao@gmail.com> wrote:

> -		vsnprintf(name, sizeof(name), namefmt, args);
> +		len = vsnprintf(name, sizeof(name), namefmt, args);
> +		if (len >= TASK_COMM_LEN) {
> +			pr_warn("truncated kthread comm:%s, pid:%d by %d characters\n",
> +				name, task->pid, len - TASK_COMM_LEN + 1);

Instead of saying how many characters it is truncated to, what about just
showing what it was truncated to?

			pr_warn("truncated kthread comm from:%s to:%.*s for pid:%d\n",
				name, TASK_COMM_LEN - 1, name, task->pid);

?

-- Steve

> +		}
