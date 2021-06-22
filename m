Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70BCE3B0586
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 15:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbhFVNMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 09:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbhFVNM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 09:12:29 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5862FC061767
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 06:10:12 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id h21-20020a1ccc150000b02901d4d33c5ca0so2221579wmb.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 06:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fuMF6VsqpQHGen6pDrwB6pK2wNwSSnPLXzA/6UmoJDM=;
        b=cVRNcNxcRVo5T+DoeWhyCiRRA3z3PEjBhzLYvJ1jZ6P+LVqmWs78fIVwX/ulXHf/ZS
         6e03N/vW16j/8WlStIcqTXXOnmkD6AVue7p98aPoK2AZx86Hm09GvsL5p7+oPD6w2a9A
         45OnrtWiv9WUXNecqPI+/VkpXtum8p8DuoYCK7fIOtk2y+PRdyDhuDeLq5M52xSfxHoV
         kp3Oo3mKTkDrkNuWbkhCDFbl9u9LGvEZsbjnuensGMV+J4CW/kb6zZPeYHNamQTg+BrM
         fCKgElRezX0uAhqemFncNqgIPfnXPdRn2t9/6nzqXSr4P1NMzCPR82cZbujqT8Yl4qH+
         t23A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fuMF6VsqpQHGen6pDrwB6pK2wNwSSnPLXzA/6UmoJDM=;
        b=tr4ND1+MWN/Zq6V3PszgPUVcvJjVtBNQ+76AfGtaC6eYOv+AYZmirK5zfmSmqFmkqs
         0iJQwP5bemd8ywy5ACqy4yaHjKOeyO+S8NAT4lQlQBxwJjsyKAp+Vv287mXtxnq3vsrP
         +0gdpPjrHPdJXQUK7U1edgZPyVRtC9RHaRoPF5ONc1r0X9ziJdSmDIYp6ViT6h3xiRHF
         eRcqSyJfVTNLOUG7sHAPh9M7Af+Gv6KVf8vIhW84dpbCNGdMt2CVf3cIw2IzJ82gNKtp
         No9kcrzGIOugZiWnW1+kiWZKa9XGV4usgwDatW1hxIDrK+nERWg3GaoFBmxTrR9lDVaW
         9Mhw==
X-Gm-Message-State: AOAM532DLbZcKc7YEIibVaoZsvCCVpJBuvVTcfMalPyjEWyZ74ZSaGOI
        oDvbg/SZpsw6vWjb3KdlZEj3HPSXyTPrVA==
X-Google-Smtp-Source: ABdhPJw8ba7sJWeYoQx8T8EpJQDCegVPgoG9LDaxB6IBb4cKoNcYmkhnSKdvmFiLK61hnCOBabjj9Q==
X-Received: by 2002:a1c:2985:: with SMTP id p127mr4275068wmp.165.1624367410803;
        Tue, 22 Jun 2021 06:10:10 -0700 (PDT)
Received: from agape ([5.171.73.108])
        by smtp.gmail.com with ESMTPSA id d12sm9655083wrn.69.2021.06.22.06.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 06:10:10 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3 05/17] staging: rtl8723bs: remove 5Ghz field in struct registry_priv
Date:   Tue, 22 Jun 2021 15:09:49 +0200
Message-Id: <3a58fae5330a321dd570d1a7931a5b17bb3996a8.1624367071.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1624367071.git.fabioaiuto83@gmail.com>
References: <cover.1624367071.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused 5Ghz field in struct registry_priv.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/drv_types.h | 2 --
 drivers/staging/rtl8723bs/os_dep/os_intfs.c   | 1 -
 2 files changed, 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/drv_types.h b/drivers/staging/rtl8723bs/include/drv_types.h
index 02df5bd8f575..895c41526164 100644
--- a/drivers/staging/rtl8723bs/include/drv_types.h
+++ b/drivers/staging/rtl8723bs/include/drv_types.h
@@ -171,9 +171,7 @@ struct registry_priv {
 	u8 RegPowerBase;
 	u8 RegPwrTblSel;
 	s8	TxBBSwing_2G;
-	s8	TxBBSwing_5G;
 	u8 AmplifierType_2G;
-	u8 AmplifierType_5G;
 	u8 bEn_RFE;
 	u8 RFE_Type;
 	u8  check_fw_ps;
diff --git a/drivers/staging/rtl8723bs/os_dep/os_intfs.c b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
index a06c8b1beb01..648456b992bb 100644
--- a/drivers/staging/rtl8723bs/os_dep/os_intfs.c
+++ b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
@@ -289,7 +289,6 @@ static void loadparam(struct adapter *padapter, struct net_device *pnetdev)
 
 	registry_par->RegPowerBase = 14;
 	registry_par->TxBBSwing_2G = 0xFF;
-	registry_par->TxBBSwing_5G = 0xFF;
 	registry_par->bEn_RFE = 1;
 	registry_par->RFE_Type = 64;
 
-- 
2.20.1

