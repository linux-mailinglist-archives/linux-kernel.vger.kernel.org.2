Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE4F377055
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 09:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbhEHHXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 May 2021 03:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbhEHHXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 May 2021 03:23:07 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C253AC061574;
        Sat,  8 May 2021 00:22:05 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id k3-20020a17090ad083b0290155b934a295so6688061pju.2;
        Sat, 08 May 2021 00:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=LQ8oxYiaNQHm5c12NrgFTgp737vOw28hFGxqzWW/MzA=;
        b=BXevbzZ/Be/IlWf5qiHMih3I/uD6l0hdwDHNt7xFZA2XcsLFxfGi2o2rBkqc8xI+jW
         E+qkI2dCVEnW20NdQ7kBcRl4Nx2kkbVezyKLr4RIXRKbmqrTwDjIAgizbPHm3mtjSMWn
         tzvg0MKBGdFtcJTWvsWkb8wwnsgKiPMA/j4TWx8jEt+NNEYaR1SEU3GXVyIFm615bh97
         bB0ufNF+tNkk8g/XBR7pZqVKdhutVeuVNdyvxQ+RPAcnmzX438+ny28k1+1Yyi/OsXbx
         kAoj012BSGOfGHYgal7/2PONo1LMHKw0tQ1eOuSyQNJPf3kmBwzF5NiuppxlAWPfB2+1
         KCbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=LQ8oxYiaNQHm5c12NrgFTgp737vOw28hFGxqzWW/MzA=;
        b=DvpKk4GmLjQNQ1Nexxz/JVNWxmof0LxLo9KLNVfZUErRCi0zv9RejvZhprLgeQNsw9
         QWLPKpb/ODv5VrhqV2pRSOao5qZZcND/U1XTjXtoLj8V42O3hUzcx7HueaU22VSY6Z8M
         uGYWvFjKBy1AjxwTGdoylLoMqUdLhTzVUjhoFctIB5lFMqERemVob9KKNm6pmCHPuwwK
         RfgIxCdx7KR7mUAPwqSmsj+/o+CJJaves9RDBF/Vo+a/FK2u1KcjUrPJXTimC1UVw27F
         BsbKIVIT12p6FWBWMOHR2Hw0Rtq5jK1dUMbxAW0PRFqfTcXr3k3S4OZfSWTy3MVSohGO
         jUdg==
X-Gm-Message-State: AOAM533iPZBuEbgK5S8/yUQJ60NEN16A8LgCNdFquEBDyJpPXbmiLEZe
        OpfwEW0tQFk9rALk+0kG7FA=
X-Google-Smtp-Source: ABdhPJwxR2YUnFliYuiVHMAhEzlWeZtU3HzKLC2i1CCCAGFs/It8jYv7MUlY7EDh8ZqUoFS0lPlWhw==
X-Received: by 2002:a17:90a:c395:: with SMTP id h21mr15129146pjt.28.1620458525148;
        Sat, 08 May 2021 00:22:05 -0700 (PDT)
Received: from user ([2001:4490:4409:327a:e6bf:11a9:8e6:3a39])
        by smtp.gmail.com with ESMTPSA id x133sm6736975pfc.19.2021.05.08.00.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 May 2021 00:22:04 -0700 (PDT)
Date:   Sat, 8 May 2021 12:51:56 +0530
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     b-liu@ti.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
Subject: [PATCH] usb: musb:  Fix spelling mistake "tranfer" -> "transfer"
Message-ID: <20210508072156.GA14656@user>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix spelling mistake "tranfer" -> "transfer" in musb_gadget.c file.

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
---
 drivers/usb/musb/musb_gadget.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index f62ffaede1ab..0246194d5577 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -611,7 +611,7 @@ static void rxstate(struct musb *musb, struct musb_request *req)
 	 * mode 0 only. So we do not get endpoint interrupts due to DMA
 	 * completion. We only get interrupts from DMA controller.
 	 *
-	 * We could operate in DMA mode 1 if we knew the size of the tranfer
+	 * We could operate in DMA mode 1 if we knew the size of the transfer
 	 * in advance. For mass storage class, request->length = what the host
 	 * sends, so that'd work.  But for pretty much everything else,
 	 * request->length is routinely more than what the host sends. For
--
2.25.1

