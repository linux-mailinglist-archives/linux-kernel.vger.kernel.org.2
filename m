Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12FEF32BEFE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 00:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1577047AbhCCRsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:48:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359480AbhCCOsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 09:48:36 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 260D8C0613A9
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 06:47:17 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id o2so6076201wme.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 06:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EHdWW2swQWWLN2fON0JrG3mS4u0FbNeaPrg5kb6hkWU=;
        b=PV+MriZ79UvO8Un1KZdEI7jH/TmK2pAk1bDhwBgsfrqdMEl5aZHt1iJgNEUfpiLo1V
         wMmDAU5F94CjmyJAaRirgMQwwNLOuiM5CLMYXAJQpPU/B5SCDupT7VL1EX0ZO4xiwRnd
         G4ww+yglt+l42P+MUzEyGedFGTybK2/JquvE1mC2gNnEk49ND7Ep3cFkuhVqnWGGy1gv
         zedscH0PVDB9gtw5qZPZZaPP7mWnhP9zXT8wJk5SyEyh+YQHK1DeNvD1kGzNSLpRx1o/
         RsI8JCTFXug/3DmPQLgJKRDsD2/Hufl21NeCaOQeISGiSCRe8v9ODktA7G/5FJJi/UI3
         e4Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EHdWW2swQWWLN2fON0JrG3mS4u0FbNeaPrg5kb6hkWU=;
        b=XBiU7+ODLOSshjsqqWoKAAHTDKDed9FOkGbdgiJ2R6jEAWmhwTpUMzoVWYnAzLBr24
         S7vxax5krOEfOQOn/uXPOkUSd1BWX71fWBw46rEfy+ShYSJ6O+4Qf193UNhSjM/+hURI
         9mmpKr4XbwMFpL1PjvOgvft2KSX4o8w0rmat/NpssS8eOQ77UUwqcDlXLu3noqtXke+A
         PdS5XoA1Vxv8AVUjb+6ySWB2YK1b+zhKSdEqsizwRa0YkpaddwT/nOZxwmYbzGq5msvS
         KBKPVVZ+D9gHsmY7VKbeGzWptO01IwaJSJ/QzOxv8nbBGcOPO83ZYDJfJky/Tv1OkcCk
         2NsA==
X-Gm-Message-State: AOAM532124R1FkEkc5ltoYnCtyK8AH2gOEOvXDj0QlTRUtpsqTL76WbR
        b1db/0gGu5BvH9N2TDmstMnGge9UoM/RGA==
X-Google-Smtp-Source: ABdhPJwr6HXMhNS0fRSUdIbEmUeBkONMcWjvSRrkPqHtMou00uULtcanI944/JGGWrmz6LNeITwM/A==
X-Received: by 2002:a1c:8005:: with SMTP id b5mr9578341wmd.130.1614782821020;
        Wed, 03 Mar 2021 06:47:01 -0800 (PST)
Received: from dell.default ([91.110.221.155])
        by smtp.gmail.com with ESMTPSA id a14sm36567233wrg.84.2021.03.03.06.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 06:46:58 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Subject: [PATCH 11/30] scsi: pm8001: pm8001_sas: Provide function name 'pm8001_I_T_nexus_reset()' in header
Date:   Wed,  3 Mar 2021 14:46:12 +0000
Message-Id: <20210303144631.3175331-12-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210303144631.3175331-1-lee.jones@linaro.org>
References: <20210303144631.3175331-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/pm8001/pm8001_sas.c:989: warning: expecting prototype for and hard reset for(). Prototype was for pm8001_I_T_nexus_reset() instead

Cc: Jack Wang <jinpu.wang@cloud.ionos.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/pm8001/pm8001_sas.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/pm8001/pm8001_sas.c b/drivers/scsi/pm8001/pm8001_sas.c
index a98d4496ff8b6..742c83bc45554 100644
--- a/drivers/scsi/pm8001/pm8001_sas.c
+++ b/drivers/scsi/pm8001/pm8001_sas.c
@@ -981,6 +981,7 @@ void pm8001_open_reject_retry(
 }
 
 /**
+ * pm8001_I_T_nexus_reset()
   * Standard mandates link reset for ATA  (type 0) and hard reset for
   * SSP (type 1) , only for RECOVERY
   * @dev: the device structure for the device to reset.
-- 
2.27.0

