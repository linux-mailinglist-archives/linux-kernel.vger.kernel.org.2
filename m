Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5281360A96
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 15:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233173AbhDONgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 09:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232642AbhDONgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 09:36:44 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C8EC061574;
        Thu, 15 Apr 2021 06:36:21 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id a1so27144135ljp.2;
        Thu, 15 Apr 2021 06:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gfe5DO858avJBDe2j2ZPzRr3cqcG+ZrZduMob5Xhk4c=;
        b=Am31RVOO3/icKOfa86Nrs2J+Ih9nXW4uiIeEWQ2JeEKmGiOeMDkROsLN0MV3uooxdd
         uyk30zVdCVDK/WW8QRkIYfMeJ5qanFBSssSFbKz7WfkL/9m4FJVz47lgxkUEY7SrOdNa
         ZTOHH5HpD6vc4MBuyDgPsn1RCI/GVJt7jvb4qvrC7j1vAOtEXb6A44xX9gajJLbPvlrR
         k04Qu46SXeMh1UqA6IW62/wWU4UUTBYHuIIKyAR+e3f9GX/ZE+f7iwwbyl5r8ZVTxxKy
         UmYBA6gK1NGD6j8JVwfSRSpyp2JOuL9aVmHz5aOw0lRAbF7dJ/ZeU/AcYRNnZ4n53Q1u
         bzjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gfe5DO858avJBDe2j2ZPzRr3cqcG+ZrZduMob5Xhk4c=;
        b=sQBiiBdsNayK8FBU7POSarmUY52fqVxpv/B5JNqzgUr0MCa1UEgn27I+8QEg+YvhKI
         RuE8cxO5A0AE1/kw8T5XodD/42W6RfnIqoX+juVlLtIh4KWv73YEOuPQmfJYHHpj+WcL
         ApiItLgopd0bDohKH86elLmPqe1kN8N0eUNCWys/WpOYZrAejN5Ro4K48uDgPzOj5TwT
         CFn4j4QEbH6815iEIm5jc35d7PdtPyXSl4VNqXj3OLRrn0FCK1MbOggj9aHANfLfO0Lm
         PCkf7uoze8x/U3+dAY58AKtr2iz7yFnefzLsOGRVRbtx2GGHy22fD3TBVrak2xQG71ux
         sT3Q==
X-Gm-Message-State: AOAM530vPmWloemTceAnoX8Lj8uPS1xAwNuNsGwvzFy0+mFB046d5xvx
        gz6fcv9ykl6p7WTjjgmkbyS8k/CU62U=
X-Google-Smtp-Source: ABdhPJyluCrjVMKeMQyDsaJpmyFRIeey5vakXu15z4CL5J3T1eDEAJdJUHOeBverXsFMFU2Velx8xA==
X-Received: by 2002:a2e:8987:: with SMTP id c7mr1855070lji.185.1618493780287;
        Thu, 15 Apr 2021 06:36:20 -0700 (PDT)
Received: from home.paul.comp (paulfertser.info. [2001:470:26:54b:226:9eff:fe70:80c2])
        by smtp.gmail.com with ESMTPSA id h26sm629377ljc.17.2021.04.15.06.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 06:36:19 -0700 (PDT)
Received: from home.paul.comp (home.paul.comp [IPv6:0:0:0:0:0:0:0:1])
        by home.paul.comp (8.15.2/8.15.2/Debian-14~deb10u1) with ESMTP id 13FDaGPl011220;
        Thu, 15 Apr 2021 16:36:17 +0300
Received: (from paul@localhost)
        by home.paul.comp (8.15.2/8.15.2/Submit) id 13FDaGeE011219;
        Thu, 15 Apr 2021 16:36:16 +0300
From:   Paul Fertser <fercerpav@gmail.com>
To:     linux-hwmon@vger.kernel.org
Cc:     Paul Fertser <fercerpav@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Vadim Pasternak <vadimp@mellanox.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: pmbus: pxe1610: don't bail out when not all pages are active
Date:   Thu, 15 Apr 2021 16:34:56 +0300
Message-Id: <20210415133535.11171-1-fercerpav@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Certain VRs might be configured to use only the first output channel and
so the mode for the second will be 0. Handle this gracefully.

Fixes: b9fa0a3acfd8 ("hwmon: (pmbus/core) Add support for vid mode detection per page bases")
Signed-off-by: Paul Fertser <fercerpav@gmail.com>
---
 drivers/hwmon/pmbus/pxe1610.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/pmbus/pxe1610.c b/drivers/hwmon/pmbus/pxe1610.c
index 517584cff3de..ff6f6e05923b 100644
--- a/drivers/hwmon/pmbus/pxe1610.c
+++ b/drivers/hwmon/pmbus/pxe1610.c
@@ -41,7 +41,16 @@ static int pxe1610_identify(struct i2c_client *client,
 				info->vrm_version[i] = vr13;
 				break;
 			default:
-				return -ENODEV;
+				/*
+				 * If prior pages are available limit operation
+				 * to them
+				 */
+				if (i != 0) {
+					info->pages = i;
+					return 0;
+				} else {
+					return -ENODEV;
+				}
 			}
 		}
 	}
-- 
2.17.1

