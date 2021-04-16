Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3081036196B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 07:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238531AbhDPFlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 01:41:45 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:26771 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbhDPFlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 01:41:44 -0400
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 13G5epDP031255
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 14:40:51 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 13G5epDP031255
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1618551652;
        bh=iFOikycyQ7i5uJ+3y6p8wEYNef3YAETSQnRFp2InNPU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vqMORC5uwkR0SD06BZH/Md9UniYKVyNm/oOVQ9a9g5+JusU6ofzdm6jVVGL+OIBgC
         LwsJRqAxJlukIdDEZCML9/lA4sbEkefUfmvDa03SeQ+uGBX17osZhjsfytKovrk9+G
         77VZN5q1HA3O135Z6op2+afBIIgxfAIr0THlu26MbuCWYG56kVmpW7LqJTusxF2bbE
         hpgTvu1u2Vk5BRjK0nU+Oo9u+mQ9qeIMKC5MQKVF3qp+vNrd6LNeLgXC0Z6n5cL8xG
         Mq6AneWA+ahyP5Skc+TASfOXYPTlbIAZbq2uRfoT0n+og1pa5Sx6CaRsKQibgIMvAs
         2c1gOVn4AT7fA==
X-Nifty-SrcIP: [209.85.210.179]
Received: by mail-pf1-f179.google.com with SMTP id d124so17585844pfa.13
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 22:40:51 -0700 (PDT)
X-Gm-Message-State: AOAM532EyaLi9bCehHZk4VR4jB/4JU8u892Cg3/FtpNldsQYE6C7U5mS
        ms/Fx5UmRs1KAy9vrFCpo0lpzLryBlYuukzsvQU=
X-Google-Smtp-Source: ABdhPJzM8++20ZWnUL+b7ja3YLqHEWvDSf4FOyp/GhhBVW1ckZUNcQQ05s/qrFGvMre4gVR9scNFPatRqd6x6UalKI4=
X-Received: by 2002:a65:45cf:: with SMTP id m15mr6561675pgr.7.1618551650955;
 Thu, 15 Apr 2021 22:40:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210327120155.500-1-ionic@ionic.de> <20210415072803.16338-1-ionic@ionic.de>
In-Reply-To: <20210415072803.16338-1-ionic@ionic.de>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 16 Apr 2021 14:40:13 +0900
X-Gmail-Original-Message-ID: <CAK7LNATqZxthFKb71OUbq6WKbEi4uWdGy-nExx5wt=Mvb+hnCA@mail.gmail.com>
Message-ID: <CAK7LNATqZxthFKb71OUbq6WKbEi4uWdGy-nExx5wt=Mvb+hnCA@mail.gmail.com>
Subject: Re: [PATCH v3] kconfig: nconf: stop endless search loops
To:     Mihai Moldovan <ionic@ionic.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2021 at 4:28 PM Mihai Moldovan <ionic@ionic.de> wrote:
>
> If the user selects the very first entry in a page and performs a
> search-up operation, or selects the very last entry in a page and
> performs a search-down operation that will not succeed (e.g., via
> [/]asdfzzz[Up Arrow]), nconf will never terminate searching the page.
>
> The reason is that in this case, the starting point will be set to -1
> or n, which is then translated into (n - 1) (i.e., the last entry of
> the page) or 0 (i.e., the first entry of the page) and finally the
> search begins. This continues to work fine until the index reaches 0 or
> (n - 1), at which point it will be decremented to -1 or incremented to
> n, but not checked against the starting point right away. Instead, it's
> wrapped around to the bottom or top again, after which the starting
> point check occurs... and naturally fails.
>
> My original implementation added another check for -1 before wrapping
> the running index variable around, but Masahiro Yamada pointed out that
> the actual issue is that the comparison point (starting point) exceeds
> bounds (i.e., the [0,n-1] interval) in the first place and that,
> instead, the starting point should be fixed.
>
> This has the welcome side-effect of also fixing the case where the
> starting point was n while searching down, which also lead to an
> infinite loop.
>
> OTOH, this code is now essentially all his work.
>
> Amazingly, nobody seems to have been hit by this for 11 years - or at
> the very least nobody bothered to debug and fix this.
>
> Signed-off-by: Mihai Moldovan <ionic@ionic.de>
> ---

Applied to linux-kbuild. Thanks.


> v2: swap constant in comparison to right side, as requested by
>     Randy Dunlap <rdunlap@infradead.org>
> v3: reimplement as suggested by Masahiro Yamada <masahiroy@kernel.org>,
>     which has the side-effect of also fixing endless looping in the
>     symmetric down-direction
>
>  scripts/kconfig/nconf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/kconfig/nconf.c b/scripts/kconfig/nconf.c
> index e0f965529166..af814b39b876 100644
> --- a/scripts/kconfig/nconf.c
> +++ b/scripts/kconfig/nconf.c
> @@ -504,8 +504,8 @@ static int get_mext_match(const char *match_str, match_f flag)
>         else if (flag == FIND_NEXT_MATCH_UP)
>                 --match_start;
>
> +       match_start = (match_start + items_num) % items_num;
>         index = match_start;
> -       index = (index + items_num) % items_num;
>         while (true) {
>                 char *str = k_menu_items[index].str;
>                 if (strcasestr(str, match_str) != NULL)
> --
> 2.30.1
>


-- 
Best Regards
Masahiro Yamada
