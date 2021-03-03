Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0DEC32BF8A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1579853AbhCCScY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:32:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347322AbhCCQuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 11:50:07 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB5FC061756
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 08:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UgK6CdUmVmia3F32TSqVm1rGFuB6oMqXqSZlCi1K1AA=; b=duaUVIGPobMFDZfqpJdAQfeR/U
        Lf82qEMloQKwNyG6quGc3BDub7P0dT0k0CIYRkRGzec3vT4+UzvmKDsxIohkEuY0vyNp1hxznx7nJ
        GRUraaCyC/uCOp6v8P1FhkLXB8Bms4yTxrpjGwmk/mc4KYKHZjw2FGxRHlMsu4iyJ9IMbEBkYv+IP
        tTJRB7ccd/hd/3dr59/2rTIaonz9EYwdJEe6OC57zyLssT7STGvAvn47g06YPi2mF1cwK0Mwlx/J5
        8wm8NEEto+4sPQnu0pAGD49zKnqFIpScSpsIBjW9ZoiJpgTgif1eIIUuqhnykAp2iEJG+OjDqEGPc
        gSroglCw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lHToH-005Tcr-F4; Wed, 03 Mar 2021 15:53:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 00736303205;
        Wed,  3 Mar 2021 16:53:13 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E44C923662BEE; Wed,  3 Mar 2021 16:53:12 +0100 (CET)
Date:   Wed, 3 Mar 2021 16:53:12 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     hannes@cmpxchg.org, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        songmuchun@bytedance.com
Subject: Re: [PATCH v2 4/4] psi: Optimize task switch inside shared cgroups
Message-ID: <YD+w6Gbb49LeIQb1@hirez.programming.kicks-ass.net>
References: <20210303034659.91735-1-zhouchengming@bytedance.com>
 <20210303034659.91735-5-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210303034659.91735-5-zhouchengming@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2021 at 11:46:59AM +0800, Chengming Zhou wrote:
> The commit 36b238d57172 ("psi: Optimize switching tasks inside shared
> cgroups") only update cgroups whose state actually changes during a
> task switch only in task preempt case, not in task sleep case.
> 
> We actually don't need to clear and set TSK_ONCPU state for common cgroups
> of next and prev task in sleep case, that can save many psi_group_change
> especially when most activity comes from one leaf cgroup.
> 
> sleep before:
> psi_dequeue()
>   while ((group = iterate_groups(prev)))  # all ancestors
>     psi_group_change(prev, .clear=TSK_RUNNING|TSK_ONCPU)
> psi_task_switch()
>   while ((group = iterate_groups(next)))  # all ancestors
>     psi_group_change(next, .set=TSK_ONCPU)
> 
> sleep after:
> psi_dequeue()
>   nop
> psi_task_switch()
>   while ((group = iterate_groups(next)))  # until (prev & next)
>     psi_group_change(next, .set=TSK_ONCPU)
>   while ((group = iterate_groups(prev)))  # all ancestors
>     psi_group_change(prev, .clear=common?TSK_RUNNING:TSK_RUNNING|TSK_ONCPU)
> 
> When a voluntary sleep switches to another task, we remove one call of
> psi_group_change() for every common cgroup ancestor of the two tasks.
> 
Co-developed-by: Muchun ?
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
