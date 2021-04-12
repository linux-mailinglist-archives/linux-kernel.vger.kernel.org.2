Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31A2D35D34A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 00:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343784AbhDLWl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 18:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238901AbhDLWly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 18:41:54 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0519AC061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 15:41:35 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id n8so24070620lfh.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 15:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/iPFYpM8U8YAYL+pLbcF7F940OQ0/rVhVKPimki0rlo=;
        b=jv0622WMCHjGaPjH2D8hxMJXGW2oB6dQIxWdckkLvueqiZgtyGLe4ubIOLTcuOpQYW
         inGGnz0iyBqJVZy5JJS3dFJr8Rmqb3fWsUXBYvvpoEJlKZlRhwPgu49AVJ23U+okpaHd
         wpr4g5YBylr/rCPN1QkR7rUdZblYbqUpw1uNwhGx7id33AGJJIzK3Slc8F8GCvdJfDTA
         Qk8jdxjB64UyHDbjYG9zE1Yt9ixTz2RPR9cH6j63S2kBCdWFqFal9ZQcs/+JzJCZdRWi
         +z/LvGsdKIcDUiunTXtrhh5lyDd3RGtuxmfUNqpaV+Nqev1vbWVfKssPH2Ic+7oUWLtA
         0Q4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/iPFYpM8U8YAYL+pLbcF7F940OQ0/rVhVKPimki0rlo=;
        b=cGDEpUrixY5ElcAALmgJ3JhNgxAKQGosWhCQYFF99pPVgpEXZ3ethdrsV2nb4aEFRp
         Rak8+uRtewWc3oVwOtmLHrBPoF3UI9y/H9VlimOWp7MHJMhLXlbmD8GUwnmaTIw3HCTJ
         J/fQWAtBTXhU9g+S3Wao8PDPx8NzC33DHpoxZQwbssnGTgkBeBbTGmQMQQ6rUMXRjb1+
         s1866faibx6bUPFatReW7Rz8JArzi8Tb/M24aIoegdc8cv7N09PhmW97PUsrkLZTJ9tx
         cFxQI1brYPbx6WMKY0EhXeik07M3Qe5x602m8ZS0nk0PtYZCpDOH3aiAoiZn8l3XRzUQ
         TjHA==
X-Gm-Message-State: AOAM5329kNXKTEk/aZ6uILxTJYNrhYpzE9RN7v6JlodSapZFyltLC/Pq
        dNO25X/0L0D8jIngWZHxmATWx3b2PaHetWTO8V2avQ==
X-Google-Smtp-Source: ABdhPJzg1qPbVONMsmRIB7R4rxaliajn6pTRcvSuzCIrtTpHQF1qTkrw43RuBDGnhY/t9NmT+ycuJTh27+DQXa0NSv0=
X-Received: by 2002:a19:ac09:: with SMTP id g9mr3896720lfc.547.1618267293232;
 Mon, 12 Apr 2021 15:41:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210412214210.6e1ecca9cdc5.I24459763acf0591d5e6b31c7e3a59890d802f79c@changeid>
In-Reply-To: <20210412214210.6e1ecca9cdc5.I24459763acf0591d5e6b31c7e3a59890d802f79c@changeid>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 12 Apr 2021 15:41:21 -0700
Message-ID: <CAKwvOd=HiYvFAO5BKuvx8=N9aCC88ukOTrwZkDQzuQUbqK4g_w@mail.gmail.com>
Subject: Re: [PATCH] gcov: clang: fix clang-11+ build
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Johannes Berg <johannes.berg@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2021 at 12:42 PM Johannes Berg
<johannes@sipsolutions.net> wrote:
>
> From: Johannes Berg <johannes.berg@intel.com>
>
> With clang-11+, the code is broken due to my kvmalloc() conversion
> (which predated the clang-11 support code) leaving one vmalloc()
> in place. Fix that.
>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
> This fixes a clang-11 build issue reported against current
> linux-next since the clang-11+ support landed in v5.12-rc5

Thanks for the patch, and noticing the breakage so quickly.  I
recently added GCOV to our CI, but I've been fighting enough fires
this morning that I haven't had time to check this particular build!

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>

> and my kvmalloc() conversion patch is in akpm/linux-next.
> I guess this should be folded into
>
>   gcov: use kvmalloc()
>
> If desired, I can send a combined patch instead.
> ---
>  kernel/gcov/clang.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/gcov/clang.c b/kernel/gcov/clang.c
> index 04a65443005d..d43ffd0c5ddb 100644
> --- a/kernel/gcov/clang.c
> +++ b/kernel/gcov/clang.c
> @@ -368,7 +368,7 @@ static struct gcov_fn_info *gcov_fn_info_dup(struct gcov_fn_info *fn)
>         INIT_LIST_HEAD(&fn_dup->head);
>
>         cv_size = fn->num_counters * sizeof(fn->counters[0]);
> -       fn_dup->counters = vmalloc(cv_size);
> +       fn_dup->counters = kvmalloc(cv_size, GFP_KERNEL);
>         if (!fn_dup->counters) {
>                 kfree(fn_dup);
>                 return NULL;
> --
> 2.30.2
>


-- 
Thanks,
~Nick Desaulniers
