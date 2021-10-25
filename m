Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DFF04395C8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 14:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233009AbhJYMQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 08:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbhJYMQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 08:16:28 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D45AC061745
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 05:14:06 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id y12so19092434eda.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 05:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=6e5dClZNqugBonIUDa3xy+s+zikUwDcuCRtJDo7dWDc=;
        b=UI1SGw3rj6zDGc3ho5bxfEYVRrJF9huO+iOj4Qie1YJH0hJSitseo7xPTw1jcRfSPi
         WoJjDjaRVTb02lCF+m6/pvSs934gD4eLWpn/lgZds7N4DhkkFvoyP1uUHZqHmA7cn/ce
         0V/fpkuLITE14ueEoy6pnK/07x4z0HHmubYikqlqdRzWL9rh0PSyIiW5ffhSRreX1Mnv
         6ntxhX/GjxCokmfjfjxWPgkRTQDnkPShsqPmt1DMpYTy+8ioo50/8rPiCCsztdftd0Ip
         S6PvOuNIj5aBMw91TC00gKRGLlAbXQ+RTBnv/EwhnTfEnhqauHOYLJUpO62ZK/+PoiIS
         Pt/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=6e5dClZNqugBonIUDa3xy+s+zikUwDcuCRtJDo7dWDc=;
        b=GpdpRVP3wI7YFqKKZtxRfWkEPfuleH8v8fuH5XVG+6idBmIw4pubItQewFvuhguk0d
         WnzutMPw/6FO6WJ7j9I3m1eTgW5th+IW+8Pg4sH3yLy/BFLOFcXyHuT4Uy5obKr9nNX4
         ntOe8m8DQaRtaVIcePRToAXUZOgAByrsEoD7MGF2xw4CrHPFukXGWjKDzS911vW1NM1i
         NI7nAybfypt10H4g85K/Xr5OjyEv+od9dOpShyY2bwSz3P3+rzVtm17UYrGWi3OuI4D5
         47/RfLH+f4BWKvvBPvg0NXTM9AGKo/+5mSIFPGG+6/3491AMRR+Z9wOpmbD7iedWWHho
         DR5g==
X-Gm-Message-State: AOAM532va9g/kpsfr/omqZUL0jmWoFQpE3z6WJJLp/VtO+PHIk+gRaNG
        Yf39Uv+2q1dIEkK5qoteqsanjUlrlLQJSNDUC7NlAA==
X-Google-Smtp-Source: ABdhPJwYIDzIsHOM44KEDTo1eeUMhc2q7IlHYTePt1GAveyFCSaLen+h5x5KtB67vFlUAnVpGwuzqiQ8tylPZDcOU4g=
X-Received: by 2002:a05:6402:3587:: with SMTP id y7mr25938248edc.182.1635164044795;
 Mon, 25 Oct 2021 05:14:04 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 25 Oct 2021 17:43:53 +0530
Message-ID: <CA+G9fYvpyUbqLko+9Dza8h4=9yOd-n9J0dKoQtZxawstCCnsZw@mail.gmail.com>
Subject: gpu: drm_fb_cma_helper.c:46: undefined reference to `drm_gem_fb_get_obj'
To:     dri-devel@lists.freedesktop.org,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Regression found on arm gcc-11 built with multi_v5_defconfig
Following build warnings / errors reported on linux next 20211025.

metadata:
    git_describe: next-20211025
    git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
    git_short_log: 9ae1fbdeabd3 (\"Add linux-next specific files for 20211025\")
    target_arch: arm
    toolchain: gcc-11
    config: multi_v5_defconfig

build error :
--------------
arm-linux-gnueabihf-ld: drivers/gpu/drm/drm_fb_cma_helper.o: in
function `drm_fb_cma_get_gem_obj':
drivers/gpu/drm/drm_fb_cma_helper.c:46: undefined reference to
`drm_gem_fb_get_obj'
arm-linux-gnueabihf-ld: drivers/gpu/drm/drm_fb_cma_helper.c:46:
undefined reference to `drm_gem_fb_get_obj'
arm-linux-gnueabihf-ld: drivers/gpu/drm/drm_fb_cma_helper.c:46:
undefined reference to `drm_gem_fb_get_obj'
arm-linux-gnueabihf-ld: drivers/gpu/drm/drm_fb_cma_helper.o: in
function `drm_fb_cma_sync_non_coherent':
drivers/gpu/drm/drm_fb_cma_helper.c:133: undefined reference to
`drm_atomic_helper_damage_iter_init'
arm-linux-gnueabihf-ld: drivers/gpu/drm/drm_fb_cma_helper.c:135:
undefined reference to `drm_atomic_helper_damage_iter_next'
make[1]: *** [Makefile:1252: vmlinux] Error 1
make[1]: Target '__all' not remade because of errors.
make: *** [Makefile:226: __sub-make] Error 2

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


build link:
-----------
https://builds.tuxbuild.com/1zzgFZBGjpQ5R0lawQFW9iJ39Hp/build.log

build config:
-------------
https://builds.tuxbuild.com/1zzgFZBGjpQ5R0lawQFW9iJ39Hp/config

# To install tuxmake on your system globally
# sudo pip3 install -U tuxmake
tuxmake --runtime podman --target-arch arm --toolchain gcc-11
--kconfig multi_v5_defconfig

--
Linaro LKFT
https://lkft.linaro.org
