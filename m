Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBAC24038BE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 13:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351498AbhIHL3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 07:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351478AbhIHL3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 07:29:31 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14604C061575
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 04:28:24 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id t19so3452148ejr.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 04:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=0w+npLymedQOmdkTjXEumVbGXNXmwr0XOw2iRGbnJe0=;
        b=Wz9lc/POPlH8xx/KP/FRuLfS23o1KhqT6EbV6HiIsyXMU8fLbcsGfocpr2wc6l+37g
         b2oIY45PVww3mmqG/B3Tj3nyKJlM/c86zTngbXaprFAEYUbKIeW1FORaeY/sGR/RHKQv
         nOFNu1ukZPOQSIFqKOCI2C7JayZs3Ltly5bzTa4S3N+2UgS/Jt/beR1Une1/wz5J3QZB
         T9M9S9WWT2KawsXE+EUMZcH+pEJcz79K+nlOcDgU0NMrXhvYxx75CKwS3WOiSGh4pXmf
         9yL9lePshOTUbr3tZ+dDVR2Pn9cxd9mlbcn3urHqmTYVB2P/BruFjQ306IiiPput9I6X
         pc8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=0w+npLymedQOmdkTjXEumVbGXNXmwr0XOw2iRGbnJe0=;
        b=orK6htum3Ya714Gv0TXpq9V3XIpAmXYipipuT5av+6YBYv/jLQZFbJxVDs+s07VWaE
         y5EbnoS2uc/BAug+Um8W/LcKG4Zgg8vzOrAAINHte3w2ej4RDoiH3ixbwV2fW8MNaHwr
         6Jhry+y8b/TyH1Wqh+2j6EZSXvDlDklgPSqClGND+QiEaOjkMolhlR1XwzTSVdwWe/0H
         nqLw4UL7OHHYfgLozoewqpGLUtDgcofbo0L82y2LmCE83+bsFo9s/QYgKX6jxzrNkIp1
         Z9tNMp6sFrscWvVn17GdptKpl/2XNB4YyZeciWDDXFC/3oOefMmSqmMW+546bjtOWusI
         pBXg==
X-Gm-Message-State: AOAM530E5DBRAWNLa6emJX1w2R9JDkmAEZmRbcuTXvXQLBo6eNMS7F/S
        yDgqUDFEesFkJsjxYd1apJlQIeO9o8Pz1Bhc2utoMg==
X-Google-Smtp-Source: ABdhPJzOGH87ffdACbvniW2JGxeaTFyzRqmCcDgdU4oQca4TO5+hAdJEpXBgzeIreusv+eEddBrBTzLTp7SpFvsNrMo=
X-Received: by 2002:a17:906:681:: with SMTP id u1mr3452871ejb.499.1631100502434;
 Wed, 08 Sep 2021 04:28:22 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 8 Sep 2021 16:58:11 +0530
Message-ID: <CA+G9fYvThAuTu1-Tg+7BaFofxfBkvBuTAnycuws-U4p473MeZQ@mail.gmail.com>
Subject: ERROR: modpost: __mulodi4 [drivers/block/nbd.ko] undefined!
To:     linux-block <linux-block@vger.kernel.org>, nbd@other.debian.org,
        open list <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
        lkft-triage@lists.linaro.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following build warnings/ errors noticed while building linux next
master branch with clang-13 for arm architecture with following configs.
  - footbridge_defconfig
  - mini2440_defconfig
  - s3c2410_defconfig

ERROR: modpost: __mulodi4 [drivers/block/nbd.ko] undefined!
make[2]: *** [/builds/linux/scripts/Makefile.modpost:134:
modules-only.symvers] Error 1
make[2]: *** Deleting file 'modules-only.symvers'
make[2]: Target '__modpost' not remade because of errors.
make[1]: *** [/builds/linux/Makefile:1952: modules] Error 2
make[1]: Target '__all' not remade because of errors.
make: *** [Makefile:226: __sub-make] Error 2
make: Target '__all' not remade because of errors.

Build config:
https://builds.tuxbuild.com/1xqOnCtgaWedE8U8jhmbI3FuAuJ/config

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

meta data:
-----------
    git_describe: next-20210908
    git_ref:
    git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
    git_sha: 999569d59a0aa2509ae4a67ecc266c1134e37e7b
    git_short_log: 999569d59a0a (\Add linux-next specific files for 20210908\)
    kconfig: [
        mini2440_defconfig
    ],
    target_arch: arm
    toolchain: clang-13

steps to reproduce:
https://builds.tuxbuild.com/1xqOnCtgaWedE8U8jhmbI3FuAuJ/tuxmake_reproducer.sh

--
Linaro LKFT
https://lkft.linaro.org
