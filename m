Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0711F3399C9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 23:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235642AbhCLWn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 17:43:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235640AbhCLWnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 17:43:00 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4200C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 14:42:59 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id v9so47787532lfa.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 14:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vNFX3HHiQJMdOb9029SXx4uJ49l+AgHck3C0FgRZcTA=;
        b=QkxFqsK/wpGEqSaZuVpiQAI4chLLzOCi8NwnOOTBxrN+8ogT9JhUCo2aN+PWFBSMJo
         0CI2GC4SeHoJIDwxZC4R7gEECvO/yRTK19oBKU5qtS+uS8fEfvbx4OBbUyOKchv9ptWk
         nK4PbXeh1FEvoiLq70pC59k0UaFTEeBaBdotPUHor7cqqAUxWD0tGnjJz9fashqml2nl
         ylDJCZgCymGqAcrSVN18Iv7MlXd//42IYbY37tFQDjqwUF9vKBAyonSMwrcmeb8TpqB2
         W98MZQPaYYimHG3VGrvZYT1YKGFyM44q4Ie5P55ra/wRBfcE+KXNyHg9sdvUxZBLm6Kt
         zqsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vNFX3HHiQJMdOb9029SXx4uJ49l+AgHck3C0FgRZcTA=;
        b=ClgwLm5yJ4t7ExBTLc8yTJ0HTpNzCHZ90JEBpX0bhV3E1TJ/qn16wqYq303e/2c528
         YgtqI/xcSPQXqzUZA8lfbB1yKEUAMnqOzFMhBXlz67uaEZEbhsLXKN5YQpcntXxSDJL8
         A/6aTmLKwQZBzUC+PLWwE2UlaWbRaOg3Vbjhdp+/RrKw92yDVGgz0bcOKKCm15WTZxce
         HQEawBv3vx63rpd4yGerOO67+Rb+LvIVRpLjl3mmbAYBGplXJwZBlXFg/VxXCXgva3fs
         FmEnEWb2OkcNb5OonZ1tHoE/0MXQ9CyReqp2F+OtSKFlNR/ITDp48v3zf5EiRQgCXePn
         sMtw==
X-Gm-Message-State: AOAM533gQz3moHtWW7OZo0aTbJFdIvfHG0SnU2SyRSE//gncOrrqY+nC
        sKpm6B7oJ3F56d9CUVxMkjHs0bn9XKXDmMGnSelA4juQ3QY=
X-Google-Smtp-Source: ABdhPJy8Uk2cZCYdisKmgw9wh7bIhRLCkr/CF3SBYoLZLt7QghsfwFf14P8v0qSnbAYrgB6mBBjwkELAOf81FeFEBiA=
X-Received: by 2002:a19:e0d:: with SMTP id 13mr804184lfo.549.1615588978110;
 Fri, 12 Mar 2021 14:42:58 -0800 (PST)
MIME-Version: 1.0
References: <20210309100717.253-1-songmuchun@bytedance.com>
 <20210309100717.253-3-songmuchun@bytedance.com> <YEoXLX37sVgULO4A@cmpxchg.org>
 <CAMZfGtXZqe7g6e4wf=tUZqxBs-F1QkS2=01Td4Rv3_qTuF0bPA@mail.gmail.com> <YEu/pnK0n8nI2OBy@cmpxchg.org>
In-Reply-To: <YEu/pnK0n8nI2OBy@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 12 Mar 2021 14:42:45 -0800
Message-ID: <CALvZod5sEcsu9AHAzdkJyjxm4ws_aKXyyer99+f2rs-OnOQAMg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v3 2/4] mm: memcontrol: make
 page_memcg{_rcu} only applicable for non-kmem page
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johannes,

On Fri, Mar 12, 2021 at 11:23 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
[...]
>
> Longer term we most likely need it there anyway. The issue you are
> describing in the cover letter - allocations pinning memcgs for a long
> time - it exists at a larger scale and is causing recurring problems
> in the real world: page cache doesn't get reclaimed for a long time,
> or is used by the second, third, fourth, ... instance of the same job
> that was restarted into a new cgroup every time. Unreclaimable dying
> cgroups pile up, waste memory, and make page reclaim very inefficient.
>

For the scenario described above, do we really want to reparent the
page cache pages? Shouldn't we recharge the pages to the second,
third, fourth and so on, memcgs? My concern is that we will see a big
chunk of page cache pages charged to root and will only get reclaimed
on global pressure.
