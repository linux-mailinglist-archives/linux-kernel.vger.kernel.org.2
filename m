Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16FD5413AFA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 21:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234801AbhIUTtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 15:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234714AbhIUTs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 15:48:56 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EFA4C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 12:47:27 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id t8so214784wri.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 12:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z5mAXIxdQ3ZHOcZa3/XgL8+waFFw5ZKFjk5I33+w7UY=;
        b=Qgpq8DP/jGL+dyqlRelcUb+X5NEG/GP8R4MIynmZFu9Lv5GBs0nXrKQSS635jEKDLr
         TNlqFwYXAO69QYz+trt2j7sW9rcyPVmJV90YJUp7L2Qzr/aC5TF3B9/r5wKk6rJpNU10
         LKIhtduN9OXAu2qNSqJb054V1CG/ykf7Magsp7RaS+MOGUJEVGli6K/4VaYRvwTdc68g
         d8pABr9AngClTNdU0kair1BWvJwLYJ5k8U5Cgd7vVEM86CFnGtHNDQNHhf5rRRSczdZv
         pxuuoeTiKbQRzr35mqXGnwetBfB9F5QHY3UtjVSwfxC7PTCao+LwgP0jmZukOkO9m2HG
         L17Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z5mAXIxdQ3ZHOcZa3/XgL8+waFFw5ZKFjk5I33+w7UY=;
        b=qJb0QLmihxnWcrN782v/MjbYUuuinB2HQLkHOi1UP16u3oU2Ocb94jYYSygYvyhstj
         cx1/14rsl9VZycfOfTmP6vqq05l1KerjiC8vgffe1SuzWfeATCvU68BVwo+gxgzjKPQY
         on7phdEVSl8+SOZyQaxfCJ4Hbdtrj5iKiyBLLQ80DGFAE7304FGe4vSVQ3hSq6ghckxz
         Cf7XQSucRhPvpkMkWn9lqddWKN1zUcGSh4neHLzBBv5Gqxtp9OhucNBTU3yHMtGy2vcQ
         L/331tsHUkkOmCB7nPkQALYprQicik1eYjNM1rL7NSDDuMvs8qqDYOML5Zu/2snJ6Dms
         mfrw==
X-Gm-Message-State: AOAM533tPl2l3GLKYP0+K8bPMouR4h6yc6vNRw4dKblHXn1SkoJkHAKM
        /KT61MbQU7nvTi/d4zX/jNk=
X-Google-Smtp-Source: ABdhPJyq7GRTP3Z5CbL05GI02YZI33qYuFblBXPF4l5dqGoX1PEAhcXOD0Ap8R2RCIo5Or4VL0J0lw==
X-Received: by 2002:adf:fc0e:: with SMTP id i14mr36978452wrr.173.1632253646165;
        Tue, 21 Sep 2021 12:47:26 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::cde])
        by smtp.gmail.com with ESMTPSA id s13sm3891243wmc.47.2021.09.21.12.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 12:47:25 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 5/8] staging: r8188eu: remove PowerIndex_backup from struct dm_priv
Date:   Tue, 21 Sep 2021 21:46:55 +0200
Message-Id: <20210921194658.10654-6-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210921194658.10654-1-straube.linux@gmail.com>
References: <20210921194658.10654-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The field PowerIndex_backup of struct dm_priv is not used, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/include/rtl8188e_dm.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/r8188eu/include/rtl8188e_dm.h b/drivers/staging/r8188eu/include/rtl8188e_dm.h
index 2209975c0b2d..bfe300730c16 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_dm.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_dm.h
@@ -30,7 +30,6 @@ struct	dm_priv {
 
 	/* for High Power */
 	u8 DynamicTxHighPowerLvl;/* Tx Power Control for Near/Far Range */
-	u8	PowerIndex_backup[6];
 };
 
 void rtl8188e_init_dm_priv(struct adapter *adapt);
-- 
2.33.0

