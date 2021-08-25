Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2E4B3F72AC
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 12:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238626AbhHYKKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 06:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235904AbhHYKKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 06:10:30 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7446EC061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 03:09:44 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id d22-20020a1c1d16000000b002e7777970f0so3859446wmd.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 03:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+eEKN9KrLV15komXvvogOZxKMISFsI5tmxYyQHSYLRQ=;
        b=BOG0eqG1b7xIzdC5C7PHnW0lrCRGCryZGUclMfK0J+rMmw7Uap44aOyE4WkJObjNR0
         /spH6lHBMFJeCLERhhWC+gTVCTtdMw9HDgSGXxp51sBQQG80kb9HvUkP2L/c1vFyaf4p
         X/FZM5Rj4s+2c+TLKC+3UpqAtUR9hN+D/84qkIwaRYXD2aud7GhsDdNlOz9pW+VPCSaj
         6GC1MYbRZb3Q/sWIdXcgrrXbsvjVn2CzhN8FVwXJcZi//II8YBm3aJRxMsfpsYnYaHa3
         n034Tc6eijpC2fFo5iMVEKUAH67X91qxyW8L2GMtElDdSCVk8MnR6Wf2Tw0Fp0b+Mir3
         3xHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+eEKN9KrLV15komXvvogOZxKMISFsI5tmxYyQHSYLRQ=;
        b=Ersqk3I+8Br03b+QxKq7yQBOAilWQibitzE09S88yEiL1ydDpy2R/ZYnQ/pmF2bcbx
         pV/Vj1J08w+Y87RY2xhFHfT4hGdZf8Bk6OEnx5/fkvkMzZDXiWtX0N1qEAm+QxPmw4Kg
         ttrdQf/pp369wygpAqWDrcHaUpOEAMOb5OYCYDJBMIRxo0pZjUyNPgmiXjAF7M56x5Bd
         Gc8dzD1TuT8ehF2TFqAVNtwnIGBV9RSpK56dLXwK/jX0xtf/xZQRElYjJZi/vTBC37G5
         mjgJVFtBY91v9ppyzihDh9DeKFPCmlYny2HOdfha1Tz7RSWadg9BKeR648t/U+xNEKNA
         a1hQ==
X-Gm-Message-State: AOAM533sROuPVtDbDjLx+6qrWLW/Lbh24HL2o6L/Y88bvdvR/fea20np
        bTsCzyX7CCC5fx6HF7Bw2LQ=
X-Google-Smtp-Source: ABdhPJzKhTH+KbG0ANUkbnN3LjAc6WTnWvPStRd7r4hswHqLyQ/DRGWWuQf4f5JZaTx6ptelAbAtFA==
X-Received: by 2002:a7b:cc16:: with SMTP id f22mr8333057wmh.99.1629886182878;
        Wed, 25 Aug 2021 03:09:42 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::5d87])
        by smtp.gmail.com with ESMTPSA id n10sm20444546wrw.76.2021.08.25.03.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 03:09:42 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: rtl8723bs: remove header file ethernet.h
Date:   Wed, 25 Aug 2021 12:08:42 +0200
Message-Id: <20210825100842.13217-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The header file ehternet.h defines only two constants.

#define ETHERNET_HEADER_SIZE   14          /*  Ethernet Header Length */
#define LLC_HEADER_SIZE         6          /*  LLC Header Length */

Both are only used in the file core/rtw_recv.c and ETHERNET_HEADER_SIZE
just duplicates the in-kernel constant ETH_HLEN. Replace the usage of
ETHERNET_HEADER_SIZE with ETH_HLEN, move the definition of LLC_HEADER_SIZE
into rtw_rev.h (renamed to LLC_HEADER_LENGTH) and remove the now unused
header file ethernet.h.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_recv.c     |  6 +++---
 drivers/staging/rtl8723bs/include/drv_types.h |  1 -
 drivers/staging/rtl8723bs/include/ethernet.h  | 14 --------------
 drivers/staging/rtl8723bs/include/rtw_recv.h  |  2 ++
 4 files changed, 5 insertions(+), 18 deletions(-)
 delete mode 100644 drivers/staging/rtl8723bs/include/ethernet.h

diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
index d4c1725718d9..5b0a596eefb7 100644
--- a/drivers/staging/rtl8723bs/core/rtw_recv.c
+++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
@@ -480,7 +480,7 @@ static union recv_frame *portctrl(struct adapter *adapter, union recv_frame *pre
 			prtnframe = precv_frame;
 
 			/* get ether_type */
-			ptr = ptr+pfhdr->attrib.hdrlen+pfhdr->attrib.iv_len+LLC_HEADER_SIZE;
+			ptr = ptr + pfhdr->attrib.hdrlen + pfhdr->attrib.iv_len + LLC_HEADER_LENGTH;
 			memcpy(&be_tmp, ptr, 2);
 			ether_type = ntohs(be_tmp);
 
@@ -1485,7 +1485,7 @@ static signed int validate_recv_frame(struct adapter *adapter, union recv_frame
 			/*  dump eapol */
 			rtw_hal_get_def_var(adapter, HAL_DEF_DBG_DUMP_RXPKT, &(bDumpRxPkt));
 			/*  get ether_type */
-			memcpy(&eth_type, ptr + pattrib->hdrlen + pattrib->iv_len + LLC_HEADER_SIZE, 2);
+			memcpy(&eth_type, ptr + pattrib->hdrlen + pattrib->iv_len + LLC_HEADER_LENGTH, 2);
 			eth_type = ntohs((unsigned short) eth_type);
 #endif
 		}
@@ -1588,7 +1588,7 @@ static int amsdu_to_msdu(struct adapter *padapter, union recv_frame *prframe)
 		/* Offset 12 denote 2 mac address */
 		nSubframe_Length = get_unaligned_be16(pdata + 12);
 
-		if (a_len < (ETHERNET_HEADER_SIZE + nSubframe_Length))
+		if (a_len < ETH_HLEN + nSubframe_Length)
 			break;
 
 		sub_pkt = rtw_os_alloc_msdu_pkt(prframe, nSubframe_Length, pdata);
diff --git a/drivers/staging/rtl8723bs/include/drv_types.h b/drivers/staging/rtl8723bs/include/drv_types.h
index 580028d28c42..c192b5a1a067 100644
--- a/drivers/staging/rtl8723bs/include/drv_types.h
+++ b/drivers/staging/rtl8723bs/include/drv_types.h
@@ -57,7 +57,6 @@
 
 #include <linux/ip.h>
 #include <linux/if_ether.h>
-#include <ethernet.h>
 
 #define SPEC_DEV_ID_NONE BIT(0)
 #define SPEC_DEV_ID_DISABLE_HT BIT(1)
diff --git a/drivers/staging/rtl8723bs/include/ethernet.h b/drivers/staging/rtl8723bs/include/ethernet.h
deleted file mode 100644
index 59899ab52aab..000000000000
--- a/drivers/staging/rtl8723bs/include/ethernet.h
+++ /dev/null
@@ -1,14 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/******************************************************************************
- *
- * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
- *
- ******************************************************************************/
-/*! \file */
-#ifndef __INC_ETHERNET_H
-#define __INC_ETHERNET_H
-
-#define ETHERNET_HEADER_SIZE	14		/*  Ethernet Header Length */
-#define LLC_HEADER_SIZE		6		/*  LLC Header Length */
-
-#endif /*  #ifndef __INC_ETHERNET_H */
diff --git a/drivers/staging/rtl8723bs/include/rtw_recv.h b/drivers/staging/rtl8723bs/include/rtw_recv.h
index 9c3cdcc990fa..a88b7c088a86 100644
--- a/drivers/staging/rtl8723bs/include/rtw_recv.h
+++ b/drivers/staging/rtl8723bs/include/rtw_recv.h
@@ -35,6 +35,8 @@
 
 #define MAX_SUBFRAME_COUNT	64
 
+#define LLC_HEADER_LENGTH	6
+
 /* for Rx reordering buffer control */
 struct recv_reorder_ctrl {
 	struct adapter	*padapter;
-- 
2.32.0

