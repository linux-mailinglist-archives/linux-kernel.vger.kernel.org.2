Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D10C376B1B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 22:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbhEGURE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 16:17:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:44498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230021AbhEGURD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 16:17:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9156861451;
        Fri,  7 May 2021 20:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620418563;
        bh=hW8BhI6/ilAGYrQpT8jNIDf24wBxHiG1Opwd9jIHan4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IlESx7c3UgT7TwzAn5Qw4/rUW+Y2MowooSLrsuoZNA8IbWTpy8hXmfe3X4WvBK/Hb
         KsEKUpSzmS2QSYy9fQy7QNF5VHT9KvRXF8E8otrIU6AcOT3tpj10ZYMVuRYN3SDovX
         ijBHdj8WDcJeeMwhwpjhVrPMuj80e7tyFwc+514XjwhvSSZ7Gz0ou2xXLbbX3OFxKI
         j7MdGgrRP0tDdl1nzudb2X7vYvi7fxPDwArTp3MauLspOY1TswPhbxGmYB0Stp2pWt
         uJ9vK52y/mTdzfvA7yNkJIX3VZUMsf0d2GHjyVLZ4E9AIzRZd2fprp1puFw1jxhsje
         qLCnO0B0xAEnA==
Date:   Fri, 7 May 2021 22:16:00 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Phil Auld <pauld@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] Revert "isolcpus: Affine unbound kernel threads to
 housekeeping cpus"
Message-ID: <20210507201600.GA66223@lothringen>
References: <20210507165710.GA429056@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210507165710.GA429056@fuller.cnet>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 07, 2021 at 01:57:10PM -0300, Marcelo Tosatti wrote:
> 
> 
> commit 9cc5b8656892a72438ee7deb introduced a new housekeeping flag,
> HK_FLAG_KTHREAD, that when enabled sets the CPU affinity for the 
> kthreadd process (therefore all unbounded kernel threads created
> from that point on will use the housekeeping cpumask).
> 
> This is not necessary, since its possible to control placement of
> kthreadd from userspace:
> 
> # taskset -c -p 0 `pgrep kthreadd`
> pid 2's current affinity list: 1
> pid 2's new affinity list: 0
> 
> Unbounded kernel threads started from that point on will inherit
> the kthreadd cpumask.

Hmm, but look below:

> @@ -405,8 +404,7 @@ struct task_struct *__kthread_create_on_
>  		 * The kernel thread should not inherit these properties.
>  		 */
>  		sched_setscheduler_nocheck(task, SCHED_NORMAL, &param);
> -		set_cpus_allowed_ptr(task,
> -				     housekeeping_cpumask(HK_FLAG_KTHREAD));
> +		set_cpus_allowed_ptr(task, cpu_possible_mask);

That inheritance is then overriden, right?

Thanks.
