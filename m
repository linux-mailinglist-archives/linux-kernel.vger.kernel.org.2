Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81CF833EC09
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 09:58:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbhCQI6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 04:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbhCQI5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 04:57:24 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B640C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 01:57:23 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id f22-20020a7bc8d60000b029010c024a1407so2929084wml.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 01:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=omHoCGEAHHfzGsCXWaSPZZFL53Kydw/eMLAhlkpH1KI=;
        b=G22gc9eNVnSkGmoUYNFy4wacYM1Maa4UM98OSYfR32gD/HkmzQQWbgY4P4UFvjX9q5
         1/K4tKYkgq+Tyz3T4Y8Mgze3tuG2JcwIvk9CWMjQuhvsY23GVjfNmJ0aem8lw+qe5UN7
         FPVmfjzgOicF0uFBQf6QL3Vj1K77BtaL/xksuNliBeu5VB6q6r30sr+Bkh6BrsKtV71N
         UnXMXD6kbvh09KJOuR8zcUy4hvQu11++xqFYTYuhf4q1E4zbXFNqkxjwgVsmqzqHBz4Y
         BDz3TZqJ4293Xc0y6RflScVaLt9bBm9iP0S+qSk34h7Cz46M4A8WS6I3GSOT+Wlls5BQ
         vKXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=omHoCGEAHHfzGsCXWaSPZZFL53Kydw/eMLAhlkpH1KI=;
        b=O/KTGuEAXofGEtTIHsN8Je7a9HTvDM8Hyb7wOGE+ogjL30toFncNVSCBjiiIu1QvQd
         7rtomAMHtz1Z/eOEpchw4K7XJbjpjSFcdJaPWim1BjuDFZUACm2Rp750+V2ReY1VYbKQ
         d45pkzmaGTjQuYoNBJbZE+wfc2QDfqlIFT0S0GMqdwV2jm4W8laO9BwLs2xfzVWxk3Sr
         TaI7Bv470Oz6gHFC/LXTcZbF2ANVhoayISvfTKiNV0S3YwuDnp0hd8Cfsh5nlzqAsFd9
         0kfI66v56uU+vK54S/KqnfQycFIsPNDD8J9PsVelYJXUI5jFN3UeTgZvcwR2/5ug3VWW
         O2kQ==
X-Gm-Message-State: AOAM530qvBfRw6aoExQ/7xYPlXS4NUN9M40wrWTaVBLlmpWvpPKCseoD
        ikpeHLqd8bL2e99/kvPbJ6Qy3A==
X-Google-Smtp-Source: ABdhPJw8Ddp7YdzjeheW5smSSk4SsocDHz5sUQEXKz8atEvBpoI8V+wWuKLJ2mg9P8iILIz+DV1vuA==
X-Received: by 2002:a1c:3c8a:: with SMTP id j132mr683090wma.127.1615971442290;
        Wed, 17 Mar 2021 01:57:22 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id j123sm1807243wmb.1.2021.03.17.01.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 01:57:21 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Subject: [PATCH 17/18] scsi: isci: remote_device: Make local function isci_remote_device_wait_for_resume_from_abort() static
Date:   Wed, 17 Mar 2021 08:57:00 +0000
Message-Id: <20210317085701.2891231-18-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210317085701.2891231-1-lee.jones@linaro.org>
References: <20210317085701.2891231-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/isci/remote_device.c:1387:6: warning: no previous prototype for ‘isci_remote_device_wait_for_resume_from_abort’ [-Wmissing-prototypes]

Cc: Artur Paszkiewicz <artur.paszkiewicz@intel.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/isci/remote_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/isci/remote_device.c b/drivers/scsi/isci/remote_device.c
index c3f540b556895..b1276f7e49c89 100644
--- a/drivers/scsi/isci/remote_device.c
+++ b/drivers/scsi/isci/remote_device.c
@@ -1384,7 +1384,7 @@ static bool isci_remote_device_test_resume_done(
 	return done;
 }
 
-void isci_remote_device_wait_for_resume_from_abort(
+static void isci_remote_device_wait_for_resume_from_abort(
 	struct isci_host *ihost,
 	struct isci_remote_device *idev)
 {
-- 
2.27.0

