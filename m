Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1C03D312A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 03:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233053AbhGWAfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 20:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232905AbhGWAff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 20:35:35 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113E2C061757
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 18:16:09 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id c204so7436944ybb.4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 18:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3GzZUiWRloPQrXBdUYorJDMZSlFJKnkE4RwHu5ZYLM4=;
        b=IAlCVu8/mqkfWitvqAfF6S/1PxmHsrL1hI3yjJtBfzQ89rf2bO8G3Vv4EmdUTjyCv4
         vErCIaWL0RSz/07P0pjWzM0Szka8jRxHUncJUX/VcOsSXI5bqBfHCc9VrH8BuzHdCMxa
         xScBENnfqpq3t6Wz9djsWnyugd8bYwvHF00f+WSd7eXfSISchVbTd792koY6PtUhCMB8
         F61QuaR2C7IkVoGlrIu/WkstgmvAzHIbXn9LQjmCyQAZCpNOgj78mN7vjhDzIP6ihwZt
         KIlL4qDOWPdRpnjLt4XbDSd5gL4XLGVADSaqIc3WQyVavvmEkIGrZSSo6+Gu+FqGME82
         zryw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3GzZUiWRloPQrXBdUYorJDMZSlFJKnkE4RwHu5ZYLM4=;
        b=tc0RIqbQm661cTxPnzqvK3t0JWXbtt0QAQ1QiWyZXNlAYUK4LHSc9NdKDedaSh0/Je
         iQhyixSBSrD4u9/mgbkb7sHwVwiQ0vNuc5hpFjuqLwRvyIycIt+KVRTe3xQNadqz+KO0
         YSlvMV+tc56Qj9JIWoJ598rVgoUtq3Mm/AcpFprYa2bRHdlWYwMj3fXfMKWWlV1iUWBc
         LakCtaorxhNaVdGVskA/kwD2q6KdVJKKNZvY8HEmB0+2zbEbxP4A6V30FBYf7MBbR0Wr
         2gYtBreEKP/3CHouQP9dC1TIKZZ/Lk+pAw2yL+aVwh/qKFQYVj//pyGy+9Cw+LZEDo88
         mJaQ==
X-Gm-Message-State: AOAM531yvZwEeSutckmhPi8zVXZIs8n4ku96lst0roThCGuBMZ1P8p7Y
        xvji4chkVzilLoWWhJSioR010jECxLGDneS6TRqi4Q==
X-Google-Smtp-Source: ABdhPJyq45hMHallqmqyOyy6fSXBjwl/uWwFFwTNoBAyZ8V7mgCKBB69jXsoebr7Ozr+T0JmNGzVP/AhVgeCaqQB5Z0=
X-Received: by 2002:a25:ba08:: with SMTP id t8mr3115977ybg.111.1627002968071;
 Thu, 22 Jul 2021 18:16:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210718214134.2619099-1-surenb@google.com> <7eb17da6-03a6-5eaf-16e6-97b53ba163d8@redhat.com>
 <20210720160707.2332738708948f7d865d67c1@linux-foundation.org>
 <ba763ed3-9ad1-9502-1ffc-3175446570d1@redhat.com> <CAJuCfpEB994Xj3FcmzyH1p3yOdLVf6EwZaGaRj7NJi_c9hbsRQ@mail.gmail.com>
 <0ee6775b-589c-3243-1c01-aafad5eecb73@redhat.com> <CAJuCfpHtRzCNH6Cspu8ngjw+WLvZTMsVbmBu_F-z8YY_n=RbvA@mail.gmail.com>
 <20210721135056.84d12dd49c07adff7b0beffb@linux-foundation.org> <CAJuCfpGsSFccjV9Qd86PCdLHjRG9gdP7snfy-856pzmfxdGO1w@mail.gmail.com>
In-Reply-To: <CAJuCfpGsSFccjV9Qd86PCdLHjRG9gdP7snfy-856pzmfxdGO1w@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 22 Jul 2021 18:15:57 -0700
Message-ID: <CAJuCfpFRXkfV_2dFt1vE-qJw8_oerE6tEza8hGZgFetPyQ6NkQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] mm, oom: move task_will_free_mem up in the file to
 be used in process_mrelease
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Christoph Hellwig <hch@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fweimer@redhat.com>,
        Jan Engelhardt <jengelh@inai.de>,
        Tim Murray <timmurray@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 21, 2021 at 1:59 PM Suren Baghdasaryan <surenb@google.com> wrote:
>
> On Wed, Jul 21, 2021 at 1:51 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Wed, 21 Jul 2021 13:19:35 -0700 Suren Baghdasaryan <surenb@google.com> wrote:
> >
> > > > > This would not require moving other functions.
> > > > > Would that be better than the current approach or the forward declaration?
> > > >
> > > > IMHO that could be an easy, possible alternative.
> > >
> > > Andrew, others? Should I follow this path instead?
> >
> > Whatever you prefer ;)
>
> I understand David's concern too well to ignore it, so I prefer to
> follow this middle-ground approach if you don't mind :)

v3 with the refactoring is posted at
https://lore.kernel.org/patchwork/project/lkml/list/?series=509230
