Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C552239D4D6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 08:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbhFGGTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 02:19:51 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:47551 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229436AbhFGGTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 02:19:48 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 5890E1652;
        Mon,  7 Jun 2021 02:17:57 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 07 Jun 2021 02:17:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=HoJ4ww4xZ6xdvjHoZ4iHbUzz9m
        LoUDTInfZZuqlp+s4=; b=MukYE+aow5Vg4ecUV7a8wV8d/hIWNu8A9Dd6nWIj+Y
        pChv0fc+3txFQd88BYiJTFKaG0e0ZyxnzLCAfeLw3qVlDOV+lb82OtZS7g+ZlrKv
        sBHOyi1FtkM2p7V4nhQysPq2zFGXujO9YMSRIm0l41/X3XUHxfhDVtmFfJ1tcBO9
        0p2BcLNPitPELPttIzwMiOCDm8GN2lcJoABabnRM597AA4R2sltHbzAX1UtOLQK2
        bXZenB+FtHI0pEuAQqpqdYKvMXkf9TYYXcGpqKc9IXDdN2nZsE4G7692PjWd5UIE
        Q/DXzdFsDtuSHlLjdjU9jkdu3/Iye0BeLmctVgBilXbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=HoJ4ww4xZ6xdvjHoZ
        4iHbUzz9mLoUDTInfZZuqlp+s4=; b=HNDDrP2EP2yDUxMLAkIzaCqmEHo5PZhv6
        MrXqr6YaHRu2frLiPcvxSROZ2zFApOIMOF32efAVO2bXHi1vuSX4HveKaAOHil3z
        6Srk7r23xXesj/ddVAsuD7Vf0bRrc+aW3JeX4whIV0Lj4JtMZnM9B3N3DvmrdBzk
        DZ1/gGVTULgBMtpRr2opsu/0YizV3AQiUF+PWtgGJK56I/y1b+4hkZ3XVdKjA1Hr
        jBuf3TiFz6Ywk5VmX31jOFMljwozpbzpENkpitWyFIJ5MT+Gz6Df3dJX54o0qNgI
        SD5EqUqBi2edpF003+jU9AdZ+uuNLlSX6+5wt0UhfG81YT6DYBJQQ==
X-ME-Sender: <xms:E7q9YMm8Lp8GCgHF_Zkj86M9F1wM1TUC1DUTdhVpvIkbH3_dgJ_y6g>
    <xme:E7q9YL0TxWPDcoB1Ngdc6UNu6GVEPNHdPJ0eeO1G3x9oPsRFA2fzYgO2g_BnGtNSg
    Jq0A6qF4mj3buWn5pQ>
X-ME-Received: <xmr:E7q9YKqNQZpWJdDp8YNR7Nbj21F8ovtkqb_vOTeddq-6z7ltDmy-MmnqArJKgRf0KRaDXL-BwqBlK9RrGPqlWv3nuge3pF0gubNXR7wL7cLGes-Md6j7S0h8wRPwOg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfedtiedguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepufhvvghnucfr
    vghtvghruceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrghtthgvrh
    hnpeeugfelkedvtdejffefjeehveelfeevkefgudduhfeghfefgedtheevjeefffffgfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsvhgvnh
    esshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:E7q9YIl5y9xoBp3K4u5KM5z2Kxcd1PYndO4A7dtrAMWgbuKRdaUpdA>
    <xmx:E7q9YK2ZY-Y0VLEQJPyWMXiyCrv8gN-gv3_E_1DetdgiAgcFTtQFsA>
    <xmx:E7q9YPt43MZ70YdAdE98HoGMUoASpvfbu1sostcRVan2vu0zGq96Wg>
    <xmx:FLq9YNSs2M76UzRz45K4odCGw8Y2GiLMq2tGyKfimrQZBRmBof7WVQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Jun 2021 02:17:54 -0400 (EDT)
From:   Sven Peter <sven@svenpeter.dev>
To:     linux-usb@vger.kernel.org
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Sven Peter <sven@svenpeter.dev>
Subject: [PATCH v3] usb: dwc3: support 64 bit DMA in platform driver
Date:   Mon,  7 Jun 2021 08:17:51 +0200
Message-Id: <20210607061751.89752-1-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the dwc3 platform driver does not explicitly ask for
a DMA mask. This makes it fall back to the default 32-bit mask which
breaks the driver on systems that only have RAM starting above the
first 4G like the Apple M1 SoC.

Fix this by calling dma_set_mask_and_coherent with a 64bit mask.

Signed-off-by: Sven Peter <sven@svenpeter.dev>
---

Third time's a charm I hope - this time much simpler :)

I still think this change should be fairly low risk.

Unfortunately I only have the Apple M1 to test this on but here
the driver still works with the iommu enabled which limits the
address space to 32 bit. It also enables to use this with the iommu
in bypass mode which requires 64 bit addresses.

I believe this has been working fine so far since the dwc3 driver
only uses a few very small buffers in host mode which might still
fit within the first 4G of address space on many devices. The
majority of DMA buffers are allocated inside the xhci driver which
will already call dma_set_mask_and_coherent.

Best,

Sven


changes from v2:
 - remove both dma_coerce_mask_and_coherent and the 32 bit
   dma_set_mask_and_coherent as pointed out by Arnd Bergmann
changes from v1:
 - removed WARN_ON around !dwc->sysdev->dma_mask; pointed out by greg k-h

 drivers/usb/dwc3/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index b6e53d8212cd..ba4792b6a98f 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1545,6 +1545,10 @@ static int dwc3_probe(struct platform_device *pdev)
 
 	dwc3_get_properties(dwc);
 
+	ret = dma_set_mask_and_coherent(dwc->sysdev, DMA_BIT_MASK(64));
+	if (ret)
+		return ret;
+
 	dwc->reset = devm_reset_control_array_get_optional_shared(dev);
 	if (IS_ERR(dwc->reset))
 		return PTR_ERR(dwc->reset);
-- 
2.25.1

