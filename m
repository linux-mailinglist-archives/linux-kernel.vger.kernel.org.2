Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB01A441D16
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 16:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbhKAPGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 11:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbhKAPGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 11:06:37 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448B3C061714
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 08:04:04 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id j28so12350538ila.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 08:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=zz8+8eAWT15ebtgLs9UUM8XkKHVahbPCHZBcbN8cF+Q=;
        b=diUd2t97mRjzk8jAknzzLiX7jzc3g576wvHA1y1vQR3NfhMi1LBD7leOtgFBdg970S
         Ahqbetd/I1fKgv6nLYzBje+GOael2jwh+jxS1QuK7fkITTONbLLWq/V0H7trp2ovOf/a
         NR7IHf9SF8XPiZbd0TkFgXW1/ijwkjvOOFBgI2r1AZgsPKQVeCkHGU26dqVs0u/k2Eiy
         b4CIJPeuff116K42HU/xrDx+6UjSPmonMNo3M2zwoYijzT8HR0LCygKZ7uOGAo78vHf0
         LGR4C7ahXcoOF+b5weJkqM9Ui+/xNUsqwq1tIbnNHhw26HdQKN1Acb0V2vNiWZOmlEdn
         Rp7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=zz8+8eAWT15ebtgLs9UUM8XkKHVahbPCHZBcbN8cF+Q=;
        b=4Vk5zhI15xm3lo+KMDBF+9cyebPaV6itoUbiBcEDnl4GVEGTlqyzCZ8sBh+H9Hhovj
         PwPr2TkPHCbSsJvAZrZP70JH3YOd0sSkr4CFEMHwaKZ0cHUJwkhAeeTYEx6uDyXGKEcd
         lFcDL4WQznSgznjUYk3x49SxVjOVlKxYbe5xdYhtZZCphY9uB5onj9lS/Yx9OapB6yyr
         n+lubWAPgWgZNgSfpxt1J8zrJYbUQakVsAP2NQ26+DpgC5YfO7P2TibDUJYVXK/fkm5O
         ltVRZYOiLqTsGRn/kHvl4gApSSC32pR6kA83j2A+582gaMEVKwUkii3OYmLH7hOcpsMC
         HHYA==
X-Gm-Message-State: AOAM531vg4S4anNFMtd6r+0a3N6NpmafhVMwzEjnhhKZe57d2jiVCikV
        GliJpxWepqNAJeT2aTb8v87hfQ57n/zzasAvWs0=
X-Google-Smtp-Source: ABdhPJx9OIYBsYfkFP3JkQn6FN5FHN88Fz6pxMQKcLr5G9awyIa6NDcEIO/RcAuvHcAJrhqaELXO1muDEK5451DcuH4=
X-Received: by 2002:a05:6e02:12e4:: with SMTP id l4mr21389883iln.25.1635779040971;
 Mon, 01 Nov 2021 08:04:00 -0700 (PDT)
MIME-Version: 1.0
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Mon, 1 Nov 2021 10:03:50 -0500
Message-ID: <CABb+yY1BgU41JCQYyPgSRBvR6E6dxPiYTamm7j4hyaQt35jLqg@mail.gmail.com>
Subject: [GIT PULL] Mailbox changes for v5.16
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 6985c40ab6c5d63a494ce9adce9a4768364f2507:

  Merge tag 'clk-fixes-for-linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux (2021-10-16
10:22:08 -0700)

are available in the Git repository at:

  git://git.linaro.org/landing-teams/working/fujitsu/integration.git
tags/mailbox-v5.16

for you to fetch changes up to 97961f78e8bc7f50ff7113fec030af6fa5f004d0:

  mailbox: imx: support i.MX8ULP S4 MU (2021-10-29 23:03:09 -0500)

----------------------------------------------------------------
- qcom: add support for qcm2290
        consolidate msm8994 type apcs_data
- mtk: fix clock id usage
- apple: add driver for ASC/M3 controllers
- pcc: reorganise PCC pcc_mbox_request_channel
       add support for PCCT extended PCC subspaces
- misc: make use of devm_platform_ioremap_resource()
       change Altera, PCC and Apple mailbox maintainers

----------------------------------------------------------------
Cai Huoqing (12):
      mailbox: altera: Make use of the helper function
devm_platform_ioremap_resource()
      mailbox: bcm2835: Make use of the helper function
devm_platform_ioremap_resource()
      mailbox: hi3660: Make use of the helper function
devm_platform_ioremap_resource()
      mailbox: hi6220: Make use of the helper function
devm_platform_ioremap_resource()
      mailbox: mtk-cmdq: Make use of the helper function
devm_platform_ioremap_resource()
      mailbox: omap: Make use of the helper function
devm_platform_ioremap_resource()
      mailbox: platform-mhu: Make use of the helper function
