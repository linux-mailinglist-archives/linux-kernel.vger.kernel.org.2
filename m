Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C65D235121B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 11:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234440AbhDAJXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 05:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233997AbhDAJW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 05:22:28 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3A1C0613E6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 02:22:28 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id u5so1837999ejn.8
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 02:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Cioluv068BWZZVTvNHvrKSQdGLCkCRUED0iLUEaae4k=;
        b=maMGbFbPgCASSoP74O4yPmcKf4MekE7OFkLCMIx1QpfLio1Igm3fMKUFPLpvPeqenV
         04KyokBUXiEsK9TfY3OEjs/Hi9Txfb1lSvnYcwHqTnoIgcFt+FE5WSrYA054isYNf3jp
         VAMSaVF3ONOBub3aoYHVnaIB85N+nP9cZefR4U1Hi3xqQSBhhBXWx3wb3ClYMXvzs7uy
         bEiewIb7MaPQr8huKr0MoAFLXlHvg/qWzspu68Qc9PQaWUsUP/0vqHwjK9/xNGkbKn/N
         CgvdH35Olh2jS4BsbudBQE42Q3eGdZCG49jbNsPZXZNIZeoaKzFua1NvPZyvatp+Fitj
         A9rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Cioluv068BWZZVTvNHvrKSQdGLCkCRUED0iLUEaae4k=;
        b=YOiw8BhAhsUQ7oxlRi31d18jDB+Qt/voBSONsoOodInOfLrcxD0TDE2R3sVM1uW8lY
         kyiPHnky+WFQJWwK4Sy9KWQ597kTKdB4pgIsdGoOJFoujON6jt796kfxyFYjmq77L5vp
         Y74+qtpBrtoIXMG8KK9EnjyrPhzRn5V3U2JsFEjQLkxn29DWNOXUJBjzH/tajvrhPErt
         fA2P96uP71VWh/cRVmWt9tcNh4vgHuMfDC6yeWb1W9XBAww9pFBLU2qQOUZJYqslMUnd
         tzs70jMuW6WcNOrPaAzUF2VFp+zkPSC2jYZgrla92QqZ5JHBsY5gj07qTaun9ibxFKJL
         Fziw==
X-Gm-Message-State: AOAM530uW8dyhhpwpG4HdT1QDZEnQteXRPXxiQKonxCL7j+NbDXqmO5v
        8igPPM08uZoatghRJ94kuuM=
X-Google-Smtp-Source: ABdhPJywMlrN3FDTsaanhNjH/JEXVZKQA4XgiS0n/jqSCG4Hux5Aswt3QF4s15OjEUN5Fbu0UqzbZA==
X-Received: by 2002:a17:907:629e:: with SMTP id nd30mr8009320ejc.407.1617268946925;
        Thu, 01 Apr 2021 02:22:26 -0700 (PDT)
Received: from agape ([5.171.80.247])
        by smtp.gmail.com with ESMTPSA id x21sm3146032eds.53.2021.04.01.02.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 02:22:26 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, dan.carpenter@oracle.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 39/49] staging: rtl8723bs: remove commented RT_TRACE calls in hal/rtl8723b_rf6052.c
Date:   Thu,  1 Apr 2021 11:21:09 +0200
Message-Id: <409119d376fc53a6a73a096891773c0612e6df35.1617268327.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617268327.git.fabioaiuto83@gmail.com>
References: <cover.1617268327.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove commented RT_TRACE calls in hal/rtl8723b_rf6052.c

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/rtl8723b_rf6052.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_rf6052.c b/drivers/staging/rtl8723bs/hal/rtl8723b_rf6052.c
index 73b47f053549..38228b46b1ee 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_rf6052.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_rf6052.c
@@ -74,7 +74,6 @@ void PHY_RF6052SetBandwidth8723B(
 		break;
 
 	default:
-		/* RT_TRACE(COMP_DBG, DBG_LOUD, ("PHY_SetRF8225Bandwidth(): unknown Bandwidth: %#X\n", Bandwidth)); */
 		break;
 	}
 
@@ -153,7 +152,6 @@ static int phy_RF6052_Config_ParaFile(struct adapter *Adapter)
 
 	ODM_ConfigRFWithTxPwrTrackHeaderFile(&pHalData->odmpriv);
 
-	/* RT_TRACE(COMP_INIT, DBG_LOUD, ("<---phy_RF6052_Config_ParaFile()\n")); */
 	return _SUCCESS;
 }
 
-- 
2.20.1

