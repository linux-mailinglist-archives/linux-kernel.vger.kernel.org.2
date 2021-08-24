Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADF3B3F5E14
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 14:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237377AbhHXMiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 08:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237310AbhHXMiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 08:38:19 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD7EC061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 05:37:35 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id h4so915183wro.7
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 05:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GM77iyqqpiUuLYvPxQ1BKHZlDJg3xbu24ehy3FqtqEo=;
        b=m/cL68+jxe1CWJZ2dk/XBxPqwbvp8kaJCa/0jQuPLrEYHoVZoabOSAgjsRM6CJ0mfu
         hCTJ3rvhffJg8kAX8L7muk0ZK0ha2ZneBe/VUzYCc8uwGLmtYOoMOo+W1Kzy0ggxJHm0
         NW0YQPWmwxzZ/dkx8B9naxh8tVQ+fqGCo35VeK1F73t2am6QH1MWKKjPZKUCLJ6ajPH3
         a/x+75KfUw0WgJgI2X0evabrvj0l/p1yO6Tbo59+6bbrHem1HwTGpAPJvTnf2v2wFx9c
         aqHZDKUPWcVXQA7rVEcH39kfg2g0yJt8dim5yZuJicvvkc7mAxSlH8a5oOizhwHpEn0p
         if9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GM77iyqqpiUuLYvPxQ1BKHZlDJg3xbu24ehy3FqtqEo=;
        b=MfxIEL7OsN/uczVYKPZxGj+Q9SuDTbfLZGXBN87PwPYiC44QKr8SML9ErPMR7CM16n
         PlxgPvQMGYKhEpaFV1gwcHNLvVlITLdkZIW/cb7IUSygCHUul3onGgo/5jk3rS7U35mZ
         llZWUYOdylG7GQhxHVC9OtPbGcVd3JzV5YI6yGltlDH/9zaTcSq6EyDjZ9g42KlDrR6d
         d8enli5Y8yeBPl8RkAQfMBhzdaHX7QAypli60JJuKYkDMQn7wyo4ECzwnD/Euou1lC7f
         gnXMyvbyXRzHs5079OhiT93gfQiNX4drA2vP9BE1AZipphWW6D/AHRXbuePXjehQBlDB
         PQfA==
X-Gm-Message-State: AOAM5337lSRRkgDYcK0E5T+RxOr5/XF1ioRxsBQibq95a5dxmHh/EZs+
        JgRDhcf9eo7etuOaDL5RJlU=
X-Google-Smtp-Source: ABdhPJx/NpwrcIzDK97gPwRoTSSTCvN62dJNu2gtdFTOztTmEIfFe8Dx5k72YddG35iZyhMkaiXc5Q==
X-Received: by 2002:adf:ea4f:: with SMTP id j15mr3069666wrn.421.1629808654366;
        Tue, 24 Aug 2021 05:37:34 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::5d87])
        by smtp.gmail.com with ESMTPSA id u23sm2137450wmc.24.2021.08.24.05.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 05:37:33 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 3/3] staging: r8188eu: remove ethernet.h header file
Date:   Tue, 24 Aug 2021 14:36:21 +0200
Message-Id: <20210824123621.10801-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210824123621.10801-1-straube.linux@gmail.com>
References: <20210824123621.10801-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are only two definitions from ethernet.h used in the driver.
Namely:

#define ETHERNET_HEADER_SIZE           14      /*  Ethernet Header Length */
#define LLC_HEADER_SIZE                6       /*  LLC Header Length */

Both are only used in the file core/rtw_recv.c. Replace the usage of
ETHERNET_HEADER_SIZE with ETH_HLEN, move the definition of LLC_HEADER_SIZE
into rtw_recv.h and remove the now unused ethernet.h header file.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_recv.c      |  3 +--
 drivers/staging/r8188eu/hal/rtl8188eu_recv.c |  1 -
 drivers/staging/r8188eu/include/ethernet.h   | 24 --------------------
 drivers/staging/r8188eu/include/rtw_recv.h   |  2 ++
 drivers/staging/r8188eu/os_dep/recv_linux.c  |  1 -
 5 files changed, 3 insertions(+), 28 deletions(-)
 delete mode 100644 drivers/staging/r8188eu/include/ethernet.h

diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index ea42b4954067..5ff306ef1c5a 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -7,7 +7,6 @@
 #include "../include/drv_types.h"
 #include "../include/recv_osdep.h"
 #include "../include/mlme_osdep.h"
