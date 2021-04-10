Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC43835AB1C
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 07:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232427AbhDJFtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 01:49:05 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:61682 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhDJFtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 01:49:04 -0400
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 13A5mNrU025316
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 14:48:24 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 13A5mNrU025316
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1618033704;
        bh=Kh4uNz3ATyczypXrIObx+vT4JZHImZQBcDO/I4QPpws=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=M0T7OdhBR3MtYs+mE9eeCDmiWrM6Im8s+3Z+JAIDS29+xzxMVOcYqWAXNbZtKB3/B
         IjARdSm2UdB1LdKJvAOkqgiAETluX5c4iKcAJyX9tZ5rOXQnAXxnGvKY5eDgSZkB5N
         34CcdOeuu+i6X/LTvqPRNQtm3L+Hm+VakJETfSp1SiJRdv5buQtSe48v5k3mG+dxpW
         pdco+NpOtSe5VBhEgna2iYPUtLAx+ZFjARAceU2KqV3Frm5ibkSo5VutK8HoXhRnwL
         OUumo40vo7TbqMdSwqvzxdOBygrOZAK8qoheerLYxq0f1cOaGfNSUJBU4PDp19iGtW
         R+ho2k9K4KaDg==
X-Nifty-SrcIP: [209.85.216.51]
Received: by mail-pj1-f51.google.com with SMTP id ot17-20020a17090b3b51b0290109c9ac3c34so5994548pjb.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 22:48:23 -0700 (PDT)
X-Gm-Message-State: AOAM533uPErI+RlKv+V5OrJiVGuDjmS1y/smOCWTBNHqoVdAgF63m7Ms
        2kmSv4Q5J4vIfm3l8Hl/FizmF2QZbv75EoB+6fg=
X-Google-Smtp-Source: ABdhPJzLNZzTFG7JUiSvv9bc98VU8RycUIFGnujqeGjNtkCQalgu4vy3/qIa/bN8HUydqcdQevtz6zN2CgeHFPzkkzk=
X-Received: by 2002:a17:90a:f68a:: with SMTP id cl10mr17310314pjb.87.1618033703145;
 Fri, 09 Apr 2021 22:48:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210327120155.500-1-ionic@ionic.de> <20210328095227.24323-1-ionic@ionic.de>
In-Reply-To: <20210328095227.24323-1-ionic@ionic.de>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 10 Apr 2021 14:47:46 +0900
X-Gmail-Original-Message-ID: <CAK7LNATzx9ujmapPbPzjL1Yo-A0RAXz0Kma+ve8pUeDDVx8GGw@mail.gmail.com>
Message-ID: <CAK7LNATzx9ujmapPbPzjL1Yo-A0RAXz0Kma+ve8pUeDDVx8GGw@mail.gmail.com>
Subject: Re: [PATCH v2] kconfig: nconf: stop endless search-up loops
To:     Mihai Moldovan <ionic@ionic.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 28, 2021 at 6:52 PM Mihai Moldovan <ionic@ionic.de> wrote:
>
> If the user selects the very first entry in a page and performs a
> search-up operation (e.g., via [/][a][Up Arrow]), nconf will never
> terminate searching the page.
>
> The reason is that in this case, the starting point will be set to -1,
> which is then translated into (n - 1) (i.e., the last entry of the
> page) and finally the search begins. This continues to work fine until
> the index reaches 0, at which point it will be decremented to -1, but
> not checked against the starting point right away. Instead, it's
> wrapped around to the bottom again, after which the starting point
> check occurs... and naturally fails.
>
> We can easily avoid it by checking against the starting point directly
> if the current index is -1 (which should be safe, since it's the only
> magic value that can occur) and terminate the matching function.
>
> Amazingly, nobody seems to have been hit by this for 11 years - or at
> the very least nobody bothered to debug and fix this.
>
> Signed-off-by: Mihai Moldovan <ionic@ionic.de>
> ---
> v2: swap constant in comparison to right side, as requested by
>     Randy Dunlap <rdunlap@infradead.org>
>
>  scripts/kconfig/nconf.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/scripts/kconfig/nconf.c b/scripts/kconfig/nconf.c
> index e0f965529166..db0dc46bc5ee 100644
> --- a/scripts/kconfig/nconf.c
> +++ b/scripts/kconfig/nconf.c
> @@ -515,6 +515,15 @@ static int get_mext_match(const char *match_str, match_f flag)
>                         --index;
>                 else
>                         ++index;
> +               /*
> +                * It's fine for index to become negative - think of an
> +                * initial value for match_start of 0 with a match direction
> +                * of up, eventually making it -1.
> +                *
> +                * Handle this as a special case.
> +                */
> +               if ((index == -1) && (index == match_start))
> +                       return -1;

We know 'index' is -1 in the second comparison.
So, you can also write like this:

       if (match_start == -1 && index == -1)
                return -1;



But, it is not the correct fix, either.

The root cause of the bug is match_start
becoming -1.


The following is the correct way to fix the bug
without increasing the number of lines.



diff --git a/scripts/kconfig/nconf.c b/scripts/kconfig/nconf.c
index e0f965529166..af814b39b876 100644
--- a/scripts/kconfig/nconf.c
+++ b/scripts/kconfig/nconf.c
@@ -504,8 +504,8 @@ static int get_mext_match(const char *match_str,
match_f flag)
        else if (flag == FIND_NEXT_MATCH_UP)
                --match_start;

+       match_start = (match_start + items_num) % items_num;
        index = match_start;
-       index = (index + items_num) % items_num;
        while (true) {
                char *str = k_menu_items[index].str;
                if (strcasestr(str, match_str) != NULL)







-- 
Best Regards
Masahiro Yamada
