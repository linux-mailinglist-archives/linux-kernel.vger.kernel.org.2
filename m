Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55F8A433B62
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 17:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232956AbhJSP6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 11:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbhJSP6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 11:58:52 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9CFC06161C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 08:56:39 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id g36so8571319lfv.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 08:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l6UyNWiQ7BoMTL4xhxCJx0qmxiRi5S2D6EPQ7sUWYlk=;
        b=l1QIf2HBZF5dgneEUJ+69UXIQWgsG1hl9tG/ALRoDN8uvKZfXJBoU7rsMJXh1lZNKI
         YfWcky8Vb3G7jm+T9EvQyUTFJRJDfeVk9V1z9uPGotOg3dNqVH5Sms9muEkC+aB640o/
         +zO0gBrkElrNwfCX9Wm8SRmCUtd02uzXxst0MLpyhq1tPMmR3eq9Lt5pDtrAONArYcfw
         /+wKdCDEbw/h6gSy1jPKXHGRZW+ymnDaZ8hUuVR6ng5sgX0mldtc1Nrs7yeAFJFJ+9NA
         6gpjJHnjAhj4qbVgNykcltsT2tasi1PyEyi307aIIyJsLAc06mFL3/Arxk8dIt8P7+bL
         xtZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l6UyNWiQ7BoMTL4xhxCJx0qmxiRi5S2D6EPQ7sUWYlk=;
        b=1W/KSeGYvHZH1KgbJa5rwwc0g18ibavUnH++2UqN/aTSC/dJpB+VqwgpODcAvPTVTV
         cgI4TzkwOnkKE2agJVlkj8no3ZCOTsttWhLOEvaTHdxaY7THTcXoTxN6benuMrKQS6jZ
         3P9r/33rN7hIPpEuqA0g9VWd8UoKTW5qfuv5+sV9Yy0ZXFAA6rJoPZEw/re4ZJBYK68P
         kHH52YRK8Y1ag85uD6cqSPrQ48QWm+WLxBiqnXwPwGfQV959+/x2VA/bQYxPFodgF7Ct
         xMG9lfQAfV1izy+23ovKq9RBdrj78UxMwK20W7SFSxdQVPz6/NPzLp8aG6xzyDuvbmVK
         xliQ==
X-Gm-Message-State: AOAM532tTrVw0bEZk45kUVCjK/PI+e0hD239pAWeJZM/BMj8B2eUF5ID
        e9QO2d4ENYPKHNS7JqRH0V86/a8W0tFNcc0frftUAw==
X-Google-Smtp-Source: ABdhPJwfXzNPMi50Z1j3h3lnLBVGHBeN9L+8DzOS23moli6FWtmF+LjZ7ijUdDpuzUZz5grrIJm7TkxrD+b1Q8WhkcQ=
X-Received: by 2002:ac2:5e3c:: with SMTP id o28mr6663490lfg.184.1634658997345;
 Tue, 19 Oct 2021 08:56:37 -0700 (PDT)
MIME-Version: 1.0
References: <20211018123710.1540996-1-chenwandun@huawei.com> <20211018123710.1540996-2-chenwandun@huawei.com>
In-Reply-To: <20211018123710.1540996-2-chenwandun@huawei.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 19 Oct 2021 08:56:26 -0700
Message-ID: <CALvZod63A_RsKJKRmAtZFXHB=EzX0JhKXTcoUGg7zn2pgK-Kwg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mm/vmalloc: fix numa spreading for large hash tables
To:     Chen Wandun <chenwandun@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, guohanjun@huawei.com,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2021 at 5:23 AM Chen Wandun <chenwandun@huawei.com> wrote:
>
[...]
>
>         /* High-order pages or fallback path if "bulk" fails. */
> -       while (nr_allocated < nr_pages) {
> -               struct page *page;
> -               int i;
>
> -               page = alloc_pages_node(nid, gfp, order);
> +       page = NULL;

No need for the above NULL assignment.

After removing this, you can add:

Reviewed-by: Shakeel Butt <shakeelb@google.com>

> +       while (nr_allocated < nr_pages) {
> +               if (nid == NUMA_NO_NODE)
> +                       page = alloc_pages(gfp, order);
> +               else
> +                       page = alloc_pages_node(nid, gfp, order);
>                 if (unlikely(!page))
>                         break;
>
> --
> 2.25.1
>
