Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE04A32069F
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 19:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbhBTSYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Feb 2021 13:24:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbhBTSYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Feb 2021 13:24:02 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E565C061786
        for <linux-kernel@vger.kernel.org>; Sat, 20 Feb 2021 10:23:22 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id t2so6177687pjq.2
        for <linux-kernel@vger.kernel.org>; Sat, 20 Feb 2021 10:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Tx3C6MQ/2W0OcQUststq3v1GAaEyt4L8MEaJY+h3wHQ=;
        b=lLPKJyj6Ou0GVccjRnKQAz3zDe598q2HfszOEmJFoIv/ujcgtcdsLeOdU8m+El4XHc
         Ono1oJjJ//HiF4HcIkqzJQKHenjJ8W+HAeO2HzYZDMZ+6dCzBjhvzSwWZnS55/3UmbMd
         3Pbm5aanrbE8CCPzAla7LOXlqpuonctyAJFn+8d3oZbq3KBlYxEIw7U9OcVMtLZtcdFd
         eUTstAoVRCkSTYkUzVNVy00ppkdlD6JD6dX98MnDU69uMkmz9KHL7eJh98VcUCyBe+vX
         eJSSAlWuwxnP8VgCK3pDKrIC4SD/hC+ARVU0IsgfTRVAE7QQXCDZOwSxDsk28s4xQGwm
         jqDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Tx3C6MQ/2W0OcQUststq3v1GAaEyt4L8MEaJY+h3wHQ=;
        b=jlPl8WNJ0p+gWqLgwV2AsTwQOXD+fXll5RO6AkFuhGum0FVMIjfafL1Avjv63tzS+U
         MKDFaIkOVYdtPwTSe1POhoN8ysQeG4HQSoBuwuvBrSe/I3ZhMQHdWaREwxdOvLE5bZnG
         htYxl7Zcvbiks2JjlXtbqnlrF4GvrT/gN4W31/Owsm1z4BVCqGjCgLU1U4/FFYrGr9rW
         RH8hGvnuTyNRecXmYffBFJAeEDqvMx8pnSr0+SEhdqrChv4Kym6gFZ9YsaqSJHuxBEdK
         qgAHfozY4Q8Ip1ysbzZziJRuWWaA4mHofOgGMbNYtc5X2SceRXpb26cnM/Z8of0nCpcH
         +wUw==
X-Gm-Message-State: AOAM53361Jy7+D8VVlx9eQ0p7tZHaXuD49x31FJ7LRsWUxeKXUpoHDGD
        nPWWo2qj7hwvdNs5CwEw6O8=
X-Google-Smtp-Source: ABdhPJxWNXG8AZGdp+stm8C69Cqhrqn+eIt7mtCrDyNWhNKqk1pe8rIm6rKYpskFeH6hH8x7f4yT+Q==
X-Received: by 2002:a17:90a:d148:: with SMTP id t8mr7278134pjw.73.1613845401976;
        Sat, 20 Feb 2021 10:23:21 -0800 (PST)
Received: from localhost.localdomain ([106.200.44.186])
        by smtp.gmail.com with ESMTPSA id j34sm12461018pgi.62.2021.02.20.10.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Feb 2021 10:23:21 -0800 (PST)
From:   Atul Gopinathan <atulgopinathan@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     gustavo@embeddedor.com, tiwai@suse.de, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Atul Gopinathan <atulgopinathan@gmail.com>
Subject: [PATCH 2/2] staging: rtl8192e: Change state information from u16 to u8
Date:   Sat, 20 Feb 2021 23:51:55 +0530
Message-Id: <20210220182154.9457-2-atulgopinathan@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210220182154.9457-1-atulgopinathan@gmail.com>
References: <20210220182154.9457-1-atulgopinathan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "CcxRmState" field in struct "rtllib_network" is defined
as a u16 array of size 2 (so, 4 bytes in total).

But the operations performed on this array throughout the code
base (in rtl8192e/) are all in byte size 2 indicating that this
array's type was defined wrongly.

There are two situation were u16 type of this field could yield
incorrect behaviour:

1. In rtllib_rx.c:1970:
memcpy(network->CcxRmState, &info_element->data[4], 2);

Here last 2 bytes (index 4 and 5) from the info_element->data[]
array are meant to be copied into CcxRmState[].
Note that "data" array here is an array of type u8.

2. In function "update_network()" in staging/rtl8192e/rtllib_rx.c:
memcpy(dst->CcxRmState, src->CcxRmState, 2);

Here again, only 2 bytes are copied from the source state to
destination state.

There are no instances of "CcxRmState" requiring u16 data type.
Here is the output of "grep -IRn 'CcxRmState'" on the rtl8192e/
directory for reviewing:

rtllib_rx.c:1970:			memcpy(network->CcxRmState, &info_element->data[4], 2);
rtllib_rx.c:1971:			if (network->CcxRmState[0] != 0)
rtllib_rx.c:1975:			network->MBssidMask = network->CcxRmState[1] & 0x07;
rtllib_rx.c:2520:	memcpy(dst->CcxRmState, src->CcxRmState, 2);
rtllib.h:1108:	u8	CcxRmState[2];

//Note: The last line of output is my commit to this patch (u8 instead
of u16).

Signed-off-by: Atul Gopinathan <atulgopinathan@gmail.com>
---
 drivers/staging/rtl8192e/rtllib.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index b84f00b8d18b..4cabaf21c1ca 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1101,15 +1101,15 @@ struct rtllib_network {
 	u8 hidden_ssid[IW_ESSID_MAX_SIZE + 1];
 	u8 hidden_ssid_len;
 	struct rtllib_qos_data qos_data;
 
 	bool	bWithAironetIE;
 	bool	bCkipSupported;
 	bool	bCcxRmEnable;
-	u16	CcxRmState[2];
+	u8	CcxRmState[2];
 	bool	bMBssidValid;
 	u8	MBssidMask;
 	u8	MBssid[ETH_ALEN];
 	bool	bWithCcxVerNum;
 	u8	BssCcxVerNumber;
 	/* These are network statistics */
 	struct rtllib_rx_stats stats;
-- 
2.27.0

