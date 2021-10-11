Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31406428D40
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 14:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235034AbhJKMo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 08:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234921AbhJKMo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 08:44:57 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8CACC061570
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 05:42:57 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id w14so15536792edv.11
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 05:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aH+daMH8/JBhYD/VNld/K3vNCe4mWktvAcObPC4aWG4=;
        b=xLAEEpeguQ0woOp63ioI84nC66mr/vNC4iM/XmaXMiR9QYFGYakzTcnCnaHK0Zc1e9
         F6SVKNckvU9wm9BB5+GFFc5UNe+g/qDBgYlf7xCE6cKla83nQsT0yJy3JCE7ac6G9KJq
         XADRbelRbMcY+njlJNQLn1PW7duC4Vj6rnp0iM7FWu9pPI//hOj0ra+tRNKgsOEbqqhL
         vX6oQOe0/+oBUJhXHqiH+UYFE+t6drOSbO7orVfi6uwUrGSpthmNLpMq/WxwZbuqJA53
         qKDIBq882XZzIobYK11lbxtPNhoujcK7bDUlmekVqSfHwHnN4AIswFT6iM2pJDUpoNgy
         9sNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aH+daMH8/JBhYD/VNld/K3vNCe4mWktvAcObPC4aWG4=;
        b=o3GmPjNdRQtxAC20UbQa+LE2esI2Hk0OiZrZv9KKmjIGIGKte0jxnaBLqJcRcO95uf
         9A0u3dA82Yy1bmM/zbz13GmRbSv8hn7JRwkqTt6pQnHnxWh4LXSXUx7MkeZdH9haErI5
         Qec7o9TAIV1I8duxkIuE7xDcT/dDjwBgvnEC59tMr69j/QWUOHD6i5Ot4jVoaqurgJh5
         Tyots186Pot3BdIXg2ZNk0zk0otVUeIaGJzPT3R9490LRdwesF121xCyQIiJ4k5Wt0rk
         eWjocLcqvS2eY3Ouef7/jH2vbnQ/4EQANxLWLHgybHv5Yb4WNzLt0rYhZRoARzQS5CpA
         3H6Q==
X-Gm-Message-State: AOAM532xl6nkXM/f6XXZQdui+pqGhAN4IMJW8Jp6xKrWcR3cej7RBtBZ
        bVBVKbLea9fH1kHE0bUQv2MmvsrPgFRXRmUig6HKNQ==
X-Google-Smtp-Source: ABdhPJykj6TCtLZRl69RScymhuL6xnVXERm419IM+Tqe+l6k+vL0tbI4Gbo/sD+X5hpP0r9q9iM2ImzMDT4aN+LSPZ4=
X-Received: by 2002:a50:9993:: with SMTP id m19mr40386265edb.357.1633956175595;
 Mon, 11 Oct 2021 05:42:55 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYv1Vbc-Y_czipb-z1bG=9axE4R1BztKGqWz-yy=+Wcsqw@mail.gmail.com>
In-Reply-To: <CA+G9fYv1Vbc-Y_czipb-z1bG=9axE4R1BztKGqWz-yy=+Wcsqw@mail.gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 11 Oct 2021 18:12:44 +0530
Message-ID: <CA+G9fYtD2EFu7-j1wPLCiu2yVpZb_wObXXXebKNSW5o4gh9vgA@mail.gmail.com>
Subject: Re: mm/kasan/init.c:282:20: error: redefinition of 'kasan_populate_early_vm_area_shadow'
To:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Cc:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Andrew Morton <akpm@linux-foundation.org>

On Mon, 11 Oct 2021 at 17:08, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> Regression found on x86_64 gcc-11 built with KASAN enabled.
> Following build warnings / errors reported on linux next 20211011.
>
> metadata:
>     git_describe: next-20211011
>     git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
>     git_short_log: d3134eb5de85 (\"Add linux-next specific files for 20211011\")
>     target_arch: x86_64
>     toolchain: gcc-11
>
> build error :
> --------------
> mm/kasan/init.c:282:20: error: redefinition of
> 'kasan_populate_early_vm_area_shadow'
>   282 | void __init __weak kasan_populate_early_vm_area_shadow(void *start,
>       |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> In file included from include/linux/mm.h:34,
>                  from include/linux/memblock.h:13,
>                  from mm/kasan/init.c:9:
> include/linux/kasan.h:463:20: note: previous definition of
> 'kasan_populate_early_vm_area_shadow' with type 'void(void *, long
> unsigned int)'
>   463 | static inline void kasan_populate_early_vm_area_shadow(void *start,
>       |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> make[3]: *** [scripts/Makefile.build:288: mm/kasan/init.o] Error 1
> make[3]: Target '__build' not remade because of errors.
>
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> build link:
> -----------
> https://builds.tuxbuild.com/1zLv2snHfZN8QV01yA9MB8NhUZt/build.log
>
> build config:
> -------------
> https://builds.tuxbuild.com/1zLv2snHfZN8QV01yA9MB8NhUZt/config
>
> # To install tuxmake on your system globally
> # sudo pip3 install -U tuxmake
> tuxmake --runtime podman --target-arch x86_64 --toolchain gcc-11
> --kconfig defconfig --kconfig-add
> https://builds.tuxbuild.com/1zLv2snHfZN8QV01yA9MB8NhUZt/config
>
> --
> Linaro LKFT
> https://lkft.linaro.org
