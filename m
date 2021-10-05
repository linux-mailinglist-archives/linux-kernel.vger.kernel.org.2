Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA627422845
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 15:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234746AbhJENvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 09:51:12 -0400
Received: from comms.puri.sm ([159.203.221.185]:43642 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234546AbhJENvK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 09:51:10 -0400
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 4B123E1246;
        Tue,  5 Oct 2021 06:49:20 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ONHSrioEtsBP; Tue,  5 Oct 2021 06:49:19 -0700 (PDT)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     martin.kepplinger@puri.sm
Cc:     devicetree@vger.kernel.org, festevam@gmail.com,
        kernel@pengutronix.de, kernel@puri.sm,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, robh@kernel.org, shawnguo@kernel.org
Subject: [PATCH v2 0/7] arm64: dts: imx8mq-librem5: wifi updates and minor fixes
Date:   Tue,  5 Oct 2021 15:48:55 +0200
Message-Id: <20211005134902.2138731-1-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

revision history
----------------
v2: (thank you Shawn)
* don't set the wifi-3v3 regulator to always-on
* add a patch to improve the volume buttons debounce interval

v1:
* https://lore.kernel.org/phone-devel/20210913135706.309685-1-martin.kepplinger@puri.sm/

Angus Ainslie (3):
  arm64: dts: imx8mq-librem5: delay the startup of the SDIO
  arm64: dts: imx8mq-librem5: add power sequencing for M.2 cards
  arm64: dts: imx8mq-librem5: Limit the max sdio frequency

Guido Günther (1):
  arm64: dts: imx8mq-librem5: wire up the wifi regulator

Martin Kepplinger (1):
  arm64: dts: imx8mq-librem5: add reset gpio to mantix panel description

Sebastian Krzyszkowiak (2):
  arm64: dts: imx8mq-librem5: Fix led_r and led_g pinctrl assignments
  arm64: dts: imx8mq-librem5: set debounce interval of volume buttons to
    50ms

 .../boot/dts/freescale/imx8mq-librem5.dtsi    | 44 ++++++++++++++++++-
 1 file changed, 42 insertions(+), 2 deletions(-)

-- 
2.30.2

