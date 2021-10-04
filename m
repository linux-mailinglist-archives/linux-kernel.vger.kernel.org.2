Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9B08421675
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 20:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238638AbhJDSat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 14:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238617AbhJDSas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 14:30:48 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA6CC061745
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 11:28:58 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id g8so68559440edt.7
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 11:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M3olL4PCIPnsY+XsG6ODxFPkLeYPL3IXmw45N+fdrVs=;
        b=ED7KbLk3Ph78YVcabHLJMRc846iOZ2dIMnZRnR0e6vJ6SPDEhonEpbqT45rC+8p5Ut
         XVAKBqPSzdcfcuSk1x6uebAiWCa2qDhAoXKI2O0qQ4eGJmD70AVvl1Ykkol5hMNsc24D
         9MfEvtlJaFfoct2c6/g7z2+rFYCBRR2moM+b8I51aXJU6AKxj/0V/yAgDx3XcvaAj08H
         dVGjtX8QraZx4uew81Xi+V4Z+ClwKzncibSDMq6OanS1R3oSGB5l1ZIssPTEcr4uvsoR
         jiAfJZAi4vGd8bK+fZaNi+FyiIz9XNjyeGOt6h+6a9/BpBhSINdXk1qQ//7ZRpyUqQ+u
         J2YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M3olL4PCIPnsY+XsG6ODxFPkLeYPL3IXmw45N+fdrVs=;
        b=N+vYsP/kNq9pfJhuHZPOwAnBfSZdWXAX2Qh7RmERV9OesLkTCHErHGgGEq8clKRKEB
         Q9J5DgLpYEGmByAO5nUDxjIQRCYmIsTGkofTLJeBCubt6y9H6X113V+dU6GnBbZh/YpN
         G1D0dRIfyO7b7fdD/TPPjjMLN8ANC1UBk0VGNvMqMqr3ugqxSBDfOVAXTWcVzkGQHq2g
         kqDOTX/tAo5XCKiDsJb3z6QLPKB48VXL4NFmvChhnhbr9tDq4dyKbnVD5bXHVg5qzf6M
         aR2WSIGrrXmpjI69o4vMhFLX8aZyjAQcvQG7jjTYLuQjwVALtF3ScFNtnkqxJJ2pWW1K
         nR/Q==
X-Gm-Message-State: AOAM530tOC8yJCrsg3+r0BBku9z59kMMuTwgwJKgFdJHGBmpbKRijBtn
        HfV0WQyJehjLYLnmwnicnz7woZCimOkze1XRUce+IjMDKv4=
X-Google-Smtp-Source: ABdhPJwKXPdOdSXdF4nkEob3263c0W+0zCyiiXlZN+Nj1BOEgtL2N6pRj+PERlK2r3mZ779LDmusd/VgET5Rl4TfoEw=
X-Received: by 2002:a50:8d85:: with SMTP id r5mr19954555edh.312.1633372137470;
 Mon, 04 Oct 2021 11:28:57 -0700 (PDT)
MIME-Version: 1.0
References: <dde441c4-febe-cfa1-7729-b405fa331a4e@linux.alibaba.com>
 <CAPhsuW5FONP=1rPh0oPLHsehjfGSDQWn8hKH4v=azdd=+WK2sA@mail.gmail.com>
 <YVSopxYWegtQJ3iD@casper.infradead.org> <CAPhsuW6_2_LxQRrs7xF3omgO22+6goDR=bEjKGRopaS-pHJB2Q@mail.gmail.com>
 <67906bf5-4de9-8433-3d70-cc8fc5cc2347@linux.alibaba.com> <CAPhsuW4_-ju9QgB7J4imrhQvH6ZqoOkVtVOVX11Yk_ZRakwQ+A@mail.gmail.com>
 <3d264ed9-f8fd-60d4-7125-f9f745ebeb52@google.com> <YVXXq0ssvW6P525J@casper.infradead.org>
 <f889db88-7b7d-ddb0-a7ed-3eda85d3eb96@google.com> <CAHbLzkq7=FsXtp4YcjeruJwbYyhsRGCq+eC8uwC-Tg06JBTUUA@mail.gmail.com>
 <YViSGYhn+zTShwFP@casper.infradead.org>
In-Reply-To: <YViSGYhn+zTShwFP@casper.infradead.org>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 4 Oct 2021 11:28:45 -0700
Message-ID: <CAHbLzkosZr_ugNAMbXreUumSyAUMH1hPhTaiXXXRUNx88J9Xsw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mm, thp: check page mapping when truncating page cache
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Hugh Dickins <hughd@google.com>, Song Liu <song@kernel.org>,
        Rongwei Wang <rongwei.wang@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        William Kucharski <william.kucharski@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 2, 2021 at 10:09 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Thu, Sep 30, 2021 at 10:39:14AM -0700, Yang Shi wrote:
> > On Thu, Sep 30, 2021 at 9:49 AM Hugh Dickins <hughd@google.com> wrote:
> > > I assume you're thinking of one of the fuzzer blkdev ones:
> > > https://lore.kernel.org/linux-mm/CACkBjsbtF_peC7N_4mRfHML_BeiPe+O9DahTfr84puSG_J9rcQ@mail.gmail.com/
> > > or
> > > https://lore.kernel.org/lkml/CACkBjsYwLYLRmX8GpsDpMthagWOjWWrNxqY6ZLNQVr6yx+f5vA@mail.gmail.com/
> > >
> > > I haven't started on those ones yet: yes, I imagine one or both of those
> > > will need a further fix (S_ISREG() check somewhere if we're lucky; but
> > > could well be nastier); but for the bug in this thread, I expect
> >
> > Makes sense to me. We should be able to check S_ISREG() in khugepaged,
> > if it is not a regular file, just bail out. Sounds not that nasty to
> > me AFAIU.
>
> I don't see why we should have an S_ISREG() check.  I agree it's not the
> intended usecase, but it ought to work fine.  Unless there's something
> I'm missing?

Check out this bug report:
https://lore.kernel.org/lkml/CACkBjsYwLYLRmX8GpsDpMthagWOjWWrNxqY6ZLNQVr6yx+f5vA@mail.gmail.com/
and the patch from me:
https://lore.kernel.org/linux-mm/20210917205731.262693-1-shy828301@gmail.com/

I don't think we handle buffers correctly for file THP, right? My
patch is ad hoc, so I thought Hugh's suggestion makes some sense to
me. Why do we have THP collapsed for unintended usecase in the first
place?
