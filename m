Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B77063DB149
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 04:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236182AbhG3CnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 22:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbhG3CnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 22:43:15 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599D3C0613C1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 19:43:10 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id a20so9363776plm.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 19:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2k7fEyFu7zGXyqWbkTSjvJ6JOYMr8rw/z8q7mEIUc8A=;
        b=JgClgnU9EdwSANU8A5FerpxJDoCmKESOX5v+FZM6r2TrDY8Hsmgx4fSSGUaIChBFJW
         nJ4E/ZBbz1I3MA/8EDBPDxWMF5E3u1sHgvJuQ0NooOw3kwGeUDjcHTC+SoVHq9wRE0PY
         V4+8QyMzbmoBDl3xFidcOKambkn17SDAQFg8woP+NP1uNpxlfm+hNQguFbWO9M9rTIVj
         MwfqoK+BfnglDvvyR3no3rQ73c+0mKGVgwByOa85doAmoI1ui4CnZ0yfBRS+cazSq3l2
         5gkMKx8CC8QVd/AoL8jHejUm2ApZHIr/tSINLrhVkby6HYZ5KngrD4z7/lZ6WSX0Me4t
         aXPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2k7fEyFu7zGXyqWbkTSjvJ6JOYMr8rw/z8q7mEIUc8A=;
        b=uhLiIwRUeY+mloLaJ2VUKEyzQj23FPntwrdHLx982zTpU6CsmIbiWbwP7rtRFusLdD
         DpuNjvvteLeQcVSL6IOZcNe8tlNQZFYiHEbYPpzh4Nvc7GNoaOFmCjX5fZozrr6jIbmR
         PlEpEHmOh/9MpEC/JMZNdXrS5WKFuyUM+QHD1qwvYM7dc0AHk0m4tHnPjbJNh3xRIu9u
         xR1qHayn1NKIohAqQ71vrb3VA1g280WjNOZ/WqkphY4FnATNXOF/a+xdN/lp7Kn2m/h2
         IMNYTbuKOFWuCdpMxEfzfXXCMck3Zv4M7rxUN7oz2Qn4yMNe47RnPdPKqmWjATHLK2Tq
         DanQ==
X-Gm-Message-State: AOAM532qdyL539N9ySHEaUAud9/S5QHOBF8pP4XYKG4Pi5b6pEXExsif
        hyBecvWAZa1XAFckd/B7bIpj2rnRKyVLHN1p5cztTw==
X-Google-Smtp-Source: ABdhPJyKMjwJtks3kZrAExse5sOaTz+Y2l4NgrwbHMWIdimiFgom2e4JKhi5i2WQTiXiZnf08teTGdgENzry63QbeGo=
X-Received: by 2002:a17:902:6ac9:b029:12c:3bac:8d78 with SMTP id
 i9-20020a1709026ac9b029012c3bac8d78mr348102plt.34.1627612989962; Thu, 29 Jul
 2021 19:43:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210729125755.16871-1-linmiaohe@huawei.com> <20210729125755.16871-3-linmiaohe@huawei.com>
In-Reply-To: <20210729125755.16871-3-linmiaohe@huawei.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 30 Jul 2021 10:42:29 +0800
Message-ID: <CAMZfGtWESFeDgV7H4N6ch+PpwYAkV+=qPJKiamnZ7sX=6t3e4g@mail.gmail.com>
Subject: Re: [PATCH 2/5] mm, memcg: narrow the scope of percpu_charge_mutex
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alex Shi <alexs@kernel.org>,
        Wei Yang <richard.weiyang@gmail.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 29, 2021 at 8:58 PM Miaohe Lin <linmiaohe@huawei.com> wrote:
>
> Since percpu_charge_mutex is only used inside drain_all_stock(), we can
> narrow the scope of percpu_charge_mutex by moving it here.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

LGTM.

Reviewed-by: Muchun Song <songmuchun@bytedance.com>
