Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6973D7B84
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 19:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbhG0RAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 13:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbhG0RAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 13:00:14 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F64C061760
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 10:00:10 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id h14so22856975lfv.7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 10:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kvve0PvD+BG/Fg4YS9gRmkOVtrJzBbhe3AaQP2JrJi8=;
        b=BamPGKxkayrhztUhyIbCPdfJ8zOowXYiQvF4Ibi4hR0BXtMIs0NGaC5lPTvZHBn0Bj
         mzTVS882/CQo5XFnXL+kJORZmjlCxYKwnGheT0Mr4xI5I3Yz7pWttn2GW7k6ri8BGFj4
         /tuUI5A98uxjuAqFl1H6Cg6ALu6Gctc66YS0ZJ2uTIrJXzhfOvU5KfgqpqJhu7maJu/a
         NVk17jZ4yzeksCWzllgFbNe9pAgPx0k9n0jdpRhENWB/kHvVMJT0VhWqYjXiQR6GW3yz
         Y5xlnUlSP02eTGvm9lLHUxGDrXWl29SGfFf709MaMb2bdgYobYPeSAp+9ixsNYkmIs2a
         3dOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kvve0PvD+BG/Fg4YS9gRmkOVtrJzBbhe3AaQP2JrJi8=;
        b=LwF3Ue+qciDXXzstj5a5XekB9FRcCrMjKcMHxYGf70BOMrTYocbcTwYrv6mQrSunF3
         QpUuSr5Vx9xMqIaVB7TATy8aX+HO+5O7IbmLHHAR/zRS594QPYYZnqG79q6sWbhPAfo/
         uqxVLdffBgpLNFRm85QaBv2SVOBz8Bpsu6QvMfxbHuOdwr8bg6XBaI1qZRagFmHX1/lk
         mxoQEwo0VqXx5/zzs7o6aBMB4gBs+lHSaSWedr9gRvHiDCG3Y/tgfuyRofE/5AUWKNVy
         /Xxb/oce03lVqAYSvvPVICCY46xGqhDk9x3i7Ujc6DLGAj6Y2OwJIHndbkZKV0ekdh/j
         4Ifg==
X-Gm-Message-State: AOAM532QeZxhmAcuNkfqbb0gzF5Ace3bq8vwS9e6pUIzai9qr4JKmTfG
        grRDdUrZ825SfSA7dRX/XSml6Fl9kUHzyuWGgaRDPg==
X-Google-Smtp-Source: ABdhPJw3HT5zZziCLyixwFiw0R8p8dngZ62UL76GxgmYW/TEr3P9n8CI/cqFloMXIxXkKLzFLg/dz8VKxewa+txr/zw=
X-Received: by 2002:a19:dc50:: with SMTP id f16mr17009143lfj.347.1627405208894;
 Tue, 27 Jul 2021 10:00:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210726150019.251820-1-hannes@cmpxchg.org>
In-Reply-To: <20210726150019.251820-1-hannes@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 27 Jul 2021 09:59:57 -0700
Message-ID: <CALvZod434VzPru+wcO=PgMDeCs6KPgR06MuGVttaDD64_z3QMw@mail.gmail.com>
Subject: Re: [PATCH] mm: memcontrol: fix blocking rstat function called from
 atomic cgroup1 thresholding code
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2021 at 8:01 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> Dan Carpenter reports:
>
>     The patch 2d146aa3aa84: "mm: memcontrol: switch to rstat" from Apr
>     29, 2021, leads to the following static checker warning:
>
>             kernel/cgroup/rstat.c:200 cgroup_rstat_flush()
>             warn: sleeping in atomic context
>
>     mm/memcontrol.c
>       3572  static unsigned long mem_cgroup_usage(struct mem_cgroup *memcg, bool swap)
>       3573  {
>       3574          unsigned long val;
>       3575
>       3576          if (mem_cgroup_is_root(memcg)) {
>       3577                  cgroup_rstat_flush(memcg->css.cgroup);
>                             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
>     This is from static analysis and potentially a false positive.  The
>     problem is that mem_cgroup_usage() is called from __mem_cgroup_threshold()
>     which holds an rcu_read_lock().  And the cgroup_rstat_flush() function
>     can sleep.
>
>       3578                  val = memcg_page_state(memcg, NR_FILE_PAGES) +
>       3579                          memcg_page_state(memcg, NR_ANON_MAPPED);
>       3580                  if (swap)
>       3581                          val += memcg_page_state(memcg, MEMCG_SWAP);
>       3582          } else {
>       3583                  if (!swap)
>       3584                          val = page_counter_read(&memcg->memory);
>       3585                  else
>       3586                          val = page_counter_read(&memcg->memsw);
>       3587          }
>       3588          return val;
>       3589  }
>
> __mem_cgroup_threshold() indeed holds the rcu lock. In addition, the
> thresholding code is invoked during stat changes, and those contexts
> have irqs disabled as well. If the lock breaking occurs inside the
> flush function, it will result in a sleep from an atomic context.
>
> Use the irsafe flushing variant in mem_cgroup_usage() to fix this.
>
> Fixes: 2d146aa3aa84 ("mm: memcontrol: switch to rstat")
> Cc: <stable@vger.kernel.org>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Shakeel Butt <shakeelb@google.com>

BTW what do you think of removing stat flushes from the read side
(kernel and userspace) completely after periodic flushing and async
flushing from update side? Basically with "memcg: infrastructure to
flush memcg stats".
