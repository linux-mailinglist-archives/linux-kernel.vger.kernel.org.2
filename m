Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FCE23FB85F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 16:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237164AbhH3OlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 10:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbhH3OlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 10:41:06 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4A6C061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 07:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=k3MbCq7FJk2FI4LAjukg9GV5w7WF8VEBe/PnT22eBJ0=; b=Sc4Qvje1WpbEeZSSZtu0whkjat
        /F+zsOZEuAuKUAUGoc5xg1vBwOrKc+WRrsrXiV2ruTUwjSLCpRTmPa2xj5vxZKKY+gSFstteU8KTB
        vME4lAH1XnPYqP7xeoJjr5WZLig2v7Id85mefFETPAYR4wBTJBUnfHw672SfbgJmOUvtnVy9yFG4a
        ZJ4zzLnulGcQ+xTITwoKtsp7PDr1CkXpSvLDS1/e7Bx88W73mZbpMy9SiS/cc/8bAOxWyIH0DQ76z
        s6UZQ5FTswneIxVaHIZUz4LwW+yrc3/vPFySbyb5eBqhCfzW/O/r6QzxJ08kq8Lwk7WtDbUNFHn8N
        qN7ctetw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mKiS6-00EQDm-Pi; Mon, 30 Aug 2021 14:39:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 683363001F6;
        Mon, 30 Aug 2021 16:39:55 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 071272C6DAB05; Mon, 30 Aug 2021 16:39:54 +0200 (CEST)
Date:   Mon, 30 Aug 2021 16:39:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Zhang Qiao <zhangqiao22@huawei.com>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        tj@kernel.org
Subject: Re: [PATCH] kernel/sched: Fix sched_fork() access an invalid
 sched_task_group
Message-ID: <YSztujInfNNXkG5/@hirez.programming.kicks-ass.net>
References: <20210826112635.7404-1-zhangqiao22@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210826112635.7404-1-zhangqiao22@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2021 at 07:26:35PM +0800, Zhang Qiao wrote:
> There is a small race between copy_process() and sched_fork()
> where child->sched_task_group point to an already freed pointer.
> 
> parent doing fork()      | someone moving the parent
> 				to another cgroup
> -------------------------------+-------------------------------
> copy_process()
>     + dup_task_struct()<1>
> 				parent move to another cgroup,
> 				and free the old cgroup. <2>
>     + sched_fork()
>       + __set_task_cpu()<3>
>       + task_fork_fair()
>         + sched_slice()<4>
> 
> In the worst case, this bug can lead to "use-after-free" and
> cause panic as shown above,
> (1)parent copy its sched_task_group to child at <1>;
> (2)someone move the parent to another cgroup and free the old
>    cgroup at <2>;
> (3)the sched_task_group and cfs_rq that belong to the old cgroup
>    will be accessed at <3> and <4>, which cause a panic:
> 
> [89249.732198] BUG: unable to handle kernel NULL pointer
> dereference at 0000000000000000
> [89249.732701] PGD 8000001fa0a86067 P4D 8000001fa0a86067 PUD
> 2029955067 PMD 0
> [89249.733005] Oops: 0000 [#1] SMP PTI
> [89249.733288] CPU: 7 PID: 648398 Comm: ebizzy Kdump: loaded
> Tainted: G           OE    --------- -  - 4.18.0.x86_64+ #1
> [89249.734318] RIP: 0010:sched_slice+0x84/0xc0
>  ....
> [89249.737910] Call Trace:
> [89249.738181]  task_fork_fair+0x81/0x120
> [89249.738457]  sched_fork+0x132/0x240
> [89249.738732]  copy_process.part.5+0x675/0x20e0
> [89249.739010]  ? __handle_mm_fault+0x63f/0x690
> [89249.739286]  _do_fork+0xcd/0x3b0
> [89249.739558]  do_syscall_64+0x5d/0x1d0
> [89249.739830]  entry_SYSCALL_64_after_hwframe+0x65/0xca
> [89249.740107] RIP: 0033:0x7f04418cd7e1
> 
> When a new process is forked, cgroup_post_fork() associates it
> with the cgroup of its parent. Therefore this commit move the
> __set_task_cpu() and task_fork() that access some cgroup-related
> fields(sched_task_group and cfs_rq) to sched_post_fork() and
> call sched_post_fork() after cgroup_post_fork().
> 
> Fixes: 8323f26ce342 ("sched: Fix race in task_group")
> Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>

Hmm, I think you're right. Did something recently chagne in cgroup land
to make this more visible? This code hasn't changed in like 9 years.
