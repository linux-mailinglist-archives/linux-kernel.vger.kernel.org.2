Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EEAA31AFDF
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Feb 2021 10:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbhBNJlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Feb 2021 04:41:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbhBNJlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Feb 2021 04:41:16 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC217C061574;
        Sun, 14 Feb 2021 01:40:35 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id r2so2084055plr.10;
        Sun, 14 Feb 2021 01:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xwgG9p72mhZkKtVpILBhmkVsNqvMEwMYTp1+ce8LMzo=;
        b=tBmM/Fb+denP7OnDpuLoU+JLl74SYfkL5Ztv8iJjcwm0QsdVSv/eVNVBUhw3e7139Y
         w2QDJxwebHHRnbFNrbQ319oADkEYUvhkwCaJ9K87bfrAzSLEQGJYWm7Yy/1NJ7Is/wZH
         xC0bUC0zCfgfq9E49q0dJnnwsTMWVf9h6F/WpcOqsUItdfM6HX63oBw8ky/WFvdQTvTA
         nn3eabRNtDj51rsou5kjhfDNMVLqrc/Uk23OnIp15L2Nbb2Ckt4IkVI+GiJbsymB3J5Y
         sskgWqGrn/3l9G8tCH/hlF2I+5Kd6KnWotpeeLmbZXsZ6I7KUiRRAg+qpu9bLqEXKkV5
         peiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xwgG9p72mhZkKtVpILBhmkVsNqvMEwMYTp1+ce8LMzo=;
        b=d/b9ZXvhB//2zQ9OtSKp1nZ+kjy8afdQt6dUntXjnzKIhzL/tohInC0nxcT+utKr9X
         d/t374Frqk829MzpsWcIqWPP6WW6IL5QKNGf1UHqkNv1kNrMU1HCVqmGtDvRYLpPotRv
         IDdch160830Y8fNLMDc0L2gjnKXNlB6nbtW6pnFM3eoJM4dFK6O1pJ8a1dLkbKRNtkQt
         Tm3KYAmGANGdd08xo2Iw4pYJtvrUpqJ5RF0sJFXuaj5D6OM1QX7JXQAEuMToAKw7zxXQ
         aJs8wi+2xh0xcQDN/tJA4q0/ynE7IKFROMh9jGS27gcSd/bn9yOHboJTlq7Q+5KaWrRj
         mZkg==
X-Gm-Message-State: AOAM532m+FtpQOyM7TJgTX+e7kAzeKoPGzRvx2YSB+blDE+QLzYG7icM
        lJAxuJeRBOyrplPjfdyRFJ5ZpskwPkOxv3Ro
X-Google-Smtp-Source: ABdhPJyBfvxe7ifmlbzcuDcua1NYIW0El6CPDIO/Q4BGxR5VyKqd3b8Ian14igy1RHdKt2zfZtJF2Q==
X-Received: by 2002:a17:90a:4e43:: with SMTP id t3mr5281732pjl.126.1613295634979;
        Sun, 14 Feb 2021 01:40:34 -0800 (PST)
Received: from localhost.localdomain (125-230-72-42.dynamic-ip.hinet.net. [125.230.72.42])
        by smtp.gmail.com with ESMTPSA id n15sm12724021pfd.143.2021.02.14.01.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Feb 2021 01:40:34 -0800 (PST)
From:   AristoChen <jj251510319013@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     balbi@kernel.org, linux-usb@vger.kernel.org,
        AristoChen <jj251510319013@gmail.com>
Subject: [PATCH] Fix typo in f_printer.c
Date:   Sun, 14 Feb 2021 17:40:25 +0800
Message-Id: <20210214094025.7380-1-jj251510319013@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In line 824, it is trying to open `out_ep`, so
I believe in line 826, it should print `out_ep`
instead of `in_ep`

Signed-off-by: AristoChen <jj251510319013@gmail.com>
---
 drivers/usb/gadget/function/f_printer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/f_printer.c b/drivers/usb/gadget/function/f_printer.c
index 2f1eb2e81d30..a3b17ec00bf0 100644
--- a/drivers/usb/gadget/function/f_printer.c
+++ b/drivers/usb/gadget/function/f_printer.c
@@ -823,7 +823,7 @@ set_printer_interface(struct printer_dev *dev)
 
 	result = usb_ep_enable(dev->out_ep);
 	if (result != 0) {
-		DBG(dev, "enable %s --> %d\n", dev->in_ep->name, result);
+		DBG(dev, "enable %s --> %d\n", dev->out_ep->name, result);
 		goto done;
 	}
 
-- 
2.25.1

