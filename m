Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE1B38F5C6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 00:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbhEXWrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 18:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbhEXWrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 18:47:04 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02401C061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 15:45:35 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id h3so2906098wmq.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 15:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JM27Fiepo3JuU4IMCBkkqX29MSJl4zpr2RA555O577k=;
        b=MWk5a+BtOdxfktnNqoNeEc7ZYi1sDsPuflrivxStySpXB9qYavLQgZdFLBiDy13rkc
         dv3eMIkOVziPFIud4NdoKxTo4SCv0Xx23VY294FK1nhqInqampdls3u49U+prFmFOaE+
         SU2gqiWbGXxDBkZH+DK9xnzUBQK6NEv+4qrNSlzrbxnGTMif+xF+0VDnLj4EDcNTPgeY
         gT6GJZRTnP+tDaVX8N0QFKUwqtHQyiDnMgrOCwu//6xQ2W3hZHM2s1vIoTUD4Zle/zHu
         9Pz78RnYc0TpTypK9KvX5jZ7/IoOdNexjkom0zz94KQgkTZPWJju4tIS4INZV122JneC
         AiHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JM27Fiepo3JuU4IMCBkkqX29MSJl4zpr2RA555O577k=;
        b=KyFfknuuPyvr9WNNSkipSftNB2XB3p5uvCIXsLqzO4EDmCakjTjHUWu+2X71OJLCqR
         y+aEDU4ks6W4d7oK1tv/d7jpBenWFSjg/4h8oH2KQh+1nKbrMwiDFCRHj3ItrG0Y6HOn
         UHnQorK28v0RQvqn9cgWL/PYi7a8YCllwNlotlc46ZKIPsmQNqf5rEYTYYWb3+WsDjx9
         3qE/A5G+VOEuZ3JYEFXXbG5HupZqFGU1y5Re84hnr9MyV11P0vHCXk8gpJo1UhjCYpU0
         rfyfL1v11Si+4MLTRyBvpUnmrhcRr6GrKD2aCT69Reweb7Ucixu3zEZV+tEGmjTsqR00
         IRgg==
X-Gm-Message-State: AOAM532kuPZaWB4bmJ6YeKykoM0u8H6VnYB60PmA7nnWAWwmRwmfMelS
        /x5Y4qL4WLctTrmeTNkcJ1OfTw==
X-Google-Smtp-Source: ABdhPJwNoGzpsTyPmtZAgP/G1MktXW31VWg7edHaJaei2RDKTIF40g9d1tW/4iotJ8h8Owsrax6w3Q==
X-Received: by 2002:a7b:c346:: with SMTP id l6mr20997715wmj.109.1621896333552;
        Mon, 24 May 2021 15:45:33 -0700 (PDT)
Received: from KernelVM.home (5.d.e.a.c.b.a.1.5.0.9.4.d.7.7.d.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:d77d:4905:1abc:aed5])
        by smtp.gmail.com with ESMTPSA id l8sm13669050wrw.71.2021.05.24.15.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 15:45:33 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, straube.linux@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8188eu: remove ASSERT and ODM_RT_ASSERT macros
Date:   Mon, 24 May 2021 23:45:32 +0100
Message-Id: <20210524224532.1230-1-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the ASSERT and ODM_RT_ASSERT macros from include/odm_debug.h
as they are unnecessary.

ASSERT does nothing, compiling to a single empty statement.
ODM_RT_ASSERT is used in only one place, in the ODM_RAStateCheck
function with hal/odm.c - it seems to have been intended as an
assertion of some kind, but given it is always called with false
here, there is little point in it not just being a pr_info() call.

Also, the lines relating to the file, function and line number are
not needed as the pr_info() with the function name and error message
is sufficient should anyone wish to track down this error at a source
level, within what is currently a relatively small function.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/rtl8188eu/hal/odm.c           |  2 +-
 drivers/staging/rtl8188eu/include/odm_debug.h | 13 -------------
 2 files changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/odm.c b/drivers/staging/rtl8188eu/hal/odm.c
index 4d659a812aed..b800d0c6dff5 100644
--- a/drivers/staging/rtl8188eu/hal/odm.c
+++ b/drivers/staging/rtl8188eu/hal/odm.c
@@ -824,7 +824,7 @@ bool ODM_RAStateCheck(struct odm_dm_struct *pDM_Odm, s32 RSSI, bool bForceUpdate
 		LowRSSIThreshForRA += GoUpGap;
 		break;
 	default:
-		ODM_RT_ASSERT(pDM_Odm, false, ("wrong rssi level setting %d !", *pRATRState));
+		pr_info("%s(): wrong rssi level setting %d!\n", __func__, *pRATRState);
 		break;
 	}
 
diff --git a/drivers/staging/rtl8188eu/include/odm_debug.h b/drivers/staging/rtl8188eu/include/odm_debug.h
index 857c64b8d2f4..3c576a029c94 100644
--- a/drivers/staging/rtl8188eu/include/odm_debug.h
+++ b/drivers/staging/rtl8188eu/include/odm_debug.h
@@ -71,10 +71,6 @@
 #define RT_PRINTK(fmt, args...)				\
 	pr_info("%s(): " fmt, __func__, ## args);
 
-#ifndef ASSERT
-	#define ASSERT(expr)
-#endif
-
 #define ODM_RT_TRACE(pDM_Odm, comp, level, fmt)				\
 	if (((comp) & pDM_Odm->DebugComponents) &&			\
 	    (level <= pDM_Odm->DebugLevel)) {				\
@@ -82,15 +78,6 @@
 		RT_PRINTK fmt;						\
 	}
 
-#define ODM_RT_ASSERT(pDM_Odm, expr, fmt)				\
-	if (!(expr)) {							\
-		pr_info("Assertion failed! %s at ......\n", #expr);	\
-		pr_info("      ......%s,%s,line=%d\n", __FILE__,	\
-			__func__, __LINE__);				\
-		RT_PRINTK fmt;						\
-		ASSERT(false);						\
-	}
-
 void ODM_InitDebugSetting(struct odm_dm_struct *pDM_Odm);
 
 #endif	/*  __ODM_DBG_H__ */
-- 
2.30.2

