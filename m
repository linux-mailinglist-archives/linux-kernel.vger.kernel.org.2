Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2F9345EC5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 13:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbhCWM7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 08:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231512AbhCWM6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 08:58:34 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3AEC061763
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 05:58:32 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id jy13so26907187ejc.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 05:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/yFbNdJ3xMv1sAY5u8eppFWtweKYPab1rduxtHqBonA=;
        b=TTAXQ1upqcvfz5w7L/lHG1Tnfocg5eW7jlvCw3/KNd8o3NEXPhwSXNtI28f8ehLKAt
         aK00Py7MotNsUNpcI/BOD8qcGn8abahgZQlKW1tMefFxe6piK5GGvHXUhuQMM5srJNEp
         3ZGSdEtYUJNST1T+iUXEvl4Ukzxn3Qi+P+9b6dC50ErxLrCsZ98oYy6cCOW4T7ZboDNj
         8v6ly6KQLmdWTq3Z5ZiHb9rtolSyAHU+fTGLZyk+2OEDhIzxBvqmdB5N1Px2J8WqOBne
         7oijz9p3NxZ+DZd9Yz1av0ztp3q6jgnvQUpKKRrYapVaH6xwP5hCl73FfxEDNbpLgntq
         jaTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/yFbNdJ3xMv1sAY5u8eppFWtweKYPab1rduxtHqBonA=;
        b=EbZi0UFU1x0FuottUnai2FlipfpbwcDHGoHT3c5me2djhQPeQQ8Fcwy5Wm73fEno+x
         irTdkewnsnw2cGAaGKbfFJ3zJAbM5PmdSGHZ3ruGCD2tnFVPey/I2qcEcLJSv30QFSCm
         scXBEPZtHM+EoAAyq5EHcJIkcAFu51vx0Xah51tLgH48anr9fjo38bLfD1X9KK3K8Keg
         7ZYetRluYJTXI8k0L2DCTgLXgM965Btv/NmU52vAsNxZNXwchmbw0lBm0DyRx7IcvDaY
         F5uZvnDrHDVe8E8D34reFylAu+p7gwQrgQ7/+Bt/9bOYJlt5WQ5/gU12NPV1TYK8oB3X
         dT5A==
X-Gm-Message-State: AOAM532pB7hOGHYbk8o30OtnlNfviLOf/Cdydxnr7OJJlF8RdMPaPUU/
        OX9NbmukaXfLk9s4LQeIxVM=
X-Google-Smtp-Source: ABdhPJydlwVNNAWGcBxqBthHdZkvec5JhbWFZsToapkS8YFwLwTvlFZX210E2rlS9F9YKQdfVgOPPA==
X-Received: by 2002:a17:906:da0e:: with SMTP id fi14mr4972101ejb.188.1616504311327;
        Tue, 23 Mar 2021 05:58:31 -0700 (PDT)
Received: from agape ([151.57.211.10])
        by smtp.gmail.com with ESMTPSA id p27sm10774390eja.79.2021.03.23.05.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 05:58:31 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, apw@canonical.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH v2 9/9] staging: rtl8723bs: remove blank line os_dep/os_intfs.c
Date:   Tue, 23 Mar 2021 13:56:36 +0100
Message-Id: <ae5671883e9a869aced3eece40b587c51e15d520.1616503354.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1616503354.git.fabioaiuto83@gmail.com>
References: <cover.1616503354.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove blank line

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/os_intfs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/os_intfs.c b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
index c6c5cc0a9e08..405aa95af579 100644
--- a/drivers/staging/rtl8723bs/os_dep/os_intfs.c
+++ b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
@@ -1027,7 +1027,6 @@ void rtw_ips_dev_unload(struct adapter *padapter)
 		rtw_hal_deinit(padapter);
 }
 
-
 static int pm_netdev_open(struct net_device *pnetdev, u8 bnormal)
 {
 	int status = -1;
-- 
2.20.1

