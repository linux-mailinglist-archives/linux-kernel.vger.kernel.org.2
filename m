Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E67383A2A1A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 13:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbhFJLYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 07:24:40 -0400
Received: from mail-ej1-f43.google.com ([209.85.218.43]:37381 "EHLO
        mail-ej1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbhFJLYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 07:24:38 -0400
Received: by mail-ej1-f43.google.com with SMTP id ce15so43541871ejb.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 04:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=5q/7Hs4kxI8jI9ZO1LM9ICHbjN0HLJ4X8ULcEWSECyc=;
        b=pJoIZW3hJBXZRKxhfaIYLwUXa03G+1jMnB4xccMYDLg1ggCKX8xmA8sjjZ/yy08J+i
         zM8GTNZMKFMeZ2rA4hseI9dCjIyoKjai6OvZ4Gw9fq4NVxSLc5BEFRhqb2nfeJRw7yep
         u8Wk2cFWKqT8Ea21sOPq/XdLXAZnibPUmnadA3wRU+zrHGLmBPctcqGOzVCpuxak82u6
         j/mIRS8UC2y4JIjSguOw9M+h0vYw85LL9kloHBAL1SswPY2NDpWnWi6CEHpGx9iPf/2I
         dAgA+Fhfqn0onmKcvmeDGfECTwG2s9H0Rs6OY40N5/HVgaPdaTfxAf2iWSZp+92pP4+A
         ouoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=5q/7Hs4kxI8jI9ZO1LM9ICHbjN0HLJ4X8ULcEWSECyc=;
        b=Yal24yw6bC9p0wGEbo+KPaElhb2fcVvFhrlZl1qkvaFWWP2MljOTgB0A94nJjSeg8Z
         5bo2pNI9uJsbz7vjhNlYmy4caoaR1U/XTCkWbRDGL4Gm5pDDlLVhF6qGuwiRBEIOOvkr
         54Jv8A1nwAB9m6Tl0rJprzaN8qlmH2q+DmYJUfyQpWC5iZszErc1xQOJupVJuAbXX2fM
         crlqrOTS7bxE/R7WY3ZGIldrVeKC7D6RY9UQt6Kjn5KwRLxfUMpAPB87dnX+FrueXfii
         Kg0NVOR2aUIBrRMOKokZvOX7airBbWc/lhkatI4jN5NTT/z+XsJ8z+wV9n+7yISHkhnK
         W55A==
X-Gm-Message-State: AOAM5331NYn9YCOPsCHCfaCmr2RW9uEMGUY4zV1SP0XTfygSskpxqcuK
        9D9n4TCJI0Cv8KZxRa6IZxHVGj1UE/xs6x+lzGd4Dg==
X-Google-Smtp-Source: ABdhPJxnRtV6u9DGZ0cSGjEPOfaB1Km3RG3MByG37mKs0Axn6pU4OoOwRZ0GWm4HfqaH3bEoKQDO1Xns+8cDlYeadCc=
X-Received: by 2002:a17:906:d0da:: with SMTP id bq26mr4107730ejb.287.1623324101557;
 Thu, 10 Jun 2021 04:21:41 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 10 Jun 2021 16:51:30 +0530
Message-ID: <CA+G9fYuaV83ZMPHdUd_QmYmzUeyuqgvYOEdimzXZMSy9fehEsw@mail.gmail.com>
Subject: ERROR: modpost: "__aeabi_uldivmod" [fs/xfs/xfs.ko] undefined!
To:     "Darrick J. Wong" <djwong@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        lkft-triage@lists.linaro.org
Cc:     Brian Foster <bfoster@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While building Linux next-20210610 following builds failed due to
these warnings / errors.

 - arm (davinci_all_defconfig) with gcc-8 / 9/ 10
 - arm (davinci_all_defconfig) with clang-10/ 11/ 12
 - mips (malta_defconfig) with gcc-8 / 9/ 10

make --silent --keep-going --jobs=8
O=/home/tuxbuild/.cache/tuxmake/builds/current ARCH=arm
CROSS_COMPILE=arm-linux-gnueabihf- 'CC=sccache
arm-linux-gnueabihf-gcc' 'HOSTCC=sccache gcc'
ERROR: modpost: "__aeabi_uldivmod" [fs/xfs/xfs.ko] undefined!
make[2]: *** [/builds/linux/scripts/Makefile.modpost:150:
modules-only.symvers] Error 1

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>

steps to reproduce these build errors:

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


tuxmake --runtime podman --target-arch arm --toolchain gcc-9 --kconfig
davinci_all_defconfig

ref:
https://gitlab.com/Linaro/lkft/mirrors/next/linux-next/-/jobs/1334701899#L312

--
Linaro LKFT
https://lkft.linaro.org
