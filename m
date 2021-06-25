Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53A7E3B4118
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 12:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbhFYKHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 06:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbhFYKHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 06:07:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E856C061574
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 03:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YWOhXI1iic/2oVNDa9dMTdaVjRWbXCXhDOxlrjM4OSs=; b=sjBGTl3QwcUDoE/bhWTh0C8CfL
        UAdqCt4iSCggkb1hMQuJb9afTJv5bKjNFfKLxISid4+a1CTqVam3RYIpLHvXwGCS5zW8TroDd1k+s
        xhPsuwWA1r8zr52WEay7pkJJllNgh5ioqcfRwjE7Z9LSgCIMUG9H+kvaAxpD7OQRlLphP1wLZT0X7
        tQ6pnHD9YR3j4j4/kY0a+xgvxisAThQGl4+Pl+lRHMlcGLuVM5UVxwLktOZp4pgaqzdVUhcR423jX
        1gZgAwKhP+IaIhmzW7SsmcXFA1DtB+ruRm6iQzjM/zQfj7MsQ9frnNVFJU7C4IhUSjcKnp48JMTKg
        GKXfd1fw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lwihN-00HXc5-Jd; Fri, 25 Jun 2021 10:04:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 305C8300252;
        Fri, 25 Jun 2021 12:04:33 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DAF2F203C0A78; Fri, 25 Jun 2021 12:04:32 +0200 (CEST)
Date:   Fri, 25 Jun 2021 12:04:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>
Subject: Re: [PATCH] sched/debug: Don't update sched_domain debug directories
 before sched_debug_init()
Message-ID: <YNWqMK34S29Nxy8t@hirez.programming.kicks-ass.net>
References: <20210518130725.3563132-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210518130725.3563132-1-valentin.schneider@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 02:07:25PM +0100, Valentin Schneider wrote:
> Since CPU capacity asymmetry can stem purely from maximum frequency
> differences (e.g. Pixel 1), a rebuild of the scheduler topology can be
> issued upon loading cpufreq, see:
> 
>   arch_topology.c::init_cpu_capacity_callback()
> 
> Turns out that if this rebuild happens *before* sched_debug_init() is
> run (which is a late initcall), we end up messing up the sched_domain debug
> directory: passing a NULL parent to debugfs_create_dir() ends up creating
> the directory at the debugfs root, which in this case creates
> /sys/kernel/debug/domains (instead of /sys/kernel/debug/sched/domains).
> 
> This currently doesn't happen on asymmetric systems which use cpufreq-scpi
> or cpufreq-dt drivers, as those are loaded via
> deferred_probe_initcall() (it is also a late initcall, but appears to be
> ordered *after* sched_debug_init()).
> 
> Ionela has been working on detecting maximum frequency asymmetry via ACPI,
> and that actually happens via a *device* initcall, thus before
> sched_debug_init(), and causes the aforementionned debugfs mayhem.
> 
> One option would be to punt sched_debug_init() down to
> fs_initcall_sync(). Preventing update_sched_domain_debugfs() from running
> before sched_debug_init() appears to be the safer option.
> 
> Link: http://lore.kernel.org/r/20210514095339.12979-1-ionela.voinescu@arm.com
> Fixes: 3b87f136f8fc ("sched,debug: Convert sysctl sched_domains to debugfs")
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>

Thanks!
