Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA52314EB1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 13:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbhBIMIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 07:08:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbhBIMH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 07:07:26 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 864A7C06178A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 04:06:46 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id 7so21380632wrz.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 04:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mnnGb8uYfAKo5j4celfDTPJ3dArWMa9VeSJuwnZYFt4=;
        b=wEKJaPKkgCJ+ae8GhAdCtynKzIbwKAfdC/y0O5HSYsLeIAkyIaUlg58XgsbE3UGzeq
         P7XjTnbUrCapMasS52nmq7yNQ84qJu5UiCy5Nc1lm4Y/y5s1gpL2OVo1+73TnxyZ6sav
         0yTI6HTYNXHA5FH88j1N2f+AUMvBaBHq5Ghy6vqxYczSjA9pB/NpAgsGBQ6Evj/dcz7Y
         cQEMwGp4tJWB1J8wWFUgcO8FzX0uI0apzLdVcgfzOP7PHuGvzOIUiSMA4vFCehXOqz/P
         i8t3OllBfZ1vIaNmIfPRhfijdGdXOYwced/mNIAG7o0ISPpc+Nmqwi3GbhDneXkp06sy
         B9EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mnnGb8uYfAKo5j4celfDTPJ3dArWMa9VeSJuwnZYFt4=;
        b=rv+Q7wxUKV4GD6Jd/SaGOI4pPaX+BtVFzIGKYAijJ9Ui0GZVWSvl8Z+VVGYwzQsarK
         NKn02NPVXoGOVA445hSQEfAm9UANqNQVjg+S11oRWpqF2sl9IC69goMvqKKfRFqQaZhF
         N37qUt5klyvMFKh30g8n4PvfJimCmVypY8HVs748AXhsZmMDmLeUGo//nf0Mhyfxs9XO
         d7F+Q2s+S4fxRdo5GfoMDcPnfISe8IY0/9OhOWBllfjDUnSsvxe9LWLMcaQfHjoUclAf
         LHhu2u4PzG41HddaHyQ1z9ccFMzcch4drYff4U1m80Ny+RAfcT6FMHDQR8nfeAGctyqW
         tqDg==
X-Gm-Message-State: AOAM533kCWDJQPOdODsC42xcOXnjqUn74FIUUsMAhevz4WHjSPNf10FI
        cmhzWdw8d5my5BMp6Ic107BtpA==
X-Google-Smtp-Source: ABdhPJx2hxuqk9YVJYljBUWNo1jn7M1UjgUr/ztTa6I0vGJ6tqK3g/UXkeKiSL3eAOyFQNOIKnvlsA==
X-Received: by 2002:a5d:6c66:: with SMTP id r6mr24586009wrz.86.1612872405309;
        Tue, 09 Feb 2021 04:06:45 -0800 (PST)
Received: from localhost.localdomain (2.0.5.1.1.6.3.8.5.c.c.3.f.b.d.3.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16:0:3dbf:3cc5:8361:1502])
        by smtp.gmail.com with ESMTPSA id z63sm4511330wme.8.2021.02.09.04.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 04:06:44 -0800 (PST)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: fix blank lines and comments in rtl8723b_hal.h
Date:   Tue,  9 Feb 2021 12:06:41 +0000
Message-Id: <20210209120641.3964-1-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary blank line, and move close of multiple-line comments
to their own trailing lines. This fixes four checkpatch warnings and one
checkpatch check notice for the include/rtl8723b_hal.h file.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/rtl8723bs/include/rtl8723b_hal.h | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtl8723b_hal.h b/drivers/staging/rtl8723bs/include/rtl8723b_hal.h
index f36516fa84c7..8e6e972dd843 100644
--- a/drivers/staging/rtl8723bs/include/rtl8723b_hal.h
+++ b/drivers/staging/rtl8723bs/include/rtl8723b_hal.h
@@ -42,11 +42,13 @@ struct rt_firmware_hdr {
 
 	/*  LONG WORD 0 ---- */
 	__le16 signature;  /* 92C0: test chip; 92C, 88C0: test chip;
-			    * 88C1: MP A-cut; 92C1: MP A-cut */
+			    * 88C1: MP A-cut; 92C1: MP A-cut
+			    */
 	u8 category;	   /* AP/NIC and USB/PCI */
 	u8 function;	   /* Reserved for different FW function indications,
 			    * for further use when driver needs to download
-			    * different FW in different conditions. */
+			    * different FW in different conditions.
+			    */
 	__le16 version;    /* FW Version */
 	__le16 subversion; /* FW Subversion, default 0x00 */
 
@@ -135,7 +137,6 @@ struct rt_firmware_hdr {
 #define WMM_NORMAL_PAGE_NUM_LPQ_8723B 0x20
 #define WMM_NORMAL_PAGE_NUM_NPQ_8723B 0x20
 
-
 #include "HalVerDef.h"
 #include "hal_com.h"
 
@@ -149,7 +150,8 @@ struct rt_firmware_hdr {
 #define EFUSE_MAX_SECTION_8723B      64
 
 #define EFUSE_IC_ID_OFFSET 506 /* For some inferiority IC purpose.
-				* Added by Roger, 2009.09.02. */
+				* Added by Roger, 2009.09.02.
+				*/
 #define AVAILABLE_EFUSE_ADDR(addr) (addr < EFUSE_REAL_CONTENT_LEN_8723B)
 
 #define EFUSE_ACCESS_ON  0x69 /* For RTL8723 only. */
@@ -173,7 +175,8 @@ typedef enum _C2H_EVT {
 	C2H_TSF = 1,
 	C2H_AP_RPT_RSP = 2,
 	C2H_CCX_TX_RPT = 3, /* The FW notify the report
-			     * of the specific tx packet. */
+			     * of the specific tx packet.
+			     */
 	C2H_BT_RSSI = 4,
 	C2H_BT_OP_MODE = 5,
 	C2H_EXT_RA_RPT = 6,
-- 
2.29.2

