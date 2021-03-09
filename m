Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7003325C5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 13:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbhCIMuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 07:50:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbhCIMth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 07:49:37 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8FEC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 04:49:37 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id a4so8699332pgc.11
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 04:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=UHGEau2CR3Zf0FehLU8kNjTEbePgoadEpgpDDWs/gXA=;
        b=RatiX+T+ANWTYx5oI1zLR5dVjeYlDZ0xhruyx4WCqpasEio48A24NWkz80JoX9fOSE
         OMH3X5UuocA6QH0Xh6q71JBxzFG9/eqRjRB4EC/Rwqs5Jlrdo5lE4KLZTpusDEYyT7rS
         Hyutde19GOd1nkk3VXiqNwAkCXaE/la2NkwP0yZRIcxosUeS4eJMWKgYmreHJN+lc9w5
         Ww7xB8Hvk7/bNQHSHULlA44UjKao50/IpOobgU+8deJvcL+/0L1GMPQTvSGyVX6BpoVg
         jE+GE1/2HnnHkHSLx57Z4hp2M0QsdzVqxXmrckabo5b4bXWKcZAFS2RIUqhRzs0xtuvv
         hnPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UHGEau2CR3Zf0FehLU8kNjTEbePgoadEpgpDDWs/gXA=;
        b=K3pWPd2z/SDGPWyYIX4dSjORRDwcsyTcPbKzPZMPT977Yf4CclovhOMqGQj8sa0rBL
         I7OoaHvHXehpAednLKjI2gH4cEbuufKDWyWqAbE2pFYCA65+JB6+YBS6s2ZOX1AnDWhp
         0UyVRX68posnC52O94ju6S89FMW88XPCdOO3bxCTiJ9b6XST5whsHLKdKCE0hvdRcS4V
         X0TuGjs99t+6iFsuflNJfQGCX2a+b1yF7z9H1+QbVfEK8dxYD2y6b2j9DY7IZ4XUTsvI
         b74Y7YKZQi56ZSqu8DtJVhNCkzaHiMwQZo/hKsL2SMNsyRRZlQ9f7UalWn56Cp7U0MY+
         QSsg==
X-Gm-Message-State: AOAM532DTzVnn345RnI/1jf3+fSYXI5ICgKxD/jNvwrteXxa70mx9spj
        Tik/hvNigZXpklrOdTcb1Y0=
X-Google-Smtp-Source: ABdhPJx0LqY4/Q1HxVdNsecQvv/1RoBonJ0DUIXjzsgjCILt+no+w5b1RzKVPi/K09dI3n5xxT4XJA==
X-Received: by 2002:a65:6a48:: with SMTP id o8mr24530323pgu.424.1615294176511;
        Tue, 09 Mar 2021 04:49:36 -0800 (PST)
Received: from localhost.localdomain ([27.4.151.14])
        by smtp.gmail.com with ESMTPSA id b10sm12891815pgm.76.2021.03.09.04.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 04:49:36 -0800 (PST)
From:   Selvakumar Elangovan <selvakumar16197@gmail.com>
To:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        florian.c.schilhabel@googlemail.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Selvakumar Elangovan <selvakumar16197@gmail.com>
Subject: [PATCH] staging: rtl8712: fixed whitespace coding style issue
Date:   Tue,  9 Mar 2021 18:19:26 +0530
Message-Id: <20210309124926.14896-1-selvakumar16197@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed additional whitspaces and added space around the binary operator in the rtl8712_xmit.h file

Signed-off-by: Selvakumar Elangovan <selvakumar16197@gmail.com>
---
 drivers/staging/rtl8712/rtl8712_xmit.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl8712_xmit.h b/drivers/staging/rtl8712/rtl8712_xmit.h
index 0b56bd3ac4d0..5cd651a0de75 100644
--- a/drivers/staging/rtl8712/rtl8712_xmit.h
+++ b/drivers/staging/rtl8712/rtl8712_xmit.h
@@ -36,10 +36,8 @@
 #define MAX_AMSDU_XMITBUF_SZ 8704
 #define MAX_TXAGG_XMITBUF_SZ 16384 /*16k*/
 
-
 #define tx_cmd tx_desc
 
-
 /*
  *defined for TX DESC Operation
  */
@@ -89,10 +87,9 @@ struct tx_desc {
 	__le32 txdw7;
 };
 
-
 union txdesc {
 	struct tx_desc txdesc;
-	unsigned int value[TXDESC_SIZE>>2];
+	unsigned int value[TXDESC_SIZE >> 2];
 };
 
 int r8712_xmitframe_complete(struct _adapter *padapter,
-- 
2.17.1

