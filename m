Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3283371F6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 13:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232947AbhCKMD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 07:03:57 -0500
Received: from comms.puri.sm ([159.203.221.185]:39046 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232898AbhCKMDs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 07:03:48 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id D8843E0D6A;
        Thu, 11 Mar 2021 04:03:17 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id AR2PfVArswsy; Thu, 11 Mar 2021 04:03:16 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     robh@kernel.org, shawnguo@kernel.org, kernel@pengutronix.de,
        festevam@gmail.com, krzk@kernel.org
Cc:     kernel@puri.sm, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH 0/3] Librem 5 phone dts fixes
Date:   Thu, 11 Mar 2021 13:02:56 +0100
Message-Id: <20210311120259.3310499-1-martin.kepplinger@puri.sm>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two fixes for the Librem 5 phone descriptions and one resend of
https://lore.kernel.org/linux-arm-kernel/20200915141622.14736-1-festevam@gmail.com/
that enables the hantro vpu staging driver. Feel free to ignore that one
if we want to wait for it to be out of staging.

Fabio Estevam (1):
  arm64: defconfig: Enable the Hantro decoder

Guido Günther (1):
  arm64: dts: imx8mq-librem5: Hog the correct gpio

Sebastian Krzyszkowiak (1):
  arm64: dts: imx8mq-librem5-r3: Mark buck3 as always on

 arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dts | 4 ++++
 arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi   | 3 ++-
 arch/arm64/configs/defconfig                        | 3 +++
 3 files changed, 9 insertions(+), 1 deletion(-)

-- 
2.30.1

