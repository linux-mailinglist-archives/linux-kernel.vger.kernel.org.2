Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B64D35DFDD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 15:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344260AbhDMNNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 09:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbhDMNN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 09:13:27 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3961C061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 06:13:07 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id l22so11925579ljc.9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 06:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uvM1xLNFtbjboqLjbQwMRXz9XirPXm1IZpwvJNf/xI4=;
        b=lQZzbGEfuKkQNZ0EyqnQ+GDHJ632xxU1Ko4KVYLh7r2DgevxDm8Ixs5cgBJbOY11bY
         aKSQD78mYWqTJYDhDZH7ZXQMqQHl/OPQX1o/RRH8ez+cRwjDu9Air/9t29L4nsiCx4H8
         WBH9B89PlSK0j8MzsWkjcc3Yd2niQQ/+m1GyopJpOLu57BDCqUgftJ5Ofvdge8xQCsPR
         2ZYiyBTIZgviLzV+oPn8mE8FXD0d5am7aTV7b3j6tcQ/HYI1efje9k2T96dLQJ75xPo/
         KJx1g1MdRXU85Mrmd+C6idriGcclZaSthpPTMiKS0NzTntPodW8U1ID8rmI6KvcV70Gd
         V2gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uvM1xLNFtbjboqLjbQwMRXz9XirPXm1IZpwvJNf/xI4=;
        b=gwsXCORY+qCWeUIiPNjcFIibHEVy7NaZhPLwBczThDE/YiEtgr21hDSMy9k8uhRE37
         7a4xpEoYYDm920FMKKy8wERqEtLHRgE66oDOy9t54P6MZ+QQ3lNL6Z0rRRScvQ/yi/Qx
         ZZT74V2dVkvauBx9pR7H5yrEcVmCbjEQuxqtRYHIX/G+QA7EMG2LdzHU1UUI037nc0Jg
         OjlYmwUUJOVKWP8M/odSjHfWKWjrSw/+qamIaitxbTP42eJQhQSQpSHBWGS63ZYaQzHv
         WRgB1j8pthNsNAmnEq/MA0oYOtlTm4l8CeXIl7ELVdjo6FUQ/f8id6fhsp93d4oxCQmB
         088Q==
X-Gm-Message-State: AOAM530lFKe2k20tXpRg6EdAkcnUILaSACjdJQXIWTD/CmpfBO+tvGP5
        aQsf2ebowQBD4+Qj1FlFUGG1g9cM+pfOHB4J8I3XwA==
X-Google-Smtp-Source: ABdhPJxwz8N7PrvB9rmwq4vzGOdn7BiHIWYtOzqHgwkSiT0s1Tl3lnWu5UIgLuha/if0KcD8ZJreMYmnUKvNQyKkA7k=
X-Received: by 2002:a2e:968a:: with SMTP id q10mr10830963lji.0.1618319585941;
 Tue, 13 Apr 2021 06:13:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210413065153.63431-1-songmuchun@bytedance.com> <20210413065153.63431-4-songmuchun@bytedance.com>
In-Reply-To: <20210413065153.63431-4-songmuchun@bytedance.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 13 Apr 2021 06:12:54 -0700
Message-ID: <CALvZod6krYWK1KucJXYNf+_Oe_iAeBi1hqNCVSp-zgu=-oQuPg@mail.gmail.com>
Subject: Re: [PATCH 3/7] mm: memcontrol: remove the pgdata parameter of mem_cgroup_page_lruvec
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
> All the callers of mem_cgroup_page_lruvec() just pass page_pgdat(page)
> as the 2nd parameter to it (except isolate_migratepages_block()). But
> for isolate_migratepages_block(), the page_pgdat(page) is also equal
> to the local variable of @pgdat. So mem_cgroup_page_lruvec() do not
> need the pgdat parameter. Just remove it to simplify the code.
>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
