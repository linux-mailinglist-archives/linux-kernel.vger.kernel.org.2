Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22C0332FA47
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 12:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbhCFLyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 06:54:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbhCFLyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 06:54:07 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B0AC06174A
        for <linux-kernel@vger.kernel.org>; Sat,  6 Mar 2021 03:54:06 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id kk2-20020a17090b4a02b02900c777aa746fso601448pjb.3
        for <linux-kernel@vger.kernel.org>; Sat, 06 Mar 2021 03:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T4KrM8Rxm09qxy5MO3z+DhuuVEgcKUDRHk+zVxCbGRc=;
        b=d5mE+pX4+FeYVqMwh4/1x5Z+ICL+91cIDNQl4N//Lak/lUizh+0ztStrucuG/7dXZ7
         OZvsSKQMz3J/BJy7U4OadJcNr3Qvbr0m/7gLAJLaj8fyj7kO8j+uWvMivgKlnryli2CZ
         hrH/805QkULuviS/du7lWNt9dXuhtum350jMGI5//QsttDcTnNMN5RfbQveYVh86Ex9H
         UH9mXQfI38KFjGrHllyj2gX8OkjnZiG319WtHxoScvqwjznnlpM1QSowQSGOJvIOfuYq
         NLWsut7Hou+qC5wXWio+Bten25vMe+gLv3VFwSUWBbbCDOgt1/i0pwpmgomNYMBQH4XX
         aOGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T4KrM8Rxm09qxy5MO3z+DhuuVEgcKUDRHk+zVxCbGRc=;
        b=rssQTm1pYI+w+aNtvHQo4UUcWTAf+aE4QTWh6NCNfcFFg3z5bbvnyTPwievqmR3qkn
         XN0gRaqLE9+09EA0UPgMIHgIT7shB/ojfXXibNxLqHLwF0Cw3KRzeSSRiqTleJi4iMio
         9I5HLlnc2hcyGSePaHNiehL7B6efi+jR7J/MJw//WlIO6sV1BVD8fCzd7H11Q2pTnElR
         hRpTwd/DziBLx5TXvbGEjSNasyvAjmJE9R3vEaURISceDZuuZZoex0jxGnN9Idug1LSE
         CuC8I2etZyAiMIG/p3tuAa9eh7+I77JK7dufR7yP+/xDf0IP3wym3aqLcni+E5XCgQ4j
         LtOw==
X-Gm-Message-State: AOAM531/Pqf5qFdIsHcpnQz1Ci09NGAI13ANCSHs5XxOv0DJEIClo26K
        TJPB7BvPO+C3w564eXvlrf9hzJpzc5E=
X-Google-Smtp-Source: ABdhPJwPj+cYtojwZq100iDg50jFOFz8xtm0a7ZM8MmSNb2Q+eOX1qikZ/1GwmEARx+SBl646xbxWw==
X-Received: by 2002:a17:90a:c096:: with SMTP id o22mr15314264pjs.119.1615031646414;
        Sat, 06 Mar 2021 03:54:06 -0800 (PST)
Received: from localhost.localdomain ([178.236.46.205])
        by smtp.gmail.com with ESMTPSA id 8sm5334771pjj.53.2021.03.06.03.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Mar 2021 03:54:05 -0800 (PST)
From:   menglong8.dong@gmail.com
X-Google-Original-From: zhang.yunkai@zte.com.cn
To:     kgugala@antmicro.com
Cc:     mholenko@antmicro.com, linux-kernel@vger.kernel.org,
        Zhang Yunkai <zhang.yunkai@zte.com.cn>
Subject: [PATCH] soc:litex: remove duplicate include in litex_soc_ctrl
Date:   Sat,  6 Mar 2021 03:54:00 -0800
Message-Id: <20210306115400.218229-1-zhang.yunkai@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Yunkai <zhang.yunkai@zte.com.cn>

'errno.h' included in 'litex_soc_ctrl.c' is duplicated.
It is also included in the 11th line.

Signed-off-by: Zhang Yunkai <zhang.yunkai@zte.com.cn>
---
 drivers/soc/litex/litex_soc_ctrl.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/soc/litex/litex_soc_ctrl.c b/drivers/soc/litex/litex_soc_ctrl.c
index 6268bfa7f0d6..c3e379a990f2 100644
--- a/drivers/soc/litex/litex_soc_ctrl.c
+++ b/drivers/soc/litex/litex_soc_ctrl.c
@@ -13,7 +13,6 @@
 #include <linux/platform_device.h>
 #include <linux/printk.h>
 #include <linux/module.h>
-#include <linux/errno.h>
 #include <linux/io.h>
 #include <linux/reboot.h>
 
-- 
2.25.1

