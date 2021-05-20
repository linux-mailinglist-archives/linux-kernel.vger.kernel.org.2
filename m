Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06A9238AF24
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243221AbhETMvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242961AbhETMvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:51:08 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B59EC0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:14:01 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id n2so17508810wrm.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WT/Ah5zVIR2n6xrqkZtr6CbWiOxcSYCJevaMTMBm4do=;
        b=W07zBgrR7Vy8cr+So8otkvS5C1Z6BoGj3mzh7HEO5/3+NPb6wwcaW1O+NKhKgYd/MF
         xahC9TqPHTPRHVO1HgE81e5yba/aF0oFtLjtHSJvsaWdqPDogBwqIG3NNn+RKcN9GisE
         0ktkmfaVXb9DTrE+DuMdSvDGkLwipZfrX+GDOxRo8x184j/fHe/JFtHKgbpfB81ytNn5
         74BIMkOB3ikMOUPzIf+bevHJ39ddJhOJ8fLp3La5dliUsMfnporDiIuBc+XWRKw128AZ
         sMSSQmIgaf17JMFfGh0j3ziJOC3nh8kfKnLJRJ7mrfcWhlIH+xOi7eLEHhmXDMTnD9/i
         ZKHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WT/Ah5zVIR2n6xrqkZtr6CbWiOxcSYCJevaMTMBm4do=;
        b=UYL9tdGPPg+Gmummi3jPSwBnc0BOTOhmHmnZWg7Dzg6jy3Jjse8Cra+uZigQESx8Hh
         Czyz/ix40u+4H4GaavipsiBr4BVO6nNbfZgZNmTkzioxqBmBIMHksD10p/X++bFSTbWB
         Dm1YyfDGsA6urdqNbwJ0wdffb/rQuKrCo2jC0PER98fwT1KU0qOZtp1Rno8wAaVo9jXK
         nYXleK/bl1AfKAX8d8Dw1v4Rnn14YWyi7yZ7gTGBKFBLxFsww+d81BXDjMe2i5J5AP9S
         y7X5cEL22SgOwRIQRvuY+26gkHuqM5zHe6ETAXgjSNKthzT/RLecmWjWCYl/Xb0/0RGG
         SBDA==
X-Gm-Message-State: AOAM531TAul6f38fM2/hF0jHKE7xLcfn2VbzxaQL5xbTlDzP7ow2SSlj
        WVVgeFCOlA+KTLlyEcSJf7DX3g==
X-Google-Smtp-Source: ABdhPJz31x+vG5fgE61zu7bMJm2r+HxMSqz28IxczkDa2N0mdPmgtDO7Su9f602zIDCIJvc0f6kOnQ==
X-Received: by 2002:adf:aad8:: with SMTP id i24mr4032634wrc.0.1621512840072;
        Thu, 20 May 2021 05:14:00 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id 61sm3393704wrm.52.2021.05.20.05.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 05:13:59 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 04/16] char: pcmcia: synclink_cs: Fix a bunch of kernel-doc issues
Date:   Thu, 20 May 2021 13:13:35 +0100
Message-Id: <20210520121347.3467794-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520121347.3467794-1-lee.jones@linaro.org>
References: <20210520121347.3467794-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/char/pcmcia/synclink_cs.c | 64 ++++++++++++++++---------------
 1 file changed, 33 insertions(+), 31 deletions(-)

diff --git a/drivers/char/pcmcia/synclink_cs.c b/drivers/char/pcmcia/synclink_cs.c
index 9f7420bc50267..4a1e63911b279 100644
--- a/drivers/char/pcmcia/synclink_cs.c
+++ b/drivers/char/pcmcia/synclink_cs.c
@@ -483,7 +483,7 @@ static void* mgslpc_get_text_ptr(void)
 	return mgslpc_get_text_ptr;
 }
 
-/**
+/*
  * line discipline callback wrappers
  *
  * The wrappers maintain line discipline references
@@ -3861,12 +3861,13 @@ static void tx_timeout(struct timer_list *t)
 #if SYNCLINK_GENERIC_HDLC
 
 /**
- * called by generic HDLC layer when protocol selected (PPP, frame relay, etc.)
- * set encoding and frame check sequence (FCS) options
+ * hdlcdev_attach() - called by generic HDLC layer when protocol selected
+ *                    (PPP, frame relay, etc.) set encoding and frame check
+ *                    sequence (FCS) options
  *
- * dev       pointer to network device structure
- * encoding  serial encoding setting
- * parity    FCS setting
+ * @dev:       pointer to network device structure
+ * @encoding:  serial encoding setting
+ * @parity:    FCS setting
  *
  * returns 0 if success, otherwise error code
  */
