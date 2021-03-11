Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5010336ECE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 10:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbhCKJZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 04:25:38 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:51684 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231639AbhCKJZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 04:25:32 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1lKHZR-0002Ad-Ob; Thu, 11 Mar 2021 09:25:29 +0000
From:   Colin King <colin.king@canonical.com>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] usb: mtu3: Fix spelling mistake "disabed" -> "disabled"
Date:   Thu, 11 Mar 2021 09:25:29 +0000
Message-Id: <20210311092529.4898-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable u3_ports_disabed contains a spelling mistake,
rename it to u3_ports_disabled.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/usb/mtu3/mtu3_host.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/mtu3/mtu3_host.c b/drivers/usb/mtu3/mtu3_host.c
index c871b94f3e6f..41a5675ac5ca 100644
--- a/drivers/usb/mtu3/mtu3_host.c
+++ b/drivers/usb/mtu3/mtu3_host.c
@@ -109,7 +109,7 @@ int ssusb_host_enable(struct ssusb_mtk *ssusb)
 	void __iomem *ibase = ssusb->ippc_base;
 	int num_u3p = ssusb->u3_ports;
 	int num_u2p = ssusb->u2_ports;
-	int u3_ports_disabed;
+	int u3_ports_disabled;
 	u32 check_clk;
 	u32 value;
 	int i;
@@ -118,10 +118,10 @@ int ssusb_host_enable(struct ssusb_mtk *ssusb)
 	mtu3_clrbits(ibase, U3D_SSUSB_IP_PW_CTRL1, SSUSB_IP_HOST_PDN);
 
 	/* power on and enable u3 ports except skipped ones */
-	u3_ports_disabed = 0;
+	u3_ports_disabled = 0;
 	for (i = 0; i < num_u3p; i++) {
 		if ((0x1 << i) & ssusb->u3p_dis_msk) {
-			u3_ports_disabed++;
+			u3_ports_disabled++;
 			continue;
 		}
 
@@ -140,7 +140,7 @@ int ssusb_host_enable(struct ssusb_mtk *ssusb)
 	}
 
 	check_clk = SSUSB_XHCI_RST_B_STS;
-	if (num_u3p > u3_ports_disabed)
+	if (num_u3p > u3_ports_disabled)
 		check_clk = SSUSB_U3_MAC_RST_B_STS;
 
 	return ssusb_check_clocks(ssusb, check_clk);
-- 
2.30.2

