Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFCEF3EC1B2
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 11:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237681AbhHNJiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 05:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236824AbhHNJiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 05:38:19 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D803DC06175F
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 02:37:50 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id bo18so19032624pjb.0
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 02:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P0UOfDH46LzJmA9HbmawuoAXG2ONdo7emlUDlsDL1UU=;
        b=BCEDXF2GqTAbjF6KozkgnbvX0jT/36sp7MiceZGJcsHiSDxvvpyLDH7xhrYhxQ1krK
         QOSogHoLRR3+rVtV579FKmkF55GLShIphnmIYu//HfYl8UaTZjxpv4a/4OUMnlhVcA9A
         MXeRibqashXrb9ggOGo8ARfbniUXBO336lVFo8oJeg+LNaVT6dtt47Kke39/8uG787cK
         Fu4iKEKlCwfCzyDCdbDK6T3Kd13vXAMlViXJDiaDNwuOrSOuMOlkWM7dKZwcuLaV8ENI
         OldYeTqqXKJgymEDWBCynqLzrW4w68hpe9s1qYdrydJrLqtOvALxNek3HnUA0Zr1H0CX
         jMjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P0UOfDH46LzJmA9HbmawuoAXG2ONdo7emlUDlsDL1UU=;
        b=qyqc9f3gJ5kW/OMG4M3GXgoF9fCM69MhJLb0QCYs1FPWed+xdzD7TbCC+5dwfx2Gwo
         BlObWtEi+15f4vJulF7YlgT62FlQ5MfLBvXDuuXaBA3QyNoicNzCtdlwmwHBf1sy5WSC
         b6f0SnCj7pvo0RxpjGhrqTxsvhHbtY87TFb5ZPu2uVyl63ePU4nBoJUsJjZQ5bb3K6/+
         UFbfDh2BopJXETEhRecQmBUgAQqNe335IR5fWLQGI8GAzUmIzkAPt4KZhBjItun4uP5e
         M8oPet/pvX5LFnJJk4PPnRL+bcpsQki9092Z+AOvfrzM/VIgmj196RNnVBVSnTZLad6c
         61lg==
X-Gm-Message-State: AOAM533Qs7t/Sh/GCkAPw6Jdzq0VUbB7s64RHyNCj3gcQct/m43VTraG
        v5OFU7uhn0REF+PWxYZmMph35tA41wE=
X-Google-Smtp-Source: ABdhPJz+nieFEHUJ6l59zpPPdPVe5exRhXaszMQdIE0KsUqQTFnViD+aG8gs4Bia/2iEN9dPVt5AuA==
X-Received: by 2002:a17:90a:940e:: with SMTP id r14mr6711426pjo.41.1628933870224;
        Sat, 14 Aug 2021 02:37:50 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id q3sm5823010pgf.18.2021.08.14.02.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Aug 2021 02:37:49 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: xu.xin16@zte.com.cn
To:     linux-kernel@vger.kernel.org
Cc:     xu.xin16@zte.com.cn, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] dio: add iounmap when ioremap() is called.
Date:   Sat, 14 Aug 2021 02:37:18 -0700
Message-Id: <20210814093718.105825-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: xu_xin <xu.xin16@zte.com.cn>

In __init dio_ini(void), when kzalloc() fails, we add the operation of
iounmap because ioremap is probably called in line 210.:

Reported-by: Zeal Robot<zealci@zte.com.cn>
Signed-off-by: xu_xin <xu.xin16@zte.com.cn>
---
 drivers/dio/dio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dio/dio.c b/drivers/dio/dio.c
index b2ff5ff84b80..21bdb16dc2f3 100644
--- a/drivers/dio/dio.c
+++ b/drivers/dio/dio.c
@@ -218,8 +218,8 @@ static int __init dio_init(void)
 
                 /* Found a board, allocate it an entry in the list */
 		dev = kzalloc(sizeof(struct dio_dev), GFP_KERNEL);
-		if (!dev){
-			if(scode >= DIOII_SCBASE)
+		if (!dev) {
+			if (scode >= DIOII_SCBASE)
 				iounmap(va);
 			return 0;
 		}
-- 
2.25.1

