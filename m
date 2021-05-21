Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 171A038CE8B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 22:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbhEUUGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 16:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbhEUUGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 16:06:24 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E37FC061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 13:05:01 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id s1-20020a4ac1010000b02901cfd9170ce2so4841283oop.12
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 13:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Lzg66wuzASaMfTHwEiQwg/u8XktLpASuIJjQt1N/kuo=;
        b=FU7oXsN5JQzdq5+zP80ciK7QmQ2OmK8b5yQw+iS0awapeC953l4vgk7lLliC5boEZ3
         Ip3Qh0tGWljGWIvwxVCLUzPDvzSJqANt8vy0VRi7P4ocTh8EGgJcsaZtEoJgcAct8PAA
         DDQ99sBgV+90JPclFqmFF5Rj9mwu+EnEqsFrmwJlVmpIlyiqlycjVAoU9e0NEoa0evwA
         DMZkyZMTi2sOLYg4k3xd647o2GG7+UmRnEoA4y6TF63/LR8cdH4kB4JeOIDIAlr0jy+H
         zjeBTPITF8m29liEhvIxP0eMLxo+1yfFkLZGEnhQ/1e/otMHXjEjncETKapC+7UGqdWa
         Q93A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=Lzg66wuzASaMfTHwEiQwg/u8XktLpASuIJjQt1N/kuo=;
        b=DpJIMDuih+3/FVJ0Vrj3oqRjKo5krU5fYft9tjXMUIZ15BJpmwkC3qjF03Sb/f2uBu
         BSrbmDQRCkQkheX5Jc4oJfnhol8PuIvXYt6odMv+ZX9VzKJKhWHDLNzI5T+9rdHoI9Kn
         uiOZXZ0wf+n7D7elsx+/Hs4FzFpCFbR+ZxNc+1YNWe5mPd/wHDQ8zilQw9P2nyCX5HB/
         R+NhI7K7DS0WfDOLJAQDtHLBoCMVaPnWo0zcucTM4XA7P/o8DHv40h8+WW2VflOLpgll
         9TTLOsuaFTKr2pdxTEfbwqsMC4NlvDU8UWQ4L2HxuR9byEDFWrSAbDbUE+1k3Zw735lo
         je6Q==
X-Gm-Message-State: AOAM530D3UftddPtGrn2c5PT5SZoic+jHNaf4/7tVlDbmLp6NxmOGxog
        tYBtBBkGgX6n0U941C+9DIA=
X-Google-Smtp-Source: ABdhPJxl9/Nm+6svLD2w6ZD46nm3ERoRNVnBbWJYVzq32/FZkh6HNexRG5Hi7Xgoz3ASHBFoZefBmg==
X-Received: by 2002:a05:6820:54e:: with SMTP id n14mr9556416ooj.49.1621627500369;
        Fri, 21 May 2021 13:05:00 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d67sm1292501oia.56.2021.05.21.13.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 13:04:59 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Derek Kiernan <derek.kiernan@xilinx.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>
Subject: [PATCH] misc: xilinx-sdfec: Drop unnecessary NULL check after container_of
Date:   Fri, 21 May 2021 13:04:57 -0700
Message-Id: <20210521200457.2112041-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

container_of() only returns NULL if the passed pointer is NULL _and_ if
the embedded element is the first element of the structure. Even if that
is the case, testing against it is misleading and possibly dangerous
because the position of the embedded element may change. In this case,
the check is unnecessary since it is known that file->private_data is
never NULL for an open file, and container_of() will therefore also
never be NULL. Drop the check.

Acked-by: Dragan Cvetic <dragan.cvetic@xilinx.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
change since RFC:
	Dropped check for the result of container_of() result instead of
	checking if file->private_data is NULL.

 drivers/misc/xilinx_sdfec.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/misc/xilinx_sdfec.c b/drivers/misc/xilinx_sdfec.c
index 23c8448a9c3b..d6e3c650bd11 100644
--- a/drivers/misc/xilinx_sdfec.c
+++ b/drivers/misc/xilinx_sdfec.c
@@ -1013,9 +1013,6 @@ static __poll_t xsdfec_poll(struct file *file, poll_table *wait)
 
 	xsdfec = container_of(file->private_data, struct xsdfec_dev, miscdev);
 
-	if (!xsdfec)
-		return EPOLLNVAL | EPOLLHUP;
-
 	poll_wait(file, &xsdfec->waitq, wait);
 
 	/* XSDFEC ISR detected an error */
-- 
2.25.1

