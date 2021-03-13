Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60418339F88
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 18:34:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234147AbhCMRdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 12:33:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234070AbhCMRdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 12:33:04 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF788C061574
        for <linux-kernel@vger.kernel.org>; Sat, 13 Mar 2021 09:33:03 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id x7-20020a17090a2b07b02900c0ea793940so12283211pjc.2
        for <linux-kernel@vger.kernel.org>; Sat, 13 Mar 2021 09:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=bKA1UktvWcJyakRtzZ4ERgYmauXN2IHyEOYSixvbU/c=;
        b=mAycPwOSWTLs3za00O6QTlslQugjOaAKbLaaw6BtCFt27jVEAclwXSfXDFB05jP6GB
         NtSZX2/WpeNceGA76qixCjVG/yNOCkLuhQgAOnt7vmpOwQ5jdN0n1HJT7/boV2TeC0sE
         JDsih9f9IpqOJLepX0BIcnv5I/qdcYWW7f/SLY+g9jnXXK23t44sUXZoN1iN8eJb/yS8
         tcb7l6NE+QnaKDV0hdvDp9CZ7VEL0oQaBcLbv7gfWtNwpZvYimitiv9dgt9uOZxVD2BA
         hLinN596+UrGxepi+uiOgKpsWmd+pDXaC7R8iZefhPZJCdT4m+ES8OuYIpAdX+n+PxvJ
         6W5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bKA1UktvWcJyakRtzZ4ERgYmauXN2IHyEOYSixvbU/c=;
        b=HjR+v0Pw/oB4QOv5BrT1DkBOdjEK+tFhlBTTQUcPM1INmgY5+14AEziyG6owmmP1sw
         1kF2I0OXJ5zjEsdpqKo+4hxjA+F0AB3V/hMaNXIycNAIpvTa8T3KTpaYFAd3kUs0Z1CJ
         fTDrzJa3Q6Bfi2dcI7aUiYvak0L4V/PnWUKTr9mgw7KF33S3Fhr8BIS+KTLVNGRpK9+q
         k3Ke05xLRIXkubqgSlzbKkzNg4ZwPbtJcADcm0BuUVByM5UFhQZMOsCvmnVyf4isQRMX
         0KbV/sClk+g1zCYXhS3Vc6hdVgLkAD3ET4AW3NKtqRvs79JBWaXdHJ4N2gCAKIBsRZHN
         eygw==
X-Gm-Message-State: AOAM532c7EL4A2v9c4cKNzatXQ0gqBtz/QZQ9BzMlQj5J4nkKDWqQMjR
        F6VFBfhIt2JdMB2gaKS1t/A=
X-Google-Smtp-Source: ABdhPJyFbUGGa344uFqWZu3UZcafx8taT94nXcL9egrrXcSVr3vfUQ0jvS1411WQUyyv7+CiflJE3Q==
X-Received: by 2002:a17:90a:bb07:: with SMTP id u7mr4584129pjr.49.1615656782991;
        Sat, 13 Mar 2021 09:33:02 -0800 (PST)
Received: from localhost.localdomain ([115.99.61.0])
        by smtp.gmail.com with ESMTPSA id s8sm5570084pjg.29.2021.03.13.09.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Mar 2021 09:33:02 -0800 (PST)
From:   Selvakumar Elangovan <selvakumar16197@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: octeon-usb: fixed precedence issue
Date:   Sat, 13 Mar 2021 23:02:47 +0530
Message-Id: <20210313173247.8676-1-selvakumar16197@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added parenthesis around reg macro to avoid precedence issue identified by
checkpatch.pl

Signed-off-by: Selvakumar Elangovan <selvakumar16197@gmail.com>
---
 drivers/staging/octeon-usb/octeon-hcd.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/octeon-usb/octeon-hcd.h b/drivers/staging/octeon-usb/octeon-hcd.h
index 9ed619c93a4e..5aefd3fb3854 100644
--- a/drivers/staging/octeon-usb/octeon-hcd.h
+++ b/drivers/staging/octeon-usb/octeon-hcd.h
@@ -51,11 +51,11 @@
 #include <asm/bitfield.h>
 
 #define CVMX_USBCXBASE 0x00016F0010000000ull
-#define CVMX_USBCXREG1(reg, bid) \
-	(CVMX_ADD_IO_SEG(CVMX_USBCXBASE | reg) + \
+#define CVMX_USBCXREG1((reg), bid) \
+	(CVMX_ADD_IO_SEG(CVMX_USBCXBASE | (reg)) + \
 	 ((bid) & 1) * 0x100000000000ull)
-#define CVMX_USBCXREG2(reg, bid, off) \
-	(CVMX_ADD_IO_SEG(CVMX_USBCXBASE | reg) + \
+#define CVMX_USBCXREG2((reg), bid, off) \
+	(CVMX_ADD_IO_SEG(CVMX_USBCXBASE | (reg)) + \
 	 (((off) & 7) + ((bid) & 1) * 0x8000000000ull) * 32)
 
 #define CVMX_USBCX_GAHBCFG(bid)		CVMX_USBCXREG1(0x008, bid)
@@ -86,10 +86,10 @@
 #define CVMX_USBNXBID1(bid) (((bid) & 1) * 0x10000000ull)
 #define CVMX_USBNXBID2(bid) (((bid) & 1) * 0x100000000000ull)
 
-#define CVMX_USBNXREG1(reg, bid) \
-	(CVMX_ADD_IO_SEG(0x0001180068000000ull | reg) + CVMX_USBNXBID1(bid))
-#define CVMX_USBNXREG2(reg, bid) \
-	(CVMX_ADD_IO_SEG(0x00016F0000000000ull | reg) + CVMX_USBNXBID2(bid))
+#define CVMX_USBNXREG1((reg), bid) \
+	(CVMX_ADD_IO_SEG(0x0001180068000000ull | (reg)) + CVMX_USBNXBID1(bid))
+#define CVMX_USBNXREG2((reg), bid) \
+	(CVMX_ADD_IO_SEG(0x00016F0000000000ull | (reg)) + CVMX_USBNXBID2(bid))
 
 #define CVMX_USBNX_CLK_CTL(bid)		CVMX_USBNXREG1(0x10, bid)
 #define CVMX_USBNX_DMA0_INB_CHN0(bid)	CVMX_USBNXREG2(0x818, bid)
-- 
2.17.1

