Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 981AE35AC6E
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 11:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234611AbhDJJXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 05:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234595AbhDJJXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 05:23:12 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E762C061763
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 02:22:58 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id g17so9534346ejp.8
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 02:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZSnOFIesKBCVdD0WKupHufVEiQpga/uUTH6Sx1Oc/oc=;
        b=X5RFo/3GVWmXIAANlMsEGxClbqtDEvC6CCQpZgHR/1hHEnFzQYYYOJlDyMr2YMS3mL
         2MyA4DVWfY19rAuM76nUaCBmr7H6WL9+FrRR+u/caHi2yZ8rmg4Qe9H5fnSRGNTvlKMX
         pzt0fiJNNBdQaeYDMnIDArz5w6eGZN6WwOmAZL023xpxVOYew+fNv2IRj5xANvz3lz6F
         RYEHb3bGpP7ZhG8OeDB2UMNjh3p6yyuoOFHX4qS5A8A6078ZvKJTNvUH9vyY+H07Osi3
         tQ5BLQ+jBt/FmkpkqmuitZt/Agp+n9i1AD2RnGPUx4LB6akfDbYgSVuIwRSXjVX93sMf
         loRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZSnOFIesKBCVdD0WKupHufVEiQpga/uUTH6Sx1Oc/oc=;
        b=oF+hRzQJCR0ATZSBBtAzBBiAvMxcm2yDOFC6k/nnLftQuD15dp7HTpCFQoGDTZy6J7
         RKgQ8Eykon02b5IAdQi69pEfyRWvQ7oYdS7tcGVYdgkYGoZP1EfZ7fUo4hgPi/lbnEBs
         vBZuEgDCyHLI69T5ywJg9tfLGXWltP5LcrOcCNOJw1IhKqVx4ZcfSL/lrQGBdYskt4xz
         LCoPObN1seT4Zt7J3Cneq4+q7ArvAAL20oq+sbh/0ye+cyJCSh6yFZGQVZGFR7IbfWtC
         T1kuQB0ZaoxIrs8Hwd9tefdBfc9CXNtXY7B0juJ94TLRUSgWyVCKn+6xc5bbEdOM+zqm
         avpA==
X-Gm-Message-State: AOAM530S2MGWlV4QbUvdTI92QFD3MWnTIoOV3E3eg0dp+gU4vJcnmpr+
        QYLU6qU97NWX59hw90d0wimvEjWDOBwY3mIW
X-Google-Smtp-Source: ABdhPJxIMqYxr5oClj3WIN/kzVKrPcI1JKNkqCdpWK0mhvNgtmYXuwTYAcOdQNZ7zrnvfX5gOWlwiA==
X-Received: by 2002:a17:907:d09:: with SMTP id gn9mr18916239ejc.538.1618046576868;
        Sat, 10 Apr 2021 02:22:56 -0700 (PDT)
Received: from localhost.localdomain (host-95-237-55-30.retail.telecomitalia.it. [95.237.55.30])
        by smtp.gmail.com with ESMTPSA id a22sm2801624edu.14.2021.04.10.02.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Apr 2021 02:22:56 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [Outreachy kernel] [PATCH 3/4] staging: rtl8723bs: core: Remove an unused variable
Date:   Sat, 10 Apr 2021 11:22:31 +0200
Message-Id: <20210410092232.15155-4-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210410092232.15155-1-fmdefrancesco@gmail.com>
References: <20210410092232.15155-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete local variable "u8 sec_idx" because it is declared and
initialised, but never used.

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
index 2af66a18200d..3fd8a4261ea2 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -628,7 +628,7 @@ int rtw_get_wapi_ie(u8 *in_ie, uint in_len, u8 *wapi_ie, u16 *wapi_len)
 
 void rtw_get_sec_ie(u8 *in_ie, uint in_len, u8 *rsn_ie, u16 *rsn_len, u8 *wpa_ie, u16 *wpa_len)
 {
-	u8 authmode, sec_idx;
+	u8 authmode;
 	u8 wpa_oui[4] = {0x0, 0x50, 0xf2, 0x01};
 	uint	cnt;
 
@@ -636,8 +636,6 @@ void rtw_get_sec_ie(u8 *in_ie, uint in_len, u8 *rsn_ie, u16 *rsn_len, u8 *wpa_ie
 
 	cnt = (_TIMESTAMP_ + _BEACON_ITERVAL_ + _CAPABILITY_);
 
-	sec_idx = 0;
-
 	while (cnt < in_len) {
 		authmode = in_ie[cnt];
 
-- 
2.31.1