devm_platform_ioremap_resource()
      mailbox: qcom-apcs-ipc: Make use of the helper function
devm_platform_ioremap_resource()
      mailbox: sti: Make use of the helper function
devm_platform_ioremap_resource()
      mailbox: stm32-ipcc: Make use of the helper function
devm_platform_ioremap_resource()
      mailbox: sun6i: Make use of the helper function
devm_platform_ioremap_resource()
      mailbox: xgene-slimpro: Make use of the helper function
devm_platform_ioremap_resource()

Fei Shao (2):
      mailbox: mtk-cmdq: Validate alias_id on probe
      mailbox: mtk-cmdq: Fix local clock ID usage

Mun Yew Tham (1):
      MAINTAINERS: Update Mun Yew Tham as Altera Mailbox Driver maintainer

Peng Fan (2):
      dt-bindings: mailbox: imx-mu: add i.MX8ULP S400 MU support
      mailbox: imx: support i.MX8ULP S4 MU

Shawn Guo (4):
      mailbox: qcom-apcs-ipc: Consolidate msm8994 type apcs_data
      dt-bindings: mailbox: qcom: Add QCM2290 APCS compatible
      mailbox: qcom-apcs-ipc: Add QCM2290 APCS IPC support
      dt-bindings: mailbox: Update maintainer email for qcom apcs-kpss

Sudeep Holla (13):
      mailbox: pcc: Fix kernel doc warnings
      mailbox: pcc: Refactor all PCC channel information into a structure
      mailbox: pcc: Consolidate subspace interrupt information parsing
      mailbox: pcc: Consolidate subspace doorbell register parsing
      mailbox: pcc: Add pcc_mbox_chan structure to hold shared memory
region info
      mailbox: pcc: Use PCC mailbox channel pointer instead of standard
      mailbox: pcc: Rename doorbell ack to platform interrupt ack register
      mailbox: pcc: Add PCC register bundle and associated accessor functions
      mailbox: pcc: Avoid accessing PCCT table in pcc_send_data and pcc_mbox_irq
      mailbox: pcc: Drop handling invalid bit-width in {read,write}_register
      mailbox: pcc: Add support for PCCT extended PCC subspaces(type 3/4)
      mailbox: pcc: Move bulk of PCCT parsing into pcc_mbox_probe
      ACPI/PCC: Add maintainer for PCC mailbox driver

Sven Peter (3):
      MAINTAINERS: Add Apple mailbox files
      dt-bindings: mailbox: Add Apple mailbox bindings
      mailbox: apple: Add driver for Apple mailboxes

jason-jh.lin (1):
      mailbox: Remove WARN_ON for async_cb.cb in cmdq_exec_done

 .../devicetree/bindings/mailbox/apple,mailbox.yaml |  77 +++
 .../devicetree/bindings/mailbox/fsl,mu.yaml        |   1 +
 .../bindings/mailbox/qcom,apcs-kpss-global.yaml    |   3 +-
 MAINTAINERS                                        |  11 +-
 drivers/acpi/cppc_acpi.c                           |  43 +-
 drivers/hwmon/xgene-hwmon.c                        |  35 +-
 drivers/i2c/busses/i2c-xgene-slimpro.c             |  33 +-
 drivers/mailbox/Kconfig                            |  12 +
 drivers/mailbox/Makefile                           |   2 +
 drivers/mailbox/apple-mailbox.c                    | 384 +++++++++++++
 drivers/mailbox/bcm2835-mailbox.c                  |   4 +-
 drivers/mailbox/hi3660-mailbox.c                   |   4 +-
 drivers/mailbox/hi6220-mailbox.c                   |   7 +-
 drivers/mailbox/imx-mailbox.c                      | 124 +++--
 drivers/mailbox/mailbox-altera.c                   |   5 +-
 drivers/mailbox/mailbox-sti.c                      |   4 +-
 drivers/mailbox/mailbox-xgene-slimpro.c            |   4 +-
 drivers/mailbox/mtk-cmdq-mailbox.c                 |  15 +-
 drivers/mailbox/omap-mailbox.c                     |   4 +-
 drivers/mailbox/pcc.c                              | 598 +++++++++++++--------
 drivers/mailbox/platform_mhu.c                     |   4 +-
 drivers/mailbox/qcom-apcs-ipc-mailbox.c            |  31 +-
 drivers/mailbox/stm32-ipcc.c                       |   4 +-
 drivers/mailbox/sun6i-msgbox.c                     |   9 +-
 include/acpi/pcc.h                                 |  21 +-
 include/linux/apple-mailbox.h                      |  19 +
 include/linux/firmware/imx/s4.h                    |  20 +
 27 files changed, 1061 insertions(+), 417 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
 create mode 100644 drivers/mailbox/apple-mailbox.c
 create mode 100644 include/linux/apple-mailbox.h
 create mode 100644 include/linux/firmware/imx/s4.h
