Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 180EC3D0339
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 22:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbhGTUEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 16:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233242AbhGTT6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 15:58:46 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A44C061762
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 13:39:22 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id a23-20020a05600c2257b0290236ec98bebaso290607wmm.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 13:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BsY+NKv/XZi+6q8ALHCEokwQlprML2szGEsHbP7dUDo=;
        b=im/y0024Xt7uIk9rdJ9nEf9Flwqy6RP+EMxki/pwkYCD4BQ6ByyJ0trjzJOu8uTZAe
         PTjTRs0CGUZ9SXGI021qmwbl+TTgYBY45hEgF3MKgeCvlopbdpAYpc0cVXonAWEL5LtO
         iedT8rcx+onhhCcPYYrNp7DxA0H/WYwqJLDwjnGe06CGoMfqFIZjuFJLMLaQD2Aur+Pw
         +klfZUsBQpxY9nKDrDwdJkNiG7VLCth/Iayf9tE09FDdOZx89jVgZxVVOpt7BolQZvl2
         2jZ69uFEEZf+Ngptqn/W4cxpq2ODZk5FwMnmcwowDsHhf4gxNY7HmU+qFFS4NdILmdBo
         DFYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BsY+NKv/XZi+6q8ALHCEokwQlprML2szGEsHbP7dUDo=;
        b=YrMNk+APni9wTMj/NAxjBWi8HIVBQkHcnvvJ84EpRGeSoIToxtzNisnfwPgYvFLMfI
         Tw//PP67yp5CDHt0xAz5CXQexfAQ/XHMFhc/1dYnphU/kYTftRFdStmIMeazbdfofwRt
         4aECK48/FSEbAcOCZuex4bQTB4T12T7sHaO3Drj9hMHXfjSgWLlFi9sdXWQt7vH8MG+F
         HJc98vR4/vmRYRuLYTqaiDLnd/bKcKzy3/xKfSQBRw7rrSnGxjU3tFHefJS0ZXQCfw7v
         3sbYevAOQrd0kEjabuMKz/en+GUA+/0ZL/Tkma+0Kpm2IE6Yw8W0muy+XvSkbL1no6Z3
         +liw==
X-Gm-Message-State: AOAM530qDoDbCEyXHu+rQ7uY0UicwUQTwPLbJr/9Hy5qD2eAxqC+p6nT
        s/l5/C/tDcPY8thVzSV9dL+kIQxuPV57/prZFXgYTA==
X-Google-Smtp-Source: ABdhPJyFRM+FJuP84u9RfB5JCpLF0nd1AqQLHes34ffj0vZDREJluGzPfvMQprHdnNcX/mCbnu6aOkxZmjNtDQ3SnZo=
X-Received: by 2002:a7b:c5d2:: with SMTP id n18mr290768wmk.97.1626813561085;
 Tue, 20 Jul 2021 13:39:21 -0700 (PDT)
MIME-Version: 1.0
References: <796cbb7-5a1c-1ba0-dde5-479aba8224f2@google.com> <20210720155657.499127-1-peterx@redhat.com>
In-Reply-To: <20210720155657.499127-1-peterx@redhat.com>
From:   Hugh Dickins <hughd@google.com>
Date:   Tue, 20 Jul 2021 13:38:53 -0700
Message-ID: <CANsGZ6a6DxnviD3ZPoHCXEEktXguOjNxPuUjjh=v8h0xD3bhvQ@mail.gmail.com>
Subject: Re: [PATCH stable 5.10.y 0/2] mm/thp: Fix uffd-wp with fork(); crash
 on pmd migration entry on fork
To:     Peter Xu <peterx@redhat.com>
Cc:     stable <stable@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Igor Raits <igor@gooddata.com>,
        Hillf Danton <hdanton@sina.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 20, 2021 at 8:57 AM Peter Xu <peterx@redhat.com> wrote:
>
> In summary, this series should be needed for 5.10/5.12/5.13. This is the 5.10.y
> backport of the series.  Patch 1 is a dependency of patch 2, while patch 2
> should be the real fix.
>
> There's a minor conflict on patch 2 when cherry pick due to not having the new
> helper called page_needs_cow_for_dma().  It's also mentioned at the entry of
> patch 2.
>
> This series should be able to fix a rare race that mentioned in thread:
>
> https://lore.kernel.org/linux-mm/796cbb7-5a1c-1ba0-dde5-479aba8224f2@google.com/
>
> This fact wasn't discovered when the fix got proposed and merged, because the
> fix was originally about uffd-wp and its fork event.  However it turns out that
> the problematic commit b569a1760782f3d is also causing crashing on fork() of
> pmd migration entries which is even more severe than the original uffd-wp
> problem.
>
> Stable kernels at least on 5.12.y has the crash reproduced, and it's possible
> 5.13.y and 5.10.y could hit it due to having the problematic commit
> b569a1760782f3d but lacking of the uffd-wp fix patch (8f34f1eac382, which is
> also patch 2 of this series).
>
> The pmd entry crash problem was reported by Igor Raits <igor@gooddata.com> and
> debugged by Hugh Dickins <hughd@google.com>.
>
> Please review, thanks.

And these two for 5.10.y look good to me also: I'm glad you decided in
the end to keep 5.10's support for uffd-wp-fork.
The first is just a straight cherry-pick of
5fc7a5f6fd04bc18f309d9f979b32ef7d1d0a997, but as you noted above,
8f34f1eac3820fc2722e5159acceb22545b30b0d needed one line of fixup for
that tree.

Thank you Peter,
Hugh


>
> Peter Xu (2):
>   mm/thp: simplify copying of huge zero page pmd when fork
>   mm/userfaultfd: fix uffd-wp special cases for fork()
>
>  include/linux/huge_mm.h |  2 +-
>  include/linux/swapops.h |  2 ++
>  mm/huge_memory.c        | 36 +++++++++++++++++-------------------
>  mm/memory.c             | 25 +++++++++++++------------
>  4 files changed, 33 insertions(+), 32 deletions(-)
>
> --
> 2.31.1
>
>
