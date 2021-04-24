Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C02936A071
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 11:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237556AbhDXJHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 05:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237582AbhDXJEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 05:04:39 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A7DC06175F
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 02:04:00 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id k14so767303wrv.5
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 02:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ck3YsdNSVP0rZ1FtHCUQWW2VZt87Mqq7djATO4TUkHY=;
        b=HkF9xIaCcJXTwTE676PshFJce2H+E5YLOZk5Se6EptvcO9HuBZTrOSwhHLFPXOR+SI
         So/BVexFRF0eUmkRzZ0edJRoDGoJxJs0Jj0s66alCoUMwP4hPQR3YmwFMsGWK+IQMx+4
         rxW+PvicMwqsyLBJCdo3qc2mNAeOz3kGqhxHefODoKP87KFETlOFFmtnexDP2/fLHcmw
         wzh0Q91/2mnuzHvtTrGetIqIVnwP0Lp9fF0CSi1cRjbFjQUSnOG0LpxxYnx/0EI3Q182
         O+NNflsl/u6kXwuQnRFHmGx0ESzPTIKLPimYmbJYkIdJddg5/XeujHLMb/E3siZCzdur
         kGww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ck3YsdNSVP0rZ1FtHCUQWW2VZt87Mqq7djATO4TUkHY=;
        b=In12H0LMWR1RA88WUwymRkoQnSr4UB7ZFKSctYDtu4YmtymfHS0m3r7yy8twWQ5Vok
         hPazVQk+0N8/ozphWMdcUbFwl69JONq4RQmlPa9qSAOehWAeNFUFSKo32zLd1lW23cAu
         bnE3E1ijND2fX7Iy+sFzgemY4Xc+FtNA7v2et6885LCp9gki/CD59kUPWfBMZOlN6L68
         eEzEwUGPnMmwlSCuEyYaAc/6gcn6d2+MtgNgg8PKW9iwVXEo99FrJJCUMHIRHUz2aZbN
         A1oLYVgFHCBWFNysFVul7rDKiSMXf+VrN7zWzPOkUlNJCl/ztd3o/8JyUlg2dY7gtw9Z
         TJmA==
X-Gm-Message-State: AOAM531OdAzIv/8N8fG0Ngv3yvmUT8c6wK1+m3vgIRuRrjsuJDHrNYd0
        8mkLtIJ0MtlmIrXS3G3EwlWBzjTH5XO3zg==
X-Google-Smtp-Source: ABdhPJwye49sqjYh3F1rAtuwk/EJTLSPCSamHCBjMkk0VD5Dw1yBWU2jSxRMnOdOoTcfWS9ZQd5how==
X-Received: by 2002:adf:f00e:: with SMTP id j14mr9504311wro.180.1619255039453;
        Sat, 24 Apr 2021 02:03:59 -0700 (PDT)
Received: from agape ([5.171.80.252])
        by smtp.gmail.com with ESMTPSA id m14sm389517wmi.39.2021.04.24.02.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Apr 2021 02:03:59 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 50/50] staging: rtl8723bs: macro DRIVER_PREFIX expands to lowercase driver name
Date:   Sat, 24 Apr 2021 11:02:33 +0200
Message-Id: <c986e9a3c9b2f73cb784bd5dc7c877eb9a669c89.1619254603.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619254603.git.fabioaiuto83@gmail.com>
References: <cover.1619254603.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

macro DRIVER_PREFIX expands to lowercase driver name.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtw_debug.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
index 189f02a8300a..3a5b083e95a1 100644
--- a/drivers/staging/rtl8723bs/include/rtw_debug.h
+++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
@@ -7,7 +7,7 @@
 #ifndef __RTW_DEBUG_H__
 #define __RTW_DEBUG_H__
 
-#define DRIVER_PREFIX "RTL8723BS: "
+#define DRIVER_PREFIX "rtl8723bs: "
 
 void mac_reg_dump(struct adapter *adapter);
 void bb_reg_dump(struct adapter *adapter);
-- 
2.20.1

