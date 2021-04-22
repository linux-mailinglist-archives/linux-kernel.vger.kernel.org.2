Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDCAF367ED8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 12:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235833AbhDVKjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 06:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235611AbhDVKjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 06:39:22 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB14C06138B
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 03:38:48 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id u20so13580452qku.10
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 03:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+J6itTyY+KkRgMA362LXOYaefIx+9LEyUZfAGr8mPwo=;
        b=Y6LzoE9MQ29pOpR4e5aTX3nSt9DP3s6j3P2cBOWI7KZubEzmMncFO430/4XhPzImbe
         y577F1el00RFXVwjsZzIXXKPhK9nL0CIIdrEhpWkNFYPrFWJqDkuNY64ThgGzr39bxEd
         8yv6Ci1r/5UceeVj85d2Z/j4dRyhgf6z0cGvaC6wAD2vfBh+qRn7djsDcYKFqcSyJi96
         HhJu0jXzeLc6yW+X05mHgE0SnjLlj2+KxFbDaJp6GdV2VMjEtC78/JRsoI72gK3d/14J
         haF7Oae5BilnWZUIEYtHNYN+rWXpeaZr3pjZbyPv+FWpQLgI0oBWvUrNwMLd2xb0Po6y
         7WkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+J6itTyY+KkRgMA362LXOYaefIx+9LEyUZfAGr8mPwo=;
        b=cp4dMbAts+SpQVh/ExryBnCNLT1WyFXTvJpP9GgTjJLvEh6I24MSettJgCzhKHkg4U
         MSBgVHeoLiPzG3R4UBdSqaw+vbzpjSglv1rR1A1tUhP9PBHKX7Kd7MUi2SmLTMK5OhlC
         lJpsa0GPHAsrjYmg9G+A/GU8ieXlxsAB+WmFT/OU3hSkKZO7/9Z1WKSo2ON6oiAAenst
         BXSNGTfJuUC24+zV/dk8/jO9R+CsoNH0B6FG79AmRZIcIh+/H/7Fz9Z0eb368ep3EQtF
         Zc+YPtJdzx6ZTjxrhokCLXxDDPdySfnaky/3X6sPO67fgYpjKRJi4/4J/2neGf9rxH6z
         NXxQ==
X-Gm-Message-State: AOAM533F2SqNK0UmxxbpKwjnwgL/Hch0RUG/xDYaL6yx8OBj0Nyzrg5K
        bQlnTQ+HeMDN2gQxEl4Z0wp0BL9XWAAC4yy5WFwu2A==
X-Google-Smtp-Source: ABdhPJyuYoOQC5R/9dwkvBwdx4uQn/Do6ceMOsPScMmfihQcn0YYEj6uhEo2Wu9qpSVU5F/DGS631ZbXVvxqr5jcHQE=
X-Received: by 2002:a37:42c3:: with SMTP id p186mr2972199qka.352.1619087927256;
 Thu, 22 Apr 2021 03:38:47 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20210422081536epcas5p417c144cce0235933a1cd0f29ad55470a@epcas5p4.samsung.com>
 <1619079317-1131-1-git-send-email-maninder1.s@samsung.com>
 <1619079317-1131-2-git-send-email-maninder1.s@samsung.com> <CACT4Y+ZJ95KiFNHeT9k0p6ezDz-apkJVp586UBSdJeHtCYR_Qg@mail.gmail.com>
In-Reply-To: <CACT4Y+ZJ95KiFNHeT9k0p6ezDz-apkJVp586UBSdJeHtCYR_Qg@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 22 Apr 2021 12:38:11 +0200
Message-ID: <CAG_fn=Xdx-hEna_S4u4nRXYXW+HrJCcyPPiGqQoU8Ri1UYZu0g@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm/kasan: proc interface to read KASAN errors at any time
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Maninder Singh <maninder1.s@samsung.com>,
        Marco Elver <elver@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        AMIT SAHRAWAT <a.sahrawat@samsung.com>,
        Vaneet Narang <v.narang@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Alex, Marco, can the recently added error_report_notify interface be
> used for this? Looks like they are doing roughly the same thing with
> the same intentions.

We've recently attempted to build a universal library capturing every
error report, but then were pointed to tracefs, which was just enough
for our purpose (https://lkml.org/lkml/2021/1/15/609).
Greg also stated that procfs is a bad place for storing reports:
https://lkml.org/lkml/2021/1/15/929.

Maninder, which exactly problem are you trying to solve?
Note that KASAN already triggers a trace_error_report_end tracepoint
on every error report:
https://elixir.bootlin.com/linux/v5.12-rc8/source/mm/kasan/report.c#L90
Would it help if you used that one? It could probably be extended with
more parameters.

Another option if you want verbatim reports is to use the console
tracepoints, as this is done in
https://elixir.bootlin.com/linux/v5.12-rc8/source/mm/kfence/kfence_test.c
Note that there are many caveats with error report collection (see the
links above), but for testing purpose it might be enough.

Alex
