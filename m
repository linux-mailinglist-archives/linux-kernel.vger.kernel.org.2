Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2357428C2E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 13:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234354AbhJKLkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 07:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233878AbhJKLks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 07:40:48 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19003C061570
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 04:38:48 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id d9so42708909edh.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 04:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=aVAseHFlKtR4hY18T2FRHhS7NIeZFLXno7FnFl0RhbU=;
        b=qomjv+hAHgs1U+H0KeSPd9BBRDuEcnJleuwPcs5pDM6bKTvkTuJ6QEgrJ2LVntS2YX
         k0prMnz6lKfgCO9svnOiIWDSGLBgy9E58QpgydyRLHTaDlduShMHSzLBOEU5Etrdc55m
         rWQRAqjY7nDKb8yX8+X5rt7PDtLXTxSQv4fs9iuSXcV24dWoO0Otr12dSdwsChJtcz+L
         WYd2YHr3Lj5oihAYIkm4gdjXreOisPrpELpCtIXjYxzIds2KosGWgKcsVZZ3zLbz0LSh
         gYDlRutNPxi7z2lgFIVEFb11+cylpFz8Sj3MJtU7WYdZfqGgTODOTdsmX6LgOI7xVIoX
         G6fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=aVAseHFlKtR4hY18T2FRHhS7NIeZFLXno7FnFl0RhbU=;
        b=HdyGs1rvROpwuNZmzg5AN4pmtB5LYOXpvmKxTWtvrzd83pyhRd4jbiO0aiEgE3Qsmj
         TPHRDctTVrLMKMw51tmogZ+CW4zmbrG78TD9qnpxF38Xdc/cjISrPWY/N/RYZjmlWADG
         DVENZhOtyNPIiDX30rDc9pl3+TowLcnLRJyhGYUNvCiFcZz1IX5/Q527UIuW3T8GYiWf
         glBKtf7Cx666eZ8UXWF3EGfKRegyDyYBJFaP8B7WXfbZ2y9dvIKfoA6EMKvJyLPtDVV7
         y/2ls1M/O5vzvgcoKSqiczh/zRJQwfslMNrcf94zlNV3KxjGG2VgHodqUZ+Gt+o22bCa
         ylVQ==
X-Gm-Message-State: AOAM530vNyHa58DQW3v+4+NC1YAL/BsD9qJ0J0Ycu1XY1sJj8vW06slX
        T8nTgcrygcK6cM8g7pNHXRT4uXnf8ht0OfTv51Hp+0fSiAmaMg==
X-Google-Smtp-Source: ABdhPJwkQ76ovFx13C9zczM3mcDGc+ax0KkVrNWG1kmrISGVUNnIWrO3TGZ47niR5zT4915iDVERR1VzJAEaX4CubUI=
X-Received: by 2002:a17:906:318b:: with SMTP id 11mr25186720ejy.493.1633952326385;
 Mon, 11 Oct 2021 04:38:46 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 11 Oct 2021 17:08:35 +0530
Message-ID: <CA+G9fYv1Vbc-Y_czipb-z1bG=9axE4R1BztKGqWz-yy=+Wcsqw@mail.gmail.com>
Subject: mm/kasan/init.c:282:20: error: redefinition of 'kasan_populate_early_vm_area_shadow'
To:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Cc:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundatio.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Regression found on x86_64 gcc-11 built with KASAN enabled.
Following build warnings / errors reported on linux next 20211011.

metadata:
    git_describe: next-20211011
    git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
    git_short_log: d3134eb5de85 (\"Add linux-next specific files for 20211011\")
    target_arch: x86_64
    toolchain: gcc-11

build error :
--------------
mm/kasan/init.c:282:20: error: redefinition of
'kasan_populate_early_vm_area_shadow'
  282 | void __init __weak kasan_populate_early_vm_area_shadow(void *start,
      |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from include/linux/mm.h:34,
                 from include/linux/memblock.h:13,
                 from mm/kasan/init.c:9:
include/linux/kasan.h:463:20: note: previous definition of
'kasan_populate_early_vm_area_shadow' with type 'void(void *, long
unsigned int)'
  463 | static inline void kasan_populate_early_vm_area_shadow(void *start,
      |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
make[3]: *** [scripts/Makefile.build:288: mm/kasan/init.o] Error 1
make[3]: Target '__build' not remade because of errors.


Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

build link:
-----------
https://builds.tuxbuild.com/1zLv2snHfZN8QV01yA9MB8NhUZt/build.log

build config:
-------------
https://builds.tuxbuild.com/1zLv2snHfZN8QV01yA9MB8NhUZt/config

# To install tuxmake on your system globally
# sudo pip3 install -U tuxmake
tuxmake --runtime podman --target-arch x86_64 --toolchain gcc-11
--kconfig defconfig --kconfig-add
https://builds.tuxbuild.com/1zLv2snHfZN8QV01yA9MB8NhUZt/config

-- 
Linaro LKFT
https://lkft.linaro.org
