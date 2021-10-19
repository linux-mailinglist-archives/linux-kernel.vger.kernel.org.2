Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9298F432D45
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 07:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233405AbhJSFg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 01:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233351AbhJSFg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 01:36:26 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 858E6C061745
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 22:34:14 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id s64so4530842yba.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 22:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RMl6loCX4NFJfsa056nJx2CwFXuES2+tyFDbKn9//yc=;
        b=hTuEcyIcrJwowhVFmr1Ryqylewdeyhe839N+rtYyyw854YKwj82YG8tP3ZrEIcyUj5
         3nBKlC3W5LVY6eQAImanPJUjibQ2OFhlBjIXWvcj2b550FKbwFt67vooTKvLoWjRuFz+
         vb66bneS468dgNCIaTDlsyxaW8tRR74sxQXupOSnhApyXlJrCGorx2qEVSZzrHLJOcg4
         7DJeN1Rb8uMxygEDTe9aPIOPDEEIox9moleQaYtIuNRyEX3FrwitftCf088a/A3nVgse
         nI1z4VydJxhIZ4l+CA5FkztaMVms9AWrRNAnd89DDLG0OEi9tvgc+rLPZVB/KtClHEcA
         9PJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RMl6loCX4NFJfsa056nJx2CwFXuES2+tyFDbKn9//yc=;
        b=FNesW7c2z91L2Qu32HRJ3SQlEbT53MfH/14mNS4xCslTdJOPU2b+80YzoXnt2/uuVC
         7KMrJLpuLEpSodcHdlj0QQqmoUeXWzIo/CrhYgMjyLrBu6n2g0kQdF0lxGs4VsdUHTur
         ex9Ku5w7h1h3E7HWqU8cb/8mokdL46Gc29ul6umsvdu3bKAodXNY6TOTyzwxZPHtmZJ7
         DkNt2R6fIKvCaiINswC0iKNMR7lf/iB2qHa0A7IB38DB1S48sbsS0Gp0xcGi38EMZUtq
         SE72BuAjqAJCy5j9/c93YvfEdmViqjO6kgjgmXBxd2Fj66raZJcAoDbqki0SRkz8NTc1
         h63g==
X-Gm-Message-State: AOAM531lKFcguaW2pYTUH5GdEeyj0mtStqGilLUlVgQgdJZo1pt3sztQ
        y3DCs3DPZ+F5IctQG7flVNlmJWiDkhRF8wTc/cHVBg==
X-Google-Smtp-Source: ABdhPJw4muOArPUxsbdZlRPVYrKgei9bVqqkp4GtRd9nh/grse1BR6U0QaqtB8AGSLTeeVP4yYeQ9AI24xDMfblDJWk=
X-Received: by 2002:a25:dc53:: with SMTP id y80mr35915639ybe.68.1634621653611;
 Mon, 18 Oct 2021 22:34:13 -0700 (PDT)
MIME-Version: 1.0
References: <9d10df01-0127-fb40-81c3-cc53c9733c3e@virtuozzo.com>
 <YW04jWSv6pQb2Goe@dhcp22.suse.cz> <6b751abe-aa52-d1d8-2631-ec471975cc3a@virtuozzo.com>
 <YW1gRz0rTkJrvc4L@dhcp22.suse.cz> <27dc0c49-a0d6-875b-49c6-0ef5c0cc3ac8@virtuozzo.com>
 <YW1oMxNkUCaAimmg@dhcp22.suse.cz> <CALvZod42uwgrg83CCKn6JgYqAQtR1RLJSuybNYjtkFo4wVgT1w@mail.gmail.com>
 <153f7aa6-39ef-f064-8745-a9489e088239@virtuozzo.com> <4a30aa18-e2a2-693c-8237-b75fffac9838@virtuozzo.com>
In-Reply-To: <4a30aa18-e2a2-693c-8237-b75fffac9838@virtuozzo.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 18 Oct 2021 22:34:02 -0700
Message-ID: <CALvZod4BKvm=DoLPVMyAF6e8bSg2aa63PZ6Kq24GxrRnHNsOcg@mail.gmail.com>
Subject: Re: [PATCH memcg 0/1] false global OOM triggered by memcg-limited task
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel@openvz.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2021 at 12:19 PM Vasily Averin <vvs@virtuozzo.com> wrote:
>
> On 18.10.2021 21:52, Vasily Averin wrote:
> > On 18.10.2021 18:07, Shakeel Butt wrote:
> >> On Mon, Oct 18, 2021 at 5:27 AM Michal Hocko <mhocko@suse.com> wrote:
> >>>
> >>> [restore the cc list]
> >>>
> >>> On Mon 18-10-21 15:14:26, Vasily Averin wrote:
> >>>> On 18.10.2021 14:53, Michal Hocko wrote:
> >>>>> On Mon 18-10-21 13:05:35, Vasily Averin wrote:
> >>>>>> On 18.10.2021 12:04, Michal Hocko wrote:
> >>>>>> Here we call try_charge_memcg() that return success and approve the allocation,
> >>>>>> however then we hit into kmem limit and fail the allocation.
> >>>>>
> >>>>> Just to make sure I understand this would be for the v1 kmem explicit
> >>>>> limit, correct?
> >>>>
> >>>> yes, I mean this limit.
> >>>
> >>> OK, thanks for the clarification. This is a known problem. Have a look
> >>> at I think we consider that one to 0158115f702b ("memcg, kmem: deprecate
> >>> kmem.limit_in_bytes"). We are reporting the deprecated and to-be removed
> >>> status since 2019 without any actual report sugested by the kernel
> >>> message. Maybe we should try and remove it and see whether that prompts
> >>> some pushback.
> >>>
> >>
> >> Yes, I think now should be the right time to take the next step for
> >> deprecation of kmem limits:
> >> https://lore.kernel.org/all/20201118175726.2453120-1-shakeelb@google.com/
> >
> > Are you going to push it to stable kernels too?
>
> Btw CONFIG_MEMCG_KMEM=y is set both in RHEL8 kernels and in ubuntu 20.04 LTS kernel 5.11.0-37.
>

CONFIG_MEMCG_KMEM is orthogonal to setting kmem limits. We are not
disabling the kmem accounting.
