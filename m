Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 555023B2403
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 01:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbhFWXlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 19:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbhFWXlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 19:41:44 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E151AC061574
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 16:39:25 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id c11so5211970ljd.6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 16:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8Sp9kvKEzYyUtaXztGUZ5tIFsqruRShTDkrjjkj9hMA=;
        b=DmxrR811qtDeK81ykDtJ64z5VEVDzDyn6DVJMs2J4ofhRHYf//dTXcglj/MdFFVWp8
         YVXqEvcKOgVsHvTXYa3McKUQRUunEhMiyBb4wxWm3y8PPnhp1Y1MZMQ3PGFxxk0zyFxN
         ok+GRnoeyRDEU6WBZPX799Xb/7R3BRz/npvu1ZI/3IWbgl/WjN8wO57e8ckeMfrlSA7f
         j8FJVMM7+nocWeR3Y8NmfRdVC3A1KYxXXnhgicSYQEw5toYWbLZJT84Bi3B0JD7JrR97
         eDC8v02oES3Vi56VB/2/We0VxGP/4xe8cY/0rNkXP44i8cKJ2QrKw34WGux6OkDgb/c/
         /adg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Sp9kvKEzYyUtaXztGUZ5tIFsqruRShTDkrjjkj9hMA=;
        b=V5E02rB/G/jRd3GUAZzalDDuvNGJRL2UsoKDLNztQocevKOVOJW761y1wPC6XIhLg5
         NjnN//uyonc27gAFZG/g4YkvPMAcYUTwPvluGI/XVK+zWh8P5GzRCEzOsenLAOaNz3Gi
         p6qmUWqqj6kUiL0v2//svpPBaH4b9DA97cQDDbM1jsgY709B4gUkVJrBTYbHBQlMixje
         yenu0wVDXKiQQfeEt4Kzh6/RLwwr4DpfC3pU3AEc1j1sbhg2W1XT6Aye6YcTT/iq8dDb
         JHE2P65MvA9MD0g7bG+OT1BoPkSvI/ES/oCAO8k8HTvbxMqOiXgSolWiOebduGBWy5kA
         EbMg==
X-Gm-Message-State: AOAM5339cxcwgBKJDLhc32qPJcvVif/61J8GUMHcxFdQ4Nt5EfL+gnIL
        AoDm2iNf594C3rR2XQy9Kcirdcla6iXwJxET0ig+QUEY4puUtA==
X-Google-Smtp-Source: ABdhPJyNc5X8MCzg++DxfuCIWb6GRmNW1XC26TvO24/XitnPxrPMhaUIPfO1EeusOmJVSqJs4Fph5fzFqE8wN8lPRk8=
X-Received: by 2002:a2e:5c03:: with SMTP id q3mr1506404ljb.233.1624491563981;
 Wed, 23 Jun 2021 16:39:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210623223015.GA315292@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20210623223015.GA315292@paulmck-ThinkPad-P17-Gen-1>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 23 Jun 2021 16:39:11 -0700
Message-ID: <CAKwvOd=Y1fhJM7NpotvjNy3OE+JtqEBy046ctwE=cqV_ge5tgw@mail.gmail.com>
Subject: Re: Build failure in -next
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     aneesh.kumar@linux.ibm.com, LKML <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Marco Elver <elver@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 23, 2021 at 3:30 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> Hello, Aneesh!
>
> Yesterday evening's next-20210622 testing gave me the following
> kernel-build error:
>
> ld: mm/mremap.o: in function `move_huge_pud':
> /home/git/linux-next/mm/mremap.c:372: undefined reference to `__compiletime_assert_395'
>
> Bisection landed on this commit:
>
> 257121c5aabe ("mm/mremap: convert huge PUD move to separate helper")
>
> I have no idea how this commit relates to that error message, but
> reverting this commit on top of next-20210622 really does get rid of
> the problem.
>
> The following reproducer provokes this error:
>
> tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --torture lock --configs LOCK07 --build-only --kconfig "CONFIG_DEBUG_LOCK_ALLOC=y CONFIG_PROVE_LOCKING=y" --kmake-arg "CC=clang-11"
>
> Run the above command in the top-level directory of your -next source
> tree, and using this compiler:
>
> $ clang-11 -v
> Ubuntu clang version 11.1.0-++20210428103817+1fdec59bffc1-1~exp1~20210428204431.166
> Target: x86_64-pc-linux-gnu
>
> Thoughts?
>
>                                                         Thanx, Paul

++beers_owed; for the report and bisection. Also reported
https://lore.kernel.org/lkml/YM0mrZIPM+sWTDHf@Ryzen-9-3900X.localdomain/,
let's chat over there.

-- 
Thanks,
~Nick Desaulniers
