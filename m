Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5388C35944E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 07:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233265AbhDIFHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 01:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233259AbhDIFGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 01:06:39 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A5BC061762
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 22:06:24 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 18so5035080edx.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 22:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=8iYmIB0hU1FV/TAMgjJvsR+ql1uW19IJI/pH9Ro9DkA=;
        b=a70py4CkGoMUXeaFQVQA4FhZexNTY7CoerXO2Kv6FbkmQVGU1qkaoBu0ilmOAnZ8FL
         7VMM8xaZNuu9MwHuQHGKFafgh6jsl2VyvafrqXVJemNWIgKlrOTXhOdKc94bF3tLPAhG
         ANE52iIr4rhXku2oImy+Es5L5DZ2D+nnQQtr/S6nZinORJB65KAVKNQLXnZ80OzpqH8y
         BMTTNBvKwFZqT2qU+RysEl+6rg68rexMN3tSrXoSNxb7Y3LaLiQeOOXwhO7iPyshSHzC
         3xyeCuBvZv/TbsOkp7ZQjDIfxDA8fx9uOFEDRcHmDAzx6nlTJSCxeCLHrPDDVX14TdS3
         5Mmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=8iYmIB0hU1FV/TAMgjJvsR+ql1uW19IJI/pH9Ro9DkA=;
        b=Hs9RctOVJeQlJMX28jJh8fPlnAmgY/rpp3g2cR+yv1kk6QLHU+YB/LjCMjfTijG95M
         C04VuDQ0bdchG3K46Dymr4AupB/mIU0QRufnWYJqzijF5sybRY/zF6w/ssQGbohdS+RU
         4tqtXlj78xDEp9jr7oMExeTQJPAnBN3qIZQ8hN2A3hPwOsLGXaN81a/fEktUnSkYxH21
         bxU0PLl16CrBMD+47k2csCBt7s5b203JJ5zn89eDYJnmTugML+AKjCsN3kWfeWLsLton
         enZGZi0BST5lR9KUxI7YFqeGWdS0Gf7vWJh5Y87Q6thMF5J93uwOqXGzhCd+Ls9O8leq
         gFCQ==
X-Gm-Message-State: AOAM531XoPtNxCebn5qfrK2Gsd9Vyy/UYMpXbosIetP3fOsXbvExbfAI
        v4XoVpjoBT/Q/Hoxo5WGj6WeJfZjiCOgqgfMAA1mzg==
X-Google-Smtp-Source: ABdhPJxwuL1N3RYHPIM35VfE6Bv0fNGNmUKwjyd3Hg12yFVOn9y5ViHlt/I8RHus77kUrzTJVLJ7QA8itjw9ycd1cdI=
X-Received: by 2002:a05:6402:145:: with SMTP id s5mr15497871edu.221.1617944783387;
 Thu, 08 Apr 2021 22:06:23 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 9 Apr 2021 10:36:12 +0530
Message-ID: <CA+G9fYu60T=vymv7gA0eaopfNDWXAVT9WRS11Rrk1OfTkrCevw@mail.gmail.com>
Subject: [next] ERROR: modpost: "dns_query" [fs/cifs/cifs.ko] undefined
To:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        samba-technical@lists.samba.org, lkft-triage@lists.linaro.org
Cc:     Maciek Borzecki <maciek.borzecki@gmail.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Wan Jiabing <wanjiabing@vivo.com>,
        Steve French <stfrench@microsoft.com>,
        "Paulo Alcantara (SUSE)" <pc@cjr.nz>,
        Pavel Shilovsky <pshilov@microsoft.com>,
        Steve French <sfrench@samba.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Large number of Linux next tag 20210408 builds failed due to these errors.

make --silent --keep-going --jobs=8
O=/home/tuxbuild/.cache/tuxmake/builds/1/tmp ARCH=arm
CROSS_COMPILE=arm-linux-gnueabihf- 'CC=sccache
arm-linux-gnueabihf-gcc' 'HOSTCC=sccache gcc'

ERROR: modpost: "dns_query" [fs/cifs/cifs.ko] undefined

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>

Regressions found on parisc:
  - build/gcc-9-defconfig
  - build/gcc-8-defconfig
  - build/gcc-10-defconfig

Regressions found on sh:
  - build/gcc-9-dreamcast_defconfig
  - build/gcc-10-dreamcast_defconfig
  - build/gcc-8-dreamcast_defconfig

Regressions found on arm:
  - build/clang-12-s3c2410_defconfig
  - build/gcc-8-s3c2410_defconfig
  - build/clang-10-nhk8815_defconfig
  - build/gcc-9-s3c2410_defconfig
  - build/gcc-10-nhk8815_defconfig
  - build/gcc-8-nhk8815_defconfig
  - build/gcc-10-s3c2410_defconfig
  - build/clang-12-nhk8815_defconfig
  - build/clang-11-s3c2410_defconfig
  - build/gcc-9-nhk8815_defconfig
  - build/clang-11-nhk8815_defconfig
  - build/clang-10-s3c2410_defconfig

--
Linaro LKFT
https://lkft.linaro.org
