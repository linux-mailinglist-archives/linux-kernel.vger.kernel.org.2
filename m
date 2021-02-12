Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF91031A541
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 20:22:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbhBLTVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 14:21:01 -0500
Received: from foss.arm.com ([217.140.110.172]:41594 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231430AbhBLTUs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 14:20:48 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 96DEF11B3;
        Fri, 12 Feb 2021 11:20:02 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 424CF3F719;
        Fri, 12 Feb 2021 11:20:00 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        joel@joelfernandes.org
Cc:     fweisbec@gmail.com, tglx@linutronix.de, qais.yousef@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH 7/7 v3] sched/fair: reduce the window for duplicated update
In-Reply-To: <20210212141744.24284-8-vincent.guittot@linaro.org>
References: <20210212141744.24284-1-vincent.guittot@linaro.org> <20210212141744.24284-8-vincent.guittot@linaro.org>
User-Agent: Notmuch/0.21 (http://notmuchmail.org) Emacs/26.3 (x86_64-pc-linux-gnu)
Date:   Fri, 12 Feb 2021 19:19:58 +0000
Message-ID: <jhj4kiht7oh.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/02/21 15:17, Vincent Guittot wrote:
> Start to update last_blocked_load_update_tick to reduce the possibility
> of another cpu starting the update one more time
>

IIUC this can happen if e.g. a CPU is busy updating load in
update_blocked_averages() while another enters update_nohz_stats() for the
same rq. They'll be serialized by the RQ lock, but both can still enter
update_blocked_averages() at roughly the same time.

Shouldn't then the rq->last_blocked_load_update_tick check be either
deferred to or re-done within update_blocked_averages(), with the rq lock
held?
