Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75364374864
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 21:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235197AbhEETEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 15:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234038AbhEETD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 15:03:59 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F24C061574;
        Wed,  5 May 2021 12:03:01 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id h20so1635021plr.4;
        Wed, 05 May 2021 12:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=JMUNJAKvNnurV0h85ctnycyg2Vjqwe0Voc3cawQ6zV0=;
        b=OoUfdlP4FvUwdDjWtaJt4Gx0r1yx59pSlM/mCbJ6JKLMFmSR6Vtaf+DUGcm0IFipo/
         vHwqI8kOmfxG5lYmKzC34AyJcvgWeWGHUJm/+qdaV2OvBSO/xIOWQJ84uR4kMqz4Ndv1
         YQnalOr/ahVw/tqIR3Z2Mu81D97ImzhtAYF2aRVKhvw0cQ7B7xX/C9KeYnH+OFFdY9o8
         o1fUKtxHqN83WHcglnaKiMTo4JNbmBcMa2wUsOv76PhkLghFGhcf4N9FJ4Fq4HwW6UBL
         oin5/MGuLcd8HuvhcFcP6gr/bNsHxhFtBZOx+wn64P5Hhq5tkY36rpGpobyFIzah11gl
         y9aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=JMUNJAKvNnurV0h85ctnycyg2Vjqwe0Voc3cawQ6zV0=;
        b=jYJmcI5osBFJ8EDPXHKB+Wf9NZ3meQg+V0TdmGI9ELeE0vCwm4eBrW27e8Wu1HD23T
         6cU4ct0BuVcy5C/yEHjVn3gv6O9PselhZgXFPhyhhURm/pwezudA3wap1j+jFruLsGRD
         A2Yy2GyxuVoQVKyd60Cg0+wX9/Fxx4+EG8TFObghVR3J9y3LUHI/clreuZntOusHU80F
         0uwlkae4NuGoQKmfqt5fMT6t3dlDetmR/SvnB3LQl8lsvrP4zgse5/6G/tTdbgJOwYxS
         RDo8sLeqSGv28McMZMJ/vwvKiwf61K+UGCh7FDDAoHGwnI3+mS3Wdcp/ZwNDoaWBOjsx
         V0JQ==
X-Gm-Message-State: AOAM533uDMsaQhGI+qQF36UDsqcxSgiU71WPXPxzSQoFMb7qZefF+8vq
        YJpZhOCy1ws6lGXfcQco8ws=
X-Google-Smtp-Source: ABdhPJzmFCEQmWP5KDOnXNCMZtNKpZCWYtnkNtCyePTMFrxEcaDtJCdSOVxn5AEDVYZ9YT3giENIeQ==
X-Received: by 2002:a17:90a:de92:: with SMTP id n18mr13377062pjv.71.1620241381264;
        Wed, 05 May 2021 12:03:01 -0700 (PDT)
Received: from user ([2001:4490:4409:2453:4f74:e94b:c9ef:2cf1])
        by smtp.gmail.com with ESMTPSA id x133sm18447pfc.19.2021.05.05.12.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 12:03:00 -0700 (PDT)
Date:   Thu, 6 May 2021 00:32:54 +0530
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     b-liu@ti.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
Subject: [PATCH] usb: musb: remove unused function argument
Message-ID: <20210505190254.GA10896@user>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused function argument from musb_tx_dma_set_mode_cppi_tusb()
in musb_host.c

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
---
 drivers/usb/musb/musb_host.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index 8b7d22a0c0fb..978d822af2c5 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -602,12 +602,8 @@ static void musb_tx_dma_set_mode_mentor(struct dma_controller *dma,
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
@@ -633,8 +629,7 @@ static bool musb_tx_dma_program(struct dma_controller *dma,
 		musb_tx_dma_set_mode_mentor(dma, hw_ep, qh, urb, offset,
 					    &length, &mode);
 	else if (is_cppi_enabled(hw_ep->musb) || tusb_dma_omap(hw_ep->musb))
-		musb_tx_dma_set_mode_cppi_tusb(dma, hw_ep, qh, urb, offset,
-					       &length, &mode);
+		musb_tx_dma_set_mode_cppi_tusb(hw_ep, urb, &mode);
 	else
 		return false;

--
2.25.1

