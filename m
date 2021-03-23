Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85462345EC6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 13:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbhCWM7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 08:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231506AbhCWM6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 08:58:32 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A675C061756
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 05:58:30 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id l4so26910994ejc.10
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 05:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1EvpZd2FnLxsx+lWGO7RiIZtf6USM4O3+dzW0c58O1o=;
        b=M/+P+XShenwQFFcw1zlMmN01Dk3fvZvLzKqkK5ekLivuhPCGf7y7oMksvlpWfGQRGZ
         ya2i1l2N/sIteOQgwkDPN7GU0ShefFpIym4+DrNcgRmZCXFSLCFd8szBZzGn4jQb+DHb
         vx94kBfDR2DA4Zca+1Ym4vDD/jKShdXjEseuCrZMlO8HXEpcY2RwmFiVogkJS7YBtFwB
         QAzBWmPqnhQWOUT4USj3XLXtE1g/tQudaAX1ZQPEhAEHnqHbd/iqKw+hB/zl5b+eGAz5
         yEb+YFAW+RQfOOGtLKmRaXC5iNJbftci1NuQTVI3MkEzGC5W2H7FhEPMmZ3DD6NEnoG9
         wVKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1EvpZd2FnLxsx+lWGO7RiIZtf6USM4O3+dzW0c58O1o=;
        b=hYWBjBsLmbrEhf604Y5GTQjIVjgiDJet1w7Taf3qHoZgkihH/Wqnd75W6Crjl796dJ
         lHYxXa3fWxNJ0Dw62Bz/LoA9Z82l1dzy/ayTVvMFZdGNISaJ7wI6YoL2WrJRHwSdjpzc
         yLcVKurXPtWBcKPEz2yTD1pPBPI4KfdRgbdRoxVU74Mm/zkmOVqRp9ZyjCYDm03HQqQd
         bmhjEe/ma6Q0HocTE/vYZV0q6PY09cniiDUmPOm2yexWeIZlK9cC6a8emB85ikPXZN9t
         6jEOH9rlLHbsOGF1aZcH9OypcAJdW3dl7bssvf58IIcc9hZo861pk6qzFXbxlIndkUbY
         dRig==
X-Gm-Message-State: AOAM533D6KspFdaxd6scsB75+j9M/eTEqkSTMb/wnkIY3dLZyedAkeCX
        sdWqtxHjoJxH/m86nJd3uz4=
X-Google-Smtp-Source: ABdhPJxRS+OmG/cVq/1NjtqzXYc1B4kQbHm7cxAjvlMsgBbNUXSQW87vE+0zfDN/VdLBTQYAs1Ppgw==
X-Received: by 2002:a17:907:971a:: with SMTP id jg26mr4917755ejc.317.1616504309328;
        Tue, 23 Mar 2021 05:58:29 -0700 (PDT)
Received: from agape ([151.57.211.10])
        by smtp.gmail.com with ESMTPSA id a2sm11090334ejy.108.2021.03.23.05.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 05:58:29 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, apw@canonical.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH v2 8/9] staging: rtl8723bs: remove unnecessary extern in os_dep/sdio_intf.c
Date:   Tue, 23 Mar 2021 13:56:35 +0100
Message-Id: <f3a7b2c00221aa09ed782fb30ce55936f443a12d.1616503354.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1616503354.git.fabioaiuto83@gmail.com>
References: <cover.1616503354.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unnecessary extern.

The function is defined static in os_dep/os_intfs.c and used only once
in the same file

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/sdio_intf.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
index 185919b6963f..156ad91d33ee 100644
--- a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
+++ b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
@@ -482,8 +482,6 @@ static void rtw_dev_remove(struct sdio_func *func)
 	RT_TRACE(_module_hci_intfs_c_, _drv_notice_, ("-rtw_dev_remove\n"));
 }
 
-extern int pm_netdev_open(struct net_device *pnetdev, u8 bnormal);
-
 static int rtw_sdio_suspend(struct device *dev)
 {
 	struct sdio_func *func = dev_to_sdio_func(dev);
-- 
2.20.1

