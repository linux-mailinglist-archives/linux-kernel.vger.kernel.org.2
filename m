Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87AE238D3D5
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 07:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbhEVFgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 01:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbhEVFgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 01:36:02 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2350C061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 22:34:37 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id x18so12171342pfi.9
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 22:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TgOIq8VQUiDYqV2oMi59dexKwHlFeeaw85QP4XFGgRc=;
        b=MCY5AqSIip8PhtjxQZv7h/SHPr82k8l1oyfAhvjpAmCkLpBx46eyAn4KmwjXg2ZjCw
         OatljgGfJF+rpMIwlVnH0aMjkR1Q9+tRpUgWpnflDEzf8+X1BaUKMqA7RHApRt0z9cXJ
         6/zMMSMe69VcHdVoYPq3kgxicCBqwvoOwbtOeeuxdlcvcHGAUnx+k3NCqtkuueaa9/jS
         faFIWALpZm9hMzeX4UfqT1BIJjzWcf8PiiF9cmYVaIAHkXsUJlG2J5O//8rhfiYpoRHE
         cAgT6wZxitJ+t953efZKS05DelxzlQQCowHVLTUlLuhjeoxM1mCjwovWC2kdoVDsZsUC
         eD0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TgOIq8VQUiDYqV2oMi59dexKwHlFeeaw85QP4XFGgRc=;
        b=nsHzgiYJExAcwsPHTFCcJaFeL+sjoPNN7te2X/otACJIJMfayqczW+qtbUFfEtq5Ck
         Mc3eWHiCCekOoFEvYch7eUIz/LRcbcAsnyCE/xjpfBwdcQQ3I8hOItSZJ/fTwHVR4cMD
         MFEfvYBHxbUY0Z3eEL7uhT3LyG6+oNccOojaIBfafI7JlMc6mvyugjOLXg3q6WhwrS3k
         pUw/z+lG+tMAt7i4+OhOXcqXn1pSQ9aRtBhKnEQKA3YDRejJZIP1S3SU4aPZGkz9nElk
         hghfyaIZ1ayEHs1eeCPRhm9pUrkDPb5bBU9GzDo6Je03Y4ak3QydVqjrrqto4metzE6O
         uO0g==
X-Gm-Message-State: AOAM533xhNiZn2h/ySnu5HrAGg+Tf8VZAwBzk+vm2tE+QUx0GVHF9t20
        tHe16IfIMoeRIwAsaUHP1OI=
X-Google-Smtp-Source: ABdhPJwW8ppPaLRjqYdBnCxQ/XpGGbWLECoAm0jnlNMRh+X8UVub3UKkGlSZ1SWmhNa6g18HOf0UBw==
X-Received: by 2002:a63:df53:: with SMTP id h19mr2482048pgj.20.1621661676962;
        Fri, 21 May 2021 22:34:36 -0700 (PDT)
Received: from phi-nguyen-z390.lan ([118.200.63.8])
        by smtp.gmail.com with ESMTPSA id i29sm6146520pgn.72.2021.05.21.22.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 22:34:36 -0700 (PDT)
From:   Nguyen Dinh Phi <phind.uet@gmail.com>
To:     nsaenz@kernel.org, gregkh@linuxfoundation.org,
        stefan.wahren@i2se.com, arnd@arndb.de, dan.carpenter@oracle.com,
        phil@raspberrypi.com, amarjargal16@gmail.com
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: vchiq_arm: Using copy_from_user() to copy data from userspace address
Date:   Sat, 22 May 2021 13:34:29 +0800
Message-Id: <20210522053429.82710-1-phind.uet@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit to fix the following sparse warning:
incorrect type in assignment (different address spaces)
expected void *[assigned] userdata
got void [noderef] __user *userdata

Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
---
 .../staging/vc04_services/interface/vchiq_arm/vchiq_arm.c    | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index afbf01b7364c..2a4fc599f977 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -960,7 +960,10 @@ static int vchiq_irq_queue_bulk_tx_rx(struct vchiq_instance *instance,
 			current->pid);
 		userdata = &waiter->bulk_waiter;
 	} else {
-		userdata = args->userdata;
+		if (copy_from_user(userdata, args->userdata, sizeof(args->userdata))) {
+			ret = -EFAULT;
+			goto out;
+		}
 	}
 
 	status = vchiq_bulk_transfer(args->handle, NULL, args->data, args->size,
-- 
2.25.1

