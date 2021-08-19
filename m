Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB7EB3F22C3
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 00:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236290AbhHSWKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 18:10:48 -0400
Received: from mout.perfora.net ([74.208.4.197]:54675 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236264AbhHSWKm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 18:10:42 -0400
Received: from toolbox.cardiotech.int ([81.221.236.183]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0M2KRe-1n6KM03lPI-00s7R5;
 Fri, 20 Aug 2021 00:09:37 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        Anson Huang <Anson.Huang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Otavio Salvador <otavio@ossystems.com.br>,
        Pascal Zimmermann <pzimmermann@dh-electronics.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/9] ARM: imx_v6_v7_defconfig: build imx sdma driver as module
Date:   Fri, 20 Aug 2021 00:09:06 +0200
Message-Id: <20210819220910.586819-6-marcel@ziswiler.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210819220910.586819-1-marcel@ziswiler.com>
References: <20210819220910.586819-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:3UAjtgUz913fX67ebkze3QF6tbHSYycM31CoroOgu81Tt8OOJQG
 N2LB5dvr5QPHEx3bHcULPHVa1GXwJK0g36TdrSAuZB4bxQtKXtTQquIc9BT4K26atVDWdrt
 TF1iWeJ1+qzCeOHbdB9+4g47E9Jlb7Nlz8g5nVdEdAkLcEJYr0FCiO4BvqO/01PZkwr4bk0
 26nz8HCV8yl3OEL6wg1OQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:/Iw8wXd/gB4=:g5PQteB83BeXmTSQ5Q2oCw
 q6djUcPFj061kvpyqc60YBXkIm08hE5U9bMDpiJij2fuN+mJmMmlLz9K8bLjdYbxb1SigDlge
 7f+WHKbQZp8b89g38tJzknHMlidIT4DI2i2K7LRK9Q/7YXQ3PlezkK5iqQ3R9nSE0XEKPNIPu
 QSqrMrXlgrZJ+G7ksVJbcUno01cai4HQANX9jxuWoWDItUL52dpAeUJRbqkStCxuc7JIzmNn2
 6yNj7ZK7Y0yZ/PuJMH/41eDYtSTGrTdkVGcd2FIDY7f5nQgPPZqnMre4FsbdpQdBjXTPfSSOF
 Vfb4UT8hq+HQFG9w4e3jHYpjEAe4DaqgHiaaSBPLCJirh7mMhTH3gvzz4IXV/XIckMFe+YYaQ
 I3L5RhRRCmOGKDF2DnER57YvprhffsRml3zuM/dNkY5TGj1icAjstrCCrjDtHVvQlttd1fs33
 goUYbkOtfAMjT0nqxYfFgT9obduyq/mLS7sy5RQuzlcnvhmaD0fVOHbic8gf8WenM3yIgTUtk
 faaex/tZakCuq9Jfd8um9NxvF8DUmkhdIQxL6p42RQi6B6kTN275AWBUnontoLNwj6ZdqLE5m
 omxHdj3WPW195nxee9/IAVek8saa83b7jkHvRm2iezuwOB14aLaiepJpKj5RyPvQa6MRw5zM4
 esuaIg/5O/V9XzONXORMbH6YrPzKYz7dWZLWOxSpCTacr1Xn5UOmS8L3vSisRiSbtyLKalpk5
 QXYffDWnrgggJCRlilyI29M6dWkE3iImeyCyLQkgBp0k/8vnGdSq4wmAw9+AMaihYgVvlDV62
 R9bOF1PqdZGb6smpe2gDaOl+UTeUwDema958+N6qqQ7XuJAo7lf7ZQRSUViSdPx9FEXhWZW
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Build CONFIG_IMX_SDMA as a module to avoid the following boot issue:

[    5.214751] imx-sdma 20ec000.sdma: Direct firmware load for
 imx/sdma/sdma-imx6q.bin failed with error -2
[    5.215762] imx-sdma 20ec000.sdma: Falling back to sysfs fallback
 for: imx/sdma/sdma-imx6q.bin

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

(no changes since v1)

 arch/arm/configs/imx_v6_v7_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 21803cd2d1ba7..c0008b7faf2ce 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -380,7 +380,7 @@ CONFIG_RTC_DRV_MXC_V2=y
 CONFIG_RTC_DRV_SNVS=y
 CONFIG_DMADEVICES=y
 CONFIG_FSL_EDMA=y
-CONFIG_IMX_SDMA=y
+CONFIG_IMX_SDMA=m
 CONFIG_MXS_DMA=y
 CONFIG_DMATEST=m
 CONFIG_STAGING=y
-- 
2.26.2

