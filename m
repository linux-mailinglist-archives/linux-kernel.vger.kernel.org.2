Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9F4035A9F4
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 03:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234325AbhDJBfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 21:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233332AbhDJBfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 21:35:15 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD93CC061762
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 18:35:01 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id b17so5171733pgh.7
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 18:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=3hsu6obEc/gfKsB+04dEn5JLfQh37pqmbH2QRBkH7pE=;
        b=uzHNVTRa8y9qXDXs6YrK/TlfUyTgeumLt/HyAnINR2vKD45S1+/Q64H7ovHiDwXUSj
         IBlGNFXM/TtyPWpCz3PkPcCbZDkqovOTXvPtgIK3SgVSznywpAkij3uakgC5gbqmIt8K
         mzavK4+kYSo/BuH3/Vn+GNv4oR8oellWqiBI5gLuH4g9Y2/mevfc43tCdMYkWnRZRAij
         JAMSzWCF2p8JVMhw+ffpAnhOcVCG7fRRRK4J4/w60iMMJSvTw+XBgBG5SSDRpKdon1KC
         Bc66uStZCBN4/883xs6eQfAoY4vP7Sx4+nYRJJUv9rOgErvBtPAvavrOt4kdV+Xx8gO/
         Z4qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=3hsu6obEc/gfKsB+04dEn5JLfQh37pqmbH2QRBkH7pE=;
        b=RYh+XxvVvj6isS7hOY4BNkmTTSVg32bGUAHY+kxi+/I7Q6GzhVK+BD0sUDo2peMcpJ
         Xg3tuDc2jfpfolVG6QIirlmInBfHa1w+qtrSLzp9ZXYI7lYBhvG3/TjXhVrZmATOvFAp
         qFOyCN5Hvu437KAtFOEjm/uAqTyaCTK3jdD6GdTo0UCYu4tWodJf+OWvuilKjReug/W8
         +U6qMeZv1c5gCIvYuJAWNHoKeDu/To18XhzbNXGeI5DW/55ZU5xy81e4Yqdanh8ToFcU
         09dTcYWI9ahOoyT1ZEQyan7GyAIiI+n/E9TfsbzRjz7Wa1NT3LRxaERZ6MQWKJjPC6Ny
         NjcA==
X-Gm-Message-State: AOAM531tD99DtuTO1o+qyLbi5v+TSI5gzhz9APmyl/SfHbtKCuMBxzLm
        g/1xB4klzMVCt4LrErzEWgpGZ/Jza44PFw==
X-Google-Smtp-Source: ABdhPJyj4/qF4fvSdU6LkAGZ1yxGc1JrmRT7Vlr0H1RlVsAygupZQHyU7b+PRONvspXi1J2MrlDWIQ==
X-Received: by 2002:a62:7907:0:b029:23e:9010:3844 with SMTP id u7-20020a6279070000b029023e90103844mr14743834pfc.58.1618018501204;
        Fri, 09 Apr 2021 18:35:01 -0700 (PDT)
Received: from kali ([103.141.87.254])
        by smtp.gmail.com with ESMTPSA id 22sm937483pfj.101.2021.04.09.18.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 18:35:00 -0700 (PDT)
Date:   Sat, 10 Apr 2021 07:04:55 +0530
From:   Mitali Borkar <mitaliborkar810@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, mitali_s@me.iitr.ac.in
Subject: [PATCH 2/6] staging: rtl8192e: remove unnecessary blank line before
 brace
Message-ID: <YHEAv+Bnl3NVUi/s@kali>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed an extra blank line before close brace as it was not necessary.
Reported by checkpatch.

Signed-off-by: Mitali Borkar <mitaliborkar810@gmail.com>
---
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 2 --
 drivers/staging/rtl8192e/rtl819x_TSProc.c | 2 --
 2 files changed, 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 7ed2ed9e63f6..e188e9e6b11e 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -263,7 +263,6 @@ static void HTIOTActDetermineRaFunc(struct rtllib_device *ieee, bool bPeerRx2ss)
 
 	if (pHTInfo->IOTAction & HT_IOT_ACT_AMSDU_ENABLE)
 		pHTInfo->IOTRaFunc |= HT_IOT_RAFUNC_TX_AMSDU;
-
 }
 
 void HTResetIOTSetting(struct rt_hi_throughput *pHTInfo)
@@ -445,7 +444,6 @@ static u8 HT_PickMCSRate(struct rtllib_device *ieee, u8 *pOperateMCS)
 		break;
 	default:
 		break;
-
 	}
 
 	return true;
diff --git a/drivers/staging/rtl8192e/rtl819x_TSProc.c b/drivers/staging/rtl8192e/rtl819x_TSProc.c
index afcdb4b6a18e..1b994a57633f 100644
--- a/drivers/staging/rtl8192e/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_TSProc.c
@@ -193,7 +193,6 @@ void TSInitialize(struct rtllib_device *ieee)
 			break;
 		pRxReorderEntry = &ieee->RxReorderEntry[count + 1];
 	}
-
 }
 
 static void AdmitTS(struct rtllib_device *ieee,
@@ -254,7 +253,6 @@ static struct ts_common_info *SearchAdmitTRStream(struct rtllib_device *ieee,
 			    pRet->TSpec.f.TSInfo.field.ucTSID == TID &&
 			    pRet->TSpec.f.TSInfo.field.ucDirection == dir)
 				break;
-
 		}
 		if (&pRet->List  != psearch_list)
 			break;
-- 
2.30.2

