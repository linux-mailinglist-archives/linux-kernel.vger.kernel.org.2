Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5A03CAD26
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 21:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344516AbhGOTyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 15:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344210AbhGOTZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 15:25:25 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538B8C08EA3C
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 12:06:52 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id qb4so10994582ejc.11
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 12:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uqvGsJK5Zcuxyijq6bYQkFswgt3gMFWId21swertgS0=;
        b=GnDQiC/frMfCzr26Rp5EJ50FhygKMKaL/9juNBqQ+Hy7v1PhfxDdwxySS0qT2yx5Di
         /GQQ0Fx0k8c8JsFgPgVFR6QOS21RQtFtUX+bgw96iqmdIwnD4C/uUljPFOYTNv1wz+wl
         PRWwdFcHgVSuyyhlmk20eieNTe2b2RSSa6tncYx1O0RSXef6B3htdoTxI1JQBycdvxeL
         xB94G66D6vpE4THo9Sev/88rKsHveH2zCcLX6u04+9A/O3aAtl5uQdyNAiGGJAGGGNqd
         XDPn7lCQsOMU1Ouv3MM93Har6BEECgWxK1INaH9IuQ25L4Jf9WhUpYYDd00pWxYO2Ouh
         9zEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uqvGsJK5Zcuxyijq6bYQkFswgt3gMFWId21swertgS0=;
        b=gYbyg77C92s72dnLQOAJQ9DuUtR1qcMJ7dSJf9AgsQxKg3ZHMr1IThTVNHBXAZes0L
         cT/w7Zhqmj2B/PIwbgQNjbmkCqdfVh8Wiys+9kBXLNB59zZevHEoUuMGr+LdErmQf6zv
         /djfLthwkDx1JExJevEk1cgMyPG4bWQ3Gn4j/2D83/ujf5uIEhwPB0vxSMPmXQpTQjH9
         xM6zURRplTxCC/+kxMEVPdHq2h33ZK2k2itjOLnxnpNbXKTujl65OO2GJOaeqEGbBlXn
         CQ6svP1QErq7mD27Y+iV0QnnyX3jWqwuZ5lOnLDln5HSPJr28qAeaVXkOynAc4uxom7x
         HA6A==
X-Gm-Message-State: AOAM533Z4wJkjDz/QJ5HP2Gvy/2KcVhLY83wvm1syab8TS1eHygONh9k
        O6/OBVKI7Kc+nixO1KaTKv3js+jZhN6SAJF+w0JGCA==
X-Google-Smtp-Source: ABdhPJwAJtZ056pN3g1I+ukwRrssYAGm4I6BGigJPe34BUO8xjUJ/FyHC7YvTHztWo1Kk1u17Vd4nKVZ58mHFmDU168=
X-Received: by 2002:a17:906:31d4:: with SMTP id f20mr6897385ejf.383.1626376010882;
 Thu, 15 Jul 2021 12:06:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1626371112.git.zhansayabagdaulet@gmail.com>
 <343394260f599d940cacc37f1dcc0309239ae220.1626371112.git.zhansayabagdaulet@gmail.com>
 <YPB7rBlU1SinK6FR@casper.infradead.org> <CA+CK2bCPMmbr+=h4evTkbJoEFQu_th_NOe0Gp11hU7xz3fLZ8A@mail.gmail.com>
 <YPB+tT0AcOB4UZQ5@casper.infradead.org> <CA+CK2bBqFr+_jxr2KU4DWv7GmOztfP8Lc+dKjy=YeUDvotyoBQ@mail.gmail.com>
In-Reply-To: <CA+CK2bBqFr+_jxr2KU4DWv7GmOztfP8Lc+dKjy=YeUDvotyoBQ@mail.gmail.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 15 Jul 2021 15:06:15 -0400
Message-ID: <CA+CK2bD8b9S7PZ8TS+vWTCwBY1h_51wQ5PrvCNNkGKO4r6E2cw@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: KSM: fix ksm_run data type
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > /sys/kernel/mm/ksm/run
> > >
> > > run: write 0 to disable ksm, read 0 while ksm is disabled.
> > >
> > > - write 1 to run ksm, read 1 while ksm is running.
> > > - write 2 to disable ksm and unmerge all its pages.
> >
> > The document is out of date then as it does not mention 'offline'.
>
> The offline mode cannot be set externally.
>
> In run_store()
>    if (flags > KSM_RUN_UNMERGE)
>       return -EINVAL;

However, I see that KSM_RUN_OFFLINE is visible via run_show(), so yes
doc should be updated. And, yes it becomes a bitfield from the user
perspective.

>
> >
> > Also, why does the call to kstrtouint() specify base 10?  If it is a
> > bitmap, then permitting 0x [1] is more natural.  I would expect to see
> > base 0 there.
>
> Users can only write 0, 1, or 2, it is not a bitmap from the user's
> perspective as the user cannot write: '3' . But, I think it is
> somewhat weird that ksm_run is used as a bitmap internally with
> KSM_RUN_OFFLINE = 4.
>
> Imo, KSM_RUN_OFFLINE should be placed in a separate boolean from "ksm_run".
>
> >
> > [1] or even 0b, although I see that _parse_integer_fixup_radix does not
> > support the 0b notation.
