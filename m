Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAA0B44FEE4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 07:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbhKOG7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 01:59:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbhKOG65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 01:58:57 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF8A6C061767
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 22:56:02 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id b15so67025808edd.7
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 22:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=DnhRi/yEd8/77prJmECQX07Ui1HU8yjd7OJqe5An4dY=;
        b=t9Se2sEFkosEsGaNqN9T9TCcZk0wJQhitNRtoH2HD7Q2i2sVGG1qJ3I3iazk8G1Zhx
         DzzlyqGN/XFf0VbvwUIZ8tQVqAvpQjouQUkr2GU+QBikDZMFlGq9s2QzIBuEos8B/HqW
         EFe9W+COyW+NeY2MoRs9g8EOuHeVF1/8XylW/KfsqFMGmGzUkuTFrdPg9AV1k2eIyVfb
         OimAFbLeYeBb61FeElkDPneXjoWJhwx1tqGrhE7zBN0C1kvJiuzZELex0qiYQfhJgD6F
         2MDLkJY7YLD5bffE4C5GkyEiDhaUGqp5Z6pAs7awOEro/Odbc7Jh6Mu9QkAykwWCICvg
         6znA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=DnhRi/yEd8/77prJmECQX07Ui1HU8yjd7OJqe5An4dY=;
        b=cxnXkSnozWcJj0SbuCCa1qCEDbQ1gSLFQ1iEeGaGqXzwLgw/TSzHbup88hzROnsQpH
         D14j2kQyjjL8/3E++nmSawqAbDPWidjgdqJs2r2HJcOTnQ5ady9S0BWGJjMCgvvfnqJw
         TTHrHP9OJtSX1BakHSzaC1+YKDNs3e7DLFe1BdzGo2yhjBecbYdIxohVbcq2okY/fmph
         39QHkJeb9s2HzQttWo0fjt8mcOUuZ8Pac0MC4aiPuG+MuPxZeTyI747fWuGdA1naXwsB
         i7yACQG2kFn9Ue9zTxSUsviKxtaW6OpZj0w8NqqXQYyo6suhX4TZlmZBNkLNVhvI82J5
         YPMQ==
X-Gm-Message-State: AOAM5315QKJc3PtS9SS1Y4O5PD8idF70bblO9/X5qA1GWSS0ef+2KcQ4
        nMaxkZUBCoo2xLXE/PDNnaCfOmxzuJa9sRLJq9wjDg==
X-Google-Smtp-Source: ABdhPJxlHl1kfno22u1uQK+1W5VimX8ZWFmx5vC5rSL362dcc7YkX1nxubWNXAqFsM73XZh/gTsf7e19SMdHhJVT6EU=
X-Received: by 2002:a05:6402:26c2:: with SMTP id x2mr52235690edd.198.1636959361036;
 Sun, 14 Nov 2021 22:56:01 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 15 Nov 2021 12:25:50 +0530
Message-ID: <CA+G9fYsZ_Zks32WTNgKjQg2gwRuqS4E92ttH+okUCdnPFdaNTQ@mail.gmail.com>
Subject: [stable-rc queue/5/15 ]: rk3568-evb1-v10.dts:10:10: fatal error:
 rk3568.dtsi: No such file or directory
To:     Peter Geis <pgwipeout@gmail.com>, Heiko Stuebner <heiko@sntech.de>,
        Sasha Levin <sashal@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-stable <stable@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, lkft-triage@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following build warnings/ errors noticed on Linux stable-rc queue/5.15 branch.
with gcc-11 for arm64 architecture.

arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi:464.3-52: Warning
(pci_device_reg): /pcie@f8000000/pcie@0,0:reg: PCI reg address is not
configuration space
arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi:464.3-52: Warning
(pci_device_reg): /pcie@f8000000/pcie@0,0:reg: PCI reg address is not
configuration space
arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi:464.3-52: Warning
(pci_device_reg): /pcie@f8000000/pcie@0,0:reg: PCI reg address is not
configuration space
arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi:464.3-52: Warning
(pci_device_reg): /pcie@f8000000/pcie@0,0:reg: PCI reg address is not
configuration space
arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts:10:10: fatal error:
rk3568.dtsi: No such file or directory
   10 | #include rk3568.dtsi
      |          ^~~~~~~~~~~~~
compilation terminated.
make[3]: *** [scripts/Makefile.lib:358:
arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dtb] Error 1

The first bad commit:
--------
arm64: dts: rockchip: move rk3568 dtsi to rk356x dtsi
[ Upstream commit 4e50d2173b67115a5574f4f4ce64ec9c5d9c136e ]

In preparation for separating the rk3568 and rk3566 device trees, move
the base rk3568 dtsi to rk356x dtsi.
This will allow us to strip out the rk3568 specific nodes.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
Link: https://lore.kernel.org/r/20210710151034.32857-2-pgwipeout@gmail.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sasha Levin <sashal@kernel.org



Build config:
https://builds.tuxbuild.com/20wHY13986hVAE9j4Kwxq4C8JUX/config

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

meta data:
-----------
    git_describe: v5.15.2-851-g750602323c68
    git_ref:
    git_repo: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc-queues
    git_sha: 750602323c68ab51f3b65c59efc4289a7e7c60f9
    git_short_log: 750602323c68 (\thermal: int340x: fix build on
32-bit targets\)
    kernel_version: 5.15.2
    target_arch: arm64
    toolchain: gcc-11
    kconfig: [
        defconfig,
        https://raw.githubusercontent.com/Linaro/meta-lkft/sumo/recipes-kernel/linux/files/lkft.config,
        https://raw.githubusercontent.com/Linaro/meta-lkft/sumo/recipes-kernel/linux/files/lkft-crypto.config,
        https://raw.githubusercontent.com/Linaro/meta-lkft/sumo/recipes-kernel/linux/files/distro-overrides.config,
        https://raw.githubusercontent.com/Linaro/meta-lkft/sumo/recipes-kernel/linux/files/systemd.config,
        https://raw.githubusercontent.com/Linaro/meta-lkft/sumo/recipes-kernel/linux/files/virtio.config,
        CONFIG_ARM64_MODULE_PLTS=y,
        CONFIG_SYN_COOKIES=y
    ],

steps to reproduce:
tuxmake --runtime podman --target-arch arm64 --toolchain gcc-11
--kconfig defconfig \
 --kconfig-add https://builds.tuxbuild.com/20wHY13986hVAE9j4Kwxq4C8JUX/config

https://builds.tuxbuild.com/20wHY13986hVAE9j4Kwxq4C8JUX/tuxmake_reproducer.sh

--
Linaro LKFT
https://lkft.linaro.org
