Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB76B35EDEE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 08:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349515AbhDNG5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 02:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349720AbhDNG4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 02:56:55 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C6BC061343
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 23:56:10 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id b17so13731678pgh.7
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 23:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jKWFgdob/YlSgZVEF7gL6K3vLHR0vBCSyJL9Ey7fyRQ=;
        b=kEnkR7Shph4FnLF7lE2LSHNqZIKGyBPPCa2lIDahpz+iDygI+2HL41VNGLE2wsJpOf
         gXJNb42xBbA/xW5k6ShsNQXwdZXWmZg0E0Z2NxIY4y39l7IilXqdzTrdyDIMHRFHAisQ
         BaTh0YEywwIThZE5By8pt+GntZsnFRMOfCzLkh2P0wB9LNABAGGCn+anPqt7FuWUYtNM
         vMBFnhd9iY2bqzVsFgJ8Q0WQon/2ZUS2vZ77rhX51tSyoghTh3GsBDy2UoO8xoyeQc4L
         bdOtF8cZbSnCF38oqcEjcOMpqgll6nz5UYE84kNrMwyDMrWs3hucRih4G6QZ2wJdBJCy
         Sa+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jKWFgdob/YlSgZVEF7gL6K3vLHR0vBCSyJL9Ey7fyRQ=;
        b=Hn+qZQODYEFn4yxegZ5g/7gsNi4pxbRNwFkZ2q64kKWClvh+C7gUbKJ0E4F3wt++b/
         4A79JjwQQ4pzvIaDkJXeIM5yFL5a2dYxWyJsz6AJx4ph2S3BHfMX2OVKTsHDUWrOuyGn
         mR3m2uX/y7uq3k4HCNcPQsbVUgAzGbZiEjr4gKmIf02LFzq97U3ZhOZm72MWm4XTd1DH
         HHnEYsHhyoE1Vhcz9tLkt6S8TnzfTst8kayAmLzrWgMGqutdQ2/4ESkBqWv5n7/9H/IA
         2IlAxd5tbsBQSqKqV25nuOj3CoI5Y1y7j2kBqusi5yELgDvVGWGZHzwjBLUP4y+Cze+2
         oerw==
X-Gm-Message-State: AOAM531rorsDtWCc4xlsSgKqZEB1VDuEUW/Y7OjlXvYwgnQw1NDxbRAD
        F7YQzYgUMjdd4yDO1QcyX/4=
X-Google-Smtp-Source: ABdhPJztzHIj9VEny0e41k/MTxEPjFQc24Yxct2UxJdRHtuYJgp8V2hkC+I6+Q5XCFUDtVTctgqLVQ==
X-Received: by 2002:a63:a0c:: with SMTP id 12mr33479455pgk.247.1618383369750;
        Tue, 13 Apr 2021 23:56:09 -0700 (PDT)
Received: from kali ([103.141.87.253])
        by smtp.gmail.com with ESMTPSA id m14sm17566246pgb.0.2021.04.13.23.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 23:56:09 -0700 (PDT)
Date:   Wed, 14 Apr 2021 12:26:01 +0530
From:   Mitali Borkar <mitaliborkar810@gmail.com>
To:     gregkh@linuxfoundation.org, davem@davemloft.net, kuba@kernel.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, mitali_s@me.iitr.ac.in
Subject: [PATCH v2 4/5] staging: rtl8192e: rectified spelling mistake and
 replace memcmp with ether_oui_equal
Message-ID: <eda8d3401f2f7ff7a61137b4935c6ccb09112e52.1618380932.git.mitaliborkar810@gmail.com>
References: <cover.1618380932.git.mitaliborkar810@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1618380932.git.mitaliborkar810@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added a generic function of static inline bool in
include/linux/etherdevice.h to replace memcmp with
ether_oui_equal throughout the execution.
Corrected the misspelled words in this file.

Signed-off-by: Mitali Borkar <mitaliborkar810@gmail.com>
---
 
Changes from v1:- Rectified spelling mistake and replaced memcmp with
ether_oui_equal.

 drivers/staging/rtl8192e/rtl819x_HTProc.c | 48 +++++++++++------------
 include/linux/etherdevice.h               |  5 +++
 2 files changed, 29 insertions(+), 24 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index ec6b46166e84..ce58feb2af9a 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -43,7 +43,7 @@ u16 MCS_DATA_RATE[2][2][77] = {
 	 810, 720, 810, 900, 900, 990} }
 };
 
-static u8 UNKNOWN_BORADCOM[3] = {0x00, 0x14, 0xbf};
+static u8 UNKNOWN_BROADCOM[3] = {0x00, 0x14, 0xbf};
 
 static u8 LINKSYSWRT330_LINKSYSWRT300_BROADCOM[3] = {0x00, 0x1a, 0x70};
 
@@ -146,16 +146,16 @@ bool IsHTHalfNmodeAPs(struct rtllib_device *ieee)
 	bool			retValue = false;
 	struct rtllib_network *net = &ieee->current_network;
 
