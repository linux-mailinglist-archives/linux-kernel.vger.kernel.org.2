Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA2F4150F5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 22:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237386AbhIVUHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 16:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbhIVUG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 16:06:59 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 769E5C061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:05:29 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id u15so10384195wru.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7e0J/R3gJQDabLtHpyjQtJohAsSE1y48rkqb7f3qtUY=;
        b=hgDUzJx9Wklh5ga++9Ww6PwBSw3PHmNLidI7GjhFVbFYKzKO80hxVYClgQ44rIUZ2i
         k7kQQDHmskPF3VfOXddFbDh77rEOYpn2FLtWzEsooSX/ZmRDgNabR1L/+WSrggQB20tU
         iIXVS0imaFljey5tguIDydky4IzzgsEpjMqHAd5MmeTIOR1O3ihbkLsZWGPshfZDsaWc
         1bvfLFGlCNeHTNDcvbYn5Ua8CcE2NK9Ccsf55laeskzrSMKA3jwRTg1m3a1mJ+HgJBXb
         wgyP4/bjg2c3LOk5qGzmbxx1oj2MvbaU+Z0LrSHgF56jdYzaV0vXfZaVF+coBEATg9hb
         Xv7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7e0J/R3gJQDabLtHpyjQtJohAsSE1y48rkqb7f3qtUY=;
        b=fza78pRglLoIB8b1TgbH9VTCPfwZF0YSAe6Mr3755G73eLTcvOENF14e2y8gjXFjOT
         LKJ/meS4p50mVaAB+uY6sdPuR+BOq6lWjGnLv7Zm7yZ7xbH5mWnitSma577bxrBET5Z2
         4gO+Qar423UOj2NBtbkyhU1AWnS9DQ7biloaKrNtzaBVnRWaYpXIpv2oKHyppNQt+diD
         v3O1amTNu0hk+Y6ee4ct9eycZbr3UjVLtduV91rBULNbgJFc00QLV8FqKoWS/AzczCLU
         r6WWn0sUyGjXFnZCDCOMFVeIChZr94hGV4D42D6nLp+UcZ/t4P8t0sIcHKwI9q8ZAPHD
         4rGA==
X-Gm-Message-State: AOAM530EJtt/KO9Fk8eQ11tha/VIY1rpHFzvF8E98bedeAEBAqcctjTc
        Qm1evbapAqAXDesmYYiJV39KxCtvyv0t1A==
X-Google-Smtp-Source: ABdhPJx9EuC82Fw1eD74bNVhvtvthXqtmBWDVjaxdniMkpMlE6EsAOYlXgBoXdRQFaUIe40CLjm6lA==
X-Received: by 2002:adf:cc82:: with SMTP id p2mr907133wrj.5.1632341128165;
        Wed, 22 Sep 2021 13:05:28 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::cde])
        by smtp.gmail.com with ESMTPSA id e2sm3219761wra.40.2021.09.22.13.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 13:05:27 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 03/47] staging: r8188eu: remove efuse_GetMaxSize()
Date:   Wed, 22 Sep 2021 22:03:36 +0200
Message-Id: <20210922200420.9693-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210922200420.9693-1-straube.linux@gmail.com>
References: <20210922200420.9693-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function efuse_GetMaxSize is not used, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_efuse.c    | 7 -------
 drivers/staging/r8188eu/include/rtw_efuse.h | 1 -
 2 files changed, 8 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_efuse.c b/drivers/staging/r8188eu/core/rtw_efuse.c
index cb4ad21f00c1..ef7a50d31c01 100644
--- a/drivers/staging/r8188eu/core/rtw_efuse.c
+++ b/drivers/staging/r8188eu/core/rtw_efuse.c
@@ -279,13 +279,6 @@ u8 rtw_efuse_access(struct adapter *padapter, u8 write, u16 start_addr, u16 cnts
 	return res;
 }
 
-u16 efuse_GetMaxSize(struct adapter *padapter)
-{
-	u16 max_size;
-	rtl8188e_EFUSE_GetEfuseDefinition(padapter, EFUSE_WIFI, TYPE_AVAILABLE_EFUSE_BYTES_TOTAL, (void *)&max_size, false);
-	return max_size;
-}
-
 u8 rtw_efuse_map_read(struct adapter *padapter, u16 addr, u16 cnts, u8 *data)
 {
 	u16 mapLen = 0;
diff --git a/drivers/staging/r8188eu/include/rtw_efuse.h b/drivers/staging/r8188eu/include/rtw_efuse.h
index a6e36be6ee76..de98b732fce0 100644
--- a/drivers/staging/r8188eu/include/rtw_efuse.h
+++ b/drivers/staging/r8188eu/include/rtw_efuse.h
@@ -101,7 +101,6 @@ extern u8 fakeBTEfuseInitMap[];
 extern u8 fakeBTEfuseModifiedMap[];
 /*------------------------Export global variable----------------------------*/
 
-u16 efuse_GetMaxSize(struct adapter *adapter);
 u8 rtw_efuse_access(struct adapter *adapter, u8 read, u16 start_addr,
 		    u16 cnts, u8 *data);
 u8 rtw_efuse_map_read(struct adapter *adapter, u16 addr, u16 cnts, u8 *data);
-- 
2.33.0

