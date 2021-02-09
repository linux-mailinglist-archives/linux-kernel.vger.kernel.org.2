Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E44E315142
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 15:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbhBIOLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 09:11:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbhBIOLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 09:11:39 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34477C061794
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 06:10:57 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id o24so3596204wmh.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 06:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DfSxnDPOrIUn/HEZGYbaIQRBPrxMTgYuKgiiI2/TE/Q=;
        b=InGYPcFmDfAAcGsK5hS1o03zp9pfkUSJCwwxaGZZnUe9b+/hyS6sRwowut59cNAMqE
         0N0fS5PdrlZv7DbzJK/yLBCVYsmAnJdoxEv8Vww4croVaZUXwSBESUWVT+dEvfSZd6AO
         M85H/fWUYtbX8u2G5L5p44aoPUgEfO0+SNhQG17Av98oQ+z++ophkCTp+rELD3DFQ/Ap
         UA10oZ3cxnK3QSZthW1TDyo3SH1KhYUtH9ppOmPUqDzmwdKiyEox9yfrfg8qL7zOsosU
         Jf1CkcNhkkVCWp0t/itxgXtr7P8hADQ+XqVxgQVpgNx7X+Dosym/J5zUQ7N9j7AEKs4H
         K1Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DfSxnDPOrIUn/HEZGYbaIQRBPrxMTgYuKgiiI2/TE/Q=;
        b=reHNmsP335Uk9UhXwuRkwB7IgScWBEWRUCtKy8KSptSw04uV7LaYdt0x0MsGQsYomW
         iH5pbHcCS4Y/yAyheVA0IFuqYUSfP4tPQbmHmOzYXlX/hYj5i15tLrOtYzzLDvs/iY9E
         5FvBrXIFK/e9LVyAjn0Rra8VxyNfGkSrxWPLYdKxClnDTj5TgPypkclYYBEzztQ20kek
         B/8b5XMuWIwPpE4vJ/tSD29KU3mTfQxQHqzjQlkgQnvIw3umprhBtPsR9KOV/ka6UJub
         +eCzdV9DbSrKayOpsFcsuvZ0EdPv39XGVPb9m48YwCIWjPS8ZenTTRyRVhq/TxrwUBnw
         Rp3w==
X-Gm-Message-State: AOAM531nzQW93k2haoLbqZx0IXRyq18KMQlYKovPP/S7e5bqMuvCwkK9
        /3nNN9wBMNBywfvfKHJ5o5FJLQ==
X-Google-Smtp-Source: ABdhPJy/onNmAvIvp0kgs2Fa63R01Dh05mS6q/CTgKfnQyFVLGOy/NHfhJa3xA3lQZdMfoXFpOvI6Q==
X-Received: by 2002:a1c:1fca:: with SMTP id f193mr3685023wmf.102.1612879855283;
        Tue, 09 Feb 2021 06:10:55 -0800 (PST)
Received: from localhost.localdomain (2.0.5.1.1.6.3.8.5.c.c.3.f.b.d.3.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16:0:3dbf:3cc5:8361:1502])
        by smtp.gmail.com with ESMTPSA id a84sm4443695wme.12.2021.02.09.06.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 06:10:54 -0800 (PST)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     romain.perier@gmail.com, apais@linux.microsoft.com,
        singhalsimran0@gmail.com, insafonov@gmail.com,
        ross.schm.dev@gmail.com, foxhlchen@gmail.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: remove typedefs from rtl8723b_recv.h
Date:   Tue,  9 Feb 2021 14:10:51 +0000
Message-Id: <20210209141051.4739-1-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove typedefs from include/rtl8723b_recv.h and convert one usage in
hal/rtl8723bs_recv.c to use the actual structure name in its pointer
declaration. Fixes two checkpatch warnings.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c    | 2 +-
 drivers/staging/rtl8723bs/include/rtl8723b_recv.h | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c b/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
index 1fbf89cb72d0..2d15a5f7648d 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
@@ -24,7 +24,7 @@ static void update_recvframe_attrib(struct adapter *padapter,
 {
 	struct rx_pkt_attrib *pattrib;
 	struct recv_stat report;
-	PRXREPORT prxreport = (PRXREPORT)&report;
+	struct rxreport_8723b *prxreport = (struct rxreport_8723b *)&report;
 
 	report.rxdw0 = prxstat->rxdw0;
 	report.rxdw1 = prxstat->rxdw1;
diff --git a/drivers/staging/rtl8723bs/include/rtl8723b_recv.h b/drivers/staging/rtl8723bs/include/rtl8723b_recv.h
index fad6749af768..60a1df703c8e 100644
--- a/drivers/staging/rtl8723bs/include/rtl8723b_recv.h
+++ b/drivers/staging/rtl8723bs/include/rtl8723b_recv.h
@@ -9,7 +9,7 @@
 
 #include <rtl8192c_recv.h>
 
-typedef struct rxreport_8723b {
+struct rxreport_8723b {
 	/* DWORD 0 */
 	u32 pktlen:14;
 	u32 crc32:1;
@@ -79,9 +79,9 @@ typedef struct rxreport_8723b {
 
 	/* DWORD 5 */
 	u32 tsfl;
-} RXREPORT, *PRXREPORT;
+};
 
-typedef struct phystatus_8723b {
+struct phystatus_8723b {
 	u32 rxgain_a:7;
 	u32 trsw_a:1;
 	u32 rxgain_b:7;
@@ -123,7 +123,7 @@ typedef struct phystatus_8723b {
 	u32 anttrainen:1;
 	u32 antselb:1;
 	u32 antsel:1;
-} PHYSTATUS, *PPHYSTATUS;
+};
 
 s32 rtl8723bs_init_recv_priv(struct adapter *padapter);
 void rtl8723bs_free_recv_priv(struct adapter *padapter);
-- 
2.29.2

