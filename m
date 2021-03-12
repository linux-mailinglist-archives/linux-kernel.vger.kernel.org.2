Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8173384CE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 06:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbhCLFCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 00:02:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbhCLFCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 00:02:38 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37C3C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 21:02:37 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id 30so6801487ple.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 21:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m1loYoW2oUetw20mL24ntlr+RIYjd3r3UQ144d0uEqQ=;
        b=rovTU+A4fTJNpdqJKB/Tz583wGYLyFwPc9Y+0eOiSdygr05TqsbRkQdMkmhPaMvTMU
         3V0br0mgm+aBXtbiSaxDW77c4He4QYBwAaxVChwqsR1CW11meCrayvhdlF8+kfQXyr5H
         1BFtML5NqxKmeP9b20WzAqVoMJ3F4H2yBEU/UzjzBrZmtushAk25654eixm+jmf9ewfT
         oIhDtZYJv3fXd7A2Z9BsaGFEmjw9nhWk0lpCrll+LCQFrzp8mLxoIBtUzixpp+rvXwHF
         cY1lqKaS06x617hf/WhLeTh5jkQxC+RQEF7iimWEv5qo9HquCUBym/ANeyGa+W0HGn04
         6xgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m1loYoW2oUetw20mL24ntlr+RIYjd3r3UQ144d0uEqQ=;
        b=OOSpm713EmzmauuGHGw+0osRbOYW1OocXRtMIdAYQ/ntDJ9ly4qeO7EjpkQ1FdJmoG
         4ck88QTChREaSvrmW9JAEW6IKU1u06CKxWPWXnq974hOPGwkBuM2ygeMor2NwXtqGkWQ
         Befhb0iT58HUWSPU1dlnysK0n6PMvF5ZSIcLY12YjdnVzo18+v25dWh02SpNQ7SUMWxO
         eWzN598TDtoH26/OAnCmk/ejjZoAhOYamvDq339iXVu+rF0O22tNm+qXN8xTXdNPpYk0
         KIk+ozog2Tvb7CO9jKFyEHcrW1ww6lyTvKKiRTa2rZlv3PzOKIQ0hW1nyiQhr4sqTDJF
         0s4g==
X-Gm-Message-State: AOAM530j12sZ44fEixsvl0WqBpIm/P4d16Xdg7N6A3EIjAde8XhtcLD+
        Ct6/BSj3qtqkHjcEo/ggloxve+P8hiSiQyGDqIlBeQ==
X-Google-Smtp-Source: ABdhPJwkzc0qelaMsCRdu7v61s9g15WGPYFSSfV+tnQr1AgHSoLp9VF9P1HivDEUzwx1SqQOhdStievyMaXm0sa4xW4=
X-Received: by 2002:a17:902:8d86:b029:e6:45a0:b16e with SMTP id
 v6-20020a1709028d86b02900e645a0b16emr11510146plo.34.1615525357475; Thu, 11
 Mar 2021 21:02:37 -0800 (PST)
MIME-Version: 1.0
References: <20210309100717.253-1-songmuchun@bytedance.com>
 <20210309100717.253-3-songmuchun@bytedance.com> <CALvZod4vmZztdbjkWT8soRd3P=JXyNJChDTOUP1HaiSQhKoutw@mail.gmail.com>
In-Reply-To: <CALvZod4vmZztdbjkWT8soRd3P=JXyNJChDTOUP1HaiSQhKoutw@mail.gmail.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 12 Mar 2021 13:02:01 +0800
Message-ID: <CAMZfGtUotAOUm4ATRtJ41zokejntVhv1=91d0TS6tFfNLeaoeQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v3 2/4] mm: memcontrol: make
 page_memcg{_rcu} only applicable for non-kmem page
To:     Shakeel Butt <shakeelb@google.com>
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

On Fri, Mar 12, 2021 at 11:22 AM Shakeel Butt <shakeelb@google.com> wrote:
>
> On Tue, Mar 9, 2021 at 2:09 AM Muchun Song <songmuchun@bytedance.com> wrote:
> >
> > We want to reuse the obj_cgroup APIs to charge the kmem pages.
> > If we do that, we should store an object cgroup pointer to
> > page->memcg_data for the kmem pages.
> >
> > Finally, page->memcg_data can have 3 different meanings.
>
> replace 'can' with 'will'

Will do. Thanks.

>
> Other than that I think Roman and Johannes have already given very
> good feedback.
