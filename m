Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6D73424FE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 19:42:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbhCSSmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 14:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbhCSSlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 14:41:51 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8B6C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 11:41:51 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id f3so3149522lfu.5
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 11:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cXH+dcJq1Qlcq3WMXI8ATU9OtVilMFQ65bMjs0UMHDg=;
        b=TNj0S4RC7TT5fCBMitvVKqaFLnlJcsF4VguNB2RglBNykJKE60t/iViTRdbuGJSTdW
         Jom/CweL61c9Awm1E7Vni+jExZ6YjT0S8087YMEicMdkwhqLtAfuNv04zroDU/nWW0p2
         Qg+nT/q1zls7iPv8jQD4WpC1Ms55Sx/gL1l1BiK32+aZPZSoe/n3dADP754AUvRSU5Gg
         XQvWAzp6B+V3hTMZ+OO7HleYi/IG3wS3/5YA1fiPCBnh9PyTjS1e/J1+/1wxiG2/axn2
         gEFIdQTLmR02h7X5lHRtGj0jlQdVljlzUm0Z/hMLWRGyXDDhyr89qEuMsqxvc0o42D82
         qwMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cXH+dcJq1Qlcq3WMXI8ATU9OtVilMFQ65bMjs0UMHDg=;
        b=fNoSDvqTkEl0oQPMAn0UZxatx3cyP62lEmEElYdnqXweW9x5h3Cnoi0rQuHbag2+sP
         it8fAZTB6bZCC6t3IneABY8kIQBptZZOYZjr1Va234mtMmfVPV/G2gwgVUSOSfrOdpgK
         nHsdRskgZQfwIc1laEZJL6WoUqLw0fQnTykiYHo/jutJuA7VwIG8k5K01BPca+gwPbRF
         uAFCCuVkFzfU4Z4U0l6p4mbUvlVhcAOavKpudyHp0yYbKXuvYmNQ8RLQaxTIzsJcYhzr
         jnoGPrWcpSzGf2xPHMFJztI0RZtJ0LhRalaTzXIbpfa7nVhgOFnhxw9iphr87UvwQgZx
         OHHQ==
X-Gm-Message-State: AOAM531GwYO+pq24TsZhB6coLviRNYh+3YBun50Q+kRCxjBCjRgHghjq
        70CSIY9Toh6ik11Gfwmw7dD2DQITDIaMlv0HdK9nbQ==
X-Google-Smtp-Source: ABdhPJyrAfzmjkQYw4/g8LnPrVLlVrXyj52MFJSwFtLn0VxSQB/GR7s/IV7p/Dh+hfLKc9FbdEOXyeebzZQzD5wrKmo=
X-Received: by 2002:a05:6512:b93:: with SMTP id b19mr1519816lfv.432.1616179309422;
 Fri, 19 Mar 2021 11:41:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210319163821.20704-1-songmuchun@bytedance.com> <20210319163821.20704-7-songmuchun@bytedance.com>
In-Reply-To: <20210319163821.20704-7-songmuchun@bytedance.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 19 Mar 2021 11:41:37 -0700
Message-ID: <CALvZod4aUu--86T7t5CMs1Z+o5Kpts9b+BHPug2JTUiddgTtZQ@mail.gmail.com>
Subject: Re: [PATCH v5 6/7] mm: memcontrol: inline __memcg_kmem_{un}charge()
 into obj_cgroup_{un}charge_pages()
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

On Fri, Mar 19, 2021 at 9:39 AM Muchun Song <songmuchun@bytedance.com> wrote:
>
> There is only one user of __memcg_kmem_charge(), so manually inline
> __memcg_kmem_charge() to obj_cgroup_charge_pages(). Similarly manually
> inline __memcg_kmem_uncharge() into obj_cgroup_uncharge_pages() and
> call obj_cgroup_uncharge_pages() in obj_cgroup_release().
>
> This is just code cleanup without any functionality changes.
>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
