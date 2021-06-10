Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83E073A2AD5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 13:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbhFJL4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 07:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbhFJL4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 07:56:31 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC8BC0617A6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 04:54:18 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id dj8so32674403edb.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 04:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=4qMF7JTBYZPTkfoUxEfMGRS4U/sbmt/HerhagcW9ih0=;
        b=qjDH5fNAAD/GL8f2FHXw0a4WQ6sXYZqGrOngMavri12bD0g2O1AbUtbrHSDAFS5jxZ
         fOZ5ezHtaekWcZiJ7qGKF4zUHxAj9BKOL/OSsjr1Oyc3+2V2F8apg8YVJM3hCo9Cu2zq
         X3f8kGIBWH+X3Uj5jKeCaAWlJpMLKIIMITqP4Mt1PuUJMWqJRG1UG8UOEBbn06+lZWLe
         UBO5pEdDm8633nCe+wHkwGRUELq1h4w8/24hrIoviSWdQkFByVH6G93MNcQfHSJhRb64
         Cc7q6g5URQGxTGvCk6bhXA6V49V+9/L2phISlmRC4Y0e6TPRwCBVOI52JY4pVN0l5BnW
         qkYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=4qMF7JTBYZPTkfoUxEfMGRS4U/sbmt/HerhagcW9ih0=;
        b=NbrBIybwxHhTkDV8EJssZ7hNlMW+/lKVuz4Ke6Lau8kiy7CzjOD8n1X2Gnwj0KP4EF
         lJWpkHZ3vhTef3xEMJ5b276mSKE54kwne6luskS1v4OAI9AYRtuT1ydmOJL669wEYa2P
         SrHLx0LulXamrQsDv4+wSzWbztRGjp1pnk2C3+vxYwS2ioO+4ks0ERL1xrEnZHJXVsVU
         y+JlJ+ypEcwUES9yL4wZ2h+u/dgwL+FxsvIJFvaPcv2JHDDNtc3x9vL/LCV9MF+a02Sk
         9Buvuz0YiGwpR0vP74VygF358EKOV5sSYPJeHUYD7CBgmk3zPjo58gpqMfm5DZHp8yBd
         mBZw==
X-Gm-Message-State: AOAM532tM3o30KtQz/bTils75ycWGnUEZA+5hXBqCy+xmvQ2glTSKR31
        rC1yI0U13r1t0fXZLqpPaFAUpbfYHrspoP+3+bdL+Q==
X-Google-Smtp-Source: ABdhPJwtN6NoyIb4L2vLWKIfPE3/jQBKdgkBzeOLxBsZHAtOgsVSYnxhhF9W+zndQH3ut6My+wgfWkcKf56ObmZlevY=
X-Received: by 2002:a05:6402:152:: with SMTP id s18mr4197413edu.221.1623326057184;
 Thu, 10 Jun 2021 04:54:17 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 10 Jun 2021 17:24:06 +0530
Message-ID: <CA+G9fYtNjffuSTiRa_=0V14nvFSnOJXbXZnMuNORGeDHfedKGw@mail.gmail.com>
Subject: [next] [powerpc] tau_6xx.c:204:30: error: too many arguments for
 format [-Werror=format-extra-args]
To:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        lkft-triage@lists.linaro.org
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Finn Thain <fthain@linux-m68k.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While building Linux next-20210610 following builds failed due to
these warnings / errors.

 - powerpc (ppc6xx_defconfig) with gcc-8
 - powerpc (ppc6xx_defconfig) with gcc-9
 - powerpc (ppc6xx_defconfig) with gcc-10


arch/powerpc/kernel/tau_6xx.c: In function 'TAU_init':
arch/powerpc/kernel/tau_6xx.c:204:30: error: too many arguments for
format [-Werror=format-extra-args]
  tau_workq = alloc_workqueue("tau", WQ_UNBOUND, 1, 0);
                              ^~~~~
cc1: all warnings being treated as errors

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>

steps to reproduce:

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


tuxmake --runtime podman --target-arch powerpc --toolchain gcc-9
--kconfig ppc6xx_defconfig

ref:
https://gitlab.com/Linaro/lkft/mirrors/next/linux-next/-/jobs/1334701929#L116

--
Linaro LKFT
https://lkft.linaro.org
