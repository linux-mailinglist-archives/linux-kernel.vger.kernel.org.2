Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE1A3219EA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 15:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbhBVONK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 09:13:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbhBVNf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 08:35:59 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A324C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 05:35:19 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id w18so4598934plc.12
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 05:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bctf/dzCv2h8tPgb+fc7WxfPbgnBZqLLxVvk8KfYrRI=;
        b=mUdHcv1EK7U8rCkloAZv3RG6Gq4BknGMD3PVDxhV9zcJBmZElbFlWG3vdVH7+bI+Hl
         S1xzXv6CGa+Bmq4FC/M38WR/bnX28EhNxdW478jthAD2tW67ai6krTrpetIfaHxIFtQM
         aiV/bIh8o4b1gcf3JTcwG1xO0DrC48r/e3x58V8Q3WFjdlZ7qAmOt3f3qDdpPpoeJ2O7
         k+CF888wMbdqUHFWaLWL4QWJKRxD9F2rDXiJKxCxmUBuxeNN0F7hpZyJMOlzL5gkMwyI
         jzh1MSkLkjTZpBSJd+qB2KUDBj+RaJNlzR+G9vtG/8SK03GR69BJTjkcoraQKLZnS3Rl
         2LXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bctf/dzCv2h8tPgb+fc7WxfPbgnBZqLLxVvk8KfYrRI=;
        b=dU/hjCQ2l+m7tvB1FqKKsib5dNOOXUwoxkRTA9PSPCITo6TWTtFTwP6daIu01WZ2W5
         wI0l58phUfzzJRXlXX5ACehnlS7mlMdPctcnjh6imk7lYeqWGEG2OmeL2N9G6EfKGYF9
         bHobbgNwLZyitlhz3usElZsqjGeZZP+G8vmxmWrHpzTT+TthMkMVXm7Le5SjUl1DcxKp
         UMpzUUPd+StbpxrrKGpYSNk8Hzv+ffUgqv9jo5Dq1Aq9DGuHKobeTKquz3gvER3stGkF
         CF/sp42TARYYQbzDRqMUfhgL54HnorszTJALwhCDWXS9XgxhbUVPxrpXkJ/PRDdGOZJD
         7SGA==
X-Gm-Message-State: AOAM532m+5HF5gfudDw9hJQJG5FF0TxMuKrBJ7NJROcqs3NQezzBj0UT
        VFKQlrOhLl1oiBMz5AORFfntX45JPaLYd1XxsyFRE58aKcU=
X-Google-Smtp-Source: ABdhPJwFukls2R93nF5DRsLTX8nCzv9HJo85UphBiibdEZqqx95pjNS43Gv3HxpoOcze6uWuDYbsq2chXaXXucsw2uc=
X-Received: by 2002:a17:90b:350b:: with SMTP id ls11mr23471873pjb.166.1614000918571;
 Mon, 22 Feb 2021 05:35:18 -0800 (PST)
MIME-Version: 1.0
References: <20210211153353.29094-1-vincenzo.frascino@arm.com>
 <20210211153353.29094-8-vincenzo.frascino@arm.com> <20210212172224.GF7718@arm.com>
 <CAAeHK+zg5aoFfi1Q36NyoaJqorES+1cvn+mRRcZ64uW8s7kAmQ@mail.gmail.com> <fbc215de-82f0-cc6f-c6f3-9ea639af65d2@arm.com>
In-Reply-To: <fbc215de-82f0-cc6f-c6f3-9ea639af65d2@arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Mon, 22 Feb 2021 14:35:07 +0100
Message-ID: <CAAeHK+zUCY8J3gHPAU6fJSQ-fK8R9JHER7PxqWkvbmbdtiLbEQ@mail.gmail.com>
Subject: Re: [PATCH v13 7/7] kasan: don't run tests in async mode
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 22, 2021 at 12:13 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
> On 2/12/21 9:44 PM, Andrey Konovalov wrote:
> >> I think we have time to fix this properly ;), so I'd rather not add this
> >> patch at all.
> > Yeah, this patch can be dropped.
> >
> > I have a prototype of async support for tests working. I'll apply it
> > on top of the next version Vincenzo posts and share the patch.
> >
> > Vincenzo, when you post the next version, please make sure you rebase
> > on top of the mm tree version that includes "kasan: export HW_TAGS
> > symbols for KUnit tests" (linux-next/akpm doesn't yet have it).
>
> Fine by me, I will drop this patch when I will repost in -rc1.
>
> @Andrey: If you want me to test the series all together, you can send me your
> tree before I repost and then I can send the patches as single series. What do
> you think?

I'll need a rebased version of your patches first, otherwise conflicts
will be a pain.

Thanks!
