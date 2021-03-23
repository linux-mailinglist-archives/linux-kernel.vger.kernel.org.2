Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD83D345AA1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 10:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbhCWJS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 05:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbhCWJSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 05:18:45 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5259DC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 02:18:45 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id g15so13670662pfq.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 02:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xDCwCUUxzBpfzU2QfVzbi3ez4QiU5v+G+EIOhfhoUmI=;
        b=x0SCR2mTDOG7KxFGyZOvpO8NlmPNBhPRfAiaBhGPX/wvNn/wFDSj2R/9a55hK5WehX
         7wmvuzm74DMiFhnlgirKZ6dVUdFkht/wK6ACSdjyaFOgmGer2bO78MDbpVYDdF8Pvcd4
         HEEA17zTSTgc9y/ePJnbYOzKrKwXHpJSmNC4tlS1ZGOhl2F32uSJNebMwb6EVN0pVcDR
         vHamBU3so8bCKHRbCpabTo1taoFgbEAemwbXQpdVy+LBOvXhjW/p25RADJ74RvPqs5PP
         WjpHhp7DUtBU5rDqXbEHE1FV0XFopcbZUZXSsI8rgxK8AJ5HfpizmuyHx5UfHf3HqVBZ
         /GPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xDCwCUUxzBpfzU2QfVzbi3ez4QiU5v+G+EIOhfhoUmI=;
        b=QzW/EzHln544owSsVnlLkVdwow9y+36+0RddXiz+y1JeR/lBit5L+X1Rf0+vODgX4n
         3DxOvtrYzgaQssMIW7zFrXLzqkmh8okIGEGuqhY/tXWTr4i9Gfgrr/4+bHJRyJoVRy11
         9emlvhmM7dM+wq80N6X5YB0vvGwIrpFc9fiUo2WFKAfV+5johfaLcSoiDgA1LiXtL2xJ
         TqbTb6cvhdmtOnl5eu7FnqDFbmTC747StiwmQTNWSun2zco7LZ5D2xQRM9WuEL6IwMVV
         WLIRkWFu0Xcn1JrHI9tnqRYVJH87QiXaGSlL+AhGX+3lgm9BaEPxOIxltmRVZi2RBZLD
         NM6g==
X-Gm-Message-State: AOAM531F6+shp8TG6ZU37oxMFmAM0ARxEhrXMTUDxgCzCpEZyXNRdbPE
        PRR5UaU3jwOfsDSbNyUvrRt0/3TCxotwGqYrfHQ4Zw==
X-Google-Smtp-Source: ABdhPJwNmPHu0MSNSBhFZpOQrh4mGXzhKqt04e+oeK/NoF14Tc+HyGjUDCeU0H73O+55f/VN5jANMBlanQPrXXCDFlk=
X-Received: by 2002:a65:6645:: with SMTP id z5mr3129824pgv.273.1616491124932;
 Tue, 23 Mar 2021 02:18:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210319163821.20704-1-songmuchun@bytedance.com>
 <20210319163821.20704-2-songmuchun@bytedance.com> <YFitwmmLFA24cofE@cmpxchg.org>
In-Reply-To: <YFitwmmLFA24cofE@cmpxchg.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 23 Mar 2021 17:18:08 +0800
Message-ID: <CAMZfGtVQPonuhQOWq2D_tZyLGuBQ2auY=SF3vPJXN=iTnp8_1Q@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v5 1/7] mm: memcontrol: slab: fix obtain a
 reference to a freeing memcg
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 10:46 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Sat, Mar 20, 2021 at 12:38:14AM +0800, Muchun Song wrote:
> > The rcu_read_lock/unlock only can guarantee that the memcg will not be
> > freed, but it cannot guarantee the success of css_get (which is in the
> > refill_stock when cached memcg changed) to memcg.
> >
> >   rcu_read_lock()
> >   memcg = obj_cgroup_memcg(old)
> >   __memcg_kmem_uncharge(memcg)
> >       refill_stock(memcg)
> >           if (stock->cached != memcg)
> >               // css_get can change the ref counter from 0 back to 1.
> >               css_get(&memcg->css)
> >   rcu_read_unlock()
> >
> > This fix is very like the commit:
> >
> >   eefbfa7fd678 ("mm: memcg/slab: fix use after free in obj_cgroup_charge")
> >
> > Fix this by holding a reference to the memcg which is passed to the
> > __memcg_kmem_uncharge() before calling __memcg_kmem_uncharge().
> >
> > Fixes: 3de7d4f25a74 ("mm: memcg/slab: optimize objcg stock draining")
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
>
> Good catch! Did you trigger the WARN_ON() in
> percpu_ref_kill_and_confirm() during testing?

No. The race window is very small, it should be difficult to trigger.
When I reviewed the code here, I suddenly realized that there
might be a problem here. Very coincidental.

Thanks.
