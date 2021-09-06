Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 891D1401B41
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 14:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241603AbhIFMgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 08:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236783AbhIFMgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 08:36:48 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFDEDC061575
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 05:35:43 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id n27so13243672eja.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 05:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=xypxOlLpIj1kGaPZeLVMc46scojUqvHHVmiRLDEQQR8=;
        b=TL6ZLMNGxgMHqhSbKACJWG4qgO0pISGZjT4JY7BFUYc/LatqxrxQpwN+gwdbM1XDsP
         xpBb0U2eP8wW9LADy2lHUFT/75fMKfjuqvMyBddfFM1xTtbVHNtw/fkk5gaRIfzWxUUy
         QdTYsduN+uwL8CXX7zlayO+MTXqottOhFkv4nbTroeFhU75RmvUMsGXCMKZvM+N8o3Bf
         lQ7P+DQmVasNhKW+dE0+4VyrifzkXnAcGGUgZDWWk4d+4bG79BkdhL6tHCMB4OXivB5o
         8ga4NUcbLasdXv2/JVZsHoZEBCG4C5HGBZwc803IM3EukNOouLdCm9hRb1HQ0BX5OAh9
         b0TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=xypxOlLpIj1kGaPZeLVMc46scojUqvHHVmiRLDEQQR8=;
        b=QS6jsNUSmBCM5f2nWvwhAaNuzVN/udBPz8LQ4to81AlbJmz3DDy7ZFg2EOTK6Ccprz
         yiBNsxngSxCnyj/KjmbtjJznpL0hlE6sZbC+QEaVH/WLILF9LY+9BScFijaHrJcFz6jl
         6ACpFvFyu+N01IN0yr3Wc6N8BSLkpLBMROjLJtbtB2IrE12YQvF008i6U6mqDeqDhcQq
         Tso2scy4oJBbU0yCTEzX+lkixbmVCAjuiDXwUJw7h4T7DpczmcccdgZEEcMw26a9NB1I
         cekjm7SfvoMwngSacU0oNoZetyCo1SYkFInlK6QZi52zCJoZhR7JB3KR666qCqBL36Qg
         YHTQ==
X-Gm-Message-State: AOAM532FrY7hYtA2IwPmgji0sRNnjC0Vxz9xbfstGlfY1Y2NHWSjkUIP
        FgZSKQBlGQUvTto1tmO3JDGF+f0ngGkrxHoATWTGYQ==
X-Google-Smtp-Source: ABdhPJx3hPH1VLkxO8Io/KzIZ1VugtEWn5DfCMkNUKAyG5KjbPB8MecAtLLMHCMKfPT+VSVkB0Iyuu0sNY1+YmKFz6E=
X-Received: by 2002:a17:906:318b:: with SMTP id 11mr13586711ejy.493.1630931742051;
 Mon, 06 Sep 2021 05:35:42 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 6 Sep 2021 18:05:30 +0530
Message-ID: <CA+G9fYvA-ctLRz=fimVs9oYPN+s5gtFc32dQVxinkOLyed0DUg@mail.gmail.com>
Subject: block/mq-deadline.c:274:12: error: 'dd_queued' defined but not used [-Werror=unused-function]
To:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        lkft-triage@lists.linaro.org
Cc:     Jens Axboe <axboe@kernel.dk>, Arnd Bergmann <arnd@arndb.de>,
        Bart Van Assche <bvanassche@acm.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following build warnings/ errors noticed while building linux mainline
master branch
with gcc-11 for arm architecture with clps711x_defconfig config file.

block/mq-deadline.c:274:12: error: 'dd_queued' defined but not used
[-Werror=unused-function]
  274 | static u32 dd_queued(struct deadline_data *dd, enum dd_prio prio)
      |            ^~~~~~~~~
cc1: all warnings being treated as errors
make[2]: *** [/builds/linux/scripts/Makefile.build:277:
block/mq-deadline.o] Error 1
make[2]: Target '__build' not remade because of errors.
make[1]: *** [/builds/linux/Makefile:1872: block] Error 2
make[1]: Target '__all' not remade because of errors.
make: *** [Makefile:219: __sub-make] Error 2
make: Target '__all' not remade because of errors.

Build config:
https://builds.tuxbuild.com/1xjZuKPY0IygLQHFkTFMY9TPQh4/config

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

meta data:
-----------
    git_describe: v5.14-9687-g27151f177827
    git_repo: https://gitlab.com/Linaro/lkft/mirrors/torvalds/linux-mainline
    git_sha: 27151f177827d478508e756c7657273261aaf8a9
    git_short_log: 27151f177827 (\Merge tag
'perf-tools-for-v5.15-2021-09-04' of
git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux\)
    kconfig: [
        clps711x_defconfig
    ]
    kernel_version: 5.14.0
    target_arch: arm
    toolchain: gcc-11

steps to reproduce:
https://builds.tuxbuild.com/1xjZuKPY0IygLQHFkTFMY9TPQh4/tuxmake_reproducer.sh

--
Linaro LKFT
https://lkft.linaro.org
