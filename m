Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E782F3FC127
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 05:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239419AbhHaDGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 23:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232008AbhHaDGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 23:06:02 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2602BC061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 20:05:08 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id m26so13840087pff.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 20:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aFxUvc9I7mwU8nvTkAH00a2ChBoc3xk8dKtPZpMhwp0=;
        b=OfrQVUFGMdoWCwuBx/dZqep8LJx4pjg4Khi2qYcvgZEVQHzs0mgquukanzPH2GD6vi
         Ofpp4oHJeOA65KYX0BfNzuHknF4W6evXGyZw9GAuVRuQidz4uHt2WwVHo4fU/QVP6j94
         D45uMhkOqmvUgpMhJDo7d2tyBTK/yAz38BaCS7BKlJwQJDWHJoFjo2n4l4Lb7jjtKmnn
         xVxJpBfTW7OdCyfYvGVh9NmSgb1+hItSJli/UDM6iz9TJwlIbXaY4C3vNZ+ws0AQMEPg
         OJecOzf4T3+2LhoWWSCxfahNDYeZVIJGLWzuqu3KgG3DqabdjlA9N2X88fNZu1zFZ3nx
         q0mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aFxUvc9I7mwU8nvTkAH00a2ChBoc3xk8dKtPZpMhwp0=;
        b=HCZ+2Dy0gzuUK/ChBmLFkmI4qJ8ysuDk+GQnsAfZ1EioXt0d0uZ0VTVU5fM06Z4+R3
         H0xgv6LEtNicxBEtXclkcnPCrmiOWXmFSaiRekinSXK1Tx1g2to1Yfz32QLzhyHutz0e
         cM6R1FgCE0x21wuIqExbRZ/Poaj22QnGY+wKFxAgPByPSij9/zTml+P5upCcouREvJVH
         grOBk+m1U5Q6aOKl3xR304QvQYN5juKpF4IwvmDWSl0ceH4kBnX3x8z5p2uiFPCNiqas
         VFEcakUZX60iHmB8b4EjcIryzE/get2KdPA/uy9Cf2acw0KGfOY/Nn5CgUcZ9P75rKhZ
         y+5w==
X-Gm-Message-State: AOAM5328oebdmKfev13BTeoiy3PZWe9Fw1fSmVmIT1H1UibIPoaYYxs6
        ycSNFhl2OZP2Dii+0fOslj/aZ+sph88=
X-Google-Smtp-Source: ABdhPJwqWz3+kOy7Q2nca4pOiqlLhKSdOeI3V+M0dYLhOk6YJIC2fuwckIBRYXlEc9DAPSdOZ8yZYA==
X-Received: by 2002:a63:1618:: with SMTP id w24mr24343362pgl.146.1630379107558;
        Mon, 30 Aug 2021 20:05:07 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id d5sm402219pfo.8.2021.08.30.20.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 20:05:07 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: xu.xin16@zte.com.cn
To:     salah.triki@gmail.com
Cc:     xu.xin16@zte.com.cn, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
Subject: [linux-next,v2] dio: add missing iounmap() after ioremap() from dio.c
Date:   Mon, 30 Aug 2021 20:05:02 -0700
Message-Id: <20210831030502.10965-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: xu xin <xu.xin16@zte.com.cn>

When the condition 'scode >= DIOII_SCBASE' is true, the pointer 'va' is
mapped by executing ioremap(). Accordingly, if kzalloc() fails, 'va'
needs to be unmapped before returning -ENOMEM.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: xu xin <xu.xin16@zte.com.cn>
---
 drivers/dio/dio.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/dio/dio.c b/drivers/dio/dio.c
index 4c06c93c93d3..7d192509a8bd 100644
--- a/drivers/dio/dio.c
+++ b/drivers/dio/dio.c
@@ -218,9 +218,11 @@ static int __init dio_init(void)
 
                 /* Found a board, allocate it an entry in the list */
 		dev = kzalloc(sizeof(struct dio_dev), GFP_KERNEL);
-		if (!dev)
+		if (!dev) {
+			if (scode >= DIOII_SCBASE)
+				iounmap(va);
 			return -ENOMEM;
-
+		}
 		dev->bus = &dio_bus;
 		dev->dev.parent = &dio_bus.dev;
 		dev->dev.bus = &dio_bus_type;
-- 
2.25.1

