Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7B6E3B046A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 14:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231714AbhFVMcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 08:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbhFVMcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 08:32:06 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7675FC061766
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 05:29:50 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id k42so10818890wms.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 05:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6pwu5pM4dbgTBood6EBI5joCOsJM78eFvHusKdHfshs=;
        b=ZnOJGE8ArpO1GaWP0LkeNuk4rynlhsarhSQ01m+IMB1CC2hcPB3h4ObVyYIBFa9p8m
         Yj1QIChEDjRoTZQtsz5UjhDYZNx/8OdKReV4s67W8AP8npZnlpii6a9LiKZ7K+h231CK
         8IpF8b6Jyz5IuvF85j1XqpGQABbJ77uNYAVMlrDPdE9b/jBji0pa1JA/bmFkaC9Dnvl9
         6NTrT9ALTXFy+WQrjtKIuhqsojRPe+EtHwcZq0PPpVfFXJST6aC/wmjZT33n+WwwFPYg
         Ml+ekpzYHf0Ts60Zf8x5kJ+P/QDuLc6gqfQYnGetMIz+VInP0sYFbm8b86m8UaL6tIMr
         DlMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6pwu5pM4dbgTBood6EBI5joCOsJM78eFvHusKdHfshs=;
        b=cDZnxNGCCemN0U/mFWfBoIl+YqYaJ0TdY4rf7y0gkl+2kQbDBYyWNYsqtwKZzZ2ZQ1
         jVoPh/rJfCt3eR9VDc6Jsysm5NGdlDLdUmePEt8BJ+1ERNz0Ek4dWGsC89duIZaCtmAF
         Jb2A1daUw8f/qI8+bjyXq8pWPRj0Z9tF0Cuc+/RhK1KzthBTtxN44q1IAlfdPHTyfqzf
         gCZ385LM0YMZ/Q2BejOdfMPsLB37iIn3rP8s71/3FXEM29uLAv0KWKp6e7ZrqFn8TV+1
         ieFp6Wm1T+90pq+XYw9Qh34lgJJdMQ274xrnaGqqLhOCHrTfRvUs93GRosDehnme8Ohk
         vO2A==
X-Gm-Message-State: AOAM5318lmsAF90GEZ9RaDVnpS3iSuE2+iCZi/f5gzGN3UEtPsKPJmib
        AV9ksAEVTHDJDq06zl9qdQI/udwy9Og5/Q==
X-Google-Smtp-Source: ABdhPJwGtgHVIsXOJT/MqW4dRSV4kspSNqZVARxdRy2wuBYoLBAbuvpEVp2vremtJtEC5MHGh4o8ag==
X-Received: by 2002:a05:600c:4642:: with SMTP id n2mr4227501wmo.101.1624364988954;
        Tue, 22 Jun 2021 05:29:48 -0700 (PDT)
Received: from agape ([5.171.73.108])
        by smtp.gmail.com with ESMTPSA id m6sm25945938wrw.9.2021.06.22.05.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 05:29:48 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/17] staging: rtl8723bs: remove unused enum items related to channel bonding
Date:   Tue, 22 Jun 2021 14:29:28 +0200
Message-Id: <aee2c78ea50a0bc24c114853500bd44c358745aa.1624364582.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1624364582.git.fabioaiuto83@gmail.com>
References: <cover.1624364582.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused enum items related to channel bonding.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtw_rf.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_rf.h b/drivers/staging/rtl8723bs/include/rtw_rf.h
index 98bc274e5e81..550471637315 100644
--- a/drivers/staging/rtl8723bs/include/rtw_rf.h
+++ b/drivers/staging/rtl8723bs/include/rtw_rf.h
@@ -98,14 +98,6 @@ enum {
 	VHT_DATA_SC_DONOT_CARE = 0,
 	VHT_DATA_SC_20_UPPER_OF_80MHZ = 1,
 	VHT_DATA_SC_20_LOWER_OF_80MHZ = 2,
-	VHT_DATA_SC_20_UPPERST_OF_80MHZ = 3,
-	VHT_DATA_SC_20_LOWEST_OF_80MHZ = 4,
-	VHT_DATA_SC_20_RECV1 = 5,
-	VHT_DATA_SC_20_RECV2 = 6,
-	VHT_DATA_SC_20_RECV3 = 7,
-	VHT_DATA_SC_20_RECV4 = 8,
-	VHT_DATA_SC_40_UPPER_OF_80MHZ = 9,
-	VHT_DATA_SC_40_LOWER_OF_80MHZ = 10,
 };
 
 /* 2007/11/15 MH Define different RF type. */
-- 
2.20.1

