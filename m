Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDCF935F5EE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 16:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233419AbhDNOKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 10:10:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:58458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232646AbhDNOKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 10:10:43 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E185761166;
        Wed, 14 Apr 2021 14:10:20 +0000 (UTC)
Date:   Wed, 14 Apr 2021 10:10:19 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kcarcia@redhat.com,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Clark Willaims <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>, linux-doc@vger.kernel.org
Subject: Re: [RFC PATCH 1/5] tracing/hwlat: Add a cpus file specific for
 hwlat_detector
Message-ID: <20210414101019.7c5a66f6@gandalf.local.home>
In-Reply-To: <94bbcd0e0f06b79aeb775e8dbf3a301f6679bb4c.1617889883.git.bristot@redhat.com>
References: <cover.1617889883.git.bristot@redhat.com>
        <94bbcd0e0f06b79aeb775e8dbf3a301f6679bb4c.1617889883.git.bristot@redhat.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  8 Apr 2021 16:13:19 +0200
Daniel Bristot de Oliveira <bristot@redhat.com> wrote:

> Provides a "cpus" interface to the hardware latency detector. By
> default, it lists all CPUs, allowing hwlatd threads to run on any online
> CPU of the system.
> 
> It serves to restrict the execution of hwlatd to the set of CPUs writing
> via this interface. Note that hwlatd also respects the "tracing_cpumask."
> Hence, hwlatd threads will run only on the set of CPUs allowed here AND
> on "tracing_cpumask."
> 
> Why not keep just "tracing_cpumask"? Because the user might be interested
> in tracing what is running on other CPUs. For instance, one might run
> hwlatd in one HT CPU while observing what is running on the sibling HT
> CPU. The cpu list format is also more intuitive.
> 
> Also in preparation to the per-cpu mode.

OK, I'm still not convinced that you couldn't use tracing_cpumask here.
Because we have instances, and tracing_cpumask is defined per instance, you
could simply do:

 # cd /sys/kernel/tracing
 # mkdir instances/hwlat
 # echo a > instances/hwlat/tracing_cpumask
 # echo hwlat > instances/hwlat/current_tracer

Now the tracing_cpumask above only affects the hwlat tracer.

I'm just reluctant to add more tracing files if the current ones can be
used without too much trouble. For being intuitive, let's make user space
tools hide the nastiness of the kernel interface ;-)

-- Steve

