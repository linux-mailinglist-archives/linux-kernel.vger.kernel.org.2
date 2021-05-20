Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D420C38B694
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 21:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237742AbhETTDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 15:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236610AbhETTCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 15:02:42 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C7ABC06138A
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 12:01:15 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 62so8774839wmb.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 12:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t4TZ9u6oAq4SZBg4hZTxMATDAwTOPHS9ZK/AyDLn4d4=;
        b=e2k7VHb12sv3hOQCa7LrwLF05Pkak+LDDNKPB6Uz0X6RrE6BoBttoxgMaxR6QONNME
         rTRW9po870y8+6j/Z7p4TRsSMyD4CIU5rkF4UYFndGVcopi9ebh919F3nd9cee2pn9/+
         bRCW2X80fPY8kwz0htp4hC0OjP5Rdl8aZcpSCeIykhQQ9tFWQKgOvWIagJHJXzhK4kiQ
         rnjAJrEWDtY/9HC06X0ez/WO5me95KlF8agImRmmEVpfPGewoJgoENGyN0ZGIosuUYC0
         6gjU9RejlXrTaU2PcqnTCSf7r6QCDtCxAK6CbBVzeu35Mu+iAjIogHqnr+z8qwwMU0RS
         iMWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t4TZ9u6oAq4SZBg4hZTxMATDAwTOPHS9ZK/AyDLn4d4=;
        b=LTXxAWsLxemt9yXW57GeKS7P0/JZvjvDxvieH7hSjwNUO5/sFpamF3kdRjTUfrE51p
         wTxTl5DT977Mhg6FNE+ehn4P+jxDaQWdaURk/Knk8CF9QACAKKTRcA4D1R7qRvgUvKOF
         VRzstGFhXPGE1sBfu3TNWbsOj572nktkQJqeWJIQbIHTvfuVkWUqOfNdd87yce4TEDMM
         4OmuZieny7kgGDCNzWBxOued8OoJhcNNBwa6hrLr+jCscMM/fRcTNyg2teRhpv4F0ykn
         Wdm4OG4mXZhLObWPffQWyrJ+k+3UhMtyT6NVbKT30dpwTu48lh7WzRMf5KEvk6Lh9hgt
         VJtQ==
X-Gm-Message-State: AOAM531jU8o11ZeU81sK5oxWSslcySN5LhYWDxbeDtYcyn9IZ1vw+FVf
        IVmtPRMdgiZoQq2q2bx9qBquT0lYhYikJaHc
X-Google-Smtp-Source: ABdhPJz4CKOgYEBopEhSdxOI2co+mVFSiVPNKK7nPotOyXV3KvTjfbVyKNEt3BbiSVQ/pjeACFJT9g==
X-Received: by 2002:a1c:7315:: with SMTP id d21mr5149019wmb.155.1621537273966;
        Thu, 20 May 2021 12:01:13 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id p20sm9011899wmq.10.2021.05.20.12.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 12:01:13 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Thor Thayer <thor.thayer@linux.intel.com>,
        linux-i2c@vger.kernel.org
Subject: [PATCH 04/16] i2c: busses: i2c-altera: Fix formatting issue in struct and demote unworthy kernel-doc headers
Date:   Thu, 20 May 2021 20:00:53 +0100
Message-Id: <20210520190105.3772683-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520190105.3772683-1-lee.jones@linaro.org>
References: <20210520190105.3772683-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/i2c/busses/i2c-altera.c:74: warning: cannot understand function prototype: 'struct altr_i2c_dev '
 drivers/i2c/busses/i2c-altera.c:180: warning: Function parameter or member 'idev' not described in 'altr_i2c_transfer'
 drivers/i2c/busses/i2c-altera.c:180: warning: Function parameter or member 'data' not described in 'altr_i2c_transfer'
 drivers/i2c/busses/i2c-altera.c:193: warning: Function parameter or member 'idev' not described in 'altr_i2c_empty_rx_fifo'
 drivers/i2c/busses/i2c-altera.c:209: warning: Function parameter or member 'idev' not described in 'altr_i2c_fill_tx_fifo'

Cc: Thor Thayer <thor.thayer@linux.intel.com>
Cc: linux-i2c@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/i2c/busses/i2c-altera.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-altera.c b/drivers/i2c/busses/i2c-altera.c
index 7d62cbda6e06c..354cf7e45c4a0 100644
--- a/drivers/i2c/busses/i2c-altera.c
+++ b/drivers/i2c/busses/i2c-altera.c
@@ -55,7 +55,7 @@
 #define ALTR_I2C_XFER_TIMEOUT	(msecs_to_jiffies(250))
 
 /**
- * altr_i2c_dev - I2C device context
+ * struct altr_i2c_dev - I2C device context
  * @base: pointer to register struct
  * @msg: pointer to current message
  * @msg_len: number of bytes transferred in msg
@@ -172,7 +172,7 @@ static void altr_i2c_init(struct altr_i2c_dev *idev)
 	altr_i2c_int_enable(idev, ALTR_I2C_ALL_IRQ, false);
 }
 
-/**
+/*
  * altr_i2c_transfer - On the last byte to be transmitted, send
  * a Stop bit on the last byte.
  */
@@ -185,7 +185,7 @@ static void altr_i2c_transfer(struct altr_i2c_dev *idev, u32 data)
 		writel(data, idev->base + ALTR_I2C_TFR_CMD);
 }
 
-/**
+/*
  * altr_i2c_empty_rx_fifo - Fetch data from RX FIFO until end of
  * transfer. Send a Stop bit on the last byte.
  */
@@ -201,9 +201,8 @@ static void altr_i2c_empty_rx_fifo(struct altr_i2c_dev *idev)
 	}
 }
 
-/**
+/*
  * altr_i2c_fill_tx_fifo - Fill TX FIFO from current message buffer.
- * @return: Number of bytes left to transfer.
  */
 static int altr_i2c_fill_tx_fifo(struct altr_i2c_dev *idev)
 {
-- 
2.31.1

