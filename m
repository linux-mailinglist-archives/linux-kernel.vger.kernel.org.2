Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 962FC433F8F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 22:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233316AbhJSUGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 16:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbhJSUF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 16:05:59 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B0DC06161C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 13:03:45 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id l5so8237220lja.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 13:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DfGhAHT9HhtqeTpI2TYryH6uFTCkzU6q0SGRJXp8/6w=;
        b=gCRm1I8UHyDh7Mi8CTU+K3MIul4qxwvNzh0Ij1H6xm95MW00t7BiwXquwR0X7cgHwj
         ArlZ0SIMAiyoiWadSJTfCevxdOFU84GJu+4mFCD3CSATO/QwyMDx/UJy35eBz9r7qzft
         QuGRgjjA4D9Dq69peRhx0vqHfiIGricAiY1wmqvS9F5zKst3bh3NzKlkt4dDmPZ0TT3I
         j9bsZL1/TnO5QKdZcJ8SdlN4xT3yvpSGbw3FXc6ypi5maL3g4PBHM220xi+XS0bYuzaL
         +qqGzod2mROnt/MeAxtoA895HOcPk7PqDA8Td3He8iv4+glZAzLW2Ena2Is1cvXFZmWt
         7BZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DfGhAHT9HhtqeTpI2TYryH6uFTCkzU6q0SGRJXp8/6w=;
        b=FgCvrn+M64s7xhzYhYOkqTR7iwJ9PnBtZNC77PhobjBCadSIiOCGLTdYQIg/Ac7Rqd
         MYT7sOhy3bweDVYi1Q1q+JkbSlruP+uL/uvzRjK6taI5J1l1F7WV8NOAsSzq2T5eYNfz
         rBKXzJHAFDXryzF8zOnf01+C9081ZOkJo04/NDAwnRTv8clPBmGYXcoVQuf7laSnpkMq
         mSM4vH7ZPw0cAdu8R52avr+2MN+oZcctnhuOePVyaVlmxTNMEOCVkG2Kbw6dx133HFhR
         S/1jGj5X4uAhOyEgOe+T6VQQ+r0xqHLCuUKwAivCnENsnVzYFOnT5wubDMts89AFJAot
         x8Eg==
X-Gm-Message-State: AOAM530+GXo7UcRKMmj4ld1vh9A0+qYQ2/IGyVHTHfN3mUVjhLPVcylI
        qzVsVdGk2p8/FZLwlX7cJbEsmofsWNdxbGGTNOFzdw==
X-Google-Smtp-Source: ABdhPJzd3sf9ZX+bEMFP3ZIWLmMCxMegHItpioGJBTww8iDfLZtbroMLSbgbN9AmLjemI+SHFKSwrT2Bf6BlAifbDEg=
X-Received: by 2002:a05:651c:1793:: with SMTP id bn19mr8820477ljb.475.1634673823685;
 Tue, 19 Oct 2021 13:03:43 -0700 (PDT)
MIME-Version: 1.0
References: <20211019153408.2916808-1-shakeelb@google.com> <20211019125147.0ad010f318bbd8233cadcdae@linux-foundation.org>
In-Reply-To: <20211019125147.0ad010f318bbd8233cadcdae@linux-foundation.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 19 Oct 2021 13:03:32 -0700
Message-ID: <CALvZod7QPR1Zz3XcN1CJvm_DuWomoR7MrS7uEyCBHNMX5c8AiQ@mail.gmail.com>
Subject: Re: [PATCH v3] memcg, kmem: further deprecate kmem.limit_in_bytes
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vasily Averin <vvs@virtuozzo.com>,
        Roman Gushchin <guro@fb.com>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Muchun Song <songmuchun@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2021 at 12:51 PM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Tue, 19 Oct 2021 08:34:08 -0700 Shakeel Butt <shakeelb@google.com> wrote:
>
> > The deprecation process of kmem.limit_in_bytes started with the commit
> > 0158115f702 ("memcg, kmem: deprecate kmem.limit_in_bytes") which also
> > explains in detail the motivation behind the deprecation. To summarize,
> > it is the unexpected behavior on hitting the kmem limit. This patch
> > moves the deprecation process to the next stage by disallowing to set
> > the kmem limit. In future we might just remove the kmem.limit_in_bytes
> > file completely.
> >
> > ...
> >
> > @@ -3791,10 +3766,8 @@ static ssize_t mem_cgroup_write(struct kernfs_open_file *of,
> >                       ret = mem_cgroup_resize_max(memcg, nr_pages, true);
> >                       break;
> >               case _KMEM:
> > -                     pr_warn_once("kmem.limit_in_bytes is deprecated and will be removed. "
> > -                                  "Please report your usecase to linux-mm@kvack.org if you "
> > -                                  "depend on this functionality.\n");
> > -                     ret = memcg_update_kmem_max(memcg, nr_pages);
> > +                     /* kmem.limit_in_bytes is deprecated. */
> > +                     ret = -ENOTSUPP;
> >                       break;
> >               case _TCP:
> >                       ret = memcg_update_tcp_max(memcg, nr_pages);
>
> checkpatch said "ENOTSUPP is not a SUSV4 error code, prefer EOPNOTSUPP"?

I should have run checkpatch and Andrew, please replace ENOTSUPP with
EOPNOTSUPP. Thanks for catching this.
