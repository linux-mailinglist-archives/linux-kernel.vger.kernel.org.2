Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59C1639A64C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 18:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbhFCQzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 12:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhFCQzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 12:55:31 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10CBC06174A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Jun 2021 09:53:29 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id f12so8019043ljp.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 09:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t0rBINIjyYVjiWlKA6CZdf8Cu1m85/b95NW0HipMWEw=;
        b=RT6DDw3hX0Vd0D9y8P1+wlBANWRsJKcOTL5XNuqjuoqdcO+eVWb3h5lPuPBdWbpXRP
         qS7RpEK9U4hewHkB9ReHFH0CpGE6xxnLud53HxAhqun48esVrJ2Tsyp+XW2wrFLkrwHK
         lH/KFiL4LHRVHxBi+EJaxQ1OcbONA/XKS1BDaSuddZH/u57dzNoDmqyVp/ACKK8Zo9xA
         GYN86bl7bcGB1HAkjN9u3Li/fE5sVQbAL/zx25EkFYVTSn2KJIenbUvhjj/7OSdYsqOj
         aF8pnMaxmokmARnSb/3P9IcKdc1ySVi+6IVr0FK6l431NPIU5pv9T8uTmzgRjZmKVxX7
         SuIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t0rBINIjyYVjiWlKA6CZdf8Cu1m85/b95NW0HipMWEw=;
        b=hO0tmClOSx0ZQf8DXxFaChcx0OrHgQHHgkRPcCmoEt1prZVND9R34+gpuR7XZIKAmz
         Zue2VzQZSrOVUQnG+NcAFV8D47HpqRRE6X33boqg1E7yIRoBRfhGsqXX+BdH2pyTaA7i
         9ER1JYzg4fL16wL8+KUIjikgNQeIAGsF1k3qZ0M3q9f0yuivgr5CV5w1D0+3KxTicqXT
         yvrB1jac5GRAQmeTrBKpGLIVFei0ZJ9ObYvFmP+qdaDfV/wQzUT5/0dTl2fyoRNpIiQs
         I9aqsH/WDoPiEYakOmlm0trRDCua6DTZvsGmeOBW2gGyxY/MX3bsPmuiMPEhsoO3Mx+X
         DsHA==
X-Gm-Message-State: AOAM532zjM4gbtt/QmF5ZFE7H01I35rML4PRdajjg/CGRuHojpkcTyO3
        AOBN+n5eAz3dFLUOJU2awd1J4xu/umwMq6UlgqFJHg==
X-Google-Smtp-Source: ABdhPJzeDeSBqXYAQ4z4rfvcdsvKYnRBUfk/V02cbzoITVb8r8bIa3oFG903QpB57v+azcbplWWae+BaY+2ulj+HrVI=
X-Received: by 2002:a05:651c:210f:: with SMTP id a15mr235460ljq.160.1622739208042;
 Thu, 03 Jun 2021 09:53:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210603145707.4031641-1-schatzberg.dan@gmail.com> <20210603145707.4031641-3-schatzberg.dan@gmail.com>
In-Reply-To: <20210603145707.4031641-3-schatzberg.dan@gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 3 Jun 2021 09:53:16 -0700
Message-ID: <CALvZod5=-Q_xFP3-8hUe4dzJ5_U+omi2R7Leen2s_sqn2+5VbA@mail.gmail.com>
Subject: Re: [PATCH 2/3] mm: Charge active memcg when no mm is set
To:     Dan Schatzberg <schatzberg.dan@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, Chris Down <chris@chrisdown.name>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 3, 2021 at 7:57 AM Dan Schatzberg <schatzberg.dan@gmail.com> wrote:
>
> set_active_memcg() worked for kernel allocations but was silently
> ignored for user pages.
>
> This patch establishes a precedence order for who gets charged:
>
> 1. If there is a memcg associated with the page already, that memcg is
>    charged. This happens during swapin.
>
> 2. If an explicit mm is passed, mm->memcg is charged. This happens
>    during page faults, which can be triggered in remote VMs (eg gup).
>
> 3. Otherwise consult the current process context. If there is an
>    active_memcg, use that. Otherwise, current->mm->memcg.
>
> Previously, if a NULL mm was passed to mem_cgroup_charge (case 3) it
> would always charge the root cgroup. Now it looks up the active_memcg
> first (falling back to charging the root cgroup if not set).
>
> Signed-off-by: Dan Schatzberg <schatzberg.dan@gmail.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Acked-by: Tejun Heo <tj@kernel.org>
> Acked-by: Chris Down <chris@chrisdown.name>
> Acked-by: Jens Axboe <axboe@kernel.dk>
> Reviewed-by: Shakeel Butt <shakeelb@google.com>

Can you please rebase over the latest mm tree? Specifically over
Muchun's patch "mm: memcontrol: bail out early when !mm in
get_mem_cgroup_from_mm".
