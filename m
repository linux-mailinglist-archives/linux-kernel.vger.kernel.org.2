Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5383726D1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 09:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbhEDHyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 03:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbhEDHyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 03:54:06 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530E1C061574
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 00:53:11 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id j28so9316004edy.9
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 00:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lf7JgZ3blTyvOrF1aLK26XvbgJBM+NI/3saP4VWsBSY=;
        b=QadQqO3Qik9eILpeT3YEoUPZ4UoN5k1eF3Sh91H6eVNWYJDOYVhxHREfQPkgj1xzrk
         BMw+gEHupyZUhKbSbKTKV2p8CtVQGnGCB1PTwX6IZiHd6GW/gQlTywhlzUk9NDRKcugi
         XHKSH21itkzKShheaymXR/ZrOA85gqGvGAATTapYWmZXecwqXdyQ6gwc9lsYIdpJg2Uu
         /UvsB8TQWUySMk+aEoIhJh1IijEZWRQPOUn7hZIJ9uMl/fHcJ8Y4mtEpCB/smXHgAq3p
         Wn6Gqoq/EcGc0uBcF2mpJXLHKHy4ABRmP0YJ5F2+oPl6RuHMm1ZrvO/LCNkQQal7fUYQ
         fdxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lf7JgZ3blTyvOrF1aLK26XvbgJBM+NI/3saP4VWsBSY=;
        b=S8tkL8kB0l8o6Jvqmk1IkW1URhWb9zDJsekGV/oyfmc2A4xVNolGj9Gfk7AV4IQIav
         o2hODp66N/IJ5ayvofFOnNVQkznZBUhlzU0VEgqcm3LJGvA8qleOygO8llRvK1gg1ozh
         2126SkrZ9KbtA2l2P94kW9cKxybEkpHPop5GeCZP1k7bxxdpat3WGy5uR4zyATGqExrY
         kwv5e3pEwOdMmEPDVYFOL7G9GY7U1mMGBDpmwX2dh1SLHzHYP2KLJZxO6BUtvsSLT/nJ
         3lT7FUsMVhhJ0/Ab4VhwvR/FWC1jfbN6BLfgzstv/4+FkmrG4fB21CZ5c/dmpXFyddK3
         qxTQ==
X-Gm-Message-State: AOAM532jUofK7UNL1pPOOwd8UkNkU+eL6l1JNRR3GDfKbvi3oDuqRuzf
        fSbbQML96FK1K44Xh9/woaYQLw==
X-Google-Smtp-Source: ABdhPJz1sIZSsRgxzLI1up98vgG/lL8YsRbeMX8JKKQMxMPqOP+wEW8D9AF34nGs7J/wBcPQgmnc7g==
X-Received: by 2002:a05:6402:b91:: with SMTP id cf17mr25123814edb.19.1620114790027;
        Tue, 04 May 2021 00:53:10 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id c12sm15177437edx.54.2021.05.04.00.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 00:53:09 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org, Alexandru Ardelean <aardelean@deviqon.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] iio: adc: mxs-lradc-adc: use iio_device_id() helper
Date:   Tue,  4 May 2021 10:53:04 +0300
Message-Id: <20210504075304.148516-1-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The @id field was moved in commit e58bb7a74dca ("iio: core: move @id from
struct iio_dev to struct iio_dev_opaque"), however this driver was omitted
by accident, because the name of the IIO device is 'iio'.

This was caught by the lkp bot.

Fixes: e58bb7a74dca ("iio: core: move @id from struct iio_dev to struct iio_dev_opaque")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---
 drivers/iio/adc/mxs-lradc-adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/mxs-lradc-adc.c b/drivers/iio/adc/mxs-lradc-adc.c
index 30e29f44ebd2..1d99170d3328 100644
--- a/drivers/iio/adc/mxs-lradc-adc.c
+++ b/drivers/iio/adc/mxs-lradc-adc.c
@@ -455,7 +455,7 @@ static int mxs_lradc_adc_trigger_init(struct iio_dev *iio)
 	struct mxs_lradc_adc *adc = iio_priv(iio);
 
 	trig = devm_iio_trigger_alloc(&iio->dev, "%s-dev%i", iio->name,
-				      iio->id);
+				      iio_device_id(iio));
 	if (!trig)
 		return -ENOMEM;
 
-- 
2.31.1

