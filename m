Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1F5C3ED17C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 11:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235548AbhHPKAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 06:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235635AbhHPKAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 06:00:09 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE32C0613C1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 02:59:37 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id f5so22658824wrm.13
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 02:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wR4etS7LkvgWmuOBz+KzpKiTXVRl5T3V83fQFCpBf6I=;
        b=R9Q+Wy+jCbiITxuqmiy0hBIfWxM28fGm44OldkwF3+cJhkVcjrXrYULX8G72d6uGPE
         5b3Nc/hKQS6OfRCzDpcJGyzKiVB00GNfA6ivR6CVjmQQ8myIMP1KLK+VTvgPExGQfgTg
         dRIx2LmiRYRJ5abGrAbLywntiroTqOfW94RjShxixPc6PpxhCV/cY22QL3QcyOVsS22P
         zeIp0H0LsuPQBxIMe1jJ92TgCdPxKNWXZ8kN/S2FA7BkCcTkMo9sCzxc1mRkPSsY/3Sa
         ZSDbvfdM+iLXsVyxYQZWWhWwt7rDqfz5x21xODYOgmPY1NvraSfdMHy0fnixPph2jPR1
         KrMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wR4etS7LkvgWmuOBz+KzpKiTXVRl5T3V83fQFCpBf6I=;
        b=MQ00hOd/BkHxaDU5xqp0EMXi8o2IVuiNqHlEzGDoe0NVCllmXsK5cOWk77oYE9yfCJ
         +I+RUwi1EwBPG4MbDcy228WvlzlVaof6L7UA08iRHkdQ84C5EchRTjaEcDtTxuJ2L2Mv
         GJ4ekjqZtwR28R2ZUeiJdJ+twgwC0sOqvOaP7cxwCTZURk1dV7LV2nP2wavIEft7Vu8T
         EsLMQSunXADiIklrszYj2wX4oAdZy7/V85jY4fkLb1t6n/g0Er4bXQVrLQeo7o5xksqA
         xcut87PNY2TF5GHvXiSaM/j6P+m9FwEIKrmXdryzz7BwWLzCsenNGi6RZACc53ferOS1
         40ww==
X-Gm-Message-State: AOAM530hZaVBi+AorfpiFXegcQwEZYFlZmOAehVTqeopAexVN4C0HA4/
        nVHWhtg7ci5nrDeoiRTIoKg=
X-Google-Smtp-Source: ABdhPJzwGKBIw1vPLsIBcJjtG9NF95KO2AWGXjypFjLrUv+NLmuJdXHbYOeURnlF+YuQxA3GxfuOTw==
X-Received: by 2002:a5d:694f:: with SMTP id r15mr17288770wrw.86.1629107976024;
        Mon, 16 Aug 2021 02:59:36 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::4058])
        by smtp.gmail.com with ESMTPSA id g21sm1946635wmk.8.2021.08.16.02.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 02:59:35 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 4/4] staging: r8188eu: convert rtw_is_cckratesonly_included() to bool
Date:   Mon, 16 Aug 2021 11:58:40 +0200
Message-Id: <20210816095840.24259-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210816095840.24259-1-straube.linux@gmail.com>
References: <20210816095840.24259-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function rtw_is_cckratesonly_included() returns boolean values.
Change the return type to bool to reflect this.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_ieee80211.c | 2 +-
 drivers/staging/r8188eu/include/ieee80211.h  | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_ieee80211.c b/drivers/staging/r8188eu/core/rtw_ieee80211.c
index 200c90b8ea51..fdbedc99f798 100644
--- a/drivers/staging/r8188eu/core/rtw_ieee80211.c
+++ b/drivers/staging/r8188eu/core/rtw_ieee80211.c
@@ -80,7 +80,7 @@ bool rtw_is_cckrates_included(u8 *rate)
 	return false;
 }
 
-uint	rtw_is_cckratesonly_included(u8 *rate)
+bool rtw_is_cckratesonly_included(u8 *rate)
 {
 	while (*rate) {
 		u8 r = *rate & 0x7f;
diff --git a/drivers/staging/r8188eu/include/ieee80211.h b/drivers/staging/r8188eu/include/ieee80211.h
index cbefd7af1d4f..1205d13171b2 100644
--- a/drivers/staging/r8188eu/include/ieee80211.h
+++ b/drivers/staging/r8188eu/include/ieee80211.h
@@ -1207,8 +1207,7 @@ int rtw_generate_ie(struct registry_priv *pregistrypriv);
 int rtw_get_bit_value_from_ieee_value(u8 val);
 
 bool rtw_is_cckrates_included(u8 *rate);
-
-uint	rtw_is_cckratesonly_included(u8 *rate);
+bool rtw_is_cckratesonly_included(u8 *rate);
 
 int rtw_check_network_type(unsigned char *rate, int ratelen, int channel);
 
-- 
2.32.0

