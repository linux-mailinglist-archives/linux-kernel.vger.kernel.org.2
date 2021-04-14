Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA71735EB09
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 04:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346532AbhDNClZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 22:41:25 -0400
Received: from inva020.nxp.com ([92.121.34.13]:48108 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232053AbhDNClX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 22:41:23 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 52F841A11F8;
        Wed, 14 Apr 2021 04:41:01 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 0C06B1A11E4;
        Wed, 14 Apr 2021 04:40:59 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id A8AA14029F;
        Wed, 14 Apr 2021 04:40:55 +0200 (CEST)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     shawnguo@kernel.org
Cc:     l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: imx8mq-evk: add one regulator used to power up
Date:   Wed, 14 Apr 2021 10:26:13 +0800
Message-Id: <1618367174-30968-1-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The other two patches are accepted into PCIe tree.
It's time to post it for Shawn to pick up into the imx DT tree.
https://patchwork.kernel.org/project/linux-pci/patch/1616661882-26487-3-git-send-email-hongxing.zhu@nxp.com/

arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 1 +
1 file changed, 1 insertion(+)

[PATCH] arm64: dts: imx8mq-evk: add one regulator used to power up
