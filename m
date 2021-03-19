Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA493416C4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 08:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234193AbhCSHgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 03:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234188AbhCSHgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 03:36:15 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102C7C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 00:36:15 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id b16so9625695eds.7
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 00:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=cFztndHYvTA4SCUs/JT696S46MToc8dDZLMQpjlmP/w=;
        b=CzTKZRB9XYctro9yS5XAB4f/goe6vswB80rzcTfnZNg4T7Cma8Qi/fhIzzB/KHC10k
         HTJ58OoyZwnle68+XdAI8h967PqPZjC+EiYIitFjXPQH5vU0poLXTS0NvgZ3OqdS9Ynt
         YkpDGAvFVkC55xYqvaHTC4yF72gdYTqFz70nnarPrdj8xC+I8wRG/RPMBdcl+DqGjrLI
         Nk2ZpVEWqYwISrhe0UYSVoRfCdfkdIgENjg+lxJPIC7Yc33CpKh49FeQcUqRFG/p8bdS
         gASNDSLPbcuEuH5DWXuN04kbKDKWzdVSK0bF4xfll27q+ZMRG+QCgNFZ75ZWYMu51mUX
         zeVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=cFztndHYvTA4SCUs/JT696S46MToc8dDZLMQpjlmP/w=;
        b=qqv1ubnG+ZIuxhEOKUWeMk4Sfs6xFo08Jy5YAU1HDNbYHG/4pCku+P6D8w6EEOuxBK
         7YPMyFVfoh7yYHmstUB1ujoJnFjdwqeAdT3KhuJR3TYGI8lBWDo4PYuIdEYYEKen4u1N
         Bm/6UgeKCRzlHF38Cgm+cqEuXHDHb6fpMW7eyn1uzD/1nRclrM2tB8FhkJdCDE10YRTa
         6GD0jiKwORVcDaMXvImDLwPEjwLuySRIUgRolQILyl37VGqA/qKCiJtN8OaXKY6HctYM
         x+pcrJXrOgA/JJShieHl2VTZI/QqVIzklAcWUaHdLx0u/dh1F01W81gALDWPqQOS9iz6
         SO1w==
X-Gm-Message-State: AOAM532A3yLMvUgUPCcSR+6f/5h1fCCuMxmxnq0zD9hrGXPxqxWlT3Jj
        c+FXQQ+/ManVgCeoW6Z/0uvJRTY1UX2mkaCec7IabQ==
X-Google-Smtp-Source: ABdhPJydspitSfVdkxaZUChndZECWQ64tBaAPD5xdSiZthfRlEdlcjDTauWloJ3dqWbr1lvF0vXI9JXbx9jJ9nNiKZ8=
X-Received: by 2002:aa7:d416:: with SMTP id z22mr7919214edq.239.1616139373731;
 Fri, 19 Mar 2021 00:36:13 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 19 Mar 2021 13:06:02 +0530
Message-ID: <CA+G9fYseDSQ2Vgg5Cb=8HHdpm56aeVQH0Vdx7JK1SktGpRRkgw@mail.gmail.com>
Subject: sparc: clang: error: unknown argument: '-mno-fpu'
To:     clang-built-linux <clang-built-linux@googlegroups.com>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, sparclinux@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linux mainline master build breaks for sparc defconfig.
There are multiple errors / warnings with clang-12 and clang-11 and 10.
 - sparc (defconfig) with clang-12, clang-11 and clang-10
 - sparc (tinyconfig) with clang-12, clang-11 and clang-10
 - sparc (allnoconfig) with clang-12, clang-11 and clang-10

make --silent --keep-going --jobs=8
O=/home/tuxbuild/.cache/tuxmake/builds/1/tmp ARCH=sparc
CROSS_COMPILE=sparc64-linux-gnu- 'HOSTCC=sccache clang' 'CC=sccache
clang'
clang: error: unknown argument: '-mno-fpu'
clang: error: unknown argument: '-fcall-used-g5'
clang: error: unknown argument: '-fcall-used-g7'
make[2]: *** [/builds/linux/scripts/Makefile.build:116:
scripts/mod/devicetable-offsets.s] Error 1
clang: error: unknown argument: '-mno-fpu'
clang: error: unknown argument: '-fcall-used-g5'
clang: error: unknown argument: '-fcall-used-g7'
make[2]: *** [/builds/linux/scripts/Makefile.build:271:
scripts/mod/empty.o] Error 1

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>

build link,
https://gitlab.com/Linaro/lkft/mirrors/torvalds/linux-mainline/-/jobs/1110841374#L81

steps to reproduce:
--------------------------
# TuxMake is a command line tool and Python library that provides
# portable and repeatable Linux kernel builds across a variety of
# architectures, toolchains, kernel configurations, and make targets.
#
# TuxMake supports the concept of runtimes.
# See https://docs.tuxmake.org/runtimes/, for that to work it requires
# that you install podman or docker on your system.
#
# To install tuxmake on your system globally:
# sudo pip3 install -U tuxmake
#
# See https://docs.tuxmake.org/ for complete documentation.

tuxmake --runtime podman --target-arch sparc --toolchain clang-12
--kconfig defconfig


--
Linaro LKFT
https://lkft.linaro.org