@@ -3914,10 +3915,10 @@ static int hdlcdev_attach(struct net_device *dev, unsigned short encoding,
 }
 
 /**
- * called by generic HDLC layer to send frame
+ * hdlcdev_xmit() - called by generic HDLC layer to send frame
  *
- * skb  socket buffer containing HDLC frame
- * dev  pointer to network device structure
+ * @skb:  socket buffer containing HDLC frame
+ * @dev:  pointer to network device structure
  */
 static netdev_tx_t hdlcdev_xmit(struct sk_buff *skb,
 				      struct net_device *dev)
@@ -3959,10 +3960,10 @@ static netdev_tx_t hdlcdev_xmit(struct sk_buff *skb,
 }
 
 /**
- * called by network layer when interface enabled
- * claim resources and initialize hardware
+ * hdlcdev_open() - called by network layer when interface enabled
+ *                  claim resources and initialize hardware
  *
- * dev  pointer to network device structure
+ * @dev:  pointer to network device structure
  *
  * returns 0 if success, otherwise error code
  */
@@ -4022,10 +4023,10 @@ static int hdlcdev_open(struct net_device *dev)
 }
 
 /**
- * called by network layer when interface is disabled
- * shutdown hardware and release resources
+ * hdlcdev_close() - called by network layer when interface is
+ *                   disabled shutdown hardware and release resources
  *
- * dev  pointer to network device structure
+ * @dev:  pointer to network device structure
  *
  * returns 0 if success, otherwise error code
  */
@@ -4161,9 +4162,10 @@ static int hdlcdev_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 }
 
 /**
- * called by network layer when transmit timeout is detected
+ * hdlcdev_tx_timeout() - called by network layer when transmit timeout
+ *                        is detected
  *
- * dev  pointer to network device structure
+ * @dev:  pointer to network device structure
  */
 static void hdlcdev_tx_timeout(struct net_device *dev, unsigned int txqueue)
 {
@@ -4184,10 +4186,10 @@ static void hdlcdev_tx_timeout(struct net_device *dev, unsigned int txqueue)
 }
 
 /**
- * called by device driver when transmit completes
- * reenable network layer transmit if stopped
+ * hdlcdev_tx_done() - called by device driver when transmit completes
+ *                     reenable network layer transmit if stopped
  *
- * info  pointer to device instance information
+ * @info:  pointer to device instance information
  */
 static void hdlcdev_tx_done(MGSLPC_INFO *info)
 {
@@ -4196,12 +4198,12 @@ static void hdlcdev_tx_done(MGSLPC_INFO *info)
 }
 
 /**
- * called by device driver when frame received
- * pass frame to network layer
+ * hdlcdev_rx() - called by device driver when frame received
+ *                pass frame to network layer
  *
- * info  pointer to device instance information
- * buf   pointer to buffer contianing frame data
- * size  count of data bytes in buf
+ * @info:  pointer to device instance information
+ * @buf:   pointer to buffer contianing frame data
+ * @size:  count of data bytes in buf
  */
 static void hdlcdev_rx(MGSLPC_INFO *info, char *buf, int size)
 {
@@ -4236,10 +4238,10 @@ static const struct net_device_ops hdlcdev_ops = {
 };
 
 /**
- * called by device driver when adding device instance
- * do generic HDLC initialization
+ * hdlcdev_init() - called by device driver when adding device instance
+ *                  do generic HDLC initialization
  *
- * info  pointer to device instance information
+ * @info:  pointer to device instance information
  *
  * returns 0 if success, otherwise error code
  */
@@ -4284,10 +4286,10 @@ static int hdlcdev_init(MGSLPC_INFO *info)
 }
 
 /**
- * called by device driver when removing device instance
- * do generic HDLC cleanup
+ * hdlcdev_exit() - called by device driver when removing device instance
+ *                  do generic HDLC cleanup
  *
- * info  pointer to device instance information
+ * @info:  pointer to device instance information
  */
 static void hdlcdev_exit(MGSLPC_INFO *info)
 {
-- 
2.31.1

