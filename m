Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B157D33EC99
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 10:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbhCQJNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 05:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbhCQJNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 05:13:01 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155EDC0613DF
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 02:13:01 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id e9so996655wrw.10
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 02:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X2jzyWxb6hZ16y5SB+2tveo3Hvk9XXLg4i7IoitMdEQ=;
        b=Sz9BPNST98yr2QElSdpJAAY98v7AGIVUMHdqfE6cjKNe9TWa0JzeSbG0yXFBZPShMH
         m/9tK7TMTeul+K8w8OuGH8yBx85GmpognI5LZrubw7BgMLhdqnb2U2q0pg67TKV7+oI7
         w3Xy+d/EhvwYX4EAKgUVr8wyabh9cHsAMXQdUiY7YihMP2XInKa6hS6le6bP2ek5arCj
         7lEmjvi3kVmFHoEgZl3t+qkbgV+QZRLPeXM6lCEI31xVu7ilVDt/ep1SB/xsDYuRU2jQ
         rO+yf1zRtLBnWz9oqKSLeS7R0pvHQzBQIk8rho0zbZw2Y1ST/nbRdAOStpC2/LyYFFGb
         jJvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X2jzyWxb6hZ16y5SB+2tveo3Hvk9XXLg4i7IoitMdEQ=;
        b=MraMTtkebsi57qDjGhutAi0BfiCY8qhYiyAv3P1Rm1KJwuZ6fEQRyAFpyYxwxbTGK/
         sTzVxtJq2N89IIUfcnoOZ4FUiodA5Ok9ojwpN51jh31EYACfCFN574iracOJU4ZRH3Mb
         shzNtWcEFP8/C/9azzf/MJpM40VYGzXUm1lZyJs2oUsJ8m2eHw+aD2xYapMoUOJqw8ok
         b+wbmEMri8eU1wbAMLR/BwYAgIo282kdqxyCOLEcSmftliQMpZ0BqWs2PwGWpEed63aM
         eSZ1dA2HNVkDTaPZmKlQD6QAB5aFWuiamIWyyWSb4ZBviQkw1fwOu3IiT0W5Ms8YAklN
         8+0g==
X-Gm-Message-State: AOAM532mWTCp2PPyPDdrsu2/joMxCk3t7In6LP7MrGA2Rf9AVcnsBSyB
        g8tD+RpOrmis9QI55zgTY3oQiA==
X-Google-Smtp-Source: ABdhPJx2rix7+pmCqOFflU2oWruALF8QN+IseT4hMQzD0HjG7GBBmKA7EPT+zTWFdoDTFUq+zdpU2g==
X-Received: by 2002:adf:8341:: with SMTP id 59mr3205254wrd.130.1615972379865;
        Wed, 17 Mar 2021 02:12:59 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id e18sm12695886wru.73.2021.03.17.02.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 02:12:59 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Subject: [PATCH 19/36] scsi: isci: phy: Provide function name and demote non-conforming header
Date:   Wed, 17 Mar 2021 09:12:13 +0000
Message-Id: <20210317091230.2912389-20-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210317091230.2912389-1-lee.jones@linaro.org>
References: <20210317091230.2912389-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/isci/phy.c:354: warning: Function parameter or member 'iphy' not described in 'phy_get_non_dummy_port'
 drivers/scsi/isci/phy.c:354: warning: expecting prototype for If the phy is(). Prototype was for phy_get_non_dummy_port() instead
 drivers/scsi/isci/phy.c:371: warning: Function parameter or member 'iphy' not described in 'sci_phy_set_port'
 drivers/scsi/isci/phy.c:371: warning: Function parameter or member 'iport' not described in 'sci_phy_set_port'

Cc: Artur Paszkiewicz <artur.paszkiewicz@intel.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/isci/phy.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/isci/phy.c b/drivers/scsi/isci/phy.c
index 7ca7621f77479..aa8787343e831 100644
--- a/drivers/scsi/isci/phy.c
+++ b/drivers/scsi/isci/phy.c
@@ -339,10 +339,11 @@ static void phy_sata_timeout(struct timer_list *t)
 }
 
 /**
- * This method returns the port currently containing this phy. If the phy is
- *    currently contained by the dummy port, then the phy is considered to not
- *    be part of a port.
- * @sci_phy: This parameter specifies the phy for which to retrieve the
+ * phy_get_non_dummy_port() - This method returns the port currently containing
+ * this phy. If the phy is currently contained by the dummy port, then the phy
+ * is considered to not be part of a port.
+ *
+ * @iphy: This parameter specifies the phy for which to retrieve the
  *    containing port.
  *
  * This method returns a handle to a port that contains the supplied phy.
@@ -360,10 +361,8 @@ struct isci_port *phy_get_non_dummy_port(struct isci_phy *iphy)
 	return iphy->owning_port;
 }
 
-/**
+/*
  * sci_phy_set_port() - This method will assign a port to the phy object.
- * @out]: iphy This parameter specifies the phy for which to assign a port
- *    object.
  */
 void sci_phy_set_port(
 	struct isci_phy *iphy,
-- 
2.27.0

