Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56E3F37067A
	for <lists+linux-kernel@lfdr.de>; Sat,  1 May 2021 10:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbhEAIsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 May 2021 04:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbhEAIsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 May 2021 04:48:03 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9E6C06174A;
        Sat,  1 May 2021 01:47:14 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id k3-20020a17090ad083b0290155b934a295so2984005pju.2;
        Sat, 01 May 2021 01:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=//OsLf8gU/9VWp4E/gtONldzoDSVWoyHb1O3vAf2hr4=;
        b=kRHorvM/R3y9LiE2chDqQilUiSbOWfrP2vlHZwHptLk/jpM1OwRAqBHgwRh4KhjhyT
         AH7PEtE3Hl12cJ9Oh11Z/6HIWQeb5vew+mroII6n2rxbnpkCqr/nOA3xmoUrNiWJNAEo
         JM9ZkdKiIov8XrHlt7Wd5sM0m//M9zH9Qnq0Qo3Ftmeya64Uq52OdoCqOrGuAKcsxM10
         gmXCKRAZmzSYrl7KqITCd7rRZJdHKHk12B3nT+W5aexNG5Gb1F4eD0N9sMAjJ0Ca/KKy
         RvqyvlEgphlLOtu3S/VCyguWSUXI2JQ82aiQEVplLvUqR6ehp+485/1RwGjs/v5QA/zI
         N0FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=//OsLf8gU/9VWp4E/gtONldzoDSVWoyHb1O3vAf2hr4=;
        b=sEA3fWAln6mq+jARSfL2m7Jg+vYSpG8kbIIcvxA0szSsw6h2Cnia7gF5YzhgTcYt9B
         A6BFxP+OWYRtMdZ4HV4AX3w65m++hdZCCNNft1g3YQV6DW7IZ6jRs4k394GFdfuLHFcq
         cQfueqOLpc3jvdoTDG9zXAXAvWt+yoXh6G7DSYjNTMBLN9M7VklL51ekv2ZRgRcLOznh
         EK0ej2kD/lZbsbwL2ZM5WCJe7jbnLw1BNcHnA6/qL02pNjGhhF4uUbz6GVw7H3snGVv8
         076rpTTLYRYJbQKfsFU7HldvLGh4/1mcgqJhBozcpAEEZl1p2B7VqbSV5TCHiVqdBrOn
         fBiA==
X-Gm-Message-State: AOAM531V/ibRRCYVW7wZgNhFNwxtNY5DBZmaJQBf0pogs1rMdRgOsEL/
        ZyWx75ZJU3tEO3///gNOBjg=
X-Google-Smtp-Source: ABdhPJxiRuPq98W1BLwhur1yTAAe2cpv3YkMCzOfdhyDSVOGzCe2PF6bDuaBpcPCaM2RmHI1mCCCeA==
X-Received: by 2002:a17:90a:5885:: with SMTP id j5mr9815184pji.102.1619858833696;
        Sat, 01 May 2021 01:47:13 -0700 (PDT)
Received: from user ([2001:4490:4409:1012:5ea7:af4f:f2d7:caab])
        by smtp.gmail.com with ESMTPSA id 3sm3915093pff.132.2021.05.01.01.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 May 2021 01:47:13 -0700 (PDT)
Date:   Sat, 1 May 2021 14:17:03 +0530
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     b-liu@ti.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
Subject: [PATCH] usb: musb: Remove unused function argument
Message-ID: <20210501084703.GA57167@user>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused function argument struct dma_controller *dma,
struct urb *urb and u32 offset from musb_tx_dma_set_mode_mentor

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
---
 drivers/usb/musb/musb_host.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index 8b7d22a0c0fb..14d9b366e605 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -563,10 +563,9 @@ musb_rx_reinit(struct musb *musb, struct musb_qh *qh, u8 epnum)
 	ep->rx_reinit = 0;
 }

-static void musb_tx_dma_set_mode_mentor(struct dma_controller *dma,
-		struct musb_hw_ep *hw_ep, struct musb_qh *qh,
-		struct urb *urb, u32 offset,
-		u32 *length, u8 *mode)
+static void musb_tx_dma_set_mode_mentor(struct musb_hw_ep *hw_ep,
+					struct musb_qh *qh,
+					u32 *length, u8 *mode)
 {
 	struct dma_channel	*channel = hw_ep->tx_channel;
 	void __iomem		*epio = hw_ep->regs;
@@ -630,7 +629,7 @@ static bool musb_tx_dma_program(struct dma_controller *dma,
 	u8			mode;

 	if (musb_dma_inventra(hw_ep->musb) || musb_dma_ux500(hw_ep->musb))
-		musb_tx_dma_set_mode_mentor(dma, hw_ep, qh, urb, offset,
+		musb_tx_dma_set_mode_mentor(hw_ep, qh,
 					    &length, &mode);
 	else if (is_cppi_enabled(hw_ep->musb) || tusb_dma_omap(hw_ep->musb))
 		musb_tx_dma_set_mode_cppi_tusb(dma, hw_ep, qh, urb, offset,
--
2.25.1

