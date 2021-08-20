Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE883F3437
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 21:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236704AbhHTTEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 15:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235726AbhHTTD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 15:03:59 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D76C061575;
        Fri, 20 Aug 2021 12:03:17 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id mq2-20020a17090b3802b0290178911d298bso7948327pjb.1;
        Fri, 20 Aug 2021 12:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=r1Ub2zCNnF2jD+YCi379UyQNacsyCmoabwxSuvI+j+U=;
        b=c5KqXjWfCyTrry1wW4RpaJG2UsqChpZxWbCw9ounHx++H9ebycNR+XxD3BAzfkpn/X
         GS/LJxyJu71ZL4GFKFLdsSIex26vUGaxbOcSfBAEAE4yUTWP/9t14MXASfzWhLTXD/D2
         75ZS6a+qlkQcMkPTbZENVQmLZkKg3Z1mYvTqaqpxp5BiuR4FRsO8X+D7MO1aAsY7/XX8
         UFzWTtGzG912FABhZPqqPDWIb8XjFa009DK8FiCb9iJ97328iv1WIGRIOtlbr0XuJDLF
         Lo07CIx4Zz6/fAEG5VxZ159+D8QU/aWQ8rwsBkPUaKv6AVxG9k85xN2qf45qvEPA2OBV
         tPow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=r1Ub2zCNnF2jD+YCi379UyQNacsyCmoabwxSuvI+j+U=;
        b=F9p2py7xNaaBDT5vC5KT9QRhQ6XEu36Q5T7PfN2O3ON1BFFRtPmjU91ov0K1CiN2f4
         Z8bq8JxM9976Xc41+yxFFPZHGEPIH4WqrRXzU3PER452CqJ+4CdlxtwRrNd7mXFayjAT
         poYv1yfuaKkazco1mZ+SUENwNhEHeqQB1hlPT1l/arjHia4jd9j+UVDJCfJ/z1LZN0Hk
         IOe5NpGtzdkrqxCwSJgs6X1h77/W2JMCt4MCssF9+b+kIaWV3SxTA2u9JZMlMgvX/F7b
         hWJSoC5Mqn98c4kGbyu0ioZh1MvFYuAxdY2oA39ySMu1VDHQE0tzE/fJCSoqgwsCWnjO
         +n6Q==
X-Gm-Message-State: AOAM5308jvX7IRr1kB6UAd81jj7z79Yd9RdUvS5lngYgzcwrYpIeDYdQ
        y2f1R8WgDu+yA049jpE2yrXMHuO+Ihq0fQ==
X-Google-Smtp-Source: ABdhPJye4QT9f6BVWVxgul8ktnATf9jvXt9k6tJbT2208r9l9Dcc6CWAHfh26RLKEppdROuyOErIbw==
X-Received: by 2002:a17:90b:f17:: with SMTP id br23mr5844696pjb.60.1629486196916;
        Fri, 20 Aug 2021 12:03:16 -0700 (PDT)
Received: from localhost.localdomain ([49.36.209.159])
        by smtp.googlemail.com with ESMTPSA id b10sm7821899pfi.122.2021.08.20.12.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 12:03:16 -0700 (PDT)
From:   Utkarsh Verma <utkarshverma294@gmail.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Utkarsh Verma <utkarshverma294@gmail.com>
Subject: [PATCH] USB: serial: iuu_phoenix: Replace symbolic permissions by octal permissions
Date:   Sat, 21 Aug 2021 00:33:06 +0530
Message-Id: <20210820190306.18149-1-utkarshverma294@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixed the below checkpatch issue:
WARNING: Symbolic permissions 'S_IRUGO | S_IWUSR' are not preferred.
Consider using octal permissions '0644'.

Signed-off-by: Utkarsh Verma <utkarshverma294@gmail.com>
Suggested-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 drivers/usb/serial/iuu_phoenix.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/serial/iuu_phoenix.c b/drivers/usb/serial/iuu_phoenix.c
index 19753611e7b0..0be3b5e1eaf3 100644
--- a/drivers/usb/serial/iuu_phoenix.c
+++ b/drivers/usb/serial/iuu_phoenix.c
@@ -1188,20 +1188,20 @@ MODULE_AUTHOR("Alain Degreffe eczema@ecze.com");
 MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE("GPL");
 
-module_param(xmas, bool, S_IRUGO | S_IWUSR);
+module_param(xmas, bool, 0644);
 MODULE_PARM_DESC(xmas, "Xmas colors enabled or not");
 
-module_param(boost, int, S_IRUGO | S_IWUSR);
+module_param(boost, int, 0644);
 MODULE_PARM_DESC(boost, "Card overclock boost (in percent 100-500)");
 
-module_param(clockmode, int, S_IRUGO | S_IWUSR);
+module_param(clockmode, int, 0644);
 MODULE_PARM_DESC(clockmode, "Card clock mode (1=3.579 MHz, 2=3.680 MHz, "
 		"3=6 Mhz)");
 
-module_param(cdmode, int, S_IRUGO | S_IWUSR);
+module_param(cdmode, int, 0644);
 MODULE_PARM_DESC(cdmode, "Card detect mode (0=none, 1=CD, 2=!CD, 3=DSR, "
 		 "4=!DSR, 5=CTS, 6=!CTS, 7=RING, 8=!RING)");
 
-module_param(vcc_default, int, S_IRUGO | S_IWUSR);
+module_param(vcc_default, int, 0644);
 MODULE_PARM_DESC(vcc_default, "Set default VCC (either 3 for 3.3V or 5 "
 		"for 5V). Default to 5.");
-- 
2.17.1

