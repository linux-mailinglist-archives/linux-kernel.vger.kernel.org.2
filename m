Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADE7C366DDB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 16:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239533AbhDUOPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 10:15:06 -0400
Received: from foss.arm.com ([217.140.110.172]:36174 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236522AbhDUOPF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 10:15:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A7FD711B3;
        Wed, 21 Apr 2021 07:14:31 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DE7413F774;
        Wed, 21 Apr 2021 07:14:29 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Arnd Bergmann <arnd@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Paul Turner <pjt@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair: Fix an unused function warning
In-Reply-To: <20210421140145.3767949-1-arnd@kernel.org>
References: <20210421140145.3767949-1-arnd@kernel.org>
Date:   Wed, 21 Apr 2021 15:14:25 +0100
Message-ID: <875z0fvi66.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On 21/04/21 16:01, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> Without CONFIG_NO_HZ_COMMON, there is now a warning about update_nohz_stats
> after the last caller outside the #ifdef was removed
>
> kernel/sched/fair.c:8433:13: error: 'update_nohz_stats' defined but not used [-Werror=unused-function]
>  8433 | static bool update_nohz_stats(struct rq *rq)
>
> Simplify the function by removing the #ifdef inside it and move it into
> the block in which it gets called.
>
> Fixes: 0826530de3cb ("sched/fair: Remove update of blocked load from newidle_balance")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

That should be covered by:

  3f5ad91488e8 ("sched/fair: Move update_nohz_stats() to the CONFIG_NO_HZ_COMMON block to simplify the code & fix an unused function warning")

which currently sits in tip/sched/core. We might want to shove that in
tip/sched/urgent along with the latest in-flight fixes.
