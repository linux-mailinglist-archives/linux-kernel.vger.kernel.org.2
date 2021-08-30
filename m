Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 817A03FB58B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 14:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237379AbhH3MGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 08:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237134AbhH3MFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 08:05:31 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9B4C061764
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 05:04:37 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id e26so3224735wmk.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 05:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eF8hUMXIhBsRJkAF7DIG+jKUHZ6c4iXSE2pyRmvKCds=;
        b=Sno+t9x0km+5GnMk09xljLYqotrtbyi02yPWrwYJW1ACMP+OFOhgASWYBYccSnua4M
         TtDE/c7i4AoSqeA9sbBpfdgfc81j9jFVOpouJW20AJVVFKrf3T2WKwWIcczyzptuZCJg
         SuXQh/7BMsBs/RYuQyBMRA1lM3hEyuUP91dvXF4yE86nEHoWy7N9U2MlNOljXPPQSpUP
         3JaHTozt/NTHckjsZhbL9zSpondsxCb6NAardONi1eTcFQ6SJ8vQdlA+sLigIGoH/pcr
         9I5Pvq7s8viAtEf/P9Aaybyln8CFmrWwNbefrdKQ+LOVimLYTx56HF3uyFsxJCt9KPb6
         0w7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eF8hUMXIhBsRJkAF7DIG+jKUHZ6c4iXSE2pyRmvKCds=;
        b=BLUQmH768CxNXTudxFh/ssNmdofzden/plEtg2NZHsMbtF884qWgzfWkaNVdWtXE4j
         3QdI19do2HOEFRBlePXOzlf2feYonCYql3YQhzrhWoUQawt+ybUVuL9YeOTMQX521CRO
         pZ9eYzecIfKH26wFO1c3AAxZq8VM6gVvtU94e4ZuGFL0q2Mtu4LLXUhwoLP3RcY7s2WS
         H90YVoSxt+RD4aFucpqWWS5ZizTHYt7R4aoxFvPneyw6czgBncwkjqTJhzJenIbe3Lei
         AL1Xz3wlUhbu855sLwIkTOW+C/l/fHTjtnOc26zmiBfW4lcWH/3mOQppSdcV9lzHSUJz
         P+vA==
X-Gm-Message-State: AOAM531CuEa0ECtRDvfJHj8Yr9sWtbH5a7f4dbIVdntRopIcEwS/kMwG
        7gDEFh+ZJPIXMuZ261QdIis=
X-Google-Smtp-Source: ABdhPJzZu6RhmkMtvK8wKDGNtB2P3mLZr0p4K4TFyCE4fx+Vb4EXBT85lbQ3+smslifs/SjFwMbWbw==
X-Received: by 2002:a7b:c255:: with SMTP id b21mr21514057wmj.44.1630325076435;
        Mon, 30 Aug 2021 05:04:36 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::16fa])
        by smtp.gmail.com with ESMTPSA id f18sm13184195wmc.6.2021.08.30.05.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 05:04:36 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/8] staging: r8188eu: use ETH_ALEN
Date:   Mon, 30 Aug 2021 14:04:15 +0200
Message-Id: <20210830120420.5287-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210830120420.5287-1-straube.linux@gmail.com>
References: <20210830120420.5287-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use ETH_ALEN instead of hard-coding the value for the mac_addr buffer
in struct eeprom_priv.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/include/rtw_eeprom.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/include/rtw_eeprom.h b/drivers/staging/r8188eu/include/rtw_eeprom.h
index fb591a764dac..d0c812cf5cc2 100644
--- a/drivers/staging/r8188eu/include/rtw_eeprom.h
+++ b/drivers/staging/r8188eu/include/rtw_eeprom.h
@@ -99,7 +99,7 @@ struct eeprom_priv {
 	u8		bautoload_fail_flag;
 	u8		bloadfile_fail_flag;
 	u8		bloadmac_fail_flag;
-	u8		mac_addr[6] __aligned(2); /* PermanentAddress */
+	u8		mac_addr[ETH_ALEN] __aligned(2); /* PermanentAddress */
 	u16		channel_plan;
 	u8		EepromOrEfuse;
 	u8		efuse_eeprom_data[HWSET_MAX_SIZE_512] __aligned(4);
-- 
2.33.0

