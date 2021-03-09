Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 294A2331CC1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 03:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbhCICKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 21:10:31 -0500
Received: from conssluserg-05.nifty.com ([210.131.2.90]:37560 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbhCICKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 21:10:14 -0500
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 12929xXU031160;
        Tue, 9 Mar 2021 11:10:00 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 12929xXU031160
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1615255800;
        bh=J6mranKrb/KUfdNP0Xm6tx3boC5mot03U1MWvDPRabs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=m/uEiFIrciR12HK33IINJM03LQASX1E1d3COnGCLBd96k1ecAQ7Jz80U7izVxpH2K
         mW9czkkQjni5exYZMCXuXChy8emLpGxhyturKHIegAKlEnXgPzux87JpXG0o98plzr
         9oKUfKN34WDYUYFSldu+wJlDawayenTu1Etu6y6gCX/j4/iX6eczyCtbsrhGSX3Tg5
         7IUCYRNp36qEZq2GGXwiekkRu9zb+QnfwAVcbwqJohgqXCSwiaIpdA/A1riwNWKlTG
         RVlpcS5gWQjqSvxj9C9rlTWUNoNLPPnkKJo+ShXV5k1IC/4X6iqpjnObZSxsnbzp8s
         MdfZLr8+I7O1Q==
X-Nifty-SrcIP: [209.85.210.180]
Received: by mail-pf1-f180.google.com with SMTP id q20so8385639pfu.8;
        Mon, 08 Mar 2021 18:10:00 -0800 (PST)
X-Gm-Message-State: AOAM533YJPPcf7yBkU8qzd4Ghxrui1UYipZ5JU9UNc7R88TkqoFRzzYS
        l5PQ9uTLi0juiWNrc3ZI5q09cRj/H0DYpRb9lUs=
X-Google-Smtp-Source: ABdhPJx21ZsW6dVxfbXwYlXV8NLpgAitKxWA9t8bKn7T2UyNg7RrwfjPU92vM3RqXIe2XIvZWqvR+F6nwu5V8nQmnws=
X-Received: by 2002:a63:dd49:: with SMTP id g9mr23702063pgj.175.1615255799431;
 Mon, 08 Mar 2021 18:09:59 -0800 (PST)
MIME-Version: 1.0
References: <20210301145823.359770-1-masahiroy@kernel.org> <41623bcf-4cc5-b41e-4968-039035311ae9@gmx.de>
In-Reply-To: <41623bcf-4cc5-b41e-4968-039035311ae9@gmx.de>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 9 Mar 2021 11:09:22 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT2oX-po9AfjBY7HGvrmjCzJQem6VrRx31p=-82XaFqOQ@mail.gmail.com>
Message-ID: <CAK7LNAT2oX-po9AfjBY7HGvrmjCzJQem6VrRx31p=-82XaFqOQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] parisc: syscalls: switch to generic syscalltbl.sh
To:     Helge Deller <deller@gmx.de>
Cc:     "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        linux-parisc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Firoz Khan <firoz.khan@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        John David Anglin <dave.anglin@bell.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        YiFei Zhu <yifeifz2@illinois.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 9, 2021 at 5:49 AM Helge Deller <deller@gmx.de> wrote:
>
> On 3/1/21 3:58 PM, Masahiro Yamada wrote:
> > Many architectures duplicate similar shell scripts.
> >
> > This commit converts parisc to use scripts/syscalltbl.sh. This also
> > unifies syscall_table_64.h and syscall_table_c32.h.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>
> For both patches:
> Acked-by: Helge Deller <deller@gmx.de>
>
> Masahiro, will you push it upstream, or should I take it through the parisc tree?


Please apply it to the parisc tree.
Thanks.






-- 
Best Regards
Masahiro Yamada
