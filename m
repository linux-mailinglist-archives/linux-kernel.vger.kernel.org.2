Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC09A416A67
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 05:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243966AbhIXD1z convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 23 Sep 2021 23:27:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:33698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235369AbhIXD1y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 23:27:54 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 315B161211;
        Fri, 24 Sep 2021 03:26:21 +0000 (UTC)
Date:   Thu, 23 Sep 2021 23:26:19 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] trace: prevent preemption in
 perf_ftrace_function_call()
Message-ID: <20210923232619.50103473@oasis.local.home>
In-Reply-To: <7f4dfb4a-d271-b3c5-f603-06cc789ba9e9@linux.alibaba.com>
References: <2470f39b-aed1-4e19-9982-206007eb0c6a@linux.alibaba.com>
        <20210923093359.30da8ba6@gandalf.local.home>
        <7f4dfb4a-d271-b3c5-f603-06cc789ba9e9@linux.alibaba.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Sep 2021 10:08:10 +0800
王贇 <yun.wang@linux.alibaba.com> wrote:

> I found the rcu tree implementation of rcu_is_watching() will check
> this_cpu_ptr(&rcu_data.dynticks), and after that enable the preemption.
> 
> If preemption happened after that and before we disable here, there are
> still possibility that the CPU changed and make the dynticks checking
> invalid, isn't it?

If it can be scheduled, then RCU is definitely watching ;-)

The rcu_is_watching() is a safe guard for places that are in between
context switches. Not task context switches, but transitioning between
kernel and user space, or going into or out of idle, or transitioning
in and out of an interrupt.  There are small critical sections that RCU
is not watching, and we are actually working on making those locations
disable instrumentation (like tracing), where rcu_is_watching() will no
longer be needed.

-- Steve
