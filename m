Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20F5335E011
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 15:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345986AbhDMN3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 09:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242158AbhDMN2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 09:28:43 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D977C061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 06:28:23 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id r22so8629281ljc.5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 06:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hj/SeZ1ZvvwY1xIzJooNaPGvpH3onFVxBgFQtfF6dKs=;
        b=b5uJDNpPZbifglYYEysAar2xQtFPzsraSWEM4TDaO+4wZXQiLchll2ftbQN4OaTVoS
         CVOXKoqUpICrWyhMIeJQya5LKJmA/im+tlRBCtBLgSpBDTOmaYCcdwHrRbkl7mBZPYxC
         AbSC7cZNjgfZQlIfdWAtWvymvtrpX+ZiYbkydyhtR4XY93fFeV3l7KaCzG7PhLC/gMnA
         dX83Q0DNRfUXDQTaISGbVrG5H2kP5Gr+VuUHY4sBpxld5+SzquxYs87K/xFh7kJFdjQf
         sx0z7JLZkJbHa/DG2l7xo/dAznjYkEsrwivW16Dhhng4JSWR3rqpax9U7TP90BaGmAIc
         HDVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hj/SeZ1ZvvwY1xIzJooNaPGvpH3onFVxBgFQtfF6dKs=;
        b=DtUgWepKlIOhWomu4dYC/UFmFS3B6UziFWrq1twOf4Flk+feU0vRRUQGyOtXF62CV3
         9uwtoVIM7NAucBd47vue1HgEoeKoB2iX+V1vr1y6UoH/2lDro2zDsiQX2G5P91iXdrfR
         7OhBuQyp+vnepcSfEKomxfXz9iTNKZGVDyRuAnpnygEzz04F4U4w8DepZ1PX1DyOuldR
         eWWgjHNV1zh7LliFU27DZf3mis8t9GPwalhrnTSfEqxQstgfc8krJeXK43TLI8aRsDc6
         Jd9Ue3LnkPUq6M3GMm9aJK3b+czDqumRG0JdMWG0dTJSSyg5YVB9iH1ANV+tjE7Vbtjw
         B9eg==
X-Gm-Message-State: AOAM533reXChNPrVg76rC9TrYVfqw8lW8jI3cX60f78z/mMcUbpyuUQx
        Qeksb1YTb0ZnY2SUa3+s75eQ4bG2z8R/Wr2AFBGjOQ==
X-Google-Smtp-Source: ABdhPJxxakCZqZ1Ab2CgtoWpKw/Pji9vy4PUpSty494sfE4n1OebazycmnhmYDcpWpHnnzHE8VbrITfOH+HnUDVQvLo=
X-Received: by 2002:a2e:8084:: with SMTP id i4mr21632742ljg.122.1618320501679;
 Tue, 13 Apr 2021 06:28:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210413065153.63431-1-songmuchun@bytedance.com> <20210413065153.63431-5-songmuchun@bytedance.com>
In-Reply-To: <20210413065153.63431-5-songmuchun@bytedance.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 13 Apr 2021 06:28:09 -0700
Message-ID: <CALvZod6P4O8JicK22=RfjLk205kTDNDV=WonO0yXE0Fx7ydsGg@mail.gmail.com>
Subject: Re: [PATCH 4/7] mm: memcontrol: simplify lruvec_holds_page_lru_lock
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

On Mon, Apr 12, 2021 at 11:57 PM Muchun Song <songmuchun@bytedance.com> wrote:
>
> We already have a helper lruvec_memcg() to get the memcg from lruvec, we
> do not need to do it ourselves in the lruvec_holds_page_lru_lock(). So use
> lruvec_memcg() instead. And if mem_cgroup_disabled() returns false, the
> page_memcg(page) (the LRU pages) cannot be NULL. So remove the odd logic
> of "memcg = page_memcg(page) ? : root_mem_cgroup". And use lruvec_pgdat
> to simplify the code. We can have a single definition for this function
> that works for !CONFIG_MEMCG, CONFIG_MEMCG + mem_cgroup_disabled() and
> CONFIG_MEMCG.
>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
