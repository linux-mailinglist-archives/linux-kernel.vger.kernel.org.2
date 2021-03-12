Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A31F3385C8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 07:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbhCLGYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 01:24:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbhCLGYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 01:24:40 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17AC4C061574;
        Thu, 11 Mar 2021 22:24:40 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id f2-20020a17090a4a82b02900c67bf8dc69so10271931pjh.1;
        Thu, 11 Mar 2021 22:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=9W91lxMjmS6duxJfVFbpN9OrD/qgQmXljbVxuKRaByg=;
        b=sZvn3dlRhwvxJZo9kABsq7xJGUX3cJwgnX/tbpaERYKuHlQilkL5Zgwv9IEZ3mWGWz
         4Z/dyota91Aw12qxr2Dnns+kQQQs82MBNxmcqVS1/6bSpZpxfEAO15ewaCptQQhrpk5c
         +bQeNPFmKaS3jkfdNl/M1mnW7n+RkpjLZvh+++HoaVCQtXG+xqucQgqzaBreXam/Sb8f
         50am4t2xy8X7NQozoJ4PuVe8LRW4xHxQvwCcbiZVx3NfD2faZQG8hC03vCdhCwDA3DZy
         HJZFSqNGFx9ifx13L/skpBz7BGHhD/8yCtB+BowywmI5c+EPjUQccOz5om4zp+/G7kBp
         gqkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9W91lxMjmS6duxJfVFbpN9OrD/qgQmXljbVxuKRaByg=;
        b=VUTu39r5Tb2Ppd9o4dPMvlOkYLRdo6HF7ppkUNDaoyfO+ePW3QC4Ezqn76lZZBXzeZ
         CEZdbRUvciIvs3OTI40E3662UY33bZKWOFhoxh2V2rafvXTa0O4Lz9AYPw5DhJOGURtn
         krNM3/45K5jemtzX5mC7kn2ONeaXNMsoJgzCb6eUmsBpPkqvMh7S8eZHSoW1S8a44Sh7
         CcF9GbcJ24m2LGR5bQlukohkbO/Rq7K+OtRP9Kw2lM3g94DHwSnEyI4CDYXq+g2kEtjX
         s97d/3I/IHWbXMJpeBttL8L6EJL8hAgSt4E8lMHRpeM13eRWwjmO0gMxvMA9UnWQf9e2
         ww6Q==
X-Gm-Message-State: AOAM533PAQMdGodelg8ZZ4MYHTuTyFOqjaFVK+0wn5hsWmTNiWswPnuH
        dUEucDi7iNjw0GZN+ConfNQ=
X-Google-Smtp-Source: ABdhPJw3ig/kHvwglXds1+7Jh0zNQfsxEoFGGunCQggwqPlTWRTNSOykTswFi7lN2H166PzmXGZEhg==
X-Received: by 2002:a17:90b:100a:: with SMTP id gm10mr12595731pjb.0.1615530279658;
        Thu, 11 Mar 2021 22:24:39 -0800 (PST)
Received: from fmin-OptiPlex-7060.nreal.work ([137.59.103.165])
        by smtp.gmail.com with ESMTPSA id h6sm4048406pfb.157.2021.03.11.22.24.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Mar 2021 22:24:39 -0800 (PST)
From:   dillon.minfei@gmail.com
To:     robh+dt@kernel.org, alexandre.torgue@foss.st.com,
        a.fatoum@pengutronix.de, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk, vladimir.murzin@arm.com,
        afzal.mohd.ma@gmail.com
Cc:     dillon min <dillon.minfei@gmail.com>
Subject: [PATCH v2 0/8] ARM: STM32: add art-pi(stm32h750xbh6) board support
Date:   Fri, 12 Mar 2021 14:24:26 +0800
Message-Id: <1615530274-31422-1-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

This patchset intend to add art-pi board support, this board developed
by rt-thread(https://www.rt-thread.org/).

Board resources:

8MiB QSPI flash
16MiB SPI flash
32MiB SDRAM
AP6212 wifi,bt,fm comb

sw context:
- as stm32h750 just has 128k bytes internal flash, so running a fw on
  internal flash to download u-boot/kernel to qspi flash, boot
  u-boot/kernel from qspi flash. this fw is based on rt-thread.
- kernel can be xip on qspi flash or load to sdram
- root filesystem is jffs2(created by buildroot), stored on spi flash

to support the boad, add following changes.
- fix r0-r3, r12 register restore failed after svc call,
- add dts binding
- update yaml doc

changes in v2:
- reorganize the pinctrl device tree about stm32h7-pinctrl/stm32h743/750-pinctrl
  stm32h7-pinctrl.dtsi --> stm32h743-pinctrl.dtsi --> stm32h743i-disco.dts
                       |                          |-> stm32h743i-eval.dts
                       |-> stm32h750-pinctrl.dtsi --> stm32h750i-art-pi.dts
   same to the stm32f7/f4's pinctrl style
- fix author name/copyright mistake
- add compatible string st,stm32h750-pinctrl to pinctl-stm32h743.c as they
  have same pin alternate functions, update Kconfig description
- make item in stm32h750i-art-pi.dts sort by letter


dillon min (8):
  Documentation: arm: stm32: Add stm32h750 value line doc
  dt-bindings: arm: stm32: Add compatible strings for ART-PI board
  dt-bindings: pinctrl: stm32: Add stm32h750 pinctrl
  ARM: dts: stm32: introduce stm32h7-pinctrl.dtsi to support stm32h750
  ARM: dts: stm32: add stm32h750-pinctrl.dtsi
  ARM: dts: stm32: add support for art-pi board based on stm32h750xbh6
  ARM: stm32: Add a new SOC - STM32H750
  pinctrl: stm32: Add STM32H750 MCU pinctrl support

 Documentation/arm/index.rst                        |   1 +
 Documentation/arm/stm32/stm32h750-overview.rst     |  33 ++
 .../devicetree/bindings/arm/stm32/stm32.yaml       |   4 +
 .../bindings/pinctrl/st,stm32-pinctrl.yaml         |   1 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/stm32h7-pinctrl.dtsi             | 392 +++++++++++++++++++++
 arch/arm/boot/dts/stm32h743-pinctrl.dtsi           | 307 +---------------
 arch/arm/boot/dts/stm32h743.dtsi                   |  30 ++
 arch/arm/boot/dts/stm32h750-pinctrl.dtsi           |  11 +
 arch/arm/boot/dts/stm32h750.dtsi                   |   5 +
 arch/arm/boot/dts/stm32h750i-art-pi.dts            | 228 ++++++++++++
 arch/arm/mach-stm32/board-dt.c                     |   1 +
 drivers/pinctrl/stm32/Kconfig                      |   2 +-
 drivers/pinctrl/stm32/pinctrl-stm32h743.c          |   3 +
 14 files changed, 717 insertions(+), 302 deletions(-)
 create mode 100644 Documentation/arm/stm32/stm32h750-overview.rst
 create mode 100644 arch/arm/boot/dts/stm32h7-pinctrl.dtsi
 create mode 100644 arch/arm/boot/dts/stm32h750-pinctrl.dtsi
 create mode 100644 arch/arm/boot/dts/stm32h750.dtsi
 create mode 100644 arch/arm/boot/dts/stm32h750i-art-pi.dts

-- 
2.7.4

