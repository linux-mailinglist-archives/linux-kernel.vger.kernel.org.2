Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B62D13F3A92
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 14:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234472AbhHUMSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 08:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234293AbhHUMSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 08:18:35 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C36C061575;
        Sat, 21 Aug 2021 05:17:55 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id p38so26617449lfa.0;
        Sat, 21 Aug 2021 05:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VTdzEtT4Wp458PIeJqhUe58FrWQCsObT9nOyzI0RjZM=;
        b=b007ORUE+CPfOXGvGatMhrF3Yn32uXZQBPrWaQcQZthtwLXuXXYt5A90tvuEJhkCT0
         f4MiXuVxlPi9tHyzDf3Uzzdt8qLRXBYh6u72goHEKDvLEFoCMYlsAVxOVp73zmuHVB3X
         zDi9ZpiIR2Rua7heV5sRC1PR0vy2bsAQ1n8DIPSBo1+q8hIZZeWoaLZLy10//f0EsqRV
         v5Mh/sXaeDM23SzAQLBERcxgXVFsoO5EdKXhUmbhBDvzBDfEHcziihyQDqs2dYrGRrN3
         RK2xzYI5A6Pfmxx/kE/qSoYgZTNWa0USR5cJ5iFwPwg1I9mHXCEYTrr1PBcizpxOeqLb
         KLCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VTdzEtT4Wp458PIeJqhUe58FrWQCsObT9nOyzI0RjZM=;
        b=OLB4zHnn5zcwrRLH+GxbXNcvqByqYCseg+ygPqRou5WMkB06uMbR6MmZdhRc65E5gF
         rJmk8TsN3jzpxhfKIhLTKJZhFYgIui7AvU1HipnrieQTWmGCME4ZZ2V55WtkOWcZQHEA
         upyzud36B1sgndUxTLz+KwDhAbokhIvzQOoOHlj+uxXMVOXx9pKHQ+k3BNGbmjsGAXKk
         XNJJHTvvZPzQMdovZcD4Gn/wxQPisyThi07/ULMKcjPziWKweY6YJRLYPXy3aWHScjXF
         Y6ABHjxEP+4ulxFtVa2tj/iCm53o4jtz3HEdChrql+BcgmCxlaO+10xFxVL6DdwvKyq1
         nveA==
X-Gm-Message-State: AOAM531dC6sx+DxKL165wYdcacTRzIv6lzlOFqj5P/8ZxVnXrfGxXXbX
        +tCurzW011Un0bP84iLYwyU=
X-Google-Smtp-Source: ABdhPJwk7DQZu0pX/YD2e8am2o/8aTO/+/0pG1RECbAYH/YritKX7u+4a3EXMNslLCSYh4wxyjRHvA==
X-Received: by 2002:a05:6512:110b:: with SMTP id l11mr18259203lfg.199.1629548273974;
        Sat, 21 Aug 2021 05:17:53 -0700 (PDT)
Received: from localhost.localdomain (h-62-63-208-27.A230.priv.bahnhof.se. [62.63.208.27])
        by smtp.googlemail.com with ESMTPSA id z11sm791481ljn.114.2021.08.21.05.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Aug 2021 05:17:53 -0700 (PDT)
From:   Niklas Lantau <niklaslantau@gmail.com>
To:     stern@rowland.harvard.edu
Cc:     linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
        linux-kernel@vger.kernel.org,
        Niklas Lantau <niklaslantau@gmail.com>
Subject: [PATCH] Usb: Storage: usb: Fixed coding style issue
Date:   Sat, 21 Aug 2021 14:16:30 +0200
Message-Id: <20210821121630.29318-1-niklaslantau@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed coding style issue. Removed not needed braces.

Signed-off-by: Niklas Lantau <niklaslantau@gmail.com>
---
 drivers/usb/storage/usb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/storage/usb.c b/drivers/usb/storage/usb.c
index 90aa9c12ffac..5f562bac14d0 100644
--- a/drivers/usb/storage/usb.c
+++ b/drivers/usb/storage/usb.c
@@ -926,9 +926,8 @@ static unsigned int usb_stor_sg_tablesize(struct usb_interface *intf)
 {
 	struct usb_device *usb_dev = interface_to_usbdev(intf);
 
-	if (usb_dev->bus->sg_tablesize) {
+	if (usb_dev->bus->sg_tablesize)
 		return usb_dev->bus->sg_tablesize;
-	}
 	return SG_ALL;
 }
 
-- 
2.33.0

