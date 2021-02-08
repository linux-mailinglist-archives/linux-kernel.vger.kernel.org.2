Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1976331331C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 14:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbhBHNRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 08:17:42 -0500
Received: from comms.puri.sm ([159.203.221.185]:42116 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230295AbhBHNQs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 08:16:48 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 30A12DFFF7;
        Mon,  8 Feb 2021 05:15:57 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id LWHEobv7BPLj; Mon,  8 Feb 2021 05:15:56 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     robh@kernel.org, shawnguo@kernel.org, kernel@pengutronix.de,
        festevam@gmail.com
Cc:     kernel@puri.sm, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH 0/5] arm64: dts: librem5 phone and devkit dts and config updates
Date:   Mon,  8 Feb 2021 14:15:22 +0100
Message-Id: <20210208131527.24463-1-martin.kepplinger@puri.sm>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Small updates to Purism hardware in order to maintain support:

Angus Ainslie (1):
  arm64: dts: librem5: protect some partitions of the nor-flash

Guido Günther (3):
  arm64: dts: imx8mq-librem5-devkit: Drop buck3 startup-ramp-delay
  arm64: dts: librem5: Drop assigned-clocks from SAI2
  arm64: defconfig: Enable devfreq support for i.MX8MQ

Martin Kepplinger (1):
  arm64: dts: imx8mq-librem5-r2: set nearlevel to 120

 .../dts/freescale/imx8mq-librem5-devkit.dts    |  1 -
 .../boot/dts/freescale/imx8mq-librem5-r2.dts   |  2 +-
 .../boot/dts/freescale/imx8mq-librem5.dtsi     | 18 ++++++++++++++++--
 arch/arm64/configs/defconfig                   |  2 ++
 4 files changed, 19 insertions(+), 4 deletions(-)

-- 
2.20.1

