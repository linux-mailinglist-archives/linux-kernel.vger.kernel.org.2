Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1320040AD41
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 14:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232779AbhINMPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 08:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232552AbhINMPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 08:15:23 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77AF8C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 05:14:06 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id w29so19066545wra.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 05:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hs3mRcTeREmOfSm39kN+QtHRavsM4VI0RyJdbjV285Q=;
        b=hflRR/IP600E/ZFCzFLswmDZ5xQG3TsjtpJmP5HTGo8mSRpFZNafY9xA6OjV1q8FX6
         hmHOw85QoDit3nCRD7gkiM9kXP7to8g+lIi4PHib4emhdTz+cqpVYxQr1zZFSL+a4iLJ
         +XfqBQGth9fKyhNCyfLKfLeD1pXAXbN8xO2XBMcvAyg/YWUlylpxk9vWu4l36zvC3AQ5
         itiGsmJfGVcv5ZtK+INbs/oi1WTB3vSDcrCM2/lVMBns3/Scsi0J4Haec8v5J7PfBKMZ
         q4kDBWPFDqjQraRfsbpTvl6xeiuJsHTJ7Uctl8koDrws6qNogJQYevhfWYmMdbyK7hBt
         b+cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hs3mRcTeREmOfSm39kN+QtHRavsM4VI0RyJdbjV285Q=;
        b=xow+ybO7Of64bLLtxttdjKGUi4oiT6cB+T5hlL/59NxbL70ri+y6qBZqmUb7IpCJn0
         /+lZpMF8TNhbVAsehNMheh+CR4ZsI/yQ1J1YYvaPnNmFJMWN9/Df098zWEGB4lmYv/Op
         PInC7BZa6x/7dHP7uPy/sg28hExe2xwBmBpF2GDLTA1AnHtGUm2yHvlJVFSWh15ksVV9
         b4TONc/qAaEBfKlThXjtznJk1pldFxOSRuMbStNPW9w+Ky68YfjJiEcy3aXfRoqjxdMm
         Plw7A3ny6NokPWSU1qYBGoQAFVPD/uLYBByijF/z/msel+8Tm+OskF+FuEowkckPP0CG
         r0vQ==
X-Gm-Message-State: AOAM530IfMf6K2aqRsOPgPHYBH78qsrbpAUncwuxBjsoUmhIWvhgz4pM
        kp3tQicwurfUZjNYQQFAmZI=
X-Google-Smtp-Source: ABdhPJxRt2LDszPZ8vdnTlTfJZO7K8vLtUm56jr2A92KeGUQ+rItZiJzCD2cQQL4Be9PevtEm+IY4Q==
X-Received: by 2002:a5d:4ed2:: with SMTP id s18mr18488301wrv.41.1631621645029;
        Tue, 14 Sep 2021 05:14:05 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::ae40])
        by smtp.gmail.com with ESMTPSA id j19sm10028100wra.92.2021.09.14.05.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 05:14:04 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/4] staging: r8188eu: remove unused enums from rtl8288e_hal.h
Date:   Tue, 14 Sep 2021 14:13:51 +0200
Message-Id: <20210914121352.26052-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210914121352.26052-1-straube.linux@gmail.com>
References: <20210914121352.26052-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After removing MultiFunc and RegulatorMode from struct hal_data_8188e
the enums rt_multi_func and rt_regulator_mode are unused now, remove
them.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/include/rtl8188e_hal.h | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/staging/r8188eu/include/rtl8188e_hal.h b/drivers/staging/r8188eu/include/rtl8188e_hal.h
index 7e2feb390416..17913dcc9fbe 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_hal.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_hal.h
@@ -207,20 +207,6 @@ struct txpowerinfo24g {
 
 #define EFUSE_PROTECT_BYTES_BANK	16
 
-/*  For RTL8723 WiFi/BT/GPS multi-function configuration. */
-enum rt_multi_func {
-	RT_MULTI_FUNC_NONE = 0x00,
-	RT_MULTI_FUNC_WIFI = 0x01,
-	RT_MULTI_FUNC_BT = 0x02,
-	RT_MULTI_FUNC_GPS = 0x04,
-};
-
-/*  For RTL8723 regulator mode. */
-enum rt_regulator_mode {
-	RT_SWITCHING_REGULATOR = 0,
-	RT_LDO_REGULATOR = 1,
-};
-
 struct hal_data_8188e {
 	struct HAL_VERSION	VersionID;
 	u16	CustomerID;
-- 
2.33.0

