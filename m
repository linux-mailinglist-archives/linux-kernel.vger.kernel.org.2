Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1681C377354
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 19:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbhEHRFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 May 2021 13:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbhEHRFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 May 2021 13:05:07 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA01C061760;
        Sat,  8 May 2021 10:04:04 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id m190so9827817pga.2;
        Sat, 08 May 2021 10:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JBRMa8mKQ62OMgm3Mexb2/wyLqKwT/ApM4zOBZB39Yc=;
        b=dNlNvdUl7OspSLy79vEclZ4kN6t0at9zZHsCGnZ1Yh5ucsrh178wTSv1Ur8UbLisL+
         126nasA8yTX3B38f4IntWfJPwoKGW2y5bTiCDXGysOpZmthAyD1cjLz1uSwE/LHxpgLc
         /8BOgrT3ZFV1/TyuD4rLmUdVYUf+9x92YrgfD+yYlNs5tO3mMJSyEqv9osf+I6CSSSbf
         k+T73ckW2SuX2Oz9LdI1SwqXHXww+MvBtLgd7Lb5MIsVKOtsOQv6zrwzuja1mfzy1oFC
         0cwmPFtzvCRfPfPPgtmw6E3Swp9CVzQdMI5VtnZ/1Unbl5p+IOUmQQMyZhbg32Y17Hv+
         B3Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JBRMa8mKQ62OMgm3Mexb2/wyLqKwT/ApM4zOBZB39Yc=;
        b=mlZuvGkAwx5kp9gIgcY7VQ/5U5fcsyBUvQRhnbfLmBrIMRasuR3RPlEF3aEMRnNmVW
         Oh/kla7op8qxPLSLiVJPFNs/93Exm/21WBzuDhDM+5goTX9HPYQr1SBNYhyJAyOKcO/u
         mq6Dy3X9QrdMbP38HGE9/N8L5hi6Sqnr4YJSp5gzz7fnmzgNVbxPnnOc8gVt7LMixdBH
         pLgLCJwHJCvIkdKJpd5XDVQapSBjO4Om2kyCsMW/zfxWfhgb5jXWTucFlIE1inZ/2sYG
         q+FWb9YRgOqwwxVUT/eVlvHTxwLFiOLm3XDbCd0DtZxFNbTysVXijgorysSVdscK2C1q
         fZrQ==
X-Gm-Message-State: AOAM531/ZL44Ehd2p3YDTPL35sPvjVmsXc9x4OAW5Ry5WMwfT9DibSzb
        /Lz3DdpMYUXmg4AHQNjsOdVnXXDtCTFoqg==
X-Google-Smtp-Source: ABdhPJyIJa0FLN63hYJAyi/EaMc92EspsxKhKA18IERo1UmSo/2Gx29v1rFx/gLtIY2oPWJRXOuZGw==
X-Received: by 2002:a63:2542:: with SMTP id l63mr17050916pgl.128.1620493444127;
        Sat, 08 May 2021 10:04:04 -0700 (PDT)
Received: from localhost.localdomain ([2001:4490:4409:357e:ddc0:965d:2b13:8892])
        by smtp.gmail.com with ESMTPSA id g190sm1674468pfb.60.2021.05.08.10.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 May 2021 10:04:03 -0700 (PDT)
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     b-liu@ti.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Saurav Girepunje <saurav.girepunje@gmail.com>
Subject: [PATCH 2/2] usb: musb: Remove unused function argument dma, qh, offset, length
Date:   Sat,  8 May 2021 22:33:17 +0530
Message-Id: <20210508170317.24403-3-saurav.girepunje@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210508170317.24403-1-saurav.girepunje@gmail.com>
References: <20210508170317.24403-1-saurav.girepunje@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused function argument dma, qh, offset, length from
musb_tx_dma_set_mode_cppi_tusb() in musb_host.c

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
---
 drivers/usb/musb/musb_host.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index 14d9b366e605..a4c185747358 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -601,12 +601,8 @@ static void musb_tx_dma_set_mode_mentor(struct musb_hw_ep *hw_ep,
 	musb_writew(epio, MUSB_TXCSR, csr);
 }
 
-static void musb_tx_dma_set_mode_cppi_tusb(struct dma_controller *dma,
-					   struct musb_hw_ep *hw_ep,
-					   struct musb_qh *qh,
+static void musb_tx_dma_set_mode_cppi_tusb(struct musb_hw_ep *hw_ep,
 					   struct urb *urb,
-					   u32 offset,
-					   u32 *length,
 					   u8 *mode)
 {
 	struct dma_channel *channel = hw_ep->tx_channel;
@@ -632,8 +628,7 @@ static bool musb_tx_dma_program(struct dma_controller *dma,
 		musb_tx_dma_set_mode_mentor(hw_ep, qh,
 					    &length, &mode);
 	else if (is_cppi_enabled(hw_ep->musb) || tusb_dma_omap(hw_ep->musb))
-		musb_tx_dma_set_mode_cppi_tusb(dma, hw_ep, qh, urb, offset,
-					       &length, &mode);
+		musb_tx_dma_set_mode_cppi_tusb(hw_ep, urb, &mode);
 	else
 		return false;
 
-- 
2.25.1