-#include "../include/ethernet.h"
 #include "../include/usb_ops.h"
 #include "../include/wifi.h"
 
@@ -1519,7 +1518,7 @@ static int amsdu_to_msdu(struct adapter *padapter, struct recv_frame *prframe)
 		/* Offset 12 denote 2 mac address */
 		nSubframe_Length = RTW_GET_BE16(pdata + 12);
 
-		if (a_len < (ETHERNET_HEADER_SIZE + nSubframe_Length)) {
+		if (a_len < ETH_HLEN + nSubframe_Length) {
 			DBG_88E("nRemain_Length is %d and nSubframe_Length is : %d\n", a_len, nSubframe_Length);
 			goto exit;
 		}
diff --git a/drivers/staging/r8188eu/hal/rtl8188eu_recv.c b/drivers/staging/r8188eu/hal/rtl8188eu_recv.c
index 666afa69fce6..2da7bde80cc0 100644
--- a/drivers/staging/r8188eu/hal/rtl8188eu_recv.c
+++ b/drivers/staging/r8188eu/hal/rtl8188eu_recv.c
@@ -6,7 +6,6 @@
 #include "../include/drv_types.h"
 #include "../include/recv_osdep.h"
 #include "../include/mlme_osdep.h"
-#include "../include/ethernet.h"
 
 #include "../include/usb_ops.h"
 #include "../include/wifi.h"
diff --git a/drivers/staging/r8188eu/include/ethernet.h b/drivers/staging/r8188eu/include/ethernet.h
deleted file mode 100644
index 898eb296013c..000000000000
--- a/drivers/staging/r8188eu/include/ethernet.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
-/* Copyright(c) 2007 - 2011 Realtek Corporation. */
-
-#ifndef __INC_ETHERNET_H
-#define __INC_ETHERNET_H
-
-#define ETHERNET_ADDRESS_LENGTH		6	/*  Ethernet Address Length */
-#define ETHERNET_HEADER_SIZE		14	/*  Ethernet Header Length */
-#define LLC_HEADER_SIZE			6	/*  LLC Header Length */
-#define TYPE_LENGTH_FIELD_SIZE		2	/*  Type/Length Size */
-#define MINIMUM_ETHERNET_PACKET_SIZE	60	/*  Min Ethernet Packet Size */
-#define MAXIMUM_ETHERNET_PACKET_SIZE	1514	/*  Max Ethernet Packet Size */
-
-/*  Is Multicast Address? */
-#define RT_ETH_IS_MULTICAST(_addr)	((((u8 *)(_addr))[0]&0x01) != 0)
-#define RT_ETH_IS_BROADCAST(_addr)	(			\
-		((u8 *)(_addr))[0] == 0xff &&		\
-		((u8 *)(_addr))[1] == 0xff &&		\
-		((u8 *)(_addr))[2] == 0xff &&		\
-		((u8 *)(_addr))[3] == 0xff &&		\
-		((u8 *)(_addr))[4] == 0xff &&		\
-		((u8 *)(_addr))[5] == 0xff)	/*  Is Broadcast Address? */
-
-#endif /*  #ifndef __INC_ETHERNET_H */
diff --git a/drivers/staging/r8188eu/include/rtw_recv.h b/drivers/staging/r8188eu/include/rtw_recv.h
index 81594e7aed51..2ce7ba99344c 100644
--- a/drivers/staging/r8188eu/include/rtw_recv.h
+++ b/drivers/staging/r8188eu/include/rtw_recv.h
@@ -20,6 +20,8 @@
 
 #define MAX_SUBFRAME_COUNT	64
 
+#define LLC_HEADER_SIZE 6
+
 /* for Rx reordering buffer control */
 struct recv_reorder_ctrl {
 	struct adapter	*padapter;
diff --git a/drivers/staging/r8188eu/os_dep/recv_linux.c b/drivers/staging/r8188eu/os_dep/recv_linux.c
index b4c5333bfff0..31fbc0d5d925 100644
--- a/drivers/staging/r8188eu/os_dep/recv_linux.c
+++ b/drivers/staging/r8188eu/os_dep/recv_linux.c
@@ -10,7 +10,6 @@
 #include "../include/recv_osdep.h"
 
 #include "../include/osdep_intf.h"
-#include "../include/ethernet.h"
 #include "../include/usb_ops.h"
 
 /* init os related resource in struct recv_priv */
-- 
2.32.0

