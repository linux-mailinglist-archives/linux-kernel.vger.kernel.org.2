Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE563DDB1A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 16:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234177AbhHBOc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 10:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234014AbhHBOcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 10:32:24 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC03BC0613D5
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 07:32:14 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id x8so20735047lfe.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 07:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=19nfVkDw1JHrHyLVrxQ7C3iIv4HJUAVawRYI+zVDKis=;
        b=g2rXIt6PCcJyTa2L7O6qIeZjWDnqOSfddyk6MrYcfEsfL7ZHrImFAKiYu/6qeNFXml
         uFaNVZeiebZF2qSRn4MPkT99U8W2aI+dIRtgDQCtGeKJguajzSd2fILGxt3hoaOrg5Al
         jNhOcCLyG2pjA96otAuaSej7Cs/zqm5fq7ZGMOXetpdUIAfuG7QYlshPWqrprPyvnP/b
         eWM3QaOgo34fZF71q7x5gABjzMONsiYCOtCG0wrB3MMQG3KaQk5Cflt++3Ea2NnFguBI
         Vvm4lTfSqGY7YleaXqoyw66XVOUYcxVgtMYqifv6gkKvQu33r8bafyCu1ggNmNAPF1uk
         2QEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=19nfVkDw1JHrHyLVrxQ7C3iIv4HJUAVawRYI+zVDKis=;
        b=cqkOAVytbysXqrwavRX4ITFPU8xg0fkyJKUgeTHPq7YkL0fl5Mw6aDUBPCQtoXOHij
         E35xi7f3P3ddEudaYf03LK53hdG/IenMp9K7c1Qa7HsFkRYJJkN5SmuvZ3eIaF71wvz1
         X/LPwP+nBOPWN39Hh65S0JU377//bKWi+6/+jXUwgNaBY27NfYdeh/aRgMvGHE63+vRS
         0jV9NzhFjCu7JRAz6E7tNdfRhRUKwmKvrD+2ZqgzSDk6dq4PvdbHxUdke1BWQTGZXVgu
         LTYYfBu1cVp+qzK4BLaUfWNaRnZR6AwmzIqKQkESia66I5Bnre4cfjJM8abCefFRCTQI
         SA1A==
X-Gm-Message-State: AOAM532Ns+I8607rFLq1T1EFk1wf1uVUfkN9TZ9Ji5Jsbdo3WrWDRL/V
        U/eP7XSb6Idq2H2XJUrxD/JtB5gxPB1Fx3qSWID7ow==
X-Google-Smtp-Source: ABdhPJw3boDKwPQvVaGncMOJTyPUymUUTg6mvCS3v3pvSwz7jcn5lVWSJhrMrzCzEd8llnaJ0PB/fY5esLDv7jWE+o8=
X-Received: by 2002:a19:ae0f:: with SMTP id f15mr12931254lfc.117.1627914732988;
 Mon, 02 Aug 2021 07:32:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210802022827.10192-1-longman@redhat.com>
In-Reply-To: <20210802022827.10192-1-longman@redhat.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 2 Aug 2021 07:32:01 -0700
Message-ID: <CALvZod7-x4ezYcUh+ycTzWypL9bLpL-fdRsZrw1iM+__H2_s_g@mail.gmail.com>
Subject: Re: [PATCH] mm/memcg: Fix incorrect flushing of lruvec data in obj_stock
To:     Waiman Long <longman@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <guro@fb.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 1, 2021 at 7:28 PM Waiman Long <longman@redhat.com> wrote:
>
> When mod_objcg_state() is called with a pgdat that is different from
> that in the obj_stock, the old lruvec data cached in obj_stock are
> flushed out. Unfortunately, they were flushed to the new pgdat and
> hence the wrong node, not the one cached in obj_stock.
>
> Fix that by flushing the data to the cached pgdat instead.
>
> Fixes: 68ac5b3c8db2 ("mm/memcg: cache vmstat data in percpu memcg_stock_pcp")
> Signed-off-by: Waiman Long <longman@redhat.com>

After incorporating Michal's comments, you can add:

Reviewed-by: Shakeel Butt <shakeelb@google.com>
