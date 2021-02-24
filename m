Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F69B324402
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 19:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234049AbhBXSr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 13:47:58 -0500
Received: from foss.arm.com ([217.140.110.172]:44212 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234634AbhBXSrN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 13:47:13 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 14FE9D6E;
        Wed, 24 Feb 2021 10:46:28 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 314433F73B;
        Wed, 24 Feb 2021 10:46:26 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        joel@joelfernandes.org
Cc:     fweisbec@gmail.com, tglx@linutronix.de, qais.yousef@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH 0/7 v4] move update blocked load outside newidle_balance
In-Reply-To: <20210224133007.28644-1-vincent.guittot@linaro.org>
References: <20210224133007.28644-1-vincent.guittot@linaro.org>
User-Agent: Notmuch/0.21 (http://notmuchmail.org) Emacs/26.3 (x86_64-pc-linux-gnu)
Date:   Wed, 24 Feb 2021 18:46:23 +0000
Message-ID: <jhjblc95mo0.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/02/21 14:30, Vincent Guittot wrote:
> Joel reported long preempt and irq off sequence in newidle_balance because
> of a large number of CPU cgroups in use and having to be updated. This
> patchset moves the update outside newidle_imblance. This enables to early
> abort during the updates in case of pending irq as an example.
>
> Instead of kicking a normal ILB that will wakes up CPU which is already
> idle, patch 6 triggers the update of statistics in the idle thread of
> the CPU before selecting and entering an idle state.
>
> Changes on v4:
> - Add a dedicated bit for updating blocked load when entering idle.
>   This simplifies the management of concurrency with kick_ilb.
>

I believe that solves the issues vs nohz balance.

One last thing for patch 7: mayhaps we could do a tad better to avoid
duplicate updates going through a heapful of leaf cfs rqs, see

  http://lore.kernel.org/r/jhj4kiht7oh.mognet@arm.com


Otherwise, feel free to add to the lot:

  Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>

