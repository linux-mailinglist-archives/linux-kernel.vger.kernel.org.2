Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26CE733CCDD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 06:05:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235145AbhCPFFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 01:05:13 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:41706 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234426AbhCPFFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 01:05:07 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4F01SK6TTNz1qs3T;
        Tue, 16 Mar 2021 06:05:05 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4F01SK6Bf2z1qqkh;
        Tue, 16 Mar 2021 06:05:05 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id w4rmjvsVUshn; Tue, 16 Mar 2021 06:05:04 +0100 (CET)
X-Auth-Info: aLSrzGs8CD9q6+afJkYEIzMZFzcAUbJ/YSaTsBquJNU=
Received: from mail-internal.denx.de (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue, 16 Mar 2021 06:05:04 +0100 (CET)
Received: from pollux.denx.de (pollux [192.168.1.1])
        by mail-internal.denx.de (Postfix) with ESMTP id 5FD7118531D;
        Tue, 16 Mar 2021 06:04:28 +0100 (CET)
Received: by pollux.denx.de (Postfix, from userid 515)
        id 557371A0092; Tue, 16 Mar 2021 06:04:28 +0100 (CET)
From:   Heiko Schocher <hs@denx.de>
To:     linux-spi@vger.kernel.org
Cc:     Heiko Schocher <hs@denx.de>, linux-arm-kernel@lists.infradead.org,
        Ashish Kumar <ashish.kumar@nxp.com>,
        Kuldeep Singh <kuldeep.singh@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Yogesh Gaur <yogeshgaur.83@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] spi: fspi: enable fspi driver for on imx8mp
Date:   Tue, 16 Mar 2021 06:04:24 +0100
Message-Id: <20210316050425.1758778-2-hs@denx.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210316050425.1758778-1-hs@denx.de>
References: <20210316050425.1758778-1-hs@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add compatible entry in nxp_fspi driver for imx8mp.

Signed-off-by: Heiko Schocher <hs@denx.de>
  into own series as Kuldeep suggested and rebased against
  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
  144c79ef33536 ("Merge tag 'perf-tools-fixes-for-v5.12-2020-03-07' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux")

---

Changes in v3:
- seperate spi changes from series:
  http://lists.infradead.org/pipermail/linux-arm-kernel/2021-March/643289.html

Changes in v2:
- work in comments from Marco
  add own compatible entry for imx8mp

 drivers/spi/spi-nxp-fspi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index ab9035662717a..19ce4a854cc97 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -1151,6 +1151,7 @@ static int nxp_fspi_resume(struct device *dev)
 static const struct of_device_id nxp_fspi_dt_ids[] = {
 	{ .compatible = "nxp,lx2160a-fspi", .data = (void *)&lx2160a_data, },
 	{ .compatible = "nxp,imx8mm-fspi", .data = (void *)&imx8mm_data, },
+	{ .compatible = "nxp,imx8mp-fspi", .data = (void *)&imx8mm_data, },
 	{ .compatible = "nxp,imx8qxp-fspi", .data = (void *)&imx8qxp_data, },
 	{ /* sentinel */ }
 };
-- 
2.29.2

