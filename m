Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA53F387A5F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 15:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235264AbhERNte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 09:49:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:45650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245330AbhERNt1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 09:49:27 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92B1961185;
        Tue, 18 May 2021 13:48:08 +0000 (UTC)
Date:   Tue, 18 May 2021 09:48:07 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Yejune Deng <yejune.deng@gmail.com>, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        Yejune Deng <yejunedeng@gmail.com>
Subject: Re: [PATCH] sched: simplify is_cpu_allowed() code
Message-ID: <20210518094807.57cb7fb7@gandalf.local.home>
In-Reply-To: <YKPA0v3we3WTWIy2@hirez.programming.kicks-ass.net>
References: <1621342486-9643-1-git-send-email-yejunedeng@gmail.com>
        <YKPA0v3we3WTWIy2@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 May 2021 15:27:46 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Tue, May 18, 2021 at 08:54:46PM +0800, Yejune Deng wrote:
> > Combine multiple if statements that return the same value.  
> 
> This patch is not a nop; You now deny cpu_dying() for everyone, while we
> explicitly allow it for kthread_is_per_cpu().

Right. The patch is flawed in many ways. You don't combine if statements
just because they return the same value, if you are messing with the order
of the checks.

	if (A)
		return false;

	if (B)
		return true;

	if (C)
		return false;

is not the same as

	if (A || C)
		return false

	if (B)
		return true;

Please don't do that.

-- Steve
