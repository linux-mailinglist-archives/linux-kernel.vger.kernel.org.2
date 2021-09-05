Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9B9140100E
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Sep 2021 15:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233826AbhIEN7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Sep 2021 09:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232209AbhIEN7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Sep 2021 09:59:51 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA11C061757
        for <linux-kernel@vger.kernel.org>; Sun,  5 Sep 2021 06:58:47 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id n27so7844235eja.5
        for <linux-kernel@vger.kernel.org>; Sun, 05 Sep 2021 06:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=giMeObktTqqGjYdTPNrfLW2//6PD84VwFUponCSrqK8=;
        b=B5PTp3dGJvFgBR7gfk2lwA93drfC1QxKNH4uxCsmePMUFAOuZdXQKr1KX2PEL0yLPG
         zoWPI8X/hNiyD7vhqBHMP0ZvZsABl7BggBW0JR2AGugQ62tpbmK6PWPl7mBJs+J/4qt2
         uN4n0WcLqeoV4necceokm+e3VVYLg9APcdeNex6ij5Yxkfg+BqHJVl2ldsXiYjOIJiCx
         ZBWXfFhYyRfsMMXlWguNOt/YaGs8jgyumgvmb0K7GCuigzS/4zpRza2hWzEVYzc5tzLG
         WNx1C7h86GXhwgMUHJ2B+eGXwkPfJgFCJx9synE7jMTUDIk+mMKPOLOGbKYAZVTRc00D
         5OZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=giMeObktTqqGjYdTPNrfLW2//6PD84VwFUponCSrqK8=;
        b=sGhTa2a0s6wO2nKTGmDl0JszF+c1WeLM2Tskz2vCs3dgyqXnM7ua5429f1ZjUKtbbU
         Y+Jf5ofOP1u+k2TKXQbfJiiFCfefXLD5fi0ztvnVIEU9WP4hSWf+rPP7vicHS+Nyz1Eu
         TYtzQbeZjVcIP39mTWm3iOJhBZA3rnxlNx33txSbsKxGiqZfjEbWnpQu68cPXPB5pcwG
         U/AXtbwQfPSfVf/M2dQBOjw6qRspdGbtMlDxKTxSBbrUzQKf6MPirqHUV19AISxrxTGv
         NHDfrV1H5cBDij5DnwbvS22KZJUPvpAYuU8WWnYA4K+gIvTLUWlqSSir9x1InoA+98r2
         4YMw==
X-Gm-Message-State: AOAM5327G2kEE37bXUUgzC2brWXyiZXp4vRDHm59i3DD3bISH9Q6WugW
        jdjTsgE2v+aJ5AP7v9j4x/i8AUPoEQ2ut0yJ8Pjs4w==
X-Google-Smtp-Source: ABdhPJymb/+H3CPAohbOi8O+q+8BJ/aRmG6IF1T6XAC7SJ2Y3BEz34pK+/Bdrn52PRiP2mFSdIyIWPBV/8ubwIzcT0M=
X-Received: by 2002:a17:906:84d0:: with SMTP id f16mr9102186ejy.6.1630850326192;
 Sun, 05 Sep 2021 06:58:46 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sun, 5 Sep 2021 19:28:35 +0530
Message-ID: <CA+G9fYvMaHgSied79QBs3D=eDVETGH=3gxA8owCSRj313yEhVg@mail.gmail.com>
Subject: kernel/kexec_file.o: failed: Cannot find symbol for section 10: .text.unlikely.
To:     Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>,
        linux-stable <stable@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, lkft-triage@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following build errors noticed while building stable rc Linux 5.13.14
with gcc-11 for powerpc architecture.

# to reproduce this build locally:
tuxmake --target-arch=powerpc --kconfig=defconfig --toolchain=gcc-11
--wrapper=sccache --environment=KBUILD_BUILD_TIMESTAMP=@1630691419
--environment=KBUILD_BUILD_USER=tuxmake
--environment=KBUILD_BUILD_HOST=tuxmake
--environment=SCCACHE_BUCKET=sccache.tuxbuild.com --runtime=podman
--image=855116176053.dkr.ecr.us-east-1.amazonaws.com/tuxmake/powerpc_gcc-11
config default kernel xipkernel modules dtbs dtbs-legacy debugkernel
headers

make --silent --keep-going --jobs=8
O=/home/tuxbuild/.cache/tuxmake/builds/current ARCH=powerpc
CROSS_COMPILE=powerpc64le-linux-gnu- 'CC=sccache
powerpc64le-linux-gnu-gcc' 'HOSTCC=sccache gcc' defconfig

make --silent --keep-going --jobs=8
O=/home/tuxbuild/.cache/tuxmake/builds/current ARCH=powerpc
CROSS_COMPILE=powerpc64le-linux-gnu- 'CC=sccache
powerpc64le-linux-gnu-gcc' 'HOSTCC=sccache gcc'
Cannot find symbol for section 10: .text.unlikely.
kernel/kexec_file.o: failed
make[2]: *** [/builds/linux/scripts/Makefile.build:273:
kernel/kexec_file.o] Error 1
make[2]: *** Deleting file 'kernel/kexec_file.o'


Build config:
https://builds.tuxbuild.com/1xdiIZVZuLCW3X1WO2YT6Fsl19w/config

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

meta data:
-----------
    git_repo: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
    git_sha: a603798fb16829e56f80f57879611e67bba4910d
    git_short_log: a603798fb168 (\Linux 5.13.14\)
    kconfig:  defconfig
    kernel_version: 5.13.14
    target_arch: powerpc
    toolchain: gcc-11

steps to reproduce:
https://builds.tuxbuild.com/1xdiIZVZuLCW3X1WO2YT6Fsl19w/tuxmake_reproducer.sh

--
Linaro LKFT
https://lkft.linaro.org
