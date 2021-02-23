Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D280322D64
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 16:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233227AbhBWPXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 10:23:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233175AbhBWPWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 10:22:53 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B115C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 07:22:10 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id u4so17982778lja.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 07:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XGL+ZEl1VxWchCvh5LCCnMOsswk/yP/QAWF1B7tp0PE=;
        b=Wy4BbxDEhgR4O7gMewi35UNKdoIq+5jPJHkEkUPI4l+zHkf/xvB3AtgtOh0iXos53O
         Zk5wGQPK48Zhpdf64dMiDAILYpmCATxqBwyi0OlNqSYSwz+hK+/9WNhp8lMNLJqBX99c
         wK4rGFVCouTcrfF/JOUpofuiPJ8fF49tqSkBBrTFMUmEw9nAgfPYyBuuln6d8YW5I8Vc
         keqpKNlB6pCw7G2BICq8n+GOkqOstBrhwKcOBIXQybErStqxgPXeiIgiNLY1VeybMdgO
         kzt0LAl78laUJAX1afg+UQPm4iS7baqN1P55qK5me5WGklMBebxv6wW+nN/50r8akgA1
         a/dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XGL+ZEl1VxWchCvh5LCCnMOsswk/yP/QAWF1B7tp0PE=;
        b=fgh2tGwaf8cP4lsQi8l4WCPCRm7gPT3tisIn5D409nmLLzAkqNq2Da11tRNVReDJJz
         qEqJEpaj63bJLT42G+NTMo9Y+R7Mw8dPau1l1UsqbTSuDeVZviknqh94GESq3kzUK3kk
         GVkdPv08iOTKEP0cOQK8dodx3pvcQrbzMl4VMOsqD7VE9Te0+5DBL+P4AqfJKkAhKAKK
         4dp4ax2qFI/hk6iqt7BepTfgxXeaAbYwSGWUFkDKgbRvj/eCk2gwm4MvJXLs82g32y8X
         ImqNleSIl5XJbKYh0buEjWfwFoltBBqVHqtAfJnbmuZTLH5Us6pkWOXmwiMX9lioZF22
         eCDw==
X-Gm-Message-State: AOAM532p//XM26ePrWK/hkaKuMV+SeCy/0Wqr0OM0zQv1x1ezgO/IdV3
        bzIvfika6D8Jb5hhis6tWDQIglT2OuRTK/MzkukgvA==
X-Google-Smtp-Source: ABdhPJwIlmw07SdzqXAyuw6LI5ynN6o9c4dTEnBt/ZtckCdCovwV8lO7Org5W5KV9NSnIS4DjO6/q9OP4G3TRBtQBhw=
X-Received: by 2002:a2e:b4e8:: with SMTP id s8mr17816849ljm.34.1614093728978;
 Tue, 23 Feb 2021 07:22:08 -0800 (PST)
MIME-Version: 1.0
References: <20210223092423.42420-1-songmuchun@bytedance.com>
In-Reply-To: <20210223092423.42420-1-songmuchun@bytedance.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 23 Feb 2021 07:21:58 -0800
Message-ID: <CALvZod4fYvxusqw=g=Sc99eiW5pd7Qu0YFh=SpUna5Ltd9Pwbg@mail.gmail.com>
Subject: Re: [PATCH] mm: memcontrol: fix slub memory accounting
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 23, 2021 at 1:25 AM Muchun Song <songmuchun@bytedance.com> wrote:
>
> SLUB currently account kmalloc() and kmalloc_node() allocations larger
> than order-1 page per-node. But it forget to update the per-memcg
> vmstats. So it can lead to inaccurate statistics of "slab_unreclaimable"
> which is from memory.stat. Fix it by using mod_lruvec_page_state instead
> of mod_node_page_state.
>
> Fixes: 6a486c0ad4dc ("mm, sl[ou]b: improve memory accounting")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
