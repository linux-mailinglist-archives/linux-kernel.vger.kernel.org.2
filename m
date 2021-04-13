Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5961E35E203
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 16:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244119AbhDMO5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 10:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238034AbhDMO5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 10:57:00 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA36C061756
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 07:56:40 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id m9so4043235wrx.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 07:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fcNyffarNsOiVEVgcXOuYtMdvEd9IGl7N+PC1sh6FEc=;
        b=Pm4POwMQ4Y6m5BACHfj/4VmvBLuQwj+n+4wNHczovv5QPTVCFmI7EUi9dPYGjLjXXX
         R14zaoGQ1p2jerCyHbXTpZSVx/M7qJ2X6yfndPerKryGppsi5ZA/3R8q/YudEHtMsKiM
         sf89lOQYsnVrkp01Sd8oGmrHNhY1k5MJEs4P5YawmqTb1FrbI7VY7jecNGCfG51TcAYv
         TpEa4w0xLR0h0s6VfW7Z4pt04WxdCN63oAqpaATA+3QQsqeDeW+fE5yF32rJyGOWYs38
         Cy/J+JrtmbTHpPtB+3RpZLVx1jwlTuk6mVmJ5zkCiMQGHSUevSYdIZD5GHd0sL/UFIrj
         P8QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fcNyffarNsOiVEVgcXOuYtMdvEd9IGl7N+PC1sh6FEc=;
        b=Ja9AGFWRBXoe/RR45qF+6ohPpwK/HdqMUfPZfsg3pRainGEmr0RSLJqYYcru++IdWT
         fh9koqx0HLMiYVmFYDNOaR9J1fFHcJmLqBEldmS1TXmOQRqr9gQiaz+mcuTTOTotLUqy
         hHsI2yBUb1EyL3f7Oc6EGTRsPo6+a25hZfpIKaJNy+RVA4xytHcHImafPSSUlOOpPv7R
         v8QnC4D2awrkYcfaX6W05dWdRpaVyVBS6zzQsWVrgeVe+17DiHGobehBZbhrKpmKfczb
         6sQmWI3ITt5HdBYg+mkDD73OVKAqeRS3CPYeL0aUHl2pwQO5y859Zymv7HcXb05+Aa7F
         yG2Q==
X-Gm-Message-State: AOAM530pYfojrdwx/+TxPMlOJkHow98g3vlYV6fr/UxLvXmnGXAzNI0S
        8yEfDYXIpoB5oW+rluJ29iGteCgT4MRGDQ==
X-Google-Smtp-Source: ABdhPJx/KQgbI5xJ+lIxPVNo1xAh80jlt/TUSO/+ISZgy8Ahqt4OIOc/yKll/ao1UlGGPJYsxD5LQA==
X-Received: by 2002:adf:e0d1:: with SMTP id m17mr37271782wri.90.1618325798766;
        Tue, 13 Apr 2021 07:56:38 -0700 (PDT)
Received: from agape ([5.171.81.171])
        by smtp.gmail.com with ESMTPSA id b6sm21770430wrv.12.2021.04.13.07.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 07:56:38 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     julia.lawall@inria.fr, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] staging: rtl8723bs: replace dump_drv_version() usage with netdev_dbg()
Date:   Tue, 13 Apr 2021 16:56:29 +0200
Message-Id: <a4df375dba6c004a22cf197ff8d498d0e4f3b52e.1618325614.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1618325614.git.fabioaiuto83@gmail.com>
References: <cover.1618325614.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

replace dump_drv_version() usage with netdev_dbg().

There's no need to further wrap a netdev_dbg() call
for such a low number of occurrences.

The string printed is the same contained in DBG_871X_SEL_NL macro
called inside dump_drv_version().

This is just preparation before bulk DBG_871X_SEL_NL macro
replacement by coccinelle, as the semantic patch that will be
used just replaces, doesn't remove.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index 332855103b14..98c9eb399ba7 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -2590,7 +2590,7 @@ static int rtw_dbg_port(struct net_device *dev,
 					break;
 
 				case 0x10:/*  driver version display */
-					dump_drv_version(RTW_DBGDUMP);
+					netdev_dbg(dev, "%s %s\n", "rtl8723bs", DRIVERVERSION);
 					break;
 				case 0x11:/* dump linked status */
 					{
-- 
2.20.1

