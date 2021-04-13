Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15B7735E134
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 16:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbhDMORg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 10:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbhDMORe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 10:17:34 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451A0C061756
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 07:17:14 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id r8so27501995lfp.10
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 07:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cZ6kidUHRj7ZJtI2NPkmgGxB5X5ZhGWZ4M1kxQQ4MYE=;
        b=BbdoH85aPSywvPs8poem3KXLPuVQZ0Kud5h/cKfVLSvTpb3s3WRCjKaOnzd7UiQ0yq
         4lA/nQdnm3zKkexJFCHsP8B/J5xwoqKyvfvcAaqxC9Ghrwk7DfHu5Cwy+dDZsN7on+ww
         UZYSmg69HMoOxDD2sujKtzM1tl72CX+LfmA482OIMXPEx9ZfaDCNcfmDQHGXu4seq4Z9
         5MJLRToL1Bxvp7riJ4qerWQwAFlDWg0LwOppAtmUM/JdKapyoDW1zmI18gbeHiBYZVq9
         iIvfcN8Ura4CX2Y4SgtdZV0b2q9ADUWn5FUULh2bUhR+aZD1vQbsw7TH3+2WZyKXbUKc
         4fcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cZ6kidUHRj7ZJtI2NPkmgGxB5X5ZhGWZ4M1kxQQ4MYE=;
        b=rzyvlLL/KefBaSjsfyn4Db+uhbm315sgZaoTl5f2K9IuGTKkxYxYHt6eRAs35ojVbE
         izl2kgaGXCn3kpVtLF24KRlkDCDnJ6uazDtJa+ttWo8+B49cGIzoBpRmxOnzbxs7sUyM
         YaNW+XEsnRozFSl9taaAqmbhSt4LR2CkMPxycYT1AIkqJnIKYJX6yz/8s/SG0nTvvcet
         ywMYBx+XNUBE3d0EO16A1iloXJDI70XZ5iF7LA2KRDV8LRgPxwU7Y6Get1FivZyoa8Dq
         4kZBtLVPV27UhpCYS/1Xqt4ILOXrF2B34lyYs7Bn4F52ZwVFYSGjZ+/ExAN5xubIbzwg
         dkXg==
X-Gm-Message-State: AOAM533ABMjSHgxTXnBAk/e0kOiwkrXCimONWpcYFynO8byBH/MyVFe0
        KfUs8yALVy3WKUgQDREQo+4jeBYiqvALZoaU0Pgh3Q==
X-Google-Smtp-Source: ABdhPJxUo28t6OhONsKty8BOllgQA7NRCoDBCUDBTN+rZWjQ8O6BwzZERctqfq+bNN0cfipLBWKK93kZVz6RjRMm398=
X-Received: by 2002:a05:6512:3703:: with SMTP id z3mr22508451lfr.358.1618323431274;
 Tue, 13 Apr 2021 07:17:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210413065153.63431-1-songmuchun@bytedance.com> <20210413065153.63431-6-songmuchun@bytedance.com>
In-Reply-To: <20210413065153.63431-6-songmuchun@bytedance.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 13 Apr 2021 07:16:58 -0700
Message-ID: <CALvZod4B3-OREkm2ZVGyueUcJRE2igTjhNHTE3nVDSzTVRDs6Q@mail.gmail.com>
Subject: Re: [PATCH 5/7] mm: memcontrol: simplify the logic of objcg pinning memcg
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Roman Gushchin <guro@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        fam.zheng@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2021 at 11:58 PM Muchun Song <songmuchun@bytedance.com> wrote:
>
> The obj_cgroup_release() and memcg_reparent_objcgs() are serialized by
> the css_set_lock. We do not need to care about objcg->memcg being
> released in the process of obj_cgroup_release(). So there is no need
> to pin memcg before releasing objcg. Remove those pinning logic to
> simplfy the code.
>
> There are only two places that modifies the objcg->memcg. One is the
> initialization to objcg->memcg in the memcg_online_kmem(), another
> is objcgs reparenting in the memcg_reparent_objcgs(). It is also
> impossible for the two to run in parallel. So xchg() is unnecessary
> and it is enough to use WRITE_ONCE().
>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
