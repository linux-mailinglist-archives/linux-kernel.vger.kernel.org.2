Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B994A3F8505
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 12:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241246AbhHZKHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 06:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233880AbhHZKHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 06:07:39 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CDB7C0613C1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 03:06:52 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id a5so1491134plh.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 03:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=itfac-mrt-ac-lk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=KyCkOwX6FlAykrEfVDREM7slwqhWzjVtSiMdbpagDO4=;
        b=LgjRvH59s9Ccoi0kWYtI5CqxF5OUK1O5mRFtMOdjPda7viEmj5dsN9GwXQu3D8AUGs
         ALWBsj6M7kZ3DHllMof7rm9FJtnLZm6kMtX2tGLErVqT1NhG40Makw5kqmmRNvCeAyu9
         QxJNwJzhDhfBKkGpTO1m0ZjoJAURCZPn/H/RY8tWhyau1PkG0SDR6xL7OtbZ6D8VfpJG
         /ICI1dydna/j6Ztq/MUw3yhLSN2G3t2Y/luJESv1vw3IWz2zy6UdVXq1BfnKjgmVSr8i
         cTfHn/hE8H4d9q62Sbs/8cDwG+nEz/n2mDRR7BApG6ubveCKnO2x4S6Drsodhu1FE/hc
         TZjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KyCkOwX6FlAykrEfVDREM7slwqhWzjVtSiMdbpagDO4=;
        b=dztyBd2cCWfKQfSAcIzL45onfdZ3xAtH1ma9cAJ0vT3l+4BNY3Ntmd2ToY1z5Bj4ic
         9sGSuIVE+FsfUiiWAzj0FZE7h6lCFZlGVhr0n1OPNo06J+PHqpNU4EeXR5jVk8+NjnGD
         46K1TRsX+/dGJhTGbHdxfF3CeSeFrS12ntRz2f0hOXNcaabo4l3YTIN5i9z+VhbK7Mjl
         q1gFRr0GKoEhcoiy95al6JdoqHJHX3qofizL6NZsayECt6msER3yuqwB28ujfdugBhvx
         fabh1RhWbLoVb7RqGCApTiLIdkgyYB6XUS8bmaUcIbZy2RZNXTAHRs9cj7whHMFRYuCQ
         v6pQ==
X-Gm-Message-State: AOAM533/DCNbpnJKGKhK/02MraR9AKCiL5SpLJyERl1RuLV8ZmhvEz/W
        LMDL7ETw84UvIvklgehE5Qxb
X-Google-Smtp-Source: ABdhPJwMNkPwuLMRtpOr1r+KTvWtHBhmpaFSHKPH9eOLpfcWOFty41sxUDZ5gQpbzSWosUEdoajzQQ==
X-Received: by 2002:a17:902:bf49:b0:136:7033:8963 with SMTP id u9-20020a170902bf4900b0013670338963mr2937843pls.75.1629972411656;
        Thu, 26 Aug 2021 03:06:51 -0700 (PDT)
Received: from localhost.localdomain ([175.157.109.217])
        by smtp.gmail.com with ESMTPSA id p16sm2364957pjz.44.2021.08.26.03.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 03:06:51 -0700 (PDT)
From:   "F.A.Sulaiman" <asha.16@itfac.mrt.ac.lk>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com
Cc:     "F.A.Sulaiman" <asha.16@itfac.mrt.ac.lk>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fix inconsistent indentation
Date:   Thu, 26 Aug 2021 15:36:34 +0530
Message-Id: <20210826100634.24183-1-asha.16@itfac.mrt.ac.lk>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fix the inconsistent indentation
warning in hid_add_device().

Signed-off-by: F.A. SULAIMAN <asha.16@itfac.mrt.ac.lk> 
---
 drivers/hid/hid-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index dbed2524fd47..76781f940186 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2401,10 +2401,10 @@ int hid_add_device(struct hid_device *hdev)
 	/*
 	 * Check for the mandatory transport channel.
 	 */
-	 if (!hdev->ll_driver->raw_request) {
+	if (!hdev->ll_driver->raw_request) {
 		hid_err(hdev, "transport driver missing .raw_request()\n");
 		return -EINVAL;
-	 }
+	}
 
 	/*
 	 * Read the device report descriptor once and use as template
-- 
2.17.1

