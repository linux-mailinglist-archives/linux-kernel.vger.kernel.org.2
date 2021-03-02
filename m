Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B12A132A656
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 17:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377720AbhCBOYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 09:24:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238052AbhCBMnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 07:43:45 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668FEC0611C2
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 04:42:59 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id p5so11973008plo.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 04:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=globaledgesoft-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=q3fqnOmjKKGxAsZ9eTlp9n/cQ2kQPR+kLhRz3gEVi4w=;
        b=oEeyazcYyX2Z8CDWd5O8mT0Bv733tjlJLHw6wVpQHMHvC2goyWxKVhyvOd5VfPTz15
         jbdUXmAGTVuucyMussGl8btp7fIdgL+gU6/Eh2fXBzrpTxdfted9qNJ87tx4CpQTyzIQ
         bmuOLj3SnZvL14c4iXrVRwm8oq9s8WkkDVBlLus0csm0ktZfYGHA+qHWFDq1NRLg9cIz
         Fcd+oRjtkvi/vXXcX+/ftuYsD3ZBmtRGikx1MQWJ/9/OQ0dowafOiDcpjhGUwyrWzBH0
         pvZI1CSmBWPaI5/OxI3r8tCsYdGVckLFfl0VZtkVnc9jpDLjOSnN83mB1R2BijyxfgHH
         fNeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=q3fqnOmjKKGxAsZ9eTlp9n/cQ2kQPR+kLhRz3gEVi4w=;
        b=kIRNALUYMoIcbfU9LhEgGmUybUERGca7kDav9pf3VEbl1g9jOMmRtRralq8dh4ZbFf
         45JyO+5yLLEA5MyV8vwB/ryfWVNGpMNNKAlPqMTqLHvcoKidtULNnuHCL8r2kpeXTeSA
         yySsAsPxXwB8NgLpiJZlaiqiVWQCGxIZIxB0GHCD9egXMJKxb/14/qD5fgmesDaboj+K
         h2OHqqQRwOijVB0KB6yjRU9X7EEWPfVyqb6YTSpmZiuw3sBDlj1/TyYLY8e3oisTdZ1k
         CJWAmqYztAKEwj9BWUC00yZrAXGsAZq4UcdLv/OvgmSAEhMu9co3+NtHVC3iEPz+On/d
         l8zg==
X-Gm-Message-State: AOAM533ot69wiuwwoMiYZc36mIVZMTumLzssIJuJ9ong2bdgCOuL16iy
        L9WX69pxD6+13C4DxFaFD+JvrEU+QCsDTBwZPV5fJIJBBQFi0Z1Um8X5jD7tqNnJLSp8MTvIxlp
        La9Bcry7fk1KXZl/KAjKPdEdsuqcEmg==
X-Google-Smtp-Source: ABdhPJz32WAkoXFUsAhrAYa3rsOUeRbJvEqu7NTuNIeGTdIhW4Wflm2Gn4ay+bxXlE6Y0kuSkv30xw==
X-Received: by 2002:a17:902:6b45:b029:e0:7a3:a8c with SMTP id g5-20020a1709026b45b02900e007a30a8cmr3589739plt.1.1614688979009;
        Tue, 02 Mar 2021 04:42:59 -0800 (PST)
Received: from vijayakumar ([49.204.93.90])
        by smtp.gmail.com with ESMTPSA id v3sm5941124pfe.147.2021.03.02.04.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 04:42:58 -0800 (PST)
Date:   Tue, 2 Mar 2021 18:12:54 +0530
From:   Vikas Kumar Sharma <ks.vikas@globaledgesoft.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] This patch fixes the check-patch errors
Message-ID: <20210302124254.GA2349431@vijayakumar>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ERROR: Macros with complex values should be enclosed in parentheses.

Signed-off-by: Vikas Kumar Sharma <ks.vikas@globaledgesoft.com>
---
 drivers/staging/ks7010/ks_hostif.h | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.h b/drivers/staging/ks7010/ks_hostif.h
index 39138191a556..c62a494ed6bb 100644
--- a/drivers/staging/ks7010/ks_hostif.h
+++ b/drivers/staging/ks7010/ks_hostif.h
@@ -498,20 +498,20 @@ struct hostif_mic_failure_request {
 #define TX_RATE_FIXED		5

 /* 11b rate */
-#define TX_RATE_1M	(u8)(10 / 5)	/* 11b 11g basic rate */
-#define TX_RATE_2M	(u8)(20 / 5)	/* 11b 11g basic rate */
-#define TX_RATE_5M	(u8)(55 / 5)	/* 11g basic rate */
-#define TX_RATE_11M	(u8)(110 / 5)	/* 11g basic rate */
+#define TX_RATE_1M	((u8)(10 / 5))	/* 11b 11g basic rate */
+#define TX_RATE_2M	((u8)(20 / 5))	/* 11b 11g basic rate */
+#define TX_RATE_5M	((u8)(55 / 5))	/* 11g basic rate */
+#define TX_RATE_11M	((u8)(110 / 5))	/* 11g basic rate */

 /* 11g rate */
-#define TX_RATE_6M	(u8)(60 / 5)	/* 11g basic rate */
-#define TX_RATE_12M	(u8)(120 / 5)	/* 11g basic rate */
-#define TX_RATE_24M	(u8)(240 / 5)	/* 11g basic rate */
-#define TX_RATE_9M	(u8)(90 / 5)
-#define TX_RATE_18M	(u8)(180 / 5)
-#define TX_RATE_36M	(u8)(360 / 5)
-#define TX_RATE_48M	(u8)(480 / 5)
-#define TX_RATE_54M	(u8)(540 / 5)
+#define TX_RATE_6M	((u8)(60 / 5))	/* 11g basic rate */
+#define TX_RATE_12M	((u8)(120 / 5))	/* 11g basic rate */
+#define TX_RATE_24M	((u8)(240 / 5))	/* 11g basic rate */
+#define TX_RATE_9M	((u8)(90 / 5))
+#define TX_RATE_18M	((u8)(180 / 5))
+#define TX_RATE_36M	((u8)(360 / 5))
+#define TX_RATE_48M	((u8)(480 / 5))
+#define TX_RATE_54M	((u8)(540 / 5))

 static inline bool is_11b_rate(u8 rate)
 {
--
2.25.1


-- 
Disclaimer:This message is intended only for the designated recipient(s). 
It may contain confidential or proprietary information and may be subject 
to other confidentiality protections. If you are not a designated 
recipient, you may not review, copy or distribute this message. Please 
notify the sender by e-mail and delete this message. GlobalEdge does not 
accept any liability for virus infected mails.

