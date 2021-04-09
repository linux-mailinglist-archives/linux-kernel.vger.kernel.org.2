Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77DBF359D92
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 13:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233472AbhDILkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 07:40:43 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:41538 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233316AbhDILkj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 07:40:39 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id B153CFB03;
        Fri,  9 Apr 2021 13:40:24 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id xwtZgkfuU3mX; Fri,  9 Apr 2021 13:40:22 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 8E68640622; Fri,  9 Apr 2021 13:40:21 +0200 (CEST)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Robert Chiras <robert.chiras@nxp.com>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Liu Ying <victor.liu@nxp.com>
Subject: [PATCH v5 0/2] phy: fsl-imx8-mipi-dphy: Hook into runtime pm
Date:   Fri,  9 Apr 2021 13:40:19 +0200
Message-Id: <cover.1617968250.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows us to shut down the mipi power domain on the imx8. The alternative
would be to drop the dphy from the mipi power domain in the SOCs device tree
and only have the DSI host controller visible there but since the PD is mostly
about the PHY that would defeat it's purpose.

This allows to shut off the power domain when blanking the LCD panel:

pm_genpd_summary before:

domain                          status          slaves
    /device                                             runtime status
----------------------------------------------------------------------
mipi                            on
    /devices/platform/soc@0/soc@0:bus@30800000/30a00300.dphy  unsupported
    /devices/platform/soc@0/soc@0:bus@30800000/30a00000.mipi_dsi  suspended

after:

mipi                            off-0
    /devices/platform/soc@0/soc@0:bus@30800000/30a00300.dphy  suspended
    /devices/platform/soc@0/soc@0:bus@30800000/30a00000.mipi_dsi  suspended

Changes from v1:
 - Tweak commit message slightly

Changes from v2:
  - As per review comment by Lucas Stach
    https://lore.kernel.org/linux-arm-kernel/ee22b072e0abe07559a3e6a63ccf6ece064a46cb.camel@pengutronix.de/
    Check for pm_runtime_get_sync failure

Changes from v3:
  - As per review comment by Liu Ying
    https://lore.kernel.org/linux-arm-kernel/424af315b677934fe6a91cee5a0a7aee058245a9.camel@nxp.com/
    https://lore.kernel.org/linux-arm-kernel/a98f7531b9d0293d3c89174446f742d4199cb27c.camel@nxp.com/
    - Use phy layers runtime pm
    - simplify mixel_dphy_remove

Chanes from v4:
  - As per review comment by Liu Ying
    https://lore.kernel.org/linux-arm-kernel/daef1299e43f0372a95c149b979441f8083f4b15.camel@nxp.com/
    - Disable after probe errors
    - core: increment device usage count on .configure as well

Guido Günther (2):
  phy: core: Use runtime pm during configure too
  phy: fsl-imx8-mipi-dphy: Hook into runtime pm

 drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c | 13 +++++++++++++
 drivers/phy/phy-core.c                         |  6 ++++++
 2 files changed, 19 insertions(+)

-- 
2.30.1

