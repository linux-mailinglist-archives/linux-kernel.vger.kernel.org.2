Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 487203B6D70
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 06:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbhF2E0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 00:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhF2E0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 00:26:53 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E941C061574
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 21:24:25 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id a6so25104137ioe.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 21:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=kKbP+sOfgvq19eFYRoX1RtO0fgrWzOmMfOhtqpOowIY=;
        b=lt8sjWYuluCGan+ZKPd6Qa9KXu6WY2pBPnRWd2MUDnRoMasrh9u6egz/fW8NUVY9H5
         RhB7NDq41BsBx2bBhrdU/q029fz2ra0UvRnJfuQuq6XJFpSF+h0S5XMSIsbGlyqJYjP5
         YMoU3DfO5ltu9U01T6nbL+7i/aG3HI8rMN/S/h0Akzvl7GmMpB/fbHb7uqKHNbD7kNE/
         yxj2lTb+PdFlPSjMUVKe2O/qlIvtVuUluJVnG+1IXjj/MJne5uUObXMBCWnpeUML9egd
         8HAyIOqn+6imVpkhjv4lmzTr4amr7TXqgJ/MO+B8+dpTTauavqFHrvU1R2Y/Gb4Qlepe
         mDug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=kKbP+sOfgvq19eFYRoX1RtO0fgrWzOmMfOhtqpOowIY=;
        b=AMc9UK9DPgB80sQoaK8AWCPPzyGK556Kzokx9eUUwObDcOpdPVchZeJzXlYWP/ypik
         i3/6h2Ero/DZn0uoqqXak5JgP2Ibkndxy++cxY54sBQeUikvC4nicZgEkpLDyWC7DLt2
         bb5vRQ6FATcyqklywObW3Q5SvYYz0iq5vuUHHTvSLzqqkjQbG71gmUbohzYX3rklQQP2
         vjq7DIYFQZrfI6fJAINLVUvmvUi0g0UlUZjSx19/urxZhAZ5t4U3752SnLtIjonW9k3/
         lSXMQ6AwcujyRqUZMxbHfViesa7qeNOn8mdAQAiOvZ7+o2ogXKGcd9BXBr++Fj2a3hNB
         IsVQ==
X-Gm-Message-State: AOAM530KLKpbV1XljgM/Pp1NQl8uBDnDeV9BB3oLSM9+qYWnIpaCnyOb
        cffNu8+VHpMcHReQdGEz1LD2OfgwXkuc2pU2L74=
X-Google-Smtp-Source: ABdhPJx4utrnf5GfyUegqhBSX/FrcaldmB50B1cYwzjg1SLGMkMzbqJKmYzr4BpNqYPxkUDwU2h/Tj2f7AIt1QIx6r8=
X-Received: by 2002:a05:6638:2143:: with SMTP id z3mr2537862jaj.103.1624940664874;
 Mon, 28 Jun 2021 21:24:24 -0700 (PDT)
MIME-Version: 1.0
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Mon, 28 Jun 2021 23:24:14 -0500
Message-ID: <CABb+yY23+V0zG1_G+_rLi4SsnrqXFZe7onv=JTedgAgWim_nYQ@mail.gmail.com>
Subject: [GIT PULL] Mailbox changes for v5.14
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 13311e74253fe64329390df80bed3f07314ddd61:

  Linux 5.13-rc7 (2021-06-20 15:03:15 -0700)

are available in the Git repository at:

  git://git.linaro.org/landing-teams/working/fujitsu/integration.git
tags/mailbox-v5.14

for you to fetch changes up to 4f197188da668180d5ea7d808ae6221ce66cfe33:

  MAINTAINERS: add entry for polarfire soc mailbox (2021-06-26 12:07:03 -0500)

----------------------------------------------------------------
- imx: add support for i.MX8ULP
- mtk: code change around callback struct
- qcom: add sm6125, MSM8939 fix for channel exhaustion
- microchip: add support for polarfire controller
- misc: cosmetic changes to bcm-2835,flexrm,pdc, arm-mhu and hisilicon

----------------------------------------------------------------
Bjorn Andersson (1):
      MAINTAINERS: Add dt-bindings to mailbox entry

