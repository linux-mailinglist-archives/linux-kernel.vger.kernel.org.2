Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFB33531E8
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 03:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236406AbhDCBYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 21:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236267AbhDCBYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 21:24:19 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7427FC0613E6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 18:24:17 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id j3so1165116qvs.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 18:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DeoFKgDzb/PHpz6A47B2kvtL5R6Ovuwi47NQyXGXcro=;
        b=Cw4wtnQsrTj7AONi48RKNf427c7jushRtNXN0np0u7QGUbkX6/dEBdEFAQUQb8RApe
         z60uA70xUhPZKoWU9Q712nL4Xd1gqCm8JuopV4wc53VpkfS40KJNtcQRh4O0lF0EXIH1
         Umb48czA00hXRrKoWLOslKWVXeQXlfpe1Ku+KLeX++bkm+0gN0LmescUI+jERvzgJ87x
         Lsg9BDrJg+3swmTeh9WyDhLaoJlBL5NOx4g+pLgAqLYevD3kpWsKUWWw6tV4HIo5SPds
         BLsgNEZ6piBgbxaYrXF1guErN57ZgNPMvPJTq42reXTxz/XsE+7Dprcwe5WL9mRr+LXM
         wk2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DeoFKgDzb/PHpz6A47B2kvtL5R6Ovuwi47NQyXGXcro=;
        b=Gs7q4bL68kaVjGzub9Ld4aCFFbkI2sy/6qNbLb02iCueDPv/Lqpq2IJttBkd+nBuBu
         z7byyDXeFGEOn1z4PNue+7yJ7YBlvKnbl/0SYg1VyRP6lzdTP4nEUm0u+U1vdbUQR72R
         U5vGgQMp1x5ZZvoYWs7umN3y1Sv20DxPD8xm/9Ix0bm7qslu54B8jWvLj/4e9NmXYYZW
         icJslEjgRGFcx2Z3vh07GdssSw8Jgt80zU2H3XFEYfRWDTSr0xRMmO0nn5lJQQVC1Sz0
         m7ItVrm8ySCScnjdjf/VdBFVmliKnaLXNocls8WsNTu/jzF/douGdw+zqLZmi58m2EJ5
         A2zw==
X-Gm-Message-State: AOAM531SdAorqiGr2RyLl+4dNfte3vM/u+nTNCmumMrfHjdaE9rz3tjA
        CFBunFYhwZ9KsBGN5zh+XF4=
X-Google-Smtp-Source: ABdhPJyKtU3VG+xmZ3GiAidmYNwuXSu7583X+vWv3MhyM89YGxBX+/Do5WSDAHWjuD+FkRS5avpFuw==
X-Received: by 2002:a0c:cc89:: with SMTP id f9mr351542qvl.46.1617413056748;
        Fri, 02 Apr 2021 18:24:16 -0700 (PDT)
Received: from LuizSampaio-PC.localdomain ([2804:14d:5cd3:8f4f:bad9:1dc4:19d9:7ce3])
        by smtp.gmail.com with ESMTPSA id h14sm7439818qtx.64.2021.04.02.18.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 18:24:16 -0700 (PDT)
From:   Luiz Sampaio <sampaio.ime@gmail.com>
To:     zbr@ioremap.net
Cc:     corbet@lwn.net, rikard.falkeborn@gmail.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Luiz Sampaio <sampaio.ime@gmail.com>
Subject: [PATCH v2 6/9] w1: ds2438: fixed a coding style issue
Date:   Fri,  2 Apr 2021 22:24:43 -0300
Message-Id: <20210403012446.381516-7-sampaio.ime@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210403012446.381516-1-sampaio.ime@gmail.com>
References: <20210403012446.381516-1-sampaio.ime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changed the permissions to preferred octal style.

Signed-off-by: Luiz Sampaio <sampaio.ime@gmail.com>
---
 drivers/w1/slaves/w1_ds2438.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/w1/slaves/w1_ds2438.c b/drivers/w1/slaves/w1_ds2438.c
index 56e53a748059..ccb06b8c2d78 100644
--- a/drivers/w1/slaves/w1_ds2438.c
+++ b/drivers/w1/slaves/w1_ds2438.c
@@ -388,7 +388,7 @@ static ssize_t vdd_read(struct file *filp, struct kobject *kobj,
 	return ret;
 }
 
-static BIN_ATTR(iad, S_IRUGO | S_IWUSR | S_IWGRP, iad_read, iad_write, 0);
+static BIN_ATTR(iad, 0664, iad_write, 0);
 static BIN_ATTR_RO(page0, DS2438_PAGE_SIZE);
 static BIN_ATTR_RO(temperature, 0/* real length varies */);
 static BIN_ATTR_RO(vad, 0/* real length varies */);
-- 
2.30.1

