Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E48339CE6B
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 11:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhFFJic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 05:38:32 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:57213 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229962AbhFFJia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 05:38:30 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id E83565C00DB;
        Sun,  6 Jun 2021 05:36:40 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sun, 06 Jun 2021 05:36:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=LJcFNkqkwBNMBLl3DFLZ1dS+fa
        kHnDWkRd6GlAOn3lo=; b=OILKlS5oLwBhgpURjfVoumk5v8MmeuviTO0jszfl8c
        MXPCj14y/W5hDMzqJjdJfspVvkapQ7wqiEzk7gLNJonosxcgLNuobLNj6j08O0qy
        smdNch3VW1BZ4emxiVgBXZnoeJYLksP6DLOKnVPRGbSNObRj0gzGv1P976dWmfYK
        vVy3Ethd3xmBuz2TY80qDZrxUoZrMvhlgc9VxB4YymMRcIA5AzwHeRtY07R76Kz7
        7D2oBcunxtUttgNwKtdVba0yKwyxD7RL29X6s7QY6eBURQvTjt6HERdMQklK+pTM
        gFivZKe5Uqmu9eVMcCekIMim22Zw9evt60gUc9rmFxJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=LJcFNkqkwBNMBLl3D
        FLZ1dS+fakHnDWkRd6GlAOn3lo=; b=rrvgsUdsYtZLKAsoVumCXOPivchcgSA5t
        oVDNQSehz5uEpcrCgoHPiL/2ZsoChXNM+oYP+zi0azlTgWMpG0llzb7AwlwOhqBX
        g5K13h21hMvG54/m5eKYOGAJ/49VLis++Nk6jBtUSmVtw1LW1Jm2EIRE5Pxe+L8I
        yZDayG17BD8OFYRTHuNk1o9//WJiJF1UJmh6BBj++YWlmcCKdjGxYkMBdXQigcW/
        vN2ZXvpF9SsrFwHS8KQ+nphUgqlDU5/o9AXn1Y3cYLm1WIAs8FTjRysnAKPtR9xC
        MZrNwSudrlHdbKNGjwDPEN+gyiMI+L20qbYb0tYajvM6oaj3EOY+A==
X-ME-Sender: <xms:KJe8YKieZWyvgX_QeqACrwBaxpjC8ZAybhsOZJdE5cz7Fb5pdoeOoA>
    <xme:KJe8YLCZpa5p0wYUBSSBvDir2oZJOOmMg57B_hN_t-wjQOpmxH7ZyYpZZT48cu3GC
    sBy3c3HdFGvE1bNNss>
X-ME-Received: <xmr:KJe8YCHoNmp6weGsJsvh0IP50CLgFoAeoAGUwIrJ4hfld20lA9KL6oRrwixsHx4UGRpvvgo9uDIq_Bxmx5qzI7rUxBKgsFh4Mv9_Fv6KePCioGB3n7ZA6tchPD5uDA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfedthedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcurfgv
    thgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvghrnh
    epuefgleekvddtjefffeejheevleefveekgfduudfhgefhfeegtdehveejfefffffgnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvghnse
    hsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:KJe8YDToPW8W6SDWLEqsEN9Wlbw3dT-ZyWgzytmRsUFpIe_yybQ9yw>
    <xmx:KJe8YHxaLmB45_pdM6Vb_8yz7LHoXiNpAm0C4qReWIgfyWWYG40woQ>
    <xmx:KJe8YB6LPgz5ps87rCwoZbFgcj9yuQhYq04oHJm1CGFBdRwIZAv-cQ>
    <xmx:KJe8YJutV8hBCqd_SSIknHcrZRVMSBrXFfAN8cr3ikndsQm6g6bOFw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 6 Jun 2021 05:36:39 -0400 (EDT)
From:   Sven Peter <sven@svenpeter.dev>
To:     linux-usb@vger.kernel.org
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Sven Peter <sven@svenpeter.dev>
Subject: [PATCH] usb: dwc3: support 64 bit DMA in platform driver
Date:   Sun,  6 Jun 2021 11:36:29 +0200
Message-Id: <20210606093629.69786-1-sven@svenpeter.dev>
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

 drivers/usb/dwc3/core.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index b6e53d8212cd..ef6bb6aaffd8 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1545,6 +1545,21 @@ static int dwc3_probe(struct platform_device *pdev)
 
 	dwc3_get_properties(dwc);
 
+	/* Try to set 64-bit DMA first */
+	if (WARN_ON(!dwc->sysdev->dma_mask))
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

