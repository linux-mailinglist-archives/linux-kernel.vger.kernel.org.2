Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 732FC390E5D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 04:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbhEZCnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 22:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbhEZCnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 22:43:20 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F993C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 19:41:48 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 27so23038038pgy.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 19:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ezkRjfHr/yM6BsQAIWTNP4dtaMyIXXLPkdDgkZxux3A=;
        b=ApaC4pDll9S1kSYB5io3ifMby1Gq9g9E6KxKclhWqvN+A47B/xv8Ms5FABOkrVHJ0g
         CZINCBiZA229upxqomoYZMpJo/264cRtH38cqUjnwOKYvWtGl+yoQ5LVSD6RoXDtO5/m
         ZXhzZ/2HtIZOYj3m1/Ct95HWzUu5ztwVbVxQUYriEGI7vKy18ka6PEqiFzcDEm9zYzLZ
         1gq2RRjHToIDlfi73whaNSHhyOfh6xVgxbcFe7kK77eD9SKm8bv/MPRlsIPl7qBF2A6U
         8M2p+216yMG/tz0hafsyLMy3j8mn8pYgkzbUP5DfabxgOLqtW/lfjMWzkq4zf7Ju5dbn
         sJYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ezkRjfHr/yM6BsQAIWTNP4dtaMyIXXLPkdDgkZxux3A=;
        b=t2CJtFdwLg96oREJs5cQPq7Gubw7PFH5pe/g92lYcM5DXAfFOb0U9fJ7HlkFCGTebp
         HP1rbaMz9aioWV3/XiO6m4psP8pbCmABnStET/XokszbyE4cS6BRWSe88Wjvkw47lprY
         2Ka2XPS0pnRqjGWyloTvLwBUKzkNb6lCfrmKAMZ7xg3sZw8GwDipPh4dMUBjlK6L4VuL
         65BrKWl5De6tpQNKjrBqt3YIPAY8qzbD1rx5OtZu2xmBtzVRIwDsaxEPKyI3WkteyQ8E
         0puQuHQLLTpzkP0LhIwVKwO/Kj8aPpksppj/AVZR+JxKr3/HkPBB5fP+Ep75IAsoBXNS
         6r3g==
X-Gm-Message-State: AOAM532OgxKfhSK7WMe5odekRvbQLqMxL0To9z8uAe1aT6wPSxnloccr
        WyLlk6ITywt/7BeL2qQUwRAI+kpxWGlIIdoBLZxnUw==
X-Google-Smtp-Source: ABdhPJzWkiQtkLiwSGp/hJKgHn8/eehIITIU/j84gUlDHfBnZGna9Pqxrd/DSMt2knZpknME/4qEhotvxr3thaMSwU8=
X-Received: by 2002:a05:6a00:8c7:b029:20f:1cf4:d02 with SMTP id
 s7-20020a056a0008c7b029020f1cf40d02mr33213719pfu.49.1621996907718; Tue, 25
 May 2021 19:41:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210421070059.69361-1-songmuchun@bytedance.com>
 <CAMZfGtUiKcM8WmP88J3K5edwLhJhsUkAUQo6rnkqx4BBOEY2SA@mail.gmail.com>
 <34366052-8A39-4E8E-A076-8B64AB4D015D@fb.com> <CAMZfGtXC_UG9gUD58ezL02a+Gyry_d7WfEwKup6UMQjvNi3HdQ@mail.gmail.com>
 <YK01SgD7sFeviDGv@carbon.dhcp.thefacebook.com>
In-Reply-To: <YK01SgD7sFeviDGv@carbon.dhcp.thefacebook.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 26 May 2021 10:41:11 +0800
Message-ID: <CAMZfGtWgCyK+W9PMSFzyuPBvBzeKZRE5t7vKzgUQK3bj0NVi9g@mail.gmail.com>
Subject: Re: [External] Re: [RFC PATCH v3 00/12] Use obj_cgroup APIs to charge
 the LRU pages
To:     Roman Gushchin <guro@fb.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        "fam.zheng@bytedance.com" <fam.zheng@bytedance.com>,
        "Singh, Balbir" <bsingharora@gmail.com>,
        Yang Shi <shy828301@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2021 at 1:35 AM Roman Gushchin <guro@fb.com> wrote:
>
> On Thu, May 20, 2021 at 11:20:47AM +0800, Muchun Song wrote:
> > On Tue, May 18, 2021 at 10:17 PM Roman Gushchin <guro@fb.com> wrote:
> > >
> > > Hi Muchun!
> > >
> > > It looks like the writeback problem will be solved in a different way=
, which will not require generalization of the obj_cgroup api to the cgroup=
 level. It=E2=80=99s not fully confirmed yet though. We still might wanna d=
o this generalization lingn-term, but as now I have no objections for conti=
nuing the work on your patchset. I=E2=80=99m on pto this week, but will tak=
e a deeper look at your patches early next week. Sorry for the delay.
> >
> > Waiting on your review. Thanks Roman.
>
> It looks like the mm tree went ahead and I can't clearly apply the whole =
patchset.
> Would you mind to rebase it and resend?

Got it. Will do that. Thanks.

>
> Thank you!
