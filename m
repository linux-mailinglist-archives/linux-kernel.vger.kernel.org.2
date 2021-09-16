Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0562640DE80
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 17:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240099AbhIPPtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 11:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240113AbhIPPtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 11:49:47 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE283C0613C1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 08:48:26 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id v20-20020a4a2554000000b0028f8cc17378so2223915ooe.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 08:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rD3TrezbVLYHxHI60H3QOHHxKkUHFG/XFIP2soX5eXI=;
        b=r9/FKsGRZxXmFM5lvEMuZE+ffceWdPYMAOrxxA24P8B0Au4MU/ZZz3vUUCjFdXCi3k
         42AQKWu7i3+zTGocdosajg4EwaklRHUAtK52+q6qA6w+YYC/9CYkAXMU/WO33AtKbpn4
         kqRqHSKRvdswhjlGOanL5WS/j+cDY5FBbVqYeS3PIoPYmLA9B/6+dnoJjYnOGPS0JNW6
         w6tOFJuju01axPG6Xbk079jVi15R9ckiG4+WDBelTKCKm2j+esuqtMEJRdhzseZsuwOv
         x+dLefRbddFbaUuTZVxdFccm7D6MCagaygz6jFHAMpUCYnqWjZ7FJXXaJ8jbnlhia0l9
         M0aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rD3TrezbVLYHxHI60H3QOHHxKkUHFG/XFIP2soX5eXI=;
        b=Nb9E/Pe0H4EMNvQMdyK3rRftuEjXWuxfy/KrZei0BSKWo8VHiczCldR/1f5AbKMKsh
         PZsuRuM/Nux6xBJuO2zyMBOMnSw3l5sVo3fY3L4eP4G9esHIaf4BVN+VhOlIfJ++W/XO
         1m3OAILEf4jRyFOjwABYXasu1rizHtR5sw6iZLMeZGBqOYSfUxmczMNC1TEt0BS+HOrt
         cX5ciTmlYQMAHnTBujX1K1SJgGQ9IwbrU22GCeY8NMsDuY9hm1k08oPNdSJRc8SMpiyP
         BzSb76RafFAF6BAHheQubni12gLLN7erPDI2XzIrSFyL3QYk3AfD7zgyl+VmWCZgjgBy
         5xfg==
X-Gm-Message-State: AOAM531O4JoF3p6+i1mMizMpC11BYp6VwTDwLNbnAh/70BfHsEUlg210
        2WynFDPvUDdVWBT1CmkT/lincMDusaDbU1x8cs3xqQ==
X-Google-Smtp-Source: ABdhPJyglXbT5duFWaAC2wJjOoTihuxBgokAfIkKTcyjjBv8P1RhULB7cFk7Y1AL7PUYSwq3MNi8/7nuKyLiaMWaWLI=
X-Received: by 2002:a4a:4344:: with SMTP id l4mr4919522ooj.38.1631807305859;
 Thu, 16 Sep 2021 08:48:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210421105132.3965998-1-elver@google.com> <20210421105132.3965998-3-elver@google.com>
 <6c0d5f40-5067-3a59-65fa-6977b6f70219@huawei.com> <abd74d5a-1236-4f0e-c123-a41e56e22391@huawei.com>
 <858909f98f33478891056a840ad68b9f@AcuMS.aculab.com>
In-Reply-To: <858909f98f33478891056a840ad68b9f@AcuMS.aculab.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 16 Sep 2021 17:48:14 +0200
Message-ID: <CANpmjNPXNM-di-XwW52Hh5kEv9BPSh_Aw75yFQpu81e1kUfGtA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] kfence: maximize allocation wait timeout duration
To:     David Laight <David.Laight@aculab.com>
Cc:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "glider@google.com" <glider@google.com>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "jannh@google.com" <jannh@google.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        "hdanton@sina.com" <hdanton@sina.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Sept 2021 at 17:45, David Laight <David.Laight@aculab.com> wrote:
>
> From: Kefeng Wang
> > Sent: 16 September 2021 02:21
> >
> > We found kfence_test will fails  on ARM64 with this patch with/without
> > CONFIG_DETECT_HUNG_TASK,
> >
> > Any thought ?
> >
> ...
> > >>       /* Enable static key, and await allocation to happen. */
> > >>       static_branch_enable(&kfence_allocation_key);
> > >>   -    wait_event_timeout(allocation_wait, atomic_read(&kfence_allocation_gate), HZ);
> > >> +    if (sysctl_hung_task_timeout_secs) {
> > >> +        /*
> > >> +         * During low activity with no allocations we might wait a
> > >> +         * while; let's avoid the hung task warning.
> > >> +         */
> > >> +        wait_event_timeout(allocation_wait, atomic_read(&kfence_allocation_gate),
> > >> +                   sysctl_hung_task_timeout_secs * HZ / 2);
> > >> +    } else {
> > >> +        wait_event(allocation_wait, atomic_read(&kfence_allocation_gate));
> > >> +    }
> > >>         /* Disable static key and reset timer. */
> > >>       static_branch_disable(&kfence_allocation_key);
>
> It has replaced a wait_event_timeout() with a wait_event().
>
> That probably isn't intended.
> Although I'd expect their to be some test for the wait being
> signalled or timing out.

It is intended -- there's a wake_up() for this. See the whole patch
series for explanation.

The whole reason we had the timeout was to avoid the hung task
warnings, but we can do better if there is no hung task warning
enabled.
