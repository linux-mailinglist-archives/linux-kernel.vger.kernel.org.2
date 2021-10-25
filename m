Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98EC043980F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 16:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233268AbhJYOGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 10:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbhJYOGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 10:06:35 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D5EC061767
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 07:04:13 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id g10so19021086edj.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 07:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lRz3CgFlSn7VynXZnvgJCMXyEuYvDuHSreaW3AYUDoc=;
        b=uiKJyxy1HlPhjZ8Qi3VptIu0aBU9Ul/6x7ftj0/5VvdglRe1z3B279lOUUA+27Qrpd
         bkYsZOA1cpWDOsFf+2w3QpZPc1fTVCrz5ke3LPCBNo31p2/t/etQTo4SucZC3YnW/AeG
         ZlZq6d2YP95Au7L+hNvxTDGFUlQ+Kl9T+huCKGR6dMQaZtG8c5YlMUYb+Sys1fjN70nX
         YaIYEb4bVOPYx0mYGnW/6nDvS5Gc/5n6aO9bEY3v/KY2DibA7KSwLS9De5HwYu0RAI6a
         9CB2UUrF2blgmUArx6029uHQiLleJtjAkII3uKn+nhQEHGteVU3L7ipQfBs5vjPtKD5K
         8PQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lRz3CgFlSn7VynXZnvgJCMXyEuYvDuHSreaW3AYUDoc=;
        b=J3We0EBhE/FXyLzH0U9Qlzqd5q8ogA9+sDff4G0/dlAlNoXR++3Av/SLO2EWTm79SY
         RB4yTPJpqTX4yeZJUKk00cUmwXxVWxfdPZE8UZl9XEfc3mDeuXaVJ5LNRzX/y64OIK4M
         gbHM6GgHJzxbmleLnbxb8zljtqDNDjorn392Gh+KsnD0MtVtEbWVaHhbIhQwm2RjQiYB
         OuqpItWLb7AX9M95NFfmEK8EFjulS1nhG1/qKSJyxfyekvLFInXOuofIK0wQ7hflHPUY
         XDSuFcdeR3uGHjL0uXcTLFTKnTA8ga0Gb0TJsvamNdlDpbrKCtugJyXMQMo1E4h2p+hZ
         rwHg==
X-Gm-Message-State: AOAM533qBzm8b/6J8r9CiroanrePMlQfNVTJtZ94BeLiWJVLKlwyVM+C
        OOcclfJZWQDb+P4+D61g1Lc9xemELvKDNCr9PC2JtQ==
X-Google-Smtp-Source: ABdhPJx0lp0PHTjiXgV2IvMCh2GtrIee4/gYDuwcwV8DC7zDqHOMDrNmfKQMSgVZNLP5fYmtX4CKmhomDDLaBS4TJ1o=
X-Received: by 2002:a05:6402:26cb:: with SMTP id x11mr5219841edd.198.1635170489365;
 Mon, 25 Oct 2021 07:01:29 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYvpyUbqLko+9Dza8h4=9yOd-n9J0dKoQtZxawstCCnsZw@mail.gmail.com>
In-Reply-To: <CA+G9fYvpyUbqLko+9Dza8h4=9yOd-n9J0dKoQtZxawstCCnsZw@mail.gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 25 Oct 2021 19:31:17 +0530
Message-ID: <CA+G9fYvdhk-H8wBDdaPmRMZS_egxndncUkbZ92HCnUFD1g_wSQ@mail.gmail.com>
Subject: Re: gpu: drm_fb_cma_helper.c:46: undefined reference to `drm_gem_fb_get_obj'
To:     dri-devel@lists.freedesktop.org,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Oct 2021 at 17:43, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> Regression found on arm gcc-11 built with multi_v5_defconfig
> Following build warnings / errors reported on linux next 20211025.
>
> metadata:
>     git_describe: next-20211025
>     git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
>     git_short_log: 9ae1fbdeabd3 (\"Add linux-next specific files for 20211025\")
>     target_arch: arm
>     toolchain: gcc-11
>     config: multi_v5_defconfig
>
> build error :
> --------------
> arm-linux-gnueabihf-ld: drivers/gpu/drm/drm_fb_cma_helper.o: in
> function `drm_fb_cma_get_gem_obj':
> drivers/gpu/drm/drm_fb_cma_helper.c:46: undefined reference to
> `drm_gem_fb_get_obj'
> arm-linux-gnueabihf-ld: drivers/gpu/drm/drm_fb_cma_helper.c:46:
> undefined reference to `drm_gem_fb_get_obj'
> arm-linux-gnueabihf-ld: drivers/gpu/drm/drm_fb_cma_helper.c:46:
> undefined reference to `drm_gem_fb_get_obj'
> arm-linux-gnueabihf-ld: drivers/gpu/drm/drm_fb_cma_helper.o: in
> function `drm_fb_cma_sync_non_coherent':
> drivers/gpu/drm/drm_fb_cma_helper.c:133: undefined reference to
> `drm_atomic_helper_damage_iter_init'
> arm-linux-gnueabihf-ld: drivers/gpu/drm/drm_fb_cma_helper.c:135:
> undefined reference to `drm_atomic_helper_damage_iter_next'
> make[1]: *** [Makefile:1252: vmlinux] Error 1
> make[1]: Target '__all' not remade because of errors.
> make: *** [Makefile:226: __sub-make] Error 2
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

The bisection script pointed to the first bad commit,

commit 4b2b5e142ff499a2bef2b8db0272bbda1088a3fe
drm: Move GEM memory managers into modules

> build link:
> -----------
> https://builds.tuxbuild.com/1zzgFZBGjpQ5R0lawQFW9iJ39Hp/build.log
>
> build config:
> -------------
> https://builds.tuxbuild.com/1zzgFZBGjpQ5R0lawQFW9iJ39Hp/config
>
> # To install tuxmake on your system globally
> # sudo pip3 install -U tuxmake
> tuxmake --runtime podman --target-arch arm --toolchain gcc-11
> --kconfig multi_v5_defconfig
>
> --
> Linaro LKFT
> https://lkft.linaro.org

- Naresh
