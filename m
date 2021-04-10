Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 279B035AEA6
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 17:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234912AbhDJPAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 11:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234879AbhDJPAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 11:00:53 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA087C06138B
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 08:00:38 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id h10so9825962edt.13
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 08:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bgdrPa7l5L6m3hWfj8WaDq/TG4IT8UX2aSD3AHmvjM4=;
        b=a4++dpXfQhFANQH3JEHBxYb72PGTgDy2ZZOmdYrZUjZ0nq5RFbDPFAubt6sH6KNe7+
         ECLEWOqho1uHNdpZLJcz0V0q4ft43WUZ2h6EUqz//pH7lJzYfIdlpmePYqVcjFbFkH0J
         McoflhG6YzEg8rUs8bnSajnmEGtaVLM79+CvlortLqdyluzfIU3y7PVNosNraG9e78MW
         bEdQnwJ8HqN7eNCWrDclXIjLFbk/iRV4U78zU3pFd2aIWTOeGleWl4ACzmOeVCLjw39T
         OnR1R4wToexQN1eA5nJi5g0FjRvYdoVGm1tn2xLFJ59Tsdibq6uydyc+FiNPmo7wvvyO
         UtdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bgdrPa7l5L6m3hWfj8WaDq/TG4IT8UX2aSD3AHmvjM4=;
        b=ap2dvjYzyEfy0G/waczW1RfGVbR922U7FcMkPvQsO1a9hZqyPaQElROf0LOHXi6wIU
         IlJUDqnXdtH4X2on9YyVIsAq9n02dSbi5SnSA1Oka4823TIqzOCBJjQ/Fm61vHFfY+h3
         C7cka9sYvH9q/qIwaTt9N5A9ZYJkM8mWCxj6C2mLXZJlNpym/2rCdxLxvO4Wn4EP40Rz
         G9XXIWwLGNbh0GsMNVa9U/ixjlpd+v6ckmljIZgJ//WVc3XV0i6/LlAauOMV2N3Afr9i
         XDQxQBiLXUHL18Eo0I0N8AnU1X56jhggzrsZPlTeM+byKz4545Y9r0y3QFeVKUx8eCXA
         Bt2g==
X-Gm-Message-State: AOAM531L7Si3X5DpbOKHM6Neum1Rq9LgYIBwDycmd2eCuXC2M89P9zXh
        QEOxSNyO3gw+owQPGSIKjYA=
X-Google-Smtp-Source: ABdhPJzourPZ2SALuJifEw4Kr/rB2XuDE/jyruxX9Bjtq5LyGlbB6CUjICg39sAbm4SA1xboi0uVRg==
X-Received: by 2002:a05:6402:17af:: with SMTP id j15mr22330057edy.50.1618066837748;
        Sat, 10 Apr 2021 08:00:37 -0700 (PDT)
Received: from localhost.localdomain (host-95-237-55-30.retail.telecomitalia.it. [95.237.55.30])
        by smtp.gmail.com with ESMTPSA id gb4sm2719494ejc.122.2021.04.10.08.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Apr 2021 08:00:37 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [Outreachy kernel] [PATCH v2 3/5] staging: rtl8723bs: core: Remove an unused variable
Date:   Sat, 10 Apr 2021 17:00:06 +0200
Message-Id: <20210410150008.5460-4-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210410150008.5460-1-fmdefrancesco@gmail.com>
References: <20210410150008.5460-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete local variable "u8 sec_idx" because is declared and set, but never
used.

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

Changes from v1: No changes.

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

