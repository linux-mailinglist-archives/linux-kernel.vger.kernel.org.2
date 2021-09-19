Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2801410DE4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 01:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234081AbhISX4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 19:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233716AbhISXzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 19:55:39 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A65DFC061764
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 16:54:11 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id c22so53938393edn.12
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 16:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=21ydcmCULDJZ9KsJaKGPSEG3gMiHBQKuZVCcI+HwaMU=;
        b=hoL31oLtdN6s2Si/mg+Y1r2D/+m+OfGeT+XQCremOXX5D14Ld5H3Q81xTBMdEuoMso
         2bdr59Zpq9c3Yk2pzY42Vn/FSJFfCYPuK5AW7UcP6dXD3Zt0HRkjCJiz1EwXg1wQPOeP
         UeLWT/UiHyrsrpcIp5cCEwRWuQf3VKtjT8j190D9I9DM9bfrEKNz77j0O1M9cYG7GeRD
         ALsxvB/tNcHRDgh+zq5FeEEdz8Z2iIt0n8NReEHRlTaHihDGQtOMxpYMCXkGKFJCUr9s
         nZ/kZbVJ3OGqOIVwEQm6+8vWget9eeNJ5KIWl0MnMmpNMwqWJYZevhpbwGAFtUSs0QrT
         +R2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=21ydcmCULDJZ9KsJaKGPSEG3gMiHBQKuZVCcI+HwaMU=;
        b=tHNn3aWj9foV+dnzwnA9WrZ4u1K4UneRdvAXSOejetFGXRrlpyM3WSy7cJr7ceoTXL
         hWuj+sNcE8YRX5ZHMiVyps+Ig8VOzxVZtvX2cDg4Bfndh12yVGxh4iBJ+od7oNrpmWHF
         cnDBrwdoUR+sccIjCY/9i/2yCrGwu8CtppPLR9EFaA1A81gprwUoXOteLgLINAwkmY2C
         aUQyP2i1SrJdff0zmDoNojUOzehVM8nparUT0bOPHob5bKiHFsMNiZ6igy7Cv8AkNlMr
         jR/BcqdWBnTCtU87BBj1lFXoIilNqYDH9zwPjL97scN64rwllh8UM5rExd16JqAb3neL
         +/1w==
X-Gm-Message-State: AOAM533Tznn08gH8/BC59nVLS3D3ubTvK98wAeNOiCAv7IFCknHfd8gB
        1KWnzAO68i6LDSxtH4NZ8X8=
X-Google-Smtp-Source: ABdhPJynBWILs0+ud+J45unKXSwkgsGZVLUhOxuRLdAPOYIVmmRd2GR9EN317bnPMbZi7t8PU8gKnA==
X-Received: by 2002:a50:fb06:: with SMTP id d6mr25628885edq.31.1632095650261;
        Sun, 19 Sep 2021 16:54:10 -0700 (PDT)
Received: from localhost.localdomain (host-79-47-104-104.retail.telecomitalia.it. [79.47.104.104])
        by smtp.gmail.com with ESMTPSA id e11sm5353636ejm.41.2021.09.19.16.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Sep 2021 16:54:09 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Martin Kaiser <martin@kaiser.cx>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v8 06/19] staging: r8188eu: remove unnecessary space in usbctrl_vendorreq()
Date:   Mon, 20 Sep 2021 01:53:43 +0200
Message-Id: <20210919235356.4151-7-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210919235356.4151-1-fmdefrancesco@gmail.com>
References: <20210919235356.4151-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary extra space in usbctrl_vendorreq().

Co-developed-by: Pavel Skripkin <paskripkin@gmail.com>
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/r8188eu/hal/usb_ops_linux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index 0b48dde5657f..a52aeb2558ad 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -66,7 +66,7 @@ static int usbctrl_vendorreq(struct intf_hdl *intfhdl, u16 value, void *data, u1
 				if (status == -ESHUTDOWN || status == -ENODEV) {
 					adapt->bSurpriseRemoved = true;
 				} else {
-					struct hal_data_8188e	*haldata = GET_HAL_DATA(adapt);
+					struct hal_data_8188e *haldata = GET_HAL_DATA(adapt);
 					haldata->srestpriv.wifi_error_status = USB_VEN_REQ_CMD_FAIL;
 				}
 			} else {
-- 
2.33.0

