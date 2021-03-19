Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C18713424A0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 19:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbhCSS1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 14:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbhCSS1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 14:27:09 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BBD0C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 11:27:08 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id z8so13085635ljm.12
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 11:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xEgTM8goNhFr4u/gIHLrFfwU7ZSevF9DK4Zkeu0KaRA=;
        b=gkobKDRtucesZHj59ZLQ0guW7RSwOPKQIDcFHyWebfXpvepkdLlbwRPmA0ZDgM29wJ
         k3r9P2ckqoszoC+MbL2nzQzl4R8Y4UlzbzKUa28Fx1UuEqwyhHMKSp/41Kvje46CfhV8
         6KUFSSMB2vbR8oCZlZ6TraMJnnvGwbO+rwB2pkuJ12k9m4cNlrouwLwF7V4KIwM/YKLf
         FZU8IOXfTacily4A+JaKbYogjJ+c+Dj6QT4GzYgT8sS5l9Ng/6FmSO76bPDdZxKy+DrX
         GlHOeXfAjksva8jHhhBq1nbjUJXUJ2vjM6CtJxF0f76zI8DF01rtdVbgJSFLc/g69yzR
         Am6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xEgTM8goNhFr4u/gIHLrFfwU7ZSevF9DK4Zkeu0KaRA=;
        b=qc0HMcbMua2OQtwJ6OU/8ukTWXVGgZcv/C4pf8AYRzL67DnRC/wSAenMFQd3DyI1k6
         a/Te81MvdXPi+EowZyLfcsj2yEt1zgTLe1V4poy3Be1SoxaGjaYW5Eqoad73qPnrRpga
         KnVn1vI7FJ58HVtxWsGK+D1nBVw6ufVFsKdNiV11JhnTkcxY77qS7QAx+JX/olgaZfvJ
         yneYxFATuhmrjXpf12+Pjgo9FhbmpNW5/jMpKrtZe/GFeKNHG6A8o9Hnv8I6dsvPrXbq
         YRwlTk17HxxDEZDF8IfdLpzb5rJ+SSog33nBYqK7n3vbEgz1p35BF+qJFxIcw6xA4yFR
         ocWQ==
X-Gm-Message-State: AOAM533zizqc89atViWakgKinOJkM19SQXHM3Lv6KBslSXl1gopv70A6
        cOUfLo8N1EZXtYAzK4xguvfQmDLd0l1bJfLM/eCpEA==
X-Google-Smtp-Source: ABdhPJxRkFwrYYAzNJyJG6nE5njJ2Fc/r/LoFTWp57jg1QYGk8XHsuJM8QaWfnKNE42iVFf0e71Z/3FrHsEJojVnKKs=
X-Received: by 2002:a2e:7d03:: with SMTP id y3mr1723814ljc.0.1616178426606;
 Fri, 19 Mar 2021 11:27:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210319163821.20704-1-songmuchun@bytedance.com> <20210319163821.20704-2-songmuchun@bytedance.com>
In-Reply-To: <20210319163821.20704-2-songmuchun@bytedance.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 19 Mar 2021 11:26:54 -0700
Message-ID: <CALvZod73P5QORH58wRi4a2wNnhxCKsGWkFB8Ko79G8SNWr9fhg@mail.gmail.com>
Subject: Re: [PATCH v5 1/7] mm: memcontrol: slab: fix obtain a reference to a
 freeing memcg
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Roman Gushchin <guro@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2021 at 9:38 AM Muchun Song <songmuchun@bytedance.com> wrote:
>
> The rcu_read_lock/unlock only can guarantee that the memcg will not be
> freed, but it cannot guarantee the success of css_get (which is in the
> refill_stock when cached memcg changed) to memcg.
>
>   rcu_read_lock()
>   memcg = obj_cgroup_memcg(old)
>   __memcg_kmem_uncharge(memcg)
>       refill_stock(memcg)
>           if (stock->cached != memcg)
>               // css_get can change the ref counter from 0 back to 1.
>               css_get(&memcg->css)
>   rcu_read_unlock()
>
> This fix is very like the commit:
>
>   eefbfa7fd678 ("mm: memcg/slab: fix use after free in obj_cgroup_charge")
>
> Fix this by holding a reference to the memcg which is passed to the
> __memcg_kmem_uncharge() before calling __memcg_kmem_uncharge().
>
> Fixes: 3de7d4f25a74 ("mm: memcg/slab: optimize objcg stock draining")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Good catch.

Reviewed-by: Shakeel Butt <shakeelb@google.com>
