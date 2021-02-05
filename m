Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8A9D310ACE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 13:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbhBEMAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 07:00:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:36286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232080AbhBEL5E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 06:57:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EB83664DD8;
        Fri,  5 Feb 2021 11:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612526182;
        bh=6XQfoFcWVQ7lpxDlsOWaLGDMZ/yYyqqNNqmFAKs4PMk=;
        h=Date:From:To:Cc:Subject:From;
        b=c/B1vV7fU2bylD1f5Hs8288hblkusrJYINEyHXs8f+cNwUXaQFGWGfMibICxNXdO8
         DdHsoRBklVRufwXJ/aYwuUuFSz+oFz4C+K+tOFxNYqTKdfj9V8eb0IOPw/jRUIWHzS
         DEH2cG4IElWaPLvr4SNk2/mTJXwtqumuaQ/ItxqXBa/h/6Ug3ATsYmqkSdp4O0PTTU
         WLc0r8/1Bqr4LEboY4FVxPvswYpXEuLmrT9EEMon4RoQKWLlyVhBjAIsgAUmNqW0Ng
         HD4kDPgoyQndnISeCTQ81qpsQaZTjj9RHyw+oEKQDedHwz3sbYM8Fa4LGkl7yFsDb4
         bdmaDgHTSnmjQ==
Date:   Fri, 5 Feb 2021 17:26:18 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-phy@lists.infradead.org
Subject: [GIT PULL] phy: second round of fixes for v5.11
Message-ID: <20210205115618.GG2656@vkoul-mobl.Dlink>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

Please pull to receive few phy driver fixes for v5.11.
Apologies for sending them bit late.

The following changes since commit d092bd9110494de3372722b317510b3692f1b2fe:

  phy: mediatek: allow compile-testing the dsi phy (2021-01-04 13:00:54 +0530)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-fixes2-5.11

for you to fetch changes up to 9a8b9434c60f40e4d2603c822a68af6a9ca710df:

  phy: mediatek: Add missing MODULE_DEVICE_TABLE() (2021-02-04 13:37:37 +0530)

----------------------------------------------------------------
phy: second round of phy fixes for v5.11

 - rockchip: init return and vednor prefix to dt-property
 - cpcap: bool conversion fix
 - lantiq: clock enable fix
 - lgm: kconfig depends on x86
 - mediatek: add mising MODULE_DEVICE_TABLE()

----------------------------------------------------------------
Boris Brezillon (1):
      phy: mediatek: Add missing MODULE_DEVICE_TABLE()

Chris Ruehl (3):
      phy: rockchip-emmc: emmc_phy_init() always return 0
      devicetree: phy: rockchip-emmc optional add vendor prefix
      phy: rockchip: emmc, add vendor prefix to dts properties

Geert Uytterhoeven (1):
      phy: USB_LGM_PHY should depend on X86

Mathias Kresin (1):
      phy: lantiq: rcu-usb2: wait after clock enable

Tian Tao (1):
      phy: cpcap-usb: remove unneeded conversion to bool

Yang Li (1):
      phy: phy-brcm-sata: remove unneeded semicolon

 Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt | 10 +++++-----
 drivers/phy/Kconfig                                         |  1 +
 drivers/phy/broadcom/phy-brcm-sata.c                        |  2 +-
 drivers/phy/lantiq/phy-lantiq-rcu-usb2.c                    | 10 +++++++++-
 drivers/phy/mediatek/phy-mtk-hdmi.c                         |  1 +
 drivers/phy/mediatek/phy-mtk-mipi-dsi.c                     |  1 +
 drivers/phy/motorola/phy-cpcap-usb.c                        |  2 +-
 drivers/phy/rockchip/phy-rockchip-emmc.c                    | 12 +++++++-----
 8 files changed, 26 insertions(+), 13 deletions(-)

-- 
~Vinod