Chun-Kuang Hu (3):
      mailbox: mtk-cmdq: Remove cmdq_cb_status
      mailbox: mtk-cmdq: Use mailbox rx_callback
      mailbox: mtk-cmdq: Add struct cmdq_pkt in struct cmdq_cb_data

Conor Dooley (4):
      dt-bindings: add bindings for polarfire soc mailbox
      mbox: add polarfire soc system controller mailbox
      dt-bindings: add bindings for polarfire soc system controller
      MAINTAINERS: add entry for polarfire soc mailbox

Dan Carpenter (1):
      mailbox: mtk-cmdq: Fix uninitialized variable in cmdq_mbox_flush()

Hao Fang (1):
      mailbox: hisilicon: Use the correct HiSilicon copyright

Martin Botka (2):
      dt-bindings: mailbox: Add binding for sm6125
      mailbox: qcom-apcs: Add SM6125 compatible

Nathan Chancellor (1):
      mailbox: imx: Avoid using val uninitialized in imx_mu_isr()

Peng Fan (4):
      dt-bindings: mailbox: imx-mu: add i.MX8ULP MU support
      mailbox: imx: replace the xTR/xRR array with single register
      mailbox: imx: add xSR/xCR register array
      mailbox: imx-mailbox: support i.MX8ULP MU

Shawn Guo (3):
      dt-bindings: mailbox: qcom: Add MSM8939 APCS compatible
      mailbox: qcom: Use PLATFORM_DEVID_AUTO to register platform device
      mailbox: qcom: Add MSM8939 APCS support

Sibi Sankar (1):
      mailbox: qcom-ipcc: Fix IPCC mbox channel exhaustion

Zhen Lei (3):
      mailbox: arm_mhu: Remove redundant error printing in mhu_probe()
      mailbox: bcm-pdc: Remove redundant error printing in pdc_probe()
      mailbox: mediatek: Remove redundant error printing in cmdq_probe()

Zhihao Cheng (2):
      mailbox: bcm2835: Remove redundant dev_err call in bcm2835_mbox_probe()
      mailbox: bcm-flexrm-mailbox: Remove redundant dev_err call in
flexrm_mbox_probe()

 .../devicetree/bindings/mailbox/fsl,mu.yaml        |   1 +
 .../mailbox/microchip,polarfire-soc-mailbox.yaml   |  47 ++++
 .../bindings/mailbox/qcom,apcs-kpss-global.yaml    |   3 +
 .../microchip,polarfire-soc-sys-controller.yaml    |  35 +++
 MAINTAINERS                                        |   9 +
 drivers/mailbox/Kconfig                            |  12 +
 drivers/mailbox/Makefile                           |   2 +
 drivers/mailbox/arm_mhu.c                          |   4 +-
 drivers/mailbox/bcm-flexrm-mailbox.c               |   1 -
 drivers/mailbox/bcm-pdc-mailbox.c                  |   1 -
 drivers/mailbox/bcm2835-mailbox.c                  |   1 -
 drivers/mailbox/hi3660-mailbox.c                   |   2 +-
 drivers/mailbox/hi6220-mailbox.c                   |   2 +-
 drivers/mailbox/imx-mailbox.c                      | 200 ++++++++++------
 drivers/mailbox/mailbox-mpfs.c                     | 251 +++++++++++++++++++++
 drivers/mailbox/mtk-cmdq-mailbox.c                 |  28 ++-
 drivers/mailbox/qcom-apcs-ipc-mailbox.c            |   8 +-
 drivers/mailbox/qcom-ipcc.c                        |   6 +
 include/linux/mailbox/mtk-cmdq-mailbox.h           |   8 +-
 include/soc/microchip/mpfs.h                       |  43 ++++
 20 files changed, 562 insertions(+), 102 deletions(-)
 create mode 100644
Documentation/devicetree/bindings/mailbox/microchip,polarfire-soc-mailbox.yaml
 create mode 100644
Documentation/devicetree/bindings/soc/microchip/microchip,polarfire-soc-sys-controller.yaml
 create mode 100644 drivers/mailbox/mailbox-mpfs.c
 create mode 100644 include/soc/microchip/mpfs.h
