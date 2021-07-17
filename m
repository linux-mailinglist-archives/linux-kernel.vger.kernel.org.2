Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54B913CC3E6
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 16:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234537AbhGQPAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jul 2021 11:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234410AbhGQO74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jul 2021 10:59:56 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38CCBC06175F
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jul 2021 07:56:59 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id l6so7569373wmq.0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jul 2021 07:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zyox365Ii1ilVd+ni/OL8Ydjg+OlcC8rNpEGzbROUls=;
        b=UQuxlyza12DYczTfoUDXY0/pu2r92CUSmUQk39mXCq79nviyKAzsIZUnHqFNzWmFD4
         KzrZSS8P19xgBkNliturf9ikvSSA8HywlhaMxcQKtSKkaBnddt11nS1a9okLlJYaR4iM
         e3U0US2QOP1g4DuKpnUkfsfOcjuAbedDzN7OPzaj4wPeDmXGms3caPX7rXPdoGfrH7Yv
         UN30PO2FkU79moqEjlaziodADwP35/GPtXm8ETPhMbg+z5Fxwis/QeeavNToNz+h01uR
         qNvlyA5IP5VTJhHaGt8sw5np6/9qjBeImuGlGhReP8zDv+sNkFyQyEGKDM1gwmN3s5za
         yf1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zyox365Ii1ilVd+ni/OL8Ydjg+OlcC8rNpEGzbROUls=;
        b=oFbeejGui1qWW2BCEk68cl/giCCyjBKvqLUUV6zw2sM11ElOulqp26RJsRZeyjk7Sy
         cCzyHC3gmndXPEehJYfVw5G5MbN1T2Ee1sDJdHLQw+HA7BWGiTNOdiWG0lbyegsCmxkA
         sMsj0ixifgNi/Oi5xkuoBL64mss7PwSDT/ji95h+zrBgR08gsG/gic/jxRcptbZH/yfV
         MjcPuLKklW6jEr/LFjKAoK/6d9FUEEmN6vjARwPw8LFNYCjfVlo4Ab7smOjB1kiyFomI
         JMmTbAGsFKXu6ic/wjuXKbkEqL7qI2kba3AdShREucJCH+HHcSlaSEF8Nv9V045ieEI+
         Xcew==
X-Gm-Message-State: AOAM532/osh9NtWSn6IOoBkkz+QY1ZSVQqoTyjgP0LA5Y0ndHC5q1ZDG
        JkIJwAasoAYfNNSeX+mxWCEi+aLjiQk=
X-Google-Smtp-Source: ABdhPJxiZbm48x1DxBPFGDb1bhtM+lB300QKeBEa1GW1Yma3/C2hDhYDNK/aD0nEhLYq8oU84ULdvg==
X-Received: by 2002:a1c:4b04:: with SMTP id y4mr23129505wma.185.1626533817809;
        Sat, 17 Jul 2021 07:56:57 -0700 (PDT)
Received: from agape ([5.171.72.101])
        by smtp.gmail.com with ESMTPSA id p12sm10619283wma.19.2021.07.17.07.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jul 2021 07:56:57 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, hdegoede@redhat.com,
        Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/10] staging: rtl8723bs: fix camel case issue
Date:   Sat, 17 Jul 2021 16:56:44 +0200
Message-Id: <a708b2b9902bedf5bd0466b05516a4c5b4f43723.1626533647.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1626533647.git.fabioaiuto83@gmail.com>
References: <cover.1626533647.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix following post commit hook checkpatch issue:

CHECK: Avoid CamelCase: <NetType>
45: FILE: drivers/staging/rtl8723bs/include/ieee80211.h:170:
+#define is_supported_ht(NetType) (((NetType)
	& (WIRELESS_11_24N)) ? true : false)

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/ieee80211.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/include/ieee80211.h b/drivers/staging/rtl8723bs/include/ieee80211.h
index 8eb0557a077a..b2c1a7dafcee 100644
--- a/drivers/staging/rtl8723bs/include/ieee80211.h
+++ b/drivers/staging/rtl8723bs/include/ieee80211.h
@@ -167,7 +167,7 @@ enum network_type {
 
 #define IsSupportedTxCCK(NetType) (((NetType) & (WIRELESS_11B)) ? true : false)
 #define IsSupportedTxOFDM(NetType) (((NetType) & (WIRELESS_11G) ? true : false)
-#define is_supported_ht(NetType) (((NetType) & (WIRELESS_11_24N)) ? true : false)
+#define is_supported_ht(net_type) (((net_type) & (WIRELESS_11_24N)) ? true : false)
 
 struct ieee_param {
 	u32 cmd;
-- 
2.20.1

