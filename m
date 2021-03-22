Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0AEE34474F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 15:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbhCVOdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 10:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbhCVOcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 10:32:36 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF2AC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 07:32:36 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id h10so19585020edt.13
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 07:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mb74xJj4X7Fk0W46aIpOMrmEyQd8S7cZr54o50UVkWo=;
        b=Z+1WnJh66sCLEUlrt4qJ+SKai9/C5gU7Lmtf//6P7u3FfEb4NfY6kIMnTGa32mL3pm
         Rw4bV3e8Tskjiz+zirSPEC8RUfWlCi3eQHBFj9rZwQeVd7W0D8Niw9NpZM2WTozWRl6a
         2FB36c+dZB2mN1pR9zEIFE8yutm1RbWlu6ysVHtqH+fWjFExSOygP99/IKdqUZeibbX3
         QAfD2BTjfEWO1zsSOThMurWRF051UHYEgRzesnbDo54cwLU4UTOX6AibChRAQgtt4FqZ
         /PSexLGykVzJom7NZZbmugW+RcUoGRqORXTBP10Xbr7ufTQ/dR3SMnc0Qq90GW9qZY3s
         xECw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mb74xJj4X7Fk0W46aIpOMrmEyQd8S7cZr54o50UVkWo=;
        b=FkLAYBFw635sglX3sTvzHzyX2EXdGy+7DxH6w1vI2ktSB0be1Nqp4xiYDEo8OrGDiK
         E985U7DoBGJYZQBIDm93FInscWeA2uQZVd9nOAOYNgrxJeDdwwePWQOIYbdVLbeT1RWJ
         X5fB/etl+6PHRRymn/ddesdWLWuxxJGvaPfTTltmj0Jm2sApMEbkKvhK7jvtR3mUwFXY
         DV/kXB7tYxePFi9chY5CPX4tmaad8b4x7xCAwesh1MMpsAVoEIgduxVWTAnBrGryEenP
         9SnFWDRXnJ1PvL/V1uyd/zvvVvda9BzdA/J3AnD3UpkcJhxcgiuw/6jrvAWdgcfM5Jym
         f6Cw==
X-Gm-Message-State: AOAM532o59gLROtIVUx6C8ci/vvA3l16PpQtblVabNhBJTd85Z9COlDZ
        OlYEexY1I2cOVF0DnnStQ6M=
X-Google-Smtp-Source: ABdhPJweYywt3A20ph306ub1lAZxde8kZ9R33ICb3QzjKL11sGQ9dQDPLzMQnhjiTM/eD8RZa97wxQ==
X-Received: by 2002:aa7:d792:: with SMTP id s18mr25803643edq.176.1616423555328;
        Mon, 22 Mar 2021 07:32:35 -0700 (PDT)
Received: from agape ([151.57.176.11])
        by smtp.gmail.com with ESMTPSA id gz20sm9943432ejc.25.2021.03.22.07.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 07:32:35 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, apw@canonical.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 10/11] staging: rtl8723bs: remove undefined function prototype in of os_dep/sdio_intf.c
Date:   Mon, 22 Mar 2021 15:31:48 +0100
Message-Id: <6a8553f32eb109a2d24b3016367e805426ebcd29.1616422773.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1616422773.git.fabioaiuto83@gmail.com>
References: <cover.1616422773.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix the following checkpatch issue:

WARNING: externs should be avoided in .c files
486: FILE: drivers/staging/rtl8723bs/os_dep/sdio_intf.c:486:
+extern int pm_netdev_close(struct net_device *pnetdev, u8 bnormal);

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/sdio_intf.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
index 8f8549eee23e..185919b6963f 100644
--- a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
+++ b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
@@ -483,7 +483,6 @@ static void rtw_dev_remove(struct sdio_func *func)
 }
 
 extern int pm_netdev_open(struct net_device *pnetdev, u8 bnormal);
-extern int pm_netdev_close(struct net_device *pnetdev, u8 bnormal);
 
 static int rtw_sdio_suspend(struct device *dev)
 {
-- 
2.20.1

