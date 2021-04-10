Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5CF35AF5E
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 19:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234923AbhDJRpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 13:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234392AbhDJRo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 13:44:59 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D05C06138A
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 10:44:44 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id v140so14741232lfa.4
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 10:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=esMk4wtxK5QjSki1w8GqTaqU70e3m70uQ3+iN1O/jRI=;
        b=lhHzahZDj1gMLdiDi/XX+TdfvNNizYENvZUbJwrIUVRU2/diE7cFZPVpW/k1XaJiBf
         b+/7c5kXVs/jFVIqGKAxF3563w6mBH8JshvbRE82Ghv4LAA8So5dRJ7W5BQZMxcKQSN8
         sLkwNYwC2/ZSoxkID3sMpuXqG/zHr2NtSvRID1sL6S2nJlRT+94R/Jhnn32dkzO6Lf2h
         mZnqG0pYukR+aVuDWGkgGZnCrYG8d5vG+Db13eVBcCl1LufrnKDqCwNVCsNKsRsxrOsb
         Ib/W98X/9r1yhITrnUfy/1YY609MeDAXRqPacRJTeVQPOlmd6XYPcAaZD+rBxdKJQDAn
         ptxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=esMk4wtxK5QjSki1w8GqTaqU70e3m70uQ3+iN1O/jRI=;
        b=ZpSBVi7ZSR2PnGmA1HbdC61h0vfG/xlGIJd4yP7LCggwp9+0zX3K5I5GNIfuzuccBw
         jKt8ekRuf16OYplQECTf5qlkheo8/Hk4faI8tFlJlVPWVBs8GZWidm1zrFQi8b5FGV4F
         ZQbWJBGcydXPttMgPRCmPlmfKu9WWGf6+WJBHnkQaJUrbADpJwLMTFuezA6ytbrHp74f
         HiQN8IUO3jITinmp6d1k0BrYTQ/vHJ0vbB2ni49iXul4hzGUZe7u4F9tNTlTvbD4l+sq
         MyQ99qrNaAXIvevlXpsyfb3Bxch9HsCP8WHGQU8vMdkWb4A3lKeYrzndp5zQ2/SF9lpX
         pk6Q==
X-Gm-Message-State: AOAM532bY5XuUA/LhYVzxM22ZJ/oqoUFSRHZe0/1fG7wIoDWSk5lGJU6
        MLuyojrrdGMt91NEpr9z0b2G+TLVTqqq2TydOn9GYg==
X-Google-Smtp-Source: ABdhPJwCIxB9VaioeQzZKXJb1BZEo4stMYbxAma3VmJJVffcYjLv02rlt0z2a3FumM27zs/qNy4cun6iw9RiSkQaz9U=
X-Received: by 2002:a05:6512:c04:: with SMTP id z4mr13907650lfu.299.1618076682646;
 Sat, 10 Apr 2021 10:44:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210409122959.82264-1-songmuchun@bytedance.com> <20210409122959.82264-2-songmuchun@bytedance.com>
In-Reply-To: <20210409122959.82264-2-songmuchun@bytedance.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Sat, 10 Apr 2021 10:44:30 -0700
Message-ID: <CALvZod7kYwt7XfuC6LnZreswKrXRLnUEZ7LbSSuNtgb-rdo=RA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 01/18] mm: memcontrol: fix page charging in page replacement
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Roman Gushchin <guro@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        fam.zheng@bytedance.com, Balbir Singh <bsingharora@gmail.com>,
        Yang Shi <shy828301@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 9, 2021 at 5:32 AM Muchun Song <songmuchun@bytedance.com> wrote:
>
> The pages aren't accounted at the root level, so do not charge the page
> to the root memcg in page replacement. Although we do not display the
> value (mem_cgroup_usage) so there shouldn't be any actual problem, but
> there is a WARN_ON_ONCE in the page_counter_cancel(). Who knows if it
> will trigger? So it is better to fix it.
>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
