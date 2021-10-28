Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 369C843E2C0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 15:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbhJ1N6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 09:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbhJ1N6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 09:58:44 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44DE2C061767
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 06:56:17 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id w15so25308423edc.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 06:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=WSTbLQavJNJbT4+PxFGX9NBSygatu7Mx2BWU1M2IA2U=;
        b=U++kpKdE+2a6HUWZiDL/odN4hCBdt3L+qULt3hHPa/2P6zCxdca9gqn2cM3gRKwagi
         chgn50EDLkUleTLN0fUwcSIxigQI50idixTeOrkl94/LDeFHMyuqZZQyVHb1Ko6CyKs7
         o3Gpr9QhKRStzhAFFoxxKt1s2uE/GP73DnLWtjByQGKIuE2+4Ipb44R1RgVKqrqRVQAD
         WDDZ+e2ixnLHfyvHh+6DfS3TI/aZfGpo+oK6+9/IKWE2+VnelKtmB1zqt7G+LdUEOJrV
         ZkSvz6hxm/awWMTifrNYi/wrQ/k3b7Wr1ISOdhX7f24VMXaquxFTUd+TOu5Wr3yrqI/h
         rBNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=WSTbLQavJNJbT4+PxFGX9NBSygatu7Mx2BWU1M2IA2U=;
        b=jkrBiHtvoyAlerQWhHFpiIwAi/Gj75jiEFL1sENUQRFZlEpco7jD0RcD9yNgDm4Tpa
         HD5WJAE2wZHlyonVzQm4nL9VjwO+1Gol8n/Jq9xL458trV1zVIpndsZTrfDG/sOmNcMQ
         ldHkGfx6PW3Akyn+EgRbkhPZ458jCsOr/uUDcjFvTn0tLk5lKteWsUwvkNQGMz5s6xeT
         cTmRw8fUyLoY+0jaF9xIB7n80Bs2B3uCD7yr8l1vNrjx/jl6KSM7wplho0aGYFALg0Nq
         XV6nBkVGVlHfLOghX5NsKzzD3fo/J+UWGXESm+snygZYmwBxLjqu2EVaV8mxfzU2u95s
         zr8g==
X-Gm-Message-State: AOAM5330skweQZHkinqdK+uqCTm9l1hcDaf/zrpqfRDbMquVyyAgU771
        /X4qMK55W5vhoKRM2InI8VgLlizFp39C8wQ4+1BAkw==
X-Google-Smtp-Source: ABdhPJzv7K5ZsTrqrtIRGOqtedD4ahyQ77vmK32yoFXb3w63Si5JEFI12AyJy2mm97F+JWBeShvcXI/WHjJoEvltq7s=
X-Received: by 2002:a05:6402:5255:: with SMTP id t21mr6182196edd.103.1635429375474;
 Thu, 28 Oct 2021 06:56:15 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 28 Oct 2021 19:26:04 +0530
Message-ID: <CA+G9fYs6X5ce1BhynpivZLU7MvPq+vkrJCM7oSJf8GJBApCqZg@mail.gmail.com>
Subject: riscv: delay.c:77:17: error: implicit declaration of function
 'cpu_relax' [-Werror=implicit-function-declaration]
To:     linux-riscv <linux-riscv@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        lkft-triage@lists.linaro.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Regression found on riscv gcc-11 built with defconfig
Following build warnings / errors reported on linux next 20211028.

metadata:
    git_describe: next-20211028
    git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
    git_short_log: 503f375baa99 (\"Add linux-next specific files for 20211028\")
    target_arch: riscv
    toolchain: gcc-11

build error :
--------------
/builds/linux/arch/riscv/lib/delay.c: In function '__delay':
/builds/linux/arch/riscv/lib/delay.c:77:17: error: implicit
declaration of function 'cpu_relax'
[-Werror=implicit-function-declaration]
   77 |                 cpu_relax();
      |                 ^~~~~~~~~
cc1: some warnings being treated as errors
make[2]: *** [/builds/linux/scripts/Makefile.build:288:
arch/riscv/lib/delay.o] Error 1


Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

build link:
-----------
https://builds.tuxbuild.com/208R1uE0CO13gO5XbrrWlqwau7r/build.log

build config:
-------------
https://builds.tuxbuild.com/208R1uE0CO13gO5XbrrWlqwau7r/config

# To install tuxmake on your system globally
# sudo pip3 install -U tuxmake
tuxmake --runtime podman --target-arch riscv --toolchain gcc-11
--kconfig defconfig

--
Linaro LKFT
https://lkft.linaro.org
