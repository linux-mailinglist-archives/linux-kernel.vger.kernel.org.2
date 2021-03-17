Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B677D33EC53
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 10:12:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbhCQJMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 05:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbhCQJLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 05:11:34 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F497C061760
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 02:11:34 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id v4so987157wrp.13
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 02:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uknjZgyKbyTHbovaIRwNwS9vIyXMZbr0zBj7lwglxO0=;
        b=xFn8GvAUxi6WQSIWeNqixwpfKw+XBtKnS8kgljV6CdV2A2sdS7J9yWgXRgTFOKy09Y
         vETvO9WEHu1Zid6vcWuhSQBKIuIPNhbOlHXpm9EG5tw/oqKyGigGAlRvzX+rMIeq7Bbk
         qvKL84UQudO+SoX856yKs8+nAR8KeYl2AERaO8NnfJUezD3x/6yVOMXYoDmt/Vtcbec7
         4nD0n0mzZit+6NSh3Hn7C9t1Cf2qvx3mZMYf1ptDutayOnL5I+4rG/H9TacCu7SnQYwg
         R9NdzaY5S6rjzkBfwSjfWEkP0K5zv2WYnlpQB2hGnmV1wvoDMPJvXCgNjfeazitgEOWh
         bILQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uknjZgyKbyTHbovaIRwNwS9vIyXMZbr0zBj7lwglxO0=;
        b=pQ/Y4eshs7xth9Db4YnWEemasKSfkXgr6q0Xt9WbBHx9Jc6O6I05qKQSSpP45HoZl2
         7n9nhyfFX058qqmNIQ7Bof/W5UIhc/smRP1Hg8UWpha0zm9IjpmVwoEDdNYMMQhBaA8r
         eDJ8JrUIe/fK5WRBDnUtUz/ZxKz0dIKGos8uqOE4QFXDFr+IJ5u8U3dk3N20J5IssQjs
         CM07Ad7HSkIy4ZcOI9XNrhizgJLTaWp+SJaEdYcgNo2gn73y+Sn3lkprlxZEDILhJkda
         SCt74LaQE3RROOMYOcxa4+21Io+MQt6Djt2p3Lfdp6a+O2LCbZGuhmgGz1ZC/8ZIIL7k
         uSHw==
X-Gm-Message-State: AOAM530O4cRSmWdo3NS1BBKX8fhIns8er73ubBzgIRuCbCXPUjBlUw+m
        9tsfcLqdyfd5w67zaMYpaEvuBA==
X-Google-Smtp-Source: ABdhPJw6hfssnv5UFSts4luL840X801w+At+C+ThmbOOYK68pR/uhhHWMSTaztumqohAobiGDMdE7g==
X-Received: by 2002:adf:ec46:: with SMTP id w6mr3237005wrn.213.1615972293434;
        Wed, 17 Mar 2021 02:11:33 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id s83sm1709279wms.16.2021.03.17.02.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 02:11:33 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Richard Hirst <richard@sleepie.demon.co.uk>,
        c by <James.Bottomley@SteelEye.com>, linux-scsi@vger.kernel.org
Subject: [PATCH 5/8] scsi: sim710: Remove unused variable 'err' from sim710_init()
Date:   Wed, 17 Mar 2021 09:11:22 +0000
Message-Id: <20210317091125.2910058-6-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210317091125.2910058-1-lee.jones@linaro.org>
References: <20210317091125.2910058-1-lee.jones@linaro.org>
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

