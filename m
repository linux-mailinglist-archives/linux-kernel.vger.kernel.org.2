Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28EE0459E25
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 09:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234833AbhKWIgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 03:36:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234779AbhKWIg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 03:36:26 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE67C061714
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 00:33:18 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id w1so88769297edc.6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 00:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=8xSm0htY7uzvXc6ZHPstXw3E/MOWP40sTEpcuQsBwNE=;
        b=iP9GNaCGIVRENAj0YlyaIOOHrzmIWv8j74Xx5bHbPV1eG9ZTIfOXYsqPjR1Q86mAlg
         zQivsH4+pLS7oaWE5XiReLSoCgwGOJI+bUxeKw2VJP8cAakS1QgoLa2sUHt9e3ycgTQO
         PihVWevLqciK1u0PHBdmApfOGbJziQtmvySEQhsfNn1FZhDIPV1kADm1GUGZWYmrKjf7
         n7Narq8phV6XrPBDSfCDeIiLJYaE/M9xu3CIaQUJJ7hjOYXA3JJFuV9oakw2kk4rjyeL
         ihwzPm/Pl8tTJ8S+fElW06jWtKELROIl610I+Tz5b/8Se0/J6LD0kFJ9+XdB1qtZrre3
         njEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=8xSm0htY7uzvXc6ZHPstXw3E/MOWP40sTEpcuQsBwNE=;
        b=T3ijAmcfvO1MPXdFUhXoC8rMPgq4QT2s9yOmv5CVz1IQK4RsYYpreRsNNQGWRH3YjR
         RtI+vwlsjNjHzGxAJJVi8ZGFKEPLKaTE2FwUsed4zoFMDI221m/Iqm1cKpyf2pS+3Gce
         4+S/jfy+PpsOSO2stt5dWj01+wQ5mHJcbVQ5ej/9DCq6nPoi3xtnudSabmF+KKyNphlw
         ZLIkbrP1xmaQ4I9mtCYTmewWJAxA+wTBYunZLw3/QYQEY+F9sjZRkbvmeONlE6+xMBoY
         ETOLDgYUtaAtzI42oaAjSc/cebl9hvhgxm1mSbffGQFau9ZJe/q5Pz1gIKG45uiGgyDX
         FqNw==
X-Gm-Message-State: AOAM5315C/gVWAQxyUL3wuySFQIVTWStulEbKGaxNLK82/ATbFewjvFh
        loQvITSgPT20aUKUnw7LqMUFurt2kZDO8ZEyJhm6Ew==
X-Google-Smtp-Source: ABdhPJz4Ge/YJURetAUcaVRMXKsZ4VAQ5tJ64Viz8V3KNHbWiWXlwTZMvoKbKzl+4t7kXzzjfgOlM1Kud1SL1asAqXQ=
X-Received: by 2002:a17:906:c302:: with SMTP id s2mr5290537ejz.499.1637656396448;
 Tue, 23 Nov 2021 00:33:16 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 23 Nov 2021 14:03:05 +0530
Message-ID: <CA+G9fYuNibUwficRoq-SS=6s2p+-rXUUR03nHfFbPUC8HoyLpA@mail.gmail.com>
Subject: drivers/net/ethernet/apple/mace.c:170:34: error: assignment of
 read-only location '*(dev->dev_addr + (sizetype)j)'
To:     Netdev <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Hui Tang <tanghui20@huawei.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While building Linux next 20211123 tag for powerpc with gcc-11
following warnings / errors noticed.

make --silent --keep-going --jobs=8
O=/home/tuxbuild/.cache/tuxmake/builds/current ARCH=powerpc
CROSS_COMPILE=powerpc64le-linux-gnu- 'CC=sccache
powerpc64le-linux-gnu-gcc' 'HOSTCC=sccache gcc'
<stdin>:1559:2: warning: #warning syscall futex_waitv not implemented [-Wcpp]
drivers/net/ethernet/apple/mace.c: In function 'mace_probe':
drivers/net/ethernet/apple/mace.c:170:34: error: assignment of
read-only location '*(dev->dev_addr + (sizetype)j)'
  170 |                 dev->dev_addr[j] = rev ? bitrev8(addr[j]): addr[j];
      |                                  ^
drivers/net/ethernet/apple/mace.c: In function 'mace_reset':
drivers/net/ethernet/apple/mace.c:349:32: warning: passing argument 2
of '__mace_set_address' discards 'const' qualifier from pointer target
type [-Wdiscarded-qualifiers]
  349 |     __mace_set_address(dev, dev->dev_addr);
      |                             ~~~^~~~~~~~~~
drivers/net/ethernet/apple/mace.c:93:62: note: expected 'void *' but
argument is of type 'const unsigned char *'
   93 | static void __mace_set_address(struct net_device *dev, void *addr);
      |                                                        ~~~~~~^~~~
drivers/net/ethernet/apple/mace.c: In function '__mace_set_address':
drivers/net/ethernet/apple/mace.c:388:43: error: assignment of
read-only location '*(dev->dev_addr + (sizetype)i)'
  388 |         out_8(&mb->padr, dev->dev_addr[i] = p[i]);
      |                                           ^
make[5]: *** [scripts/Makefile.build:288:
drivers/net/ethernet/apple/mace.o] Error 1
drivers/net/ethernet/apple/bmac.c: In function 'bmac_probe':
drivers/net/ethernet/apple/bmac.c:1287:34: error: assignment of
read-only location '*(dev->dev_addr + (sizetype)j)'
 1287 |                 dev->dev_addr[j] = rev ? bitrev8(addr[j]): addr[j];
      |                                  ^
make[5]: *** [scripts/Makefile.build:288:
drivers/net/ethernet/apple/bmac.o] Error 1
make[5]: Target '__build' not remade because of errors.
make[4]: *** [scripts/Makefile.build:571: drivers/net/ethernet/apple] Error 2
drivers/net/ethernet/freescale/fec_mpc52xx.c: In function 'mpc52xx_fec_start':
drivers/net/ethernet/freescale/fec_mpc52xx.c:659:39: warning: passing
argument 2 of 'mpc52xx_fec_set_paddr' discards 'const' qualifier from
pointer target type [-Wdiscarded-qualifiers]
  659 |         mpc52xx_fec_set_paddr(dev, dev->dev_addr);
      |                                    ~~~^~~~~~~~~~
drivers/net/ethernet/freescale/fec_mpc52xx.c:102:63: note: expected
'u8 *' {aka 'unsigned char *'} but argument is of type 'const unsigned
char *'
  102 | static void mpc52xx_fec_set_paddr(struct net_device *dev, u8 *mac)
      |                                                           ~~~~^~~
make[4]: Target '__build' not remade because of errors.
make[3]: *** [scripts/Makefile.build:571: drivers/net/ethernet] Error 2


Build config:
https://builds.tuxbuild.com/21J9lNXArf0rGC2zEytrVxfwmQP/config


Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

meta data:
-----------
    git describe: next-20211123
    git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
    git_sha: aacdecce8147c20b01f865b4e214bb8dbe8c4af1
    git_short_log: aacdecce8147 (\"Add linux-next specific files for 20211123\")
    target_arch: powerpc
    toolchain: gcc-11

steps to reproduce:
tuxmake --runtime podman --target-arch powerpc --toolchain gcc-11
--kconfig ppc6xx_defconfig

https://builds.tuxbuild.com/21J9lNXArf0rGC2zEytrVxfwmQP/tuxmake_reproducer.sh

--
Linaro LKFT
https://lkft.linaro.org
