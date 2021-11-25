Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF4145D545
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 08:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352928AbhKYHSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 02:18:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345324AbhKYHRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 02:17:04 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96E5C061746
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 23:13:53 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id y13so21229827edd.13
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 23:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=SxTPhuFWzLMO4T3qb3VR1ibcyfEQ0WltPBPxNAcTbnE=;
        b=vV443gGmwKS+xeKfdULrxdV89++/7bOGVfsHvj+k4XJjSrhG4LW1fYH86PEm28GiDM
         H3D8p/WVTylz1Vacsl3q/1intRuwdhaTUaOL6ROumny8rGKwTyNp61G3h4ZwW4mB8Q1b
         z9FCBOAdVud2Wnmyhb1GUpzROUkeUibLXkD7R4kpWBSLxqbn4GJI+P0sM3YYjMtdhQ6Y
         3omQMESy2X4Mn4/cdcEZ1Dex/vDkeIkqCsMcTu8d5/UqkpHn6y4Dx6m2Jz4EE5M+4k33
         6O+4YbF0BssuMZe3mPXhiNbLR7Jy1FcolSWdpxF6vz1p55GTjmSQeU9PFpIgP/FDLue3
         /bCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=SxTPhuFWzLMO4T3qb3VR1ibcyfEQ0WltPBPxNAcTbnE=;
        b=uY60NFBBDSc5Pnyt7GYVBgmGL80cdprCmBPqO5fbaYjXEvqx0ZmIk1uwTCwTJ6yLlL
         1DUEINK9AgJfa3cCuhzigdxysaolHfWZRiZoBJJ//ZpviYVvqqPD9zN5/zncPBdmDXhZ
         ERfU5IuN3Ebjk673KqCUStBF5V7Amhy4164PJsvV1jboHY9Vw7z17N80b9GEPjye9/cf
         O4hkzpF1mIyQ1RtImlbjZefWKB8ABECC1fqNsPl1Vabdn3Mnh5NbtAXNVJTcStRGoocH
         2mFCX1UHeSqVtFiQXSsXE/Oi7P7CCNKg8BvBjXdYLn0M8xiQav3PuRpn1Kz46A8Ntf0V
         GUlg==
X-Gm-Message-State: AOAM532uxEDaT6ZyNun3TjTLvYqwaVVJ3+EUe9F2MQ0ilKwG8C12Pnie
        DTqVmoVOy4fBxAvoBDcDdVzoJe7476oDaA6rogXv9Q==
X-Google-Smtp-Source: ABdhPJx9aQRrIPd88Z2lvPqRT950h72vJSvyH2seN0hnIK/8d+6voT8QRGTd1YOsXyJjIk8d+QDRrXJ4E2Cf3mhdOxY=
X-Received: by 2002:aa7:c415:: with SMTP id j21mr34988585edq.357.1637824432389;
 Wed, 24 Nov 2021 23:13:52 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 25 Nov 2021 12:43:41 +0530
Message-ID: <CA+G9fYuLv7491Q2AHcaUAQ2AQeFBQgx8w0DzK95Qf6Fh9gGFfQ@mail.gmail.com>
Subject: [next] kasan: shadow.c:528:33: error: 'VM_DELAY_KMEMLEAK' undeclared
To:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Yongqiang Liu <liuyongqiang13@huawei.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Please ignore this email if it is already reported ]

While building Linux next 20211125 x86 with CONFIG_KASAN=y gcc-11
following warnings / errors noticed.

mm/kasan/shadow.c: In function 'kasan_module_alloc':
mm/kasan/shadow.c:528:33: error: 'VM_DELAY_KMEMLEAK' undeclared (first
use in this function); did you mean 'VM_DEFER_KMEMLEAK'?
  528 |                 if (vm->flags & VM_DELAY_KMEMLEAK)
      |                                 ^~~~~~~~~~~~~~~~~
      |                                 VM_DEFER_KMEMLEAK
mm/kasan/shadow.c:528:33: note: each undeclared identifier is reported
only once for each function it appears in
make[3]: *** [scripts/Makefile.build:288: mm/kasan/shadow.o] Error 1

Build config:
https://builds.tuxbuild.com/21OjEyx87iCX9bqOwJrZdl1wFFj/config


Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

meta data:
-----------
    git describe: next-20211125
    git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
    git_sha: f81e94e91878bded599cc60f2881cfd50991aeb9
    git_short_log: f81e94e91878 (\"Add linux-next specific files for 20211125\")
    target_arch: x86
    toolchain: gcc-11

steps to reproduce:
tuxmake --runtime podman --target-arch x86_64 --toolchain gcc-11
--kconfig defconfig \
--kconfig-add https://builds.tuxbuild.com/21OjEyx87iCX9bqOwJrZdl1wFFj/config

https://builds.tuxbuild.com/21OjEyx87iCX9bqOwJrZdl1wFFj/tuxmake_reproducer.sh

--
Linaro LKFT
https://lkft.linaro.org
