Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2004005A9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 21:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351005AbhICTRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 15:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244110AbhICTRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 15:17:07 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A732C0612E7
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 12:15:59 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id u16so126955wrn.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 12:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S2oJzZ74OeEcmMoVJIdNJVgmv6TrWggcYk6PbcNXqcA=;
        b=jNgwdW1p3xj0RM90Do8456wdjIRfDCsh4vybcYl2iWW2CidxOPlTp7DxXlNTl74KBY
         tLjkuBb8owrgChfEaWHrYAFpQHHG5B7o5PeAf/EHVbX/eoGDQBwmLpFoHKC0YXxsZxmh
         thko7SfHUlELsKHkemOtaMIKB0h1zLjEvjNQ7x4B/B+gHg7h4cr1mpdXfiiqWFf1iQ/j
         FuQelESiVBPAdrwIXtV756GPh5qTo4Fusd55Vy1iQV3ttTLsTz9EiXAaN5PYK0QbEmMj
         GB5rhHpDCrEd5vuE6CAEo+zKYre6I/EA351KS8QSXQuVFIABi0DNbojsD/PTLUhRZO6q
         2F+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S2oJzZ74OeEcmMoVJIdNJVgmv6TrWggcYk6PbcNXqcA=;
        b=Da5Oa1UtaEi8GlceNTlBdMXPcrlrcS2DIkte68kgH1IJZn6jmhynK2ihnaD7RItJ7v
         iQqGuN0qxLcpIiGyO3EJPGhQ7KvwxoDMKH8M83qRBJWzrXV6vD6I7wqc5fjDk4tKbo9z
         s3ImGUFokgJINLwmPB5wgsLUa2cb64bY+1xkdwFuSDL6vK+hKKJmfE1CBho1dwrsk4UW
         g++ZQ/WkAV/nJSIdNNZdArAOD1uXxv0Yf9IHcvcNzuXe6zNSkJv0sUOdRRdxKJJ/qDd7
         CBMoYW8lZWiO5+R317Pra1ITjUb9CgM86ds1zRRfHP4midq66GhZJrDXnQUO3Yg46Ggy
         ecLw==
X-Gm-Message-State: AOAM531BrxCqbKfaVgCqhTPJT4sSWsvsZt9d9cta+QkO/9GaLbRJc+jh
        OU2jyBFVNs/X8IqEaH/BY4gH2A==
X-Google-Smtp-Source: ABdhPJx9tLMskYowPxGHdc+Ey3r7w6n2qnsZASLpq17hpXjVJFgsvKBcpJUgcNgWPrLV1exSOcWOUg==
X-Received: by 2002:adf:9f51:: with SMTP id f17mr583205wrg.301.1630696558023;
        Fri, 03 Sep 2021 12:15:58 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id a133sm253397wme.5.2021.09.03.12.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 12:15:57 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     gregkh@linuxfoundation.org, mchehab@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, mjpeg-users@lists.sourceforge.net,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 7/8] staging: media: zoran: remove vidmem
Date:   Fri,  3 Sep 2021 19:15:39 +0000
Message-Id: <20210903191540.3052775-8-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210903191540.3052775-1-clabbe@baylibre.com>
References: <20210903191540.3052775-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vidmem parameter is no longer necessary since we removed framebuffer
support.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/staging/media/zoran/zoran_card.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/staging/media/zoran/zoran_card.c b/drivers/staging/media/zoran/zoran_card.c
index 7b2e1d1c4622..ed74f04994da 100644
--- a/drivers/staging/media/zoran/zoran_card.c
+++ b/drivers/staging/media/zoran/zoran_card.c
@@ -39,17 +39,6 @@ static int card[BUZ_MAX] = { [0 ... (BUZ_MAX - 1)] = -1 };
 module_param_array(card, int, NULL, 0444);
 MODULE_PARM_DESC(card, "Card type");
 
-/*
- * The video mem address of the video card. The driver has a little database
- * for some videocards to determine it from there. If your video card is not
- * in there you have either to give it to the driver as a parameter or set
- * in a VIDIOCSFBUF ioctl
- */
-
-static unsigned long vidmem;	/* default = 0 - Video memory base address */
-module_param_hw(vidmem, ulong, iomem, 0444);
-MODULE_PARM_DESC(vidmem, "Default video memory base address");
-
 /* Default input and video norm at startup of the driver. */
 
 static unsigned int default_input;	/* default 0 = Composite, 1 = S-Video */
@@ -1161,10 +1150,6 @@ static int zoran_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		jpg_bufsize = 8192;
 	if (jpg_bufsize > (512 * 1024))
 		jpg_bufsize = 512 * 1024;
-	/* Use parameter for vidmem or try to find a video card */
-	if (vidmem)
-		pci_info(pdev, "%s: Using supplied video memory base address @ 0x%lx\n",
-			 ZORAN_NAME, vidmem);
 
 	/* some mainboards might not do PCI-PCI data transfer well */
 	if (pci_pci_problems & (PCIPCI_FAIL | PCIAGP_FAIL | PCIPCI_ALIMAGIK))
-- 
2.32.0

