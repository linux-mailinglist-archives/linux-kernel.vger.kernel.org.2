Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26CB3345E53
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 13:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbhCWMio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 08:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbhCWMiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 08:38:24 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B7AC061574;
        Tue, 23 Mar 2021 05:38:23 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id v2so11550156pgk.11;
        Tue, 23 Mar 2021 05:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=1A1x6rnbVrqFAZgFlS5moMGgnUzPHz2Psn4t+8eo22E=;
        b=ToSaHNA3NTnHzdwfC4D2/IRpHgKy3G/Yea1Zg11GFtQg6hKD/XI753YfjflN4hRfQa
         +qsj+z53hdZ7PoGUrin1hxu9vZSJbcd/fJvR0Yc46Ztngo1ubYCZ4h5F7SEpFDbipUSV
         lNaoucTboXuCboxC+44nj878gKFQ456Cu5ptmtSuVx/g0LXuF4zuPp7Q16ZS8M/x4+XR
         wSeY9yYCnpInKtycZw1tPHGrSNrCKBFhM23e3XwYnFql/IjGkiNXYtfAMVZ+nRW8DPGP
         Q4+8h8fltRfC8oYLB65O64pL8E3EShpOJL5h2ilepdHJvAmXYDmvXGf51nzNAGFZ/A5R
         +9lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1A1x6rnbVrqFAZgFlS5moMGgnUzPHz2Psn4t+8eo22E=;
        b=ryUnA/PBQE32lQpNTJcmPTAq6FdaYvaIl7R4BgF0Mk27LJo1qUJ7WFDmeC0c9iNYKi
         59w8lcB5UTrOpsmjE/4s3ruv3/L7IoyfgzsRGb9mEjSFq1oLAkq1KsDlsKLiBQX0T33R
         8FKS4dJwj5BdmEvlE1bu56la/YSALnOLeL8nTpuPlj15e8tr9Ttq178UwDhUV8r4VQJy
         0Sg1uB1311UKd602efuR/iiAP4HFIio32DNt9dvrSvpweh6ppyF18Ak5MJh/2jLr8FYa
         qlXRZ4dxDj4jzZR0wokqJ4NlIFTZDHPk0Kh0NjOqDwo9olLYtgTQwOjbh+5e6LZpwAgK
         L/uQ==
X-Gm-Message-State: AOAM530KZ6sLt3fvqKMJ1OVKcNQhXJOo5inV04HYw/2563FVjsaiyVdW
        GIU5tT9p2pi1MVKRv+BxsMY=
X-Google-Smtp-Source: ABdhPJybH2X41CmpPj1jVAY5imx9xQTG0VEOCNZVnc6T6J6lFgYPian7xrOeFeU52lovwRpNIQ3Nmw==
X-Received: by 2002:a63:5c1e:: with SMTP id q30mr3734328pgb.259.1616503103539;
        Tue, 23 Mar 2021 05:38:23 -0700 (PDT)
Received: from localhost.localdomain ([45.135.186.113])
        by smtp.gmail.com with ESMTPSA id j35sm17087811pgj.45.2021.03.23.05.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 05:38:23 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     balbi@kernel.org, gregkh@linuxfoundation.org,
        weiyongjun1@huawei.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH v2] usb: gadget: legacy: fix error return code of msg_bind()
Date:   Tue, 23 Mar 2021 05:36:48 -0700
Message-Id: <20210323123648.3997-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When usb_otg_descriptor_alloc() returns NULL to usb_desc, no error
return code of msg_bind() is assigned.
To fix this bug, status is assigned with -ENOMEM in this case.

Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
v2:
* Fix a mistake in the report.
  Thank Greg for good advice.

---
 drivers/usb/gadget/legacy/mass_storage.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/legacy/mass_storage.c b/drivers/usb/gadget/legacy/mass_storage.c
index 9ed22c5fb7fe..ac1741126619 100644
--- a/drivers/usb/gadget/legacy/mass_storage.c
+++ b/drivers/usb/gadget/legacy/mass_storage.c
@@ -175,8 +175,10 @@ static int msg_bind(struct usb_composite_dev *cdev)
 		struct usb_descriptor_header *usb_desc;
 
 		usb_desc = usb_otg_descriptor_alloc(cdev->gadget);
-		if (!usb_desc)
+		if (!usb_desc) {
+			status = -ENOMEM;
 			goto fail_string_ids;
+		}
 		usb_otg_descriptor_init(cdev->gadget, usb_desc);
 		otg_desc[0] = usb_desc;
 		otg_desc[1] = NULL;
-- 
2.17.1