-	if ((memcmp(net->bssid, BELKINF5D8233V1_RALINK, 3) == 0) ||
-	    (memcmp(net->bssid, BELKINF5D82334V3_RALINK, 3) == 0) ||
-	    (memcmp(net->bssid, PCI_RALINK, 3) == 0) ||
-	    (memcmp(net->bssid, EDIMAX_RALINK, 3) == 0) ||
-	    (memcmp(net->bssid, AIRLINK_RALINK, 3) == 0) ||
+	if ((ether_oui_equal(net->bssid, BELKINF5D8233V1_RALINK) == 0) ||
+	    (ether_oui_equal(net->bssid, BELKINF5D82334V3_RALINK) == 0) ||
+	    (ether_oui_equal(net->bssid, PCI_RALINK) == 0) ||
+	    (ether_oui_equal(net->bssid, EDIMAX_RALINK) == 0) ||
+	    (ether_oui_equal(net->bssid, AIRLINK_RALINK) == 0) ||
 	    (net->ralink_cap_exist))
 		retValue = true;
-	else if (!memcmp(net->bssid, UNKNOWN_BORADCOM, 3) ||
-		 !memcmp(net->bssid, LINKSYSWRT330_LINKSYSWRT300_BROADCOM, 3) ||
-		 !memcmp(net->bssid, LINKSYSWRT350_LINKSYSWRT150_BROADCOM, 3) ||
+	else if (ether_oui_equal(net->bssid, UNKNOWN_BROADCOM) ||
+		 ether_oui_equal(net->bssid, LINKSYSWRT330_LINKSYSWRT300_BROADCOM) ||
+		 ether_oui_equal(net->bssid, LINKSYSWRT350_LINKSYSWRT150_BROADCOM) ||
 		 (net->broadcom_cap_exist))
 		retValue = true;
 	else if (net->bssht.bd_rt2rt_aggregation)
@@ -179,26 +179,26 @@ static void HTIOTPeerDetermine(struct rtllib_device *ieee)
 			pHTInfo->IOTPeer = HT_IOT_PEER_92U_SOFTAP;
 	} else if (net->broadcom_cap_exist) {
 		pHTInfo->IOTPeer = HT_IOT_PEER_BROADCOM;
-	} else if (!memcmp(net->bssid, UNKNOWN_BORADCOM, 3) ||
-		 !memcmp(net->bssid, LINKSYSWRT330_LINKSYSWRT300_BROADCOM, 3) ||
-		 !memcmp(net->bssid, LINKSYSWRT350_LINKSYSWRT150_BROADCOM, 3)) {
+	} else if (ether_oui_equal(net->bssid, UNKNOWN_BROADCOM) ||
+		   ether_oui_equal(net->bssid, LINKSYSWRT330_LINKSYSWRT300_BROADCOM) ||
+		   ether_oui_equal(net->bssid, LINKSYSWRT350_LINKSYSWRT150_BROADCOM)) {
 		pHTInfo->IOTPeer = HT_IOT_PEER_BROADCOM;
-	} else if ((memcmp(net->bssid, BELKINF5D8233V1_RALINK, 3) == 0) ||
-		 (memcmp(net->bssid, BELKINF5D82334V3_RALINK, 3) == 0) ||
-		 (memcmp(net->bssid, PCI_RALINK, 3) == 0) ||
-		 (memcmp(net->bssid, EDIMAX_RALINK, 3) == 0) ||
-		 (memcmp(net->bssid, AIRLINK_RALINK, 3) == 0) ||
-		  net->ralink_cap_exist) {
+	} else if ((ether_oui_equal(net->bssid, BELKINF5D8233V1_RALINK) == 0) ||
+		   (ether_oui_equal(net->bssid, BELKINF5D82334V3_RALINK) == 0) ||
+		   (ether_oui_equal(net->bssid, PCI_RALINK) == 0) ||
+		   (ether_oui_equal(net->bssid, EDIMAX_RALINK) == 0) ||
+		   (ether_oui_equal(net->bssid, AIRLINK_RALINK) == 0) ||
+		   net->ralink_cap_exist) {
 		pHTInfo->IOTPeer = HT_IOT_PEER_RALINK;
 	} else if ((net->atheros_cap_exist) ||
-		(memcmp(net->bssid, DLINK_ATHEROS_1, 3) == 0) ||
-		(memcmp(net->bssid, DLINK_ATHEROS_2, 3) == 0)) {
+		   (ether_oui_equal(net->bssid, DLINK_ATHEROS_1) == 0) ||
+		   (ether_oui_equal(net->bssid, DLINK_ATHEROS_2) == 0)) {
 		pHTInfo->IOTPeer = HT_IOT_PEER_ATHEROS;
-	} else if ((memcmp(net->bssid, CISCO_BROADCOM, 3) == 0) ||
-		  net->cisco_cap_exist) {
+	} else if ((ether_oui_equal(net->bssid, CISCO_BROADCOM) == 0) ||
+		   net->cisco_cap_exist) {
 		pHTInfo->IOTPeer = HT_IOT_PEER_CISCO;
-	} else if ((memcmp(net->bssid, LINKSYS_MARVELL_4400N, 3) == 0) ||
-		  net->marvell_cap_exist) {
+	} else if ((ether_oui_equal(net->bssid, LINKSYS_MARVELL_4400N) == 0) ||
+		   net->marvell_cap_exist) {
 		pHTInfo->IOTPeer = HT_IOT_PEER_MARVELL;
 	} else if (net->airgo_cap_exist) {
 		pHTInfo->IOTPeer = HT_IOT_PEER_AIRGO;
diff --git a/include/linux/etherdevice.h b/include/linux/etherdevice.h
index 2e5debc0373c..6a1a63168319 100644
--- a/include/linux/etherdevice.h
+++ b/include/linux/etherdevice.h
@@ -87,6 +87,11 @@ static inline bool is_link_local_ether_addr(const u8 *addr)
 #endif
 }
 
+static inline bool ether_oui_equal(const u8 *addr, const u8 *oui)
+{
+return addr[0] == oui[0] && addr[1] == oui[1] && addr[2] == oui[2];
+}
+
 /**
  * is_zero_ether_addr - Determine if give Ethernet address is all zeros.
  * @addr: Pointer to a six-byte array containing the Ethernet address
-- 
2.30.2

