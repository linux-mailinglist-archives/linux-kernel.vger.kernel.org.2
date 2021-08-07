Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 329F53E3394
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 07:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbhHGFYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 01:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbhHGFYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 01:24:19 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58140C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Aug 2021 22:24:02 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id g13so22228291lfj.12
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 22:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZqLuhYgeKsDqWSkoQoYju4RuNI8asvlPSwM2IzFO9Fo=;
        b=svcPRaGPcibReGcJQX+H6QEohG/XfPy6C4LUhMRFPhJh96e9BmeeibzkJRw4ZjY1mR
         bj9zeWWjVelGDg2HjiK8364mXmS4h6JPB4cXYUp+FTRFDt/ywfQa8Tw3qhwR9oB86ikQ
         Q9YcR8ZLzyhR/pjuyuCwKwByfJ5VhiVidPbQrqoWHUl3v3qgAJhuKUxhYDvYanGMRtAu
         dMLO7ngzUxE8krTsaofMQrH2Rk9SgoHmNijDRCWnj2miXffPDAMJquWYU7ZwFz1iEqFS
         OHUVf2vYXMXpVT8jYC39Opw57CIMRXDkBmubvdpA3mq0AD3DLxJTKK2c0eojcu0qgIxV
         WaQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZqLuhYgeKsDqWSkoQoYju4RuNI8asvlPSwM2IzFO9Fo=;
        b=RNEr+hkeXJJ0PYdPApmG+Y2Qg5Ub2btMpQfTTYmvm15f1nC9N8zLWKmB/rJezSDYaq
         cua4mpkCcb8pyTztHnc/5M2HNeLZCX0Z6uhyl5JsfSLr5H9GOt7FqRv8rK4FDdGA6R2R
         bWquig7aD8dMiQUOQDwYG0aBXAgXb/iTMc0I0AAlac95/9Oes9/8yqbqj8ZNM1src8kC
         zVz1czzwIhpA9/ytKOC3gxx/XPyBjZ4mjcGD397sKT+jaXyV4qz3TZ6B+aiz385eutVw
         SmSU270dVpRqAT3CYA6dFPGqK3PVn1X6sNianSVqry3Q/WaCILL46Mq+cBn5OpcfzAGe
         wP/A==
X-Gm-Message-State: AOAM5316QaUJ2tV2IrG1oLq4QFiqkX6xEVLO9gRxSLZ/OMHdQSUENI9D
        ZShKlryuHR19s0AxlOvdoVNw3BKvz/vcKSilo/P1mw==
X-Google-Smtp-Source: ABdhPJxdoadSOx3CDgngRPDA+viNO0fADRiTs6/EPBW/zvuM5Awj/9LY2isJL4+CnvMx//QCQNg+7EYunVVFPZ1FF6E=
X-Received: by 2002:a05:6512:376d:: with SMTP id z13mr5726308lft.347.1628313840113;
 Fri, 06 Aug 2021 22:24:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210806231701.106980-1-npache@redhat.com> <CALvZod6gCof1bhVwdU7vYYKBRCn_HZBFi4BjSYoSK-dyrmswMA@mail.gmail.com>
 <91605888-e343-2712-c097-bcade4cb389d@redhat.com>
In-Reply-To: <91605888-e343-2712-c097-bcade4cb389d@redhat.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 6 Aug 2021 22:23:48 -0700
Message-ID: <CALvZod6Kv_eZcZeJOvypXe_XVzkvLDau7faiDQ2mrqV8kOqq3g@mail.gmail.com>
Subject: Re: [PATCH] vm_swappiness=0 should still try to avoid swapping anon memory
To:     Nico Pache <npache@redhat.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Rafael Aquini <aquini@redhat.com>,
        Waiman Long <longman@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 6, 2021 at 6:37 PM Nico Pache <npache@redhat.com> wrote:
>
>
> On 8/6/21 9:00 PM, Shakeel Butt wrote:
[...]
> > If you are really seeing the said behavior then why will this fix it.
> > This is just about deactivating active anon LRU. I would rather look
> > at get_scan_count() to check why swappiness = 0 is still letting the
> > kernel to scan anon LRU. BTW in cgroup v1, the memcg can overwrite
> > their swappiness which will be preferred over system vm_swappiness.
> > Did you set system level swappiness or memcg one?
>
> This fixes the issue because shrink_list() uses the may_deactivate field
> to determine if it should shrink the active list.

First, the shrink_list() will not be called for anon LRU if get_scan_count()
has decided to not scan the anon LRU.

Second, I would like to get your attention to the following comment in
get_scan_count():

"Global reclaim will swap to prevent OOM even with no swappiness"

It seems like the behavior you are seeing is actually working as intended.
You may decide to change that behavior but you will need to motivate the
change.
