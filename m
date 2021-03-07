Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6845832FFB7
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Mar 2021 09:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbhCGIqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 03:46:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbhCGIqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 03:46:02 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ECB2C06174A;
        Sun,  7 Mar 2021 00:46:01 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id n9so3442760pgi.7;
        Sun, 07 Mar 2021 00:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=5WA49KtxVGIwb3eXl30IXZXGXZZpFGkYnUXeh5u+VtU=;
        b=aWiLJlkjxnleVeMFtvMkgAXx2zUKIFqlSjY1TwJg4mO5qbAjrOAvc1czyJClBLuuf3
         AeNlgPckkjPMSV9A3qmz34xLL36dCb5bPr+xTDwFzUhcDxWljouT6PvseM21pQSkXg3P
         OmZrIfbnmfWpUJCRgvqDcIWKvXdEekOHKtApnv6UQYOLqDxgCMaZ9xU8PDNTpvwwuU11
         j9FM0CJvFhaGVfm79ECh2j0izT+xTho31HvlWrQ3m2Y2e9AgejRH7fsR06CGvWS5vkHX
         IphfomPR8aUXX+Du3rx733L0xihAvGdH9Ntdr6UHX+E6K9O+C8VvdqEiDYoSWTxqnvoH
         X8KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5WA49KtxVGIwb3eXl30IXZXGXZZpFGkYnUXeh5u+VtU=;
        b=D/C7SJCll589w3o9iFkqlnGr8yn+RF91euDde2isCtZrsd6zj992BVrgguNx2e7830
         Px8W9coJbvakbGJl1wAR7JmumV6l4GJ0dGh52fxreIJAhRKp1w3FbTdki3ezKhfnqhbK
         PqFgLLylQCqm7CJqMxrWUCVGcV4Qtvi8kAcEh9VWQ9vmdeDIPSTVTC6TITi1kI5icATG
         aj5OGtDiKkJRK8yggm2Ck9JYFWXriIkdC3zwwQtnGyfH69j87Kc9MrOvz80QENYANQGE
         XJwzMags7520rDIRu8jXV3BSn24QXXFAaCJq+hCShk469NXyTdE5X5ZGvtCmVsvSv15P
         jmKQ==
X-Gm-Message-State: AOAM531Ui5QQV32WXi8QYA+aOH/fTLTMjxzFeyGQJ5I2ShfaFJc6p9ma
        f2Uidpbvg7cLX3lBD3397Os=
X-Google-Smtp-Source: ABdhPJyFoU3MiXvA1tg9N+JsbyMlILpSCbuV3z9P/FIUle6W3ZI8eUa7RSvCiV1FDM+M0pUsigc0tA==
X-Received: by 2002:a63:580d:: with SMTP id m13mr15877206pgb.342.1615106761161;
        Sun, 07 Mar 2021 00:46:01 -0800 (PST)
Received: from localhost.localdomain ([45.135.186.66])
        by smtp.gmail.com with ESMTPSA id h6sm7208395pfb.157.2021.03.07.00.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Mar 2021 00:46:00 -0800 (PST)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     balbi@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] usb: gadget: legacy: fix error return code of multi_bind()
Date:   Sun,  7 Mar 2021 00:45:45 -0800
Message-Id: <20210307084545.21775-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When usb_otg_descriptor_alloc() returns NULL to usb_desc, no error
return code of multi_bind() is assigned.
To fix this bug, status is assigned with -ENOMEM in this case.

Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/usb/gadget/legacy/multi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/legacy/multi.c b/drivers/usb/gadget/legacy/multi.c
index ec9749845660..7734bf77b309 100644
--- a/drivers/usb/gadget/legacy/multi.c
+++ b/drivers/usb/gadget/legacy/multi.c
@@ -399,8 +399,10 @@ static int __ref multi_bind(struct usb_composite_dev *cdev)
 		struct usb_descriptor_header *usb_desc;
 
 		usb_desc = usb_otg_descriptor_alloc(gadget);
-		if (!usb_desc)
+		if (!usb_desc) {
+			status = -ENOMEM;
 			goto fail_string_ids;
+		}
 		usb_otg_descriptor_init(gadget, usb_desc);
 		otg_desc[0] = usb_desc;
 		otg_desc[1] = NULL;
-- 
2.17.1

