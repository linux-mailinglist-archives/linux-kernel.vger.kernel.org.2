Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7635C39CE99
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 12:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbhFFKix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 06:38:53 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:41669 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229465AbhFFKiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 06:38:51 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 0D2875C010A;
        Sun,  6 Jun 2021 06:37:02 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sun, 06 Jun 2021 06:37:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=SmKvFMjBu/a0urc3RGRKw51AD7
        PuMxYFcgBohA05z0Q=; b=jnwCt1OcYp2RG/uWgT/Rt3w7wgw4B2lwS7sHkOzlUv
        CefOnLcPw7by9k4yrLYL5ehhn2PnB6kEGyVFwfL7YzrZl04m1olk6snXhiXck4/N
        5AP1G9ec6LzKzwJ2P9pDe0LXb+rBYxH8HhtAj+iM22WJ9q0eaNvYA9BghAAPDv+p
        cJ5g9qaul3ShkI2WYl9PpXE1bsIHdTMQMURmOBynxxILgrBgZa1Ugdxy5Hrtkbl2
        xgs7Ew6Zr/0H0bIPPQiDsCCl9I40nt7+oXB8uATlqJZoaIE1KPWjI08VQypsqrpQ
        bdilQyEMy9vnFK7hWDQdmSR2kPa2YbOxgiyuiVAUPhQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=SmKvFMjBu/a0urc3R
        GRKw51AD7PuMxYFcgBohA05z0Q=; b=QaZkEO0AMDpdG4MxgVJ99h6pmiuLSGFle
        ZRdS3yi0DzltUhWhjjcSme1auYJ7WvVouXcJkfu4CJK31rFnxJ2FBPMclOZ2N0+F
        rmwVFgXsWrQeb8jplkoi+WeMrDYOnOMauk/1QnsKuCibrdv/UDAPGv8shILU884h
        /SkT79ISXyZRYtDkfNod3hZMUyaPCzkHTxlliAVYZj40Iu48SnEONteBHDW0rFlM
        ZhzpP7NzvzelGqjlaF7P5q8RHyUleE9yHf2KX68unZ/F8SI+KehJYcfI5MIkBxhl
        E3op1/XqYFeC1sC9FdXlMSinX8aNyXLXWdaNBKnkMEwlK6be6uLLQ==
X-ME-Sender: <xms:TaW8YInKjia9Eai-raIGrcsntvLUVXq-pbTf-ENaFwTETXj3NpaLhg>
    <xme:TaW8YH1uBYFFQH3M-5yTXvXLfC3ipz15f3-Im_S2KIsT7s4_6u74r3iT9y4hXiOsv
    rUDJPfX5sD8Q1bbnPU>
X-ME-Received: <xmr:TaW8YGqxMAlb8metNJ4-jaaojZ2iXP3o3B9GrbJyroGCXtonXngAm3ciuvtCIDKpzWl4dDiRlDfnmF63Mz8fsOMWuGa1y6YeX6_o7hTd_vSTZW0-wNcfr28Hhnvjig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfedthedgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcurfgv
    thgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvghrnh
    epuefgleekvddtjefffeejheevleefveekgfduudfhgefhfeegtdehveejfefffffgnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvghnse
    hsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:TaW8YEkyvGfZHCdIoGvY9GloZHsOyIlv824QYpdL4TctcSbjLNqrLw>
    <xmx:TaW8YG3D3iUT8_xcVnCDi4-LrtAvQk4DplUoS2jovSwz1Loc6V6HZQ>
    <xmx:TaW8YLu_z3IfV_nR4nU0bXT8b3n3yZ106c_e6ntBTPgxX6SobqYFcg>
    <xmx:TaW8YJSEqimqUrWBj_DHQh813m1NW07hnSAwa_KEpSY9Dqu6xq3Zvg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 6 Jun 2021 06:37:00 -0400 (EDT)
From:   Sven Peter <sven@svenpeter.dev>
To:     linux-usb@vger.kernel.org
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Sven Peter <sven@svenpeter.dev>
Subject: [PATCH v2] usb: dwc3: support 64 bit DMA in platform driver
Date:   Sun,  6 Jun 2021 12:36:56 +0200
Message-Id: <20210606103656.71079-1-sven@svenpeter.dev>
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

Fix this by using the same logic already present in xhci-plat.c:
First, try to set a coherent dma mask for 64-bit, and then attempt
again with a 32-bit mask if this fails.

Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
I have taken the code directly from the xhci-plat.c driver so
I think this change should be fairly low risk.
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

changes from v1:
 - removed WARN_ON around !dwc->sysdev->dma_mask; pointed out by greg k-h

 drivers/usb/dwc3/core.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index b6e53d8212cd..4930541a8984 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1545,6 +1545,21 @@ static int dwc3_probe(struct platform_device *pdev)
 
 	dwc3_get_properties(dwc);
 
+	/* Try to set 64-bit DMA first */
+	if (!dwc->sysdev->dma_mask)
+		/* Platform did not initialize dma_mask */
+		ret = dma_coerce_mask_and_coherent(dwc->sysdev,
+						   DMA_BIT_MASK(64));
+	else
+		ret = dma_set_mask_and_coherent(dwc->sysdev, DMA_BIT_MASK(64));
+
+	/* If seting 64-bit DMA mask fails, fall back to 32-bit DMA mask */
+	if (ret) {
+		ret = dma_set_mask_and_coherent(dwc->sysdev, DMA_BIT_MASK(32));
+		if (ret)
+			return ret;
+	}
+
 	dwc->reset = devm_reset_control_array_get_optional_shared(dev);
 	if (IS_ERR(dwc->reset))
 		return PTR_ERR(dwc->reset);
-- 
2.25.1

