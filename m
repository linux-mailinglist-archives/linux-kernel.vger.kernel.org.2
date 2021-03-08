Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F751330682
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 04:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbhCHDpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 22:45:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233957AbhCHDox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 22:44:53 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8C8C06174A
        for <linux-kernel@vger.kernel.org>; Sun,  7 Mar 2021 19:44:53 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id n9so4609659pgi.7
        for <linux-kernel@vger.kernel.org>; Sun, 07 Mar 2021 19:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=YX0/RvzShai54+m5e8gpa/XV7NCeU+beFMIjwOYIdPk=;
        b=AmnygrS9u5m2MqHnyc1e1uqPPp2ggexPHVnMPApIVY/c72+aex6WWtTenZV/DIlK/u
         J/FHl8Vpgq2RRvA4w/WjfkZg8tVhmCAhna09IP7GzngaSlkpV3htsth2QrkRV+Daug4z
         VjE+yVLA7+EeXy51jqjwgFfth/3e9TGM3CcR2+Z72Ap7cibEWkIWVtV0SFBbL4A3ZQ66
         /0OOiGMBVPa9CpVkwCQHKPBWX61EvQcYaQId1+WdMD0EQQJghLEFOpN2E9DHkqdBx0PF
         Z6/TJMBzwlBWC3iyJe3C8NT/GtqCURo7J8ax/8qmgCvtI43/BnQ+xdkpi9LlO6cAvBX+
         I3Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YX0/RvzShai54+m5e8gpa/XV7NCeU+beFMIjwOYIdPk=;
        b=OQwBNlI7jz/wLWGgq04hh8q9beDefkQGEv31SrntsYk3egSR5qYZ2eZYJyJErycvBA
         V05Cly6Ci3U9iIXf2Icc7feDE3hMjlyRxiaHKDyShkI4CthJkmhHtEeiuvKTJxKaFKnT
         wxYqEL79jJeI/l6pPzdR13XS8Bms2GlaHjWAs+qiiBDaHYK/sJPUQBkdk1/xFQJqoxXI
         xV37MhFohzIy89IdgoTZ/iIumvNVuZtWHzP+ud2/wl+RuMf49uuOCP1zZZNEl/LI8N+X
         +nkcC0Qw4zgfkFtwbyk3b/cCzihiLS4ek+d9hOonPgrj5NRUwE+Ts71sjLH2clZmQwGh
         OhXg==
X-Gm-Message-State: AOAM531IBVSJ97lCejeFTnrQne9Z/U/7f7DhQSJshGEDnjcoFO6fb2cs
        8YIYOGeVDFXietM10E0jSkMgPRhoh4PNZvg6
X-Google-Smtp-Source: ABdhPJwVD4Bjl8EINQJF4uJSsLs+sl1XRJxE604ZyR8rAVnWTYhd079SSnJgXdIHw/fuDKs354RDkQ==
X-Received: by 2002:aa7:96ab:0:b029:1f6:2d3:3c91 with SMTP id g11-20020aa796ab0000b02901f602d33c91mr3669962pfk.10.1615175093269;
        Sun, 07 Mar 2021 19:44:53 -0800 (PST)
Received: from localhost.localdomain ([45.135.186.99])
        by smtp.gmail.com with ESMTPSA id i22sm9077748pjz.56.2021.03.07.19.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Mar 2021 19:44:52 -0800 (PST)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        chris.packham@alliedtelesis.co.nz,
        Sergey.Semin@baikalelectronics.ru
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] mtd: maps: fix error return code of physmap_flash_remove()
Date:   Sun,  7 Mar 2021 19:44:46 -0800
Message-Id: <20210308034446.3052-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When platform_get_drvdata() returns NULL to info, no error return code
of physmap_flash_remove() is assigned.
To fix this bug, err is assigned with -EINVAL in this case

Fixes: 73566edf9b91 ("[MTD] Convert physmap to platform driver")
Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/mtd/maps/physmap-core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/maps/physmap-core.c b/drivers/mtd/maps/physmap-core.c
index 001ed5deb622..4f63b8430c71 100644
--- a/drivers/mtd/maps/physmap-core.c
+++ b/drivers/mtd/maps/physmap-core.c
@@ -69,8 +69,10 @@ static int physmap_flash_remove(struct platform_device *dev)
 	int i, err = 0;
 
 	info = platform_get_drvdata(dev);
-	if (!info)
+	if (!info) {
+		err = -EINVAL;
 		goto out;
+	}
 
 	if (info->cmtd) {
 		err = mtd_device_unregister(info->cmtd);
-- 
2.17.1

