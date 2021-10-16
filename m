Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13F55430519
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 23:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241046AbhJPV72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 17:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235312AbhJPV70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 17:59:26 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52761C061765
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 14:57:18 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id qe4-20020a17090b4f8400b0019f663cfcd1so11866768pjb.1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 14:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lR7v2SeiI/rPTDpitBfRCXahGE0ZCHzarZSpq+/okuQ=;
        b=O/rj1uASFAU7AVI7upqHkb/IgntAN0O5+JJqCM+1f7zJqD5BfrRhNWYIW77zzwENlr
         CKiPr/inPoD1hARjNIKkZBzNsT7DJ7Yg91HSAMfVDXgLdGDoEzSTZ7XQ8qfWKZzCg18Y
         5LEONqJDaVEjTjKN02SJJn/7D+kDM99lU5UbAAeiFazUSi7fNC3ZrDz4lCFRn0/VCvs1
         XTi4uT9Q29IENgEH+dmyU/FlGv4aQcTUfSUIoBslMqW6NoOEWOQP7vUULDiF1m7ph5MH
         /uGAzmXg08Yn94H5zB9TdELb3OwHrYSEXBlLkMMpoJeh36nbgvCEtIWDjbF/dtH6DxvN
         RHhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lR7v2SeiI/rPTDpitBfRCXahGE0ZCHzarZSpq+/okuQ=;
        b=N4zqJWSoS64gOWkOeuuXQw0P2kRVhGEz8tFnNC18Mshr3G6cNJjbGVlXGIaicNSawg
         UkLZcZ68Og2i/SxADPT1kc7RPJ4eIs1eyPHfq6CL7RPBMDWHRn67RPgSW3pEsci8b0CW
         Vb5PEBPBQo7dhaWwuyUv+GKts8Hxw4hqAYL42+LSQqdN1IQNqfNf06GONqmCSnztmTug
         LIXrrsix84TERutjSKz5rSYc7QxNRVuz5CDUjMW8/snKXg5vnXMyvtjDvnE+QZweUFSJ
         IUv6HplOLCs4Q4ZEss8knnPYKstOQmgBJCRxjfvkFIf4n8wfYrVWZPG9jYuJjotW2t0W
         dKhw==
X-Gm-Message-State: AOAM533oXh5FXMHv5yTChUG/101cOGn/WmhspzTChjmlwQzaxeZi62zv
        CAb3/3dSt4Fl+UxblFn6of8=
X-Google-Smtp-Source: ABdhPJxLq4+FJHPQaRNEEuI8Y2uczN276b3TXoygp2NtPHHqEResNravQTmRhPjApKGg3CtJgkT82Q==
X-Received: by 2002:a17:90a:71c5:: with SMTP id m5mr37000621pjs.105.1634421437722;
        Sat, 16 Oct 2021 14:57:17 -0700 (PDT)
Received: from localhost.localdomain ([115.96.219.100])
        by smtp.googlemail.com with ESMTPSA id y3sm8630080pjg.7.2021.10.16.14.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 14:57:17 -0700 (PDT)
From:   Kushal-kothari <kushalkothari285@gmail.com>
To:     linux-arm-kernel@lists.infradead.org, mike.rapoport@gmail.com,
        kushalkothari2850@gmail.com, kushalkothari285@gmail.com,
        outreachy-kernel@googlegroups.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        nsaenz@kernel.org, bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH] staging: vc04_services: Fixed checkpatch warning: MSLEEP: msleep < 20ms can sleep for up to 20ms.
Date:   Sun, 17 Oct 2021 03:25:27 +0530
Message-Id: <20211016215527.119189-1-kushalkothari285@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Kushal-kothari <kushalkothari285@gmail.com>
---
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 6fbafdfe340f..80a7898c5331 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -857,7 +857,7 @@ vchiq_bulk_transmit(unsigned int handle, const void *data, unsigned int size,
 		if (status != VCHIQ_RETRY)
 			break;
 
-		msleep(1);
+		usleep_range(1000, 2000);
 	}
 
 	return status;
@@ -894,7 +894,7 @@ enum vchiq_status vchiq_bulk_receive(unsigned int handle, void *data,
 		if (status != VCHIQ_RETRY)
 			break;
 
-		msleep(1);
+		usleep_range(1000, 2000);
 	}
 
 	return status;
-- 
2.25.1

