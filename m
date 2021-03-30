Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14CC934DE19
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 04:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbhC3COL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 22:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbhC3COI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 22:14:08 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7AD7C061762
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 19:14:07 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id m7so10617642pgj.8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 19:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A+W3TeeQ+CFLjInxB7jJ8DoAPGAMGkk/5XTsXaeHgbU=;
        b=O+1pcnhivoUaF3JAzcPjuitpd6X9JWxq86Dvyl8iJO871PDQhIgqszOCTcxNAfJs27
         hCsHvywAXt/RWNMEzNrvBmD1Repsn1xQnys5hgLdCM7ekhIxdUJAm6qj+ReE3X5lQn/R
         i8ddQ2IJMydxE+1VWz3U1w+XipRjFIo7RazrGtv0sN12Vh3FBWNiPyYhJaW/2/zXu2A/
         metPowlj1rxCaVL7Y389sVWWDZHIIP3H0ORPK7O1Y30opA1BxVWG4igUGMDe1EWDdkBb
         bx/7mJkzk9pxTpA0a1ZkKQFMBn/tpVfEIV0tdNdeSQhAO/6/nTqzFqkqckspdR+dSdgo
         6yPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A+W3TeeQ+CFLjInxB7jJ8DoAPGAMGkk/5XTsXaeHgbU=;
        b=rgbLD+0Ad9qGe3qfZoB4KHU5I7WCjS4xwGsABWJRyUmXAlrgRw7y8y4/CbQuKibuN4
         FlDTAFTzXG8QUPlT+P3jAN4mKvf0LnwLDxfs62towDSyKjqzLddFi3QFdKQazXUtsaK/
         uo0g2jaJGawYR4umGHXGQhh2NGO6DsBh+mkDIh7do8XhCh+rUIVnPkjlXQcbSajo52Ot
         vT80ZPy7JZmBVCoVq3+Sdy+Mek006MSPNUr7mN8k4tHEIgZ+K2C/tTDGvs586icUMdtC
         /v0ZyHYyJ62UOwS9v2m49tBq4rlkLsFOQLNStbZMzGP6VHZcKziVnSo11GtWZ4EMFthJ
         7ntg==
X-Gm-Message-State: AOAM531q8xbJiy0KZQ5T/Ov6nxCpuad3u9oIGieK7MBHmqpCNclWwyHk
        vx5IK5cRgHQV+41IY1Q+8fNBsURp9yVq7OqNYVCNXw==
X-Google-Smtp-Source: ABdhPJx4AfNhP8brz6xPci92lQLbahnnyxILHNy7smBTzxjm1IZ3U8nQTw+QwnNGdstRE2X+LMa1qqKHz+cw23mVa2Y=
X-Received: by 2002:a63:141e:: with SMTP id u30mr26923738pgl.31.1617070447404;
 Mon, 29 Mar 2021 19:14:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210330020246.2265371-1-wanjiabing@vivo.com>
In-Reply-To: <20210330020246.2265371-1-wanjiabing@vivo.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 30 Mar 2021 10:13:30 +0800
Message-ID: <CAMZfGtVSNVC2zapQPxN-G=Pk6vk2VWa0jf235-Vz8F-zjSTKDQ@mail.gmail.com>
Subject: Re: [External] [PATCH] linux/memcontrol.h: Remove duplicate struct declaration
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, kael_w@yeah.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 10:03 AM Wan Jiabing <wanjiabing@vivo.com> wrote:
>
> struct mem_cgroup is declared twice. One has been declared
> at forward struct declaration. Remove the duplicate.
>
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.

> ---
>  include/linux/memcontrol.h | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 0c04d39a7967..f0ae33a0f175 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1068,8 +1068,6 @@ void split_page_memcg(struct page *head, unsigned int nr);
>  #define MEM_CGROUP_ID_SHIFT    0
>  #define MEM_CGROUP_ID_MAX      0
>
> -struct mem_cgroup;
> -
>  static inline struct mem_cgroup *page_memcg(struct page *page)
>  {
>         return NULL;
> --
> 2.25.1
>
