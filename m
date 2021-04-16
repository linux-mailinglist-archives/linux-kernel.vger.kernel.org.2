Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1053626C9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 19:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242273AbhDPRav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 13:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234404AbhDPRar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 13:30:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166BAC061574
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 10:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8TWUEpRZp/QTwrvwYSXbnkSx60aeb88p1od16kj1Quo=; b=EP6h+yaataVxruWXk8aKNrfi1k
        K0yIMUSpQWcoq9exyCKf/XnXGnRr8a6iPUzUFoxVMcvCBOuTMlJrPZsfjfgNfWkQTId+jgu6FtUvU
        TLBvi8CneTR+9DIFMgLjjMP4koEMwYc3vAlfFsrMAP7Mgza6IbWSXey3OTKthxO/trfHn/qucpbau
        QJDCqiNDihOKNtNShpiSdC4RNw21ci0Zatd0BeewNkD2zSgY+5JIogS4W5z8Z0x1J25AQEe+YwGVo
        EuRfhXo8OYEoypPgxzGYMS9MZoEQwiWRnnLXmC8Viy8W8tkK8wzSJ0n8ggnd15+f9dyNofQvL8MYK
        CCrayGEw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lXSGz-00AFKB-Ko; Fri, 16 Apr 2021 17:28:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EF4ED3001FF;
        Fri, 16 Apr 2021 19:28:52 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CE6B124C0E74A; Fri, 16 Apr 2021 19:28:52 +0200 (CEST)
Date:   Fri, 16 Apr 2021 19:28:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Bharata B Rao <bharata@linux.vnet.ibm.com>,
        Phil Auld <pauld@redhat.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] sched/debug: Use sched_debug_lock to serialize use of
 cgroup_path[] only
Message-ID: <YHnJVK5N1QMTlDgm@hirez.programming.kicks-ass.net>
References: <20210415195426.6677-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210415195426.6677-1-longman@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2021 at 03:54:26PM -0400, Waiman Long wrote:
> The handling of sysrq key can be activated by echoing the key to
> /proc/sysrq-trigger or via the magic key sequence typed into a terminal
> that is connected to the system in some way (serial, USB or other mean).
> In the former case, the handling is done in a user context. In the
> latter case, it is likely to be in an interrupt context.
> 
> Currently in print_cpu() of kernel/sched/debug.c, sched_debug_lock is
> taken with interrupt disabled for the whole duration of the calls to
> print_*_stats() and print_rq() which could last for the quite some time
> if the information dump happens on the serial console.
> 
> If the system has many cpus and the sched_debug_lock is somehow busy
> (e.g. parallel sysrq-t), the system may hit a hard lockup panic
> depending on the actually serial console implementation of the
> system. For instance,
> 
...
> 
> The purpose of sched_debug_lock is to serialize the use of the global
> cgroup_path[] buffer in print_cpu(). The rests of the printk calls don't
> need serialization from sched_debug_lock.
> 
> Calling printk() with interrupt disabled can still be problematic if
> multiple instances are running. Allocating a stack buffer of PATH_MAX
> bytes is not feasible because of the limited size of the kernel stack.
> 
> The solution implemented in this patch is to allow only one caller at a
> time to use the full size group_path[], while other simultaneous callers
> will have to use shorter stack buffers with the possibility of path
> name truncation. A "..." suffix will be printed if truncation may have
> happened.  The cgroup path name is provided for informational purpose
> only, so occasional path name truncation should not be a big problem.
> 
> Fixes: efe25c2c7b3a ("sched: Reinstate group names in /proc/sched_debug")
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Waiman Long <longman@redhat.com>

Thanks!
