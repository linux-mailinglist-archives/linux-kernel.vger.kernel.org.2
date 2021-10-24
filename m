Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA8DA438B75
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 20:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbhJXSiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 14:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbhJXSiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 14:38:05 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4441AC061745
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 11:35:44 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id v20so6381503plo.7
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 11:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=0mujV0YU/cPDCUxwyNfnmQlQiFEVg2B7mgv7g4IgXvs=;
        b=WbxKS55mTdOt2c8LaZWqEss4RjELhj6nYAaMb3ZE/1prdDrKPwWUm30D8yDsIvuUqP
         gyAaYiMCzYMISXFC6FNp1XGk/gOCTrnudrM8HCtWiZIttxx0Qg+uGsYxeFVDdwEdXHOg
         So9N2MIr/PeW3waefDTzY7qlx1Dk4cP0yXRVp+F2z0SBISBQONAANu3PK/onm++9SiDL
         1hdsDDVQXjv5zROlc8Ng56VjOHO55ZItpPhJmIw5ThhHoWi0MTQ9iHvNkQoGE5Fo+l6v
         p5D8OgTTAxkaarZ6m9PEVkQyPBtvU6Tj1qllr2TRu9twHpGMz6T8UNSdcLgv+U4DECwU
         bzbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=0mujV0YU/cPDCUxwyNfnmQlQiFEVg2B7mgv7g4IgXvs=;
        b=6swRWxLazRrRUeRz5omIdXJ8y1wtItpu8XJ3xNy6sQWM0m1IeSr8rRjHo84MFtoEGx
         W/0NVXeYJFFRu4vJMd8G/cf2ByNU4VQg92XR1ccTMXd9aiaoin5+3RIIj4Kryv/UCXzz
         lCd+9jJ9OclDqjtjtpqm34VatLvOzI2qhLA+SEgZRXpAR0ubVfLyoD7kVyAcQsTbzJ8n
         Duvu0COLpm80sbt/OgYWYQSUCIZRphEvkGXI93u76OfJP9SxEAGfscmVmcVn//U8Y8k9
         bowUf0mXH0Bmepvhwf/bAYa7cP0K6ZZ8yauA2qfo7vIxVgiMFturPubcIxOMYWtz5GrR
         SXIg==
X-Gm-Message-State: AOAM531JMFaGfvN2JWel8cFCMzYYBWIChG+KxCi2iGE5GfxP1yPJgNn1
        es6MHfDjIx8ykjHMEjdwZrc=
X-Google-Smtp-Source: ABdhPJyoDNSQz4xepj5zV89A96UJXq5lGe0Jsx4xhvZNYf1Mc06yr5x5KhBzND5Ox4w+wdwLEUsdDQ==
X-Received: by 2002:a17:902:db02:b0:140:581e:6eb5 with SMTP id m2-20020a170902db0200b00140581e6eb5mr929816plx.46.1635100543701;
        Sun, 24 Oct 2021 11:35:43 -0700 (PDT)
Received: from Sauravs-MacBook-Air.local ([59.95.95.3])
        by smtp.gmail.com with ESMTPSA id b16sm16930936pfm.58.2021.10.24.11.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Oct 2021 11:35:43 -0700 (PDT)
Date:   Mon, 25 Oct 2021 00:05:35 +0530
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        saurav.girepunje@gmail.com, paskripkin@gmail.com,
        fmdefrancesco@gmail.com, dan.carpenter@oracle.com,
        martin@kaiser.cx, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
Subject: [PATCH] staging: r8188eu: remove unused local variable
Message-ID: <YXWnd5X9+p0X+1EB@Sauravs-MacBook-Air.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused local variable padapter from rtl8188eu_init_recvbuf().
Function is not using this variable.

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
---
 drivers/staging/r8188eu/hal/rtl8188eu_recv.c    | 2 +-
 drivers/staging/r8188eu/hal/usb_ops_linux.c     | 2 +-
 drivers/staging/r8188eu/include/rtl8188e_recv.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188eu_recv.c b/drivers/staging/r8188eu/hal/rtl8188eu_recv.c
index 9c191b7ffbf1..8031ac9f9d43 100644
--- a/drivers/staging/r8188eu/hal/rtl8188eu_recv.c
+++ b/drivers/staging/r8188eu/hal/rtl8188eu_recv.c
@@ -12,7 +12,7 @@

 #include "../include/rtl8188e_hal.h"

-void rtl8188eu_init_recvbuf(struct adapter *padapter, struct recv_buf *precvbuf)
+void rtl8188eu_init_recvbuf(struct recv_buf *precvbuf)
 {
 	precvbuf->transfer_len = 0;

diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index 4c1974cc9a16..7912d7a6c31a 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -483,7 +483,7 @@ u32 rtw_read_port(struct adapter *adapter, u32 addr, u32 cnt, u8 *rmem)
 			precvbuf->reuse = true;
 	}

-	rtl8188eu_init_recvbuf(adapter, precvbuf);
+	rtl8188eu_init_recvbuf(precvbuf);

 	/* re-assign for linux based on skb */
 	if (!precvbuf->reuse || !precvbuf->pskb) {
diff --git a/drivers/staging/r8188eu/include/rtl8188e_recv.h b/drivers/staging/r8188eu/include/rtl8188e_recv.h
index a91daf84d6c3..2ab395ef579b 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_recv.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_recv.h
@@ -40,7 +40,7 @@ enum rx_packet_type {
 };

 #define INTERRUPT_MSG_FORMAT_LEN 60
-void rtl8188eu_init_recvbuf(struct adapter *padapter, struct recv_buf *buf);
+void rtl8188eu_init_recvbuf(struct recv_buf *buf);
 s32 rtl8188eu_init_recv_priv(struct adapter *padapter);
 void rtl8188eu_free_recv_priv(struct adapter * padapter);
 void rtl8188eu_recv_hdl(struct adapter * padapter, struct recv_buf *precvbuf);
--
2.33.0

