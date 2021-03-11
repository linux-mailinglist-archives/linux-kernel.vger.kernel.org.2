Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0BD5337D0B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 19:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbhCKS6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 13:58:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbhCKS5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 13:57:47 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA25C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 10:56:16 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id u20so3515669lja.13
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 10:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sj72PiFPhSmQxSCZm5N0lEERJUa0o1oQN/crzfRE0Qs=;
        b=lkz8vuw+3RRifWr422QzbO45MGu0YpLaTqDPw6zXOM0Kgh3BTWvFlC0I4tyDT2I7zh
         Whc+nGbPZwNmlFMCz7WWW03OKrGjmweRxnhxJkPtvkZfS/Z5JLP/ScwsxtLSNoL0YelN
         f9C/Q4V3h83yUbI95f/weBKNK1ykfxKYrcHjvTB5/OJ1InzrGj0iigPiuFxDDoWbGXfg
         nnhJp4s98wmUvlSa7/HrB0hc19I23IkDmTSZ5LeXS5R9bNzPRZiltE2G9OBLZ3+569y2
         eccfSZ5YUUPqTHNWeMs/wqwF/fvjj5edbqGrQxz9IWsWGXyajrClDfyJ92rvzDb8Xsda
         lNpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sj72PiFPhSmQxSCZm5N0lEERJUa0o1oQN/crzfRE0Qs=;
        b=Mn2eaExGd4nvNcq/WbwgW5ieJLiEUviUlEr3VDYwlMgYe78bQB8D0+wii1PXxxVfNF
         WrVA2fWEIsyCVhnPnEgblfS03uTv83HYYzDskjS79eFWQ1mRy7+lpwNeEQKF89UgKjAw
         ytdZQQ89aqEsz7NAQnkOxwEWKAv/9P1sKHrHFaoPHtRjR2/UBQhyQJCkeP8Bf5R5WlCP
         Y/zfbpOlC8Hnp+e+SyR50Y4Psk8u79Qr/aTRJ5hnqjFdvZfpnZUZU5CCOeP2ORwTyn42
         8asbZ38eYHND1bYDP65S4Fhuus3eN7O4fEeHKELF0OC5DNCPqMyGthdGroE4xFspU9Yq
         uUOw==
X-Gm-Message-State: AOAM531mguTy02JcPxG571phLeYiyHjWAHReRDcjd8FRGtfz02VBIPyq
        wr8UIAIfjJkJ4T0AAE+OX+VhNvYpIMV4zBLh1hu2Ow==
X-Google-Smtp-Source: ABdhPJwU6JRSU7Tk++yDCpBTF31gHC9aFT1b0YhHVcrFFp/ZSeIof9AdMq5xh6RLX7SXeS8+NEaksDf3Di+KXZVGM6A=
X-Received: by 2002:a2e:5c02:: with SMTP id q2mr171505ljb.81.1615488974746;
 Thu, 11 Mar 2021 10:56:14 -0800 (PST)
MIME-Version: 1.0
References: <20210309100717.253-1-songmuchun@bytedance.com> <20210309100717.253-2-songmuchun@bytedance.com>
In-Reply-To: <20210309100717.253-2-songmuchun@bytedance.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 11 Mar 2021 10:56:02 -0800
Message-ID: <CALvZod61mTEK2L_a9a+t10S4XWu-F+-h8SNCaG5UbC+U97v=aQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] mm: memcontrol: introduce obj_cgroup_{un}charge_pages
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

On Tue, Mar 9, 2021 at 2:09 AM Muchun Song <songmuchun@bytedance.com> wrote:
>
> We know that the unit of slab object charging is bytes, the unit of
> kmem page charging is PAGE_SIZE. If we want to reuse obj_cgroup APIs
> to charge the kmem pages, we should pass PAGE_SIZE (as third parameter)
> to obj_cgroup_charge(). Because the size is already PAGE_SIZE, we can
> skip touch the objcg stock. And obj_cgroup_{un}charge_pages() are
> introduced to charge in units of page level.
>
> In the later patch, we also can reuse those two helpers to charge or
> uncharge a number of kernel pages to a object cgroup. This is just
> a code movement without any functional changes.
>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: Roman Gushchin <guro@fb.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
