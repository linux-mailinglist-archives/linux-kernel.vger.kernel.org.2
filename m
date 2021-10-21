Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3900435B28
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 08:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbhJUGze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 02:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbhJUGzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 02:55:32 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978C0C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 23:53:16 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id t5-20020a17090a4e4500b001a0a284fcc2so2393881pjl.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 23:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jEvot2/U8Y2VEZAq8gnF0AaMmTOHKYNz01x2+c2DX9c=;
        b=dQsb6pM9kxaDmwJsssvX7XAJTR8vvfUW1PmKjqZTI16HFdYPKjtxsxg6cmeK86fRq0
         hWooY2R4ITtA/8Uo2cQv9Ebw/zxMnnDZayahBsbB5wuIjOyNKb2s2BAEc8eOB5U70KFA
         s7zju/GKtDaloRxvk3WEZEEwYAJzn2IJLv8bpOZ6gAJtQTcFbdh8UHimz6xK3HZ9C1Yh
         C3uqiE1GpK9Oz+6dLTJFc9wsUabwLGrjIDAtoRZsg354nXoY78v0i6B8bRKpBaqTl6ee
         c0z8utK3fNUgc8g399Zos0DPsjKeO2ZaMPWaq4kmibh/TJoXixGIH8Irbym5EHNamq+B
         NlMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jEvot2/U8Y2VEZAq8gnF0AaMmTOHKYNz01x2+c2DX9c=;
        b=R+vg6QtM3s9lEdmS5i96B5M3cHywtkTl/4bSeaGFZm/oTV1wLE9He2MJwekc4xIUw0
         QtV8evsaCZ0cqTxhsSfidT/PL3hlSJJsq88ncbSFiIrP6PG/qaRT+CaAEdBa3Ej6/PRt
         Z2FEbnHp57Lh+n98gL2kK/GvoNi4CgfyxIU1Ze6UNy0y/lspdwOFOFQcG3LLnY3zY7Nl
         3kaWu26KFTins0ojsJGfMyt8cOD4E+tRoZH7jjyya6PTwn5gjOyDbBNJ8pCwnsUG48Yc
         V1gT46FA5LCt5+rxtu2+C2dlb6XDDpnNlnOCTmjP8e+ONJffxxp27DITcs+B21v2gcVP
         hRdQ==
X-Gm-Message-State: AOAM532buJB4vF3NBBFehzNCzfobddpQh9pC6nzmLqqbGOm50MM3cc+S
        65gJ0WPvqmcFSUaLBhlb6Es=
X-Google-Smtp-Source: ABdhPJxC6/m/NiS1do8LxMbLZEX7+VP4Cjg79drP4QDYLUsqbvPMt8Ku2Oqv5B5Efk9X/Bwxx2AVMw==
X-Received: by 2002:a17:90a:e547:: with SMTP id ei7mr4618602pjb.169.1634799196238;
        Wed, 20 Oct 2021 23:53:16 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id u4sm4826428pfh.147.2021.10.20.23.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 23:53:16 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.guojin@zte.com.cn
To:     stuyoder@gmail.com
Cc:     laurentiu.tudor@nxp.com, linux-kernel@vger.kernel.org,
        Ye Guojin <ye.guojin@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] bus: fsl-mc: fixup coccinelle warnings
Date:   Thu, 21 Oct 2021 06:53:09 +0000
Message-Id: <20211021065309.1048043-1-ye.guojin@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ye Guojin <ye.guojin@zte.com.cn>

coccicheck complains about the use of snprintf() in sysfs show
functions:
WARNING  use scnprintf or sprintf

Use sysfs_emit instead of scnprintf or sprintf makes more sense.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Ye Guojin <ye.guojin@zte.com.cn>
---
 drivers/bus/fsl-mc/fsl-mc-bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 8fd4a356a86e..e82bcdad2eb7 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -200,7 +200,7 @@ static ssize_t driver_override_show(struct device *dev,
 {
 	struct fsl_mc_device *mc_dev = to_fsl_mc_device(dev);
 
-	return snprintf(buf, PAGE_SIZE, "%s\n", mc_dev->driver_override);
+	return sysfs_emit(buf, "%s\n", mc_dev->driver_override);
 }
 static DEVICE_ATTR_RW(driver_override);
 
-- 
2.25.1

