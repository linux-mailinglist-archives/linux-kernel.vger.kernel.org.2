Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5831933EC01
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 09:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbhCQI56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 04:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbhCQI5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 04:57:22 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85ED9C0613D8
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 01:57:21 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id z2so954933wrl.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 01:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uknjZgyKbyTHbovaIRwNwS9vIyXMZbr0zBj7lwglxO0=;
        b=jyM5AtVqD1gbwSyCgL+XC69BhPp58i7rui/GQduzTndKglMY0QDRJiMINMn9pqzRI9
         FacVRjketCFrOI9jkEpRwxco361TWUUJqNwJcZubfxro7ILh1mYgKldo0fvHDRPub1Z4
         MMdFipRIYAGSSeixDl1jFrYrvXr90kreByWKhCz6T8h6lrvRmu3BF129zP/QUEMXWWC8
         XM7pQWLyopi7Q5zrQaXQULTS9EBinMxlMAT9M1aimg8J7N0/GB33WAIK98KjRQIK7nIy
         mvv2pBjDOiculG/h4lyTapmXYGS2ihH5AbBRQzJsXfo2OZnD/1/AJmEGFhsbwmqzfUmv
         k82Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uknjZgyKbyTHbovaIRwNwS9vIyXMZbr0zBj7lwglxO0=;
        b=SzTM4M9saIbphapO7qbZQbbAFSvKAuaXhNaZsdsAWzytvn2+gRurTdGKBHhor5j81o
         UyeQhpypz8zrBS7MpPXhvY4uUW9zIVUQKRpVF3ZuhcJXv/whyNm0Xjb3HrnCpxPNzZ+6
         o8p7wh26hcjJWc5zCTDEvVB5hLGHXBEaIoDQTiuA8YYggtRbKPD0amvwHFwmx84m1nO0
         dGEy+mmVwZg4HP/ipceydSdb0UM1gVSSIirP0u6Ih+F8izrdjwUXqQvunTNH4q70YLLH
         R6iXw30QmYIL/HzbzLpO0Iz+pGqdQPspy9e/MFoZdq4Wvfo+StHAw7j6p+1Uf98ZBXFZ
         L/TA==
X-Gm-Message-State: AOAM5332of5DMgN0oc0AwL7l8VQmvJrn+xYRvQYfscyFdB2GV5TYKTVC
        mNodOJqZmaf9KpbB0o9gAmJXHQ==
X-Google-Smtp-Source: ABdhPJx+GlNNh0KH6vMpIl5u5vhs56iee2KFJdoue8jlx2OnR2y+cQgqHzC+YWhg2AlgZ3S8cr5uPg==
X-Received: by 2002:adf:e441:: with SMTP id t1mr3251524wrm.21.1615971440343;
        Wed, 17 Mar 2021 01:57:20 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id j123sm1807243wmb.1.2021.03.17.01.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 01:57:19 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Richard Hirst <richard@sleepie.demon.co.uk>,
        c by <James.Bottomley@SteelEye.com>, linux-scsi@vger.kernel.org
Subject: [PATCH 15/18] scsi: sim710: Remove unused variable 'err' from sim710_init()
Date:   Wed, 17 Mar 2021 08:56:58 +0000
Message-Id: <20210317085701.2891231-16-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210317085701.2891231-1-lee.jones@linaro.org>
References: <20210317085701.2891231-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Take the opportunity to rework the comment a little.

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/sim710.c: In function ‘sim710_init’:
 drivers/scsi/sim710.c:216:6: warning: variable ‘err’ set but not used [-Wunused-but-set-variable]

Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Richard Hirst <richard@sleepie.demon.co.uk>
Cc: c by <James.Bottomley@SteelEye.com>
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/sim710.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/sim710.c b/drivers/scsi/sim710.c
index 22302612e032b..e519df68d603d 100644
--- a/drivers/scsi/sim710.c
+++ b/drivers/scsi/sim710.c
@@ -213,21 +213,19 @@ static struct eisa_driver sim710_eisa_driver = {
 
 static int __init sim710_init(void)
 {
-	int err = -ENODEV;
-
 #ifdef MODULE
 	if (sim710)
 		param_setup(sim710);
 #endif
 
 #ifdef CONFIG_EISA
-	err = eisa_driver_register(&sim710_eisa_driver);
+	/*
+	 * FIXME: We'd really like to return -ENODEV if no devices have actually
+	 * been found.  However eisa_driver_register() only reports problems
+	 * with kobject_register() so simply return success for now.
+	 */
+	eisa_driver_register(&sim710_eisa_driver);
 #endif
-	/* FIXME: what we'd really like to return here is -ENODEV if
-	 * no devices have actually been found.  Instead, the err
-	 * above actually only reports problems with kobject_register,
-	 * so for the moment return success */
-
 	return 0;
 }
 
-- 
2.27.0

