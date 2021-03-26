Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7810334A61B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 12:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbhCZLGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 07:06:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:38598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229832AbhCZLGV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 07:06:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D9A4061A14;
        Fri, 26 Mar 2021 11:06:20 +0000 (UTC)
Date:   Fri, 26 Mar 2021 12:06:19 +0100
From:   Greg KH <greg@kroah.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, mgorman@suse.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        joshdon@google.com, valentin.schneider@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/9] sched: Move SCHED_DEBUG to debugfs
Message-ID: <YF3AK1SwSwLNT6Y6@kroah.com>
References: <20210326103352.603456266@infradead.org>
 <20210326103935.025550243@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210326103935.025550243@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2021 at 11:33:56AM +0100, Peter Zijlstra wrote:
> Stop polluting sysctl with undocumented knobs that really are debug
> only, move them all to /debug/sched/ along with the existing
> /debug/sched_* files that already exist.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  include/linux/sched/sysctl.h |    8 +--
>  kernel/sched/core.c          |    4 +
>  kernel/sched/debug.c         |   74 +++++++++++++++++++++++++++++++--
>  kernel/sched/fair.c          |    9 ----
>  kernel/sched/sched.h         |    2 
>  kernel/sysctl.c              |   96 -------------------------------------------
>  6 files changed, 80 insertions(+), 113 deletions(-)

Yes!!!

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
