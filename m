Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3016C426753
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 12:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbhJHKEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 06:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239608AbhJHKEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 06:04:13 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB6EC061570
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 03:02:17 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id i12so15430170wrb.7
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 03:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uKJo8PQ8qCZ+w5l5NjxKVTa4Y5qVORlljgfVPolx7L0=;
        b=RM3zE3hhW+l1SbxfWPHkQ2Lh+ybH6D74fTeSry17W7mQLFy/X/KptWvzEBvuqQMdUT
         ZCJ7j+y3OHSd/E3XBmQA/SWDHWEwiqitv9U9QshyGG/uvgiyljJjqo6zmHdAvLTotOQO
         F65UFtWqbrD+GSXUIi8bkjFfCeaEjIS21E9VaDf9Ge/Pr1JS8JExMnruX7jzIamVSFo9
         Ao11pXwc73uFV/alESBLQutMjaeYhUkYNTmwneYdT2Kaj7mRutu1RSwkkfHW68DFH3DB
         c5lk5TaB9c2hyTbiW8TmzSKuOpSS0RKZV9jbqt+5DvjDesxWZxt5OgbSUjr2wd43+e+x
         jPcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uKJo8PQ8qCZ+w5l5NjxKVTa4Y5qVORlljgfVPolx7L0=;
        b=1r/GwC+9Oo27oioVOyd23Xdc/FzpN5VOX9eOwZfj1njXBtcuKM71U/cx+3P5Rja72r
         gpB0kvjZtoMGEGiKY6QD1r3RWiBHyom0JBQsJks3L0Ekng2o7m51EMmo60YKcE3mP/Lr
         e6Lysj2SIZD4fMswBtii2bRDZcLj8mUTIJejILTmDtLKh1CV3A/5ne5D/4ddIT9wN9Bc
         ZI0plxghrevWypFrRWrWUZP6tT55BEeZcTjhpJLDpdz4ZFYUePOY4vCoTtPJFghiLJb4
         BU9nQeFoRjL/XgJNhsY9cbppwGG3TuEiU0Pvkiq/E7zmM4wsz1oiGz90SMRfJWBWETAn
         0pzg==
X-Gm-Message-State: AOAM532ghh96IiuFfmF//XMOOiW9zjPxwRKryNAl7Ye8yC1TrPBYdHd2
        ovrPf08bL8l6nNs4AqI/i2k=
X-Google-Smtp-Source: ABdhPJxj0gUM5/SprLYHHOJcPozOmnsMYc59x50iLkKK9ukRj2QwRj8koLY8IDCHvlLM6iHqc9roHA==
X-Received: by 2002:a1c:4484:: with SMTP id r126mr2413166wma.150.1633687335920;
        Fri, 08 Oct 2021 03:02:15 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::40c9])
        by smtp.gmail.com with ESMTPSA id k10sm1998249wrh.64.2021.10.08.03.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 03:02:15 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: r8188eu: remove unused defines from rtw_sreset.h
Date:   Fri,  8 Oct 2021 12:02:09 +0200
Message-Id: <20211008100209.28801-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused defines from rtw_sreset.h.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/include/rtw_sreset.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/r8188eu/include/rtw_sreset.h b/drivers/staging/r8188eu/include/rtw_sreset.h
index 47ad185c755f..45bc227d088a 100644
--- a/drivers/staging/r8188eu/include/rtw_sreset.h
+++ b/drivers/staging/r8188eu/include/rtw_sreset.h
@@ -21,10 +21,6 @@ struct sreset_priv {
 #define	USB_VEN_REQ_CMD_FAIL	BIT(0)
 #define	USB_READ_PORT_FAIL		BIT(1)
 #define	USB_WRITE_PORT_FAIL		BIT(2)
-#define	WIFI_MAC_TXDMA_ERROR	BIT(3)
-#define   WIFI_TX_HANG				BIT(4)
-#define	WIFI_RX_HANG				BIT(5)
-#define		WIFI_IF_NOT_EXIST			BIT(6)
 
 void sreset_init_value(struct adapter *padapter);
 void sreset_reset_value(struct adapter *padapter);
-- 
2.33.0

