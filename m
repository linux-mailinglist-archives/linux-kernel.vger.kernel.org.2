Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70EFE30625F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 18:44:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344094AbhA0Rnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 12:43:31 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60956 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344069AbhA0Rlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 12:41:32 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 123291F44AA5
Received: by jupiter.universe (Postfix, from userid 1000)
        id E978A4800BC; Wed, 27 Jan 2021 18:40:47 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCH 0/2] Add i.MX51/i.MX53 serial number support
Date:   Wed, 27 Jan 2021 18:40:22 +0100
Message-Id: <20210127174024.170408-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This complements support for reading the unique ID / serial
number on i.MX by adding the feature for i.MX51 and i.MX53.
This has been tested on i.MX53. I also added support for
i.MX51 since it uses exactly the same registers according
to its datasheet.

I did not add support for older i.MX processor. They also have
an IIM IP-core, but their datasheet does not contain information
about the unique ID registers and I do not have the hardware for
testing.

-- Sebastian

Sebastian Reichel (2):
  ARM: dts: imx: Mark IIM as syscon on i.MX51/i.MX53
  soc: imx: add i.MX51/i.MX53 unique id support

 arch/arm/boot/dts/imx51.dtsi |  2 +-
 arch/arm/boot/dts/imx53.dtsi |  2 +-
 drivers/soc/imx/soc-imx.c    | 12 ++++++++++++
 3 files changed, 14 insertions(+), 2 deletions(-)

-- 
2.29.2

