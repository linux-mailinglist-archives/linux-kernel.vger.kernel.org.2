Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD7032BB70
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 22:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234326AbhCCM2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 07:28:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379975AbhCCHSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 02:18:10 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD88C061788
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 23:17:30 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id i14so3583865pjz.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 23:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OdXxfZmQvvMlVkpXe4/VBS+7KAt8VKvcktbPkcCmQBE=;
        b=AmLnpKUvZrMJzLctPvB1tuvcCMxhwJpGV71a+oeOtqj5220HM1pqnlCcyypJ99F55R
         Zx1lvmuFjHRFhkH50yCdEXm7Rc6QrY3yI9VB1ZAkNcXii6kO8vUK/Bo+XqeSmYxwTy4g
         8x/yJcVilra4QKa1jw8qggX5fjzQxv9ab2YQJWLhf2hZQrzLLu4Ejqx7ke7DHACPebyy
         kq1elVQuJm6w1KiLJtidt4EIjeL7e1VPHMHTiHmF4bs1PqGGuT6YT5q9u6rCgM+wcXVt
         YRYNXHtTXUFMxD2liJFo5z6EjUVy/YY3DqhRlliRL1AmsF+MlgeP4YCYNWM1EOfb4Z/5
         Z3fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OdXxfZmQvvMlVkpXe4/VBS+7KAt8VKvcktbPkcCmQBE=;
        b=AngIjlatdtPwqgLZLpZpfVFL5gOBew2dnAZ7/OdnN3lQdLqH92NcJob5szM2sAsCEh
         nLXP6h/3SalBO5beFmmOxZdDbSvSRzwp3JUzxjByjMNcraiBAd5IG/jfBQs1m5yVCqsU
         bm0nP6vEAJwE0NLTL1v/y1k4nCItP4YNsmblvCPqdfwHBNXpP2zex1cSR1nZV0B/yn4P
         siiObkqQtZ1aE2agLRNNeeG1ntFM652/k+0stOXKguCrcfgjQZw+Pq6NsnSC+tf6ORo7
         lYCloCFFdkgnFetGKKhjTeLi4RIuVHhXhmfMcCNhPRQA4JSrPslVzrv4Dg3pRvowEDD/
         4Xcw==
X-Gm-Message-State: AOAM532cucTPu6w7Dh5nD51v83fv2PCPDBJGeJp9TfhPNAri74kAGz28
        Mi4nrOJcqFGzueJbWN74E6I=
X-Google-Smtp-Source: ABdhPJwgBMpUhf/fS7fPzMCS8Jgtlx+fhnkUa7UndkqxdbUVKOdT+/dSDg3vY3v/OjeAPlqatk5Euw==
X-Received: by 2002:a17:90a:68cf:: with SMTP id q15mr1331881pjj.231.1614755849843;
        Tue, 02 Mar 2021 23:17:29 -0800 (PST)
Received: from localhost.localdomain ([178.236.46.205])
        by smtp.gmail.com with ESMTPSA id k11sm21951302pfc.22.2021.03.02.23.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 23:17:29 -0800 (PST)
From:   menglong8.dong@gmail.com
X-Google-Original-From: zhang.yunkai@zte.com.cn
To:     linux@armlinux.org.uk
Cc:     akpm@linux-foundation.org, rppt@kernel.org,
        zhang.yunkai@zte.com.cn, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] module: remove duplicate include in arch/arm/mach-sa1100/hackkit.c
Date:   Tue,  2 Mar 2021 23:17:21 -0800
Message-Id: <20210303071721.177968-1-zhang.yunkai@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Yunkai <zhang.yunkai@zte.com.cn>

'linux/tty.h' included in 'arch/arm/mach-sa1100/hackkit.c' is duplicated.

Signed-off-by: Zhang Yunkai <zhang.yunkai@zte.com.cn>
---
 arch/arm/mach-sa1100/hackkit.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-sa1100/hackkit.c b/arch/arm/mach-sa1100/hackkit.c
index 3085f1c2e586..3fe34ee7c0ab 100644
--- a/arch/arm/mach-sa1100/hackkit.c
+++ b/arch/arm/mach-sa1100/hackkit.c
@@ -18,7 +18,6 @@
 #include <linux/serial_core.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
-#include <linux/tty.h>
 #include <linux/gpio.h>
 #include <linux/leds.h>
 #include <linux/platform_device.h>
-- 
2.25.1

