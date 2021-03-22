Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55B0A3436AE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 03:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhCVCdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 22:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbhCVCdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 22:33:21 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A99C061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 19:33:20 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id q9so7983962qvm.6
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 19:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mc1N3GtZ1bTFeJ11aXl2/W65kfbaBX9thn6otmVgR90=;
        b=BgMjtwc054TbqFkhEF8nmK+g4+BTge2Md+mjcddUPsW1bCZ7smtPL5Vhh1Ya5FCEyG
         SrIdQOONSssBoTjcpmXWLiBwHG97qlKUFn1YeV4mABuA1CAPWbIrnCk2tepNCyFaN4h7
         25bKg/1FwigNN37HwubMehutew45kl/1lz2L6FXJ6kmBdudSsf9DxLrRCcGbyujzrf+2
         oXbsMxjjdD9PIHOGDhnxQi87vOZKD24z4dVMNC/TnkgYkf9RCbDAR3xpTiM0UT2Mluh9
         8ibxoQr9HiCgz3yqn6OBCMHmp5kIGA3eU7I7Y4Vy3A0uUkRDpW0W9JvD66gOSYreq5v6
         qkbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mc1N3GtZ1bTFeJ11aXl2/W65kfbaBX9thn6otmVgR90=;
        b=d9dJ/69bPTSROss0t+Nh9xeNOZRo0covUfJ9DBXH2/R8EgUSwozcsAxTQheIozXamK
         UUqe3U0eLF8jQQ4tlreZ/BB0qbEbYihdvarV2AnhPALy581hqm6oZjUnLFifBZwmxYCm
         9PTyarmhR+51wWo0CmVlFM3sDLiJjT107RV7vUasS7zVgQ2bYFSaQzvAGpSTe1GNnHkp
         sDlYKzrzTA7eGV/jMEQLCduc8zjNrwdpKAothbM8lHkf1QaeDbNXkJZpjwQERkgTuzkX
         RnV6avVfjrUcuVv48OhvJkTCXwtYuAr7dCAeppAueA/CAdRo9ptJBS6zkzOEn3cCVVjz
         f2CA==
X-Gm-Message-State: AOAM530ZHk+aCgoQ/PwWrhWaDbRGWIL5TT2bx9UE3gj6sbNToT7AqL+d
        h1JVgaygnnSHruCWHmBQ688=
X-Google-Smtp-Source: ABdhPJwnwqqrcZY6jMNWHf4bis+/45QG9/GksAxj3Ld3jKCRUquKvDERF4B71eVqw3wU5Sp/VtWiUQ==
X-Received: by 2002:a0c:c345:: with SMTP id j5mr8059007qvi.52.1616380399358;
        Sun, 21 Mar 2021 19:33:19 -0700 (PDT)
Received: from localhost.localdomain ([156.146.54.190])
        by smtp.gmail.com with ESMTPSA id 77sm10139906qko.48.2021.03.21.19.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 19:33:18 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     fbarrat@linux.ibm.com, ajd@linux.ibm.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] cxl: Fix couple of spellings
Date:   Mon, 22 Mar 2021 08:03:07 +0530
Message-Id: <20210322023307.168754-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/filesytem/filesystem/
s/symantics/semantics/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/misc/cxl/context.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/cxl/context.c b/drivers/misc/cxl/context.c
index fb2eff69e449..e627b4056623 100644
--- a/drivers/misc/cxl/context.c
+++ b/drivers/misc/cxl/context.c
@@ -52,7 +52,7 @@ int cxl_context_init(struct cxl_context *ctx, struct cxl_afu *afu, bool master)
 		 * can always access it when dereferenced from IDR. For the same
 		 * reason, the segment table is only destroyed after the context is
 		 * removed from the IDR.  Access to this in the IOCTL is protected by
-		 * Linux filesytem symantics (can't IOCTL until open is complete).
+		 * Linux filesystem semantics (can't IOCTL until open is complete).
 		 */
 		i = cxl_alloc_sst(ctx);
 		if (i)
--
2.31.0

