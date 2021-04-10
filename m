Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE98B35AF62
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 19:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234933AbhDJRrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 13:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234392AbhDJRri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 13:47:38 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173FEC06138A
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 10:47:23 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id r8so14636637lfp.10
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 10:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YgtCeA1Y4wCp3r4IZqk+RljjksiftqBoFrg1EOiiX98=;
        b=LpEUse8MvSsBjR/LUs2dYtDHrydq5lyD4O4gsodi1yEPM1SHXLqHM0JxMtitWaQN9H
         EjVClxjmcjV/R3akgoMCcpKdQjKgXDny3p99W67WidjZKzmra53wR4VT60QnK8HQT7Hy
         KObIDGfQuKYiK1rQUpzwWidXgMky7nMhfZX9nHu6GsS+z9cbbFKMC668EiZU2TKXuBnW
         RfcXHqLce4uv0mbDhLIJT8IYwd775JtTIMO6SeuVcDDtLfC89Dm67GRetRPt4ju4w0EF
         SjMbS/9O6WMx3RjMRPCEDRyXXXviVegPcT2E+QzPNL4qy1wqzPD2ylChZxW2hPoRbF+p
         akVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YgtCeA1Y4wCp3r4IZqk+RljjksiftqBoFrg1EOiiX98=;
        b=phySlrFJPrQ5458OPpRNI4foACBUOlNFIvES73hUyGWKADqutjzXQBPGVrz655twwu
         Oqk+5QDxiOrSDNKWDOBn83CipjIV1/mvZ+ae9wdElnkhtunFIWX+EOIYY3bDdma7JMvW
         xqR+hGM+FswFIOTkr97muTYFSKkLqNFQT3wdLm8mbwnu/i3cGsKpE6n9K865g17aCixR
         yNXR1PMGsKNt9CqRRC5ut6PRI0dx+mjKC9IVRDld0FCOr9/c9ky/2XTjynCH8w3oHYi8
         QyR9QUTBhulh6G3C8JNv4v1phXyve/Ig+D4KAKJrmfIoKPWoBt0jtmMrIEZY6rv/nG8T
         QwWQ==
X-Gm-Message-State: AOAM532Dw7lSZ966J05LD2H6LrxKXie9WLA+A2p2vODXyjsrheNRoRqI
        0OTwAzGes7H+QpesMhE7s2gmkmfrHclbI0VbTn1l5Q==
X-Google-Smtp-Source: ABdhPJyrJ9OtawfTPWSGdv8LD+6QkmBdDM6JV5MAKUk0DwXB9KTifdsnQzGpekz9zSTIOufp5RVbxrgLQ95h3NYYcXs=
X-Received: by 2002:a05:6512:2019:: with SMTP id a25mr4230772lfb.347.1618076841358;
 Sat, 10 Apr 2021 10:47:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210409122959.82264-1-songmuchun@bytedance.com> <20210409122959.82264-3-songmuchun@bytedance.com>
In-Reply-To: <20210409122959.82264-3-songmuchun@bytedance.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Sat, 10 Apr 2021 10:47:08 -0700
Message-ID: <CALvZod5Z4r7RyU-zQdWBUn8bKibviXrfbyqVpgmO_e6VDjBHCg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 02/18] mm: memcontrol: bail out early when !mm in get_mem_cgroup_from_mm
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Roman Gushchin <guro@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        fam.zheng@bytedance.com, Balbir Singh <bsingharora@gmail.com>,
        Yang Shi <shy828301@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Dan Schatzberg <schatzberg.dan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 9, 2021 at 5:32 AM Muchun Song <songmuchun@bytedance.com> wrote:
>
> When mm is NULL, we do not need to hold rcu lock and call css_tryget for
> the root memcg. And we also do not need to check !mm in every loop of
> while. So bail out early when !mm.
>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
