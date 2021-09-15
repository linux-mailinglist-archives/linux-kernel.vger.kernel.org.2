Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E79FA40C42E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 13:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237415AbhIOLLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 07:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237558AbhIOLLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 07:11:35 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3787FC061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 04:10:16 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id x6so3200859wrv.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 04:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xIc1TJKHNDEJugEawqGLzpfqg8jZCQtvA5lcl+ms/bs=;
        b=aNjYYj74+RVXOjZ9dW1QZCH74cAHh2U51k76impL+mU/pwsuC8fe2WH6raDVC23pR2
         g+8esSPhgsTI5uSEsqPfz8hG8bsnuGQUss0KSlh5a27u7IIbYPDrmAL6eGU1EWx1/e/J
         toLIeryRlb5Am1/Mrqw716B24yCB0+Aecmxf6WlKf63fWTDbXbuXwxMU3apbk6Pv1LsQ
         w0gDpPnmpKm0woPsF/p+E9pry91sKpEabMMd75c7xnZPg0PrLfGwgoAl7JyoRB5YgLMt
         e3SkIyDB3yBOPCBf8GylebP+sui/gTDY+E7mc2IX/Tck3xlqH8AyMnAn7fGVxpjGv64s
         eWGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xIc1TJKHNDEJugEawqGLzpfqg8jZCQtvA5lcl+ms/bs=;
        b=Ep/Y6SJrUot9+HPwW4PY01s3pUCGqHwKfMF+XBECH6kCXexrDm19tWl+DizmKay+uF
         wQoy+hj6UlCGY5e8fTxX//tLnBWbyG3JB2crzeGQM2Q/CO9Vzm7yiECgNwcKmwVSkXEc
         7VDPy5LqBCZmIXRbVnE4S4iOGslHNJLcQSuxCZjmTbTsAu3FdTKBSXpHzXL4c+eez9YR
         /M49sqO6meCIBW+0iZEuSJe5F5is+K9rlSxZ0c2+VU0Jri7mxrODfMCfZVsNUl/JH2U7
         G6hsZgbRU600Dru2/ExsqXS3/xX8nK1B04uiT7MejVqypWsmQaaxsn8WOVEgV0x+UGnf
         wrCQ==
X-Gm-Message-State: AOAM533jYKH9teE5GrRQ1120YNyFo65t4AmFLzgvTAoKWOm0rF2HVh4y
        8XV4Kpu5eRMxFjrzZN+nP2s=
X-Google-Smtp-Source: ABdhPJxDjtNyLzCmH1TUvW34PN2loF452WiHb4Z4GMGhu8CATYErY0AG+BqWisUW7g+cT7v7a8Pcqw==
X-Received: by 2002:adf:e108:: with SMTP id t8mr4343594wrz.84.1631704214902;
        Wed, 15 Sep 2021 04:10:14 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::1db2])
        by smtp.gmail.com with ESMTPSA id c23sm3955702wmb.37.2021.09.15.04.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 04:10:14 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: r8188eu: remove unused enum odm_bt_coexist
Date:   Wed, 15 Sep 2021 13:09:58 +0200
Message-Id: <20210915110958.17743-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused enum odm_bt_coexist.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/include/odm.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/staging/r8188eu/include/odm.h b/drivers/staging/r8188eu/include/odm.h
index c6e876f5d470..4fee0e9e0df3 100644
--- a/drivers/staging/r8188eu/include/odm.h
+++ b/drivers/staging/r8188eu/include/odm.h
@@ -514,13 +514,6 @@ enum odm_mac_phy_mode {
 	ODM_DMDP	= 2,
 };
 
-enum odm_bt_coexist {
-	ODM_BT_BUSY		= 1,
-	ODM_BT_ON		= 2,
-	ODM_BT_OFF		= 3,
-	ODM_BT_NONE		= 4,
-};
-
 /*  ODM_CMNINFO_OP_MODE */
 enum odm_operation_mode {
 	ODM_NO_LINK		= BIT(0),
-- 
2.33.0

