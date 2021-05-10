Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64FEB377990
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 02:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbhEJAzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 20:55:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:33778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229941AbhEJAzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 20:55:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F1A90613CD;
        Mon, 10 May 2021 00:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1620608044;
        bh=b1iyFhP93PLYe183MwIZhu4SLDJGahzFM+EHwvxRKxQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Xx8+8MR6Ik0YNRnih52LHJJp7wdu+H2nY5NpKdl7wRS9vhP0EsyqskBnuzF4pRXDW
         l3ytroX/P9+QKvPZeQeWxoRNs1fYsyJbkECfwYH9W1q5aMKbLGWCylXyV+NgQ2n4Or
         HDJO0G93SEYnifPBEPt7KacT6mOLfIyTJlkKX4DQ=
Date:   Sun, 9 May 2021 17:54:03 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        shakeelb@google.com, vdavydov.dev@gmail.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        zhengqi.arch@bytedance.com
Subject: Re: [PATCH v2] mm: memcontrol: fix root_mem_cgroup charging
Message-Id: <20210509175403.ec3f33f293ed69f2a9b275a6@linux-foundation.org>
In-Reply-To: <20210425075410.19255-1-songmuchun@bytedance.com>
References: <20210425075410.19255-1-songmuchun@bytedance.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Apr 2021 15:54:10 +0800 Muchun Song <songmuchun@bytedance.com> wrote:

> The below scenario can cause the page counters of the root_mem_cgroup
> to be out of balance.
> 
> CPU0:                                   CPU1:
> 
> objcg = get_obj_cgroup_from_current()
> obj_cgroup_charge_pages(objcg)
>                                         memcg_reparent_objcgs()
>                                             // reparent to root_mem_cgroup
>                                             WRITE_ONCE(iter->memcg, parent)
>     // memcg == root_mem_cgroup
>     memcg = get_mem_cgroup_from_objcg(objcg)
>     // do not charge to the root_mem_cgroup
>     try_charge(memcg)
> 
> obj_cgroup_uncharge_pages(objcg)
>     memcg = get_mem_cgroup_from_objcg(objcg)
>     // uncharge from the root_mem_cgroup
>     refill_stock(memcg)
>         drain_stock(memcg)
>             page_counter_uncharge(&memcg->memory)
> 
> get_obj_cgroup_from_current() never returns a root_mem_cgroup's objcg,
> so we never explicitly charge the root_mem_cgroup. And it's not
> going to change. It's all about a race when we got an obj_cgroup
> pointing at some non-root memcg, but before we were able to charge it,
> the cgroup was gone, objcg was reparented to the root and so we're
> skipping the charging. Then we store the objcg pointer and later use
> to uncharge the root_mem_cgroup.
> 
> This can cause the page counter to be less than the actual value.
> Although we do not display the value (mem_cgroup_usage) so there
> shouldn't be any actual problem, but there is a WARN_ON_ONCE in
> the page_counter_cancel(). Who knows if it will trigger? So it
> is better to fix it.
> 

It sounds like Roman will be acking this, but some additional reviewer
attention would be helpful, please.

