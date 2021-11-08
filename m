Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBA7244792A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 05:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234987AbhKHEOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 23:14:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233833AbhKHEOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 23:14:17 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0101C061570
        for <linux-kernel@vger.kernel.org>; Sun,  7 Nov 2021 20:11:33 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id b13so14958126plg.2
        for <linux-kernel@vger.kernel.org>; Sun, 07 Nov 2021 20:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=+r5v0Qkb9CskeIUp24NWApH4et+2cF4LENwGR9mkgPI=;
        b=ksG9H0mH9ezpfVFJemUARGntpLmJtB5sxcqfrOAB/mZdHKhslGOm+2IuFcHiDsOECb
         EYJ+OKS+sZX/WgZpFpz25MEQ/2OIZJw7yeFTy+cDwhN7o3Tq/iEx0QYIeAtQH1D8IIOB
         IbbIsDVMOANo9VjiHIxLJe9XsstPt1CeZrirXXbygFhIEva4C+JNDVwfh0N6WlwnO4Pw
         pgsxH0RNYxGDn2mCwKAzBi6IZJAOl7fiAbN8vDxi9zuLe8ZhKPmVrnsrh1bmu+WP0lYc
         7VnB+IThKaCJJ/Goz4R0rlPd70PAF3UXzaxD/NsMFSJWLb28zPv6I/tNaLE1dz8KKpUP
         8YlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=+r5v0Qkb9CskeIUp24NWApH4et+2cF4LENwGR9mkgPI=;
        b=sccLzGzjDlYAsVRO233N2G0uhbL1ZhZwMyK961Uovmp/7SGpOLYlA51Vm0CV0lcWiH
         CjIZ1hIQldvsIsYwKhtDFHYB/a3nyqHheMh1TItOQKAgBExiNsALETyCqYQZZpCTPVrO
         KTZ+2GygCeVcE4mLd/EfFRegO+tlgdfiEZ02INNTaIjcuqKDHeV1th3Ydsejpt6xr6d7
         XGAQhsjX3szwXEZH0VWE3e5+d6Q9RkZQIBphPYlzjZ3N5kaUL+Xz7blWdXfpX3wcU+8u
         xQmjKrPGdxhS7RVdylSKjwS7pTHiju36jhjoGa8qcnkcIoG8V9pnWMRcZsiYA8sSnzkx
         zZ7A==
X-Gm-Message-State: AOAM531TXdDZBAGpCRQitzi2NozS+CLYnF6Ib21TH7pkYe5n4qln/dA6
        8KsnjEI5oqGG8wp6qD643rzhP34DpGWqMg==
X-Google-Smtp-Source: ABdhPJz53C1GxcDNgZIQ7AHrcxpnC9yV4l2D8vHmUQak4AX6drOI3HDoe3B/rpg3QyRbNSkIcxCXlA==
X-Received: by 2002:a17:90a:eb03:: with SMTP id j3mr48831736pjz.149.1636344693335;
        Sun, 07 Nov 2021 20:11:33 -0800 (PST)
Received: from Sauravs-MacBook-Air.local ([59.88.109.27])
        by smtp.gmail.com with ESMTPSA id k1sm5684400pfu.31.2021.11.07.20.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Nov 2021 20:11:32 -0800 (PST)
Date:   Mon, 8 Nov 2021 09:41:22 +0530
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     gregkh@linuxfoundation.org, kuba@kernel.org, lee.jones@linaro.org,
        saurav.girepunje@gmail.com, nathan@kernel.org, clrrm@isep.ipp.pt,
        johan@kernel.org, dinghao.liu@zju.edu.cn,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
Subject: [PATCH] staging: rtl8192u: remove the if condition without effect
Message-ID: <YYijapuGOmObwM3S@Sauravs-MacBook-Air.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function rtl8192_adapter_start priv->pFirmware->firmware_status
is assign to FW_STATUS_0_INIT just after assignment variable is
again get check for same value. Therefore if condition will be
always be true. So remove the if condition ,else if section and
else section which will never get execute.

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
---
 drivers/staging/rtl8192u/r8192U_core.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index 726d7ad9408b..f5d9e81f4ac7 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -2666,14 +2666,7 @@ static bool rtl8192_adapter_start(struct net_device *dev)
 	/* config CPUReset Register */
 	/* Firmware Reset or not? */
 	read_nic_dword(dev, CPU_GEN, &dwRegRead);
-	if (priv->pFirmware->firmware_status == FW_STATUS_0_INIT)
-		dwRegRead |= CPU_GEN_SYSTEM_RESET; /* do nothing here? */
-	else if (priv->pFirmware->firmware_status == FW_STATUS_5_READY)
-		dwRegRead |= CPU_GEN_FIRMWARE_RESET;
-	else
-		RT_TRACE(COMP_ERR,
-			 "ERROR in %s(): undefined firmware state(%d)\n",
-			 __func__,   priv->pFirmware->firmware_status);
+	dwRegRead |= CPU_GEN_SYSTEM_RESET; /* do nothing here? */

 	write_nic_dword(dev, CPU_GEN, dwRegRead);
 	/* config BB. */
--
2.33.0

