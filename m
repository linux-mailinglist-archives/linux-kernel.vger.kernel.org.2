Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8CB3F1619
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 11:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbhHSJZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 05:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbhHSJZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 05:25:58 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF27C061575
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 02:25:22 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id f5so7954096wrm.13
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 02:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IVbcKYMfOmhTBBsQIKq+07W8pgc80trDsJf7FkANsyo=;
        b=mMdgY/sfu+S8ZUjtkWVbrgcjUjGDUPBg+A3xzqZnft33Rq9/q5NkcMxLIW0KAuIpzT
         F+INo97PcvPMd5paheBcYbx1/z35ll+yTAzaIRM1xHdeDm6HPqhzc7PC4iBABi9kHBck
         mhwhVCw8xEnJWVbt/8lNwe6WGXdhknYFbYrtFE+i92DRCUbKMSs1aHeEsDf5yVgu6y8U
         KIGMo+RG76c+0gEVFfcdvhLrqW8tOjlHEHMdN4JpiFbX4AspA7/ijzi80s3p+TGkmRYa
         KWp+bz3CsUjNV+YzPN5pWkiqvKxQrGKkxNUwX0nf8KKjaLBlB4gxCLEC8NQEVF3wJmcq
         yWrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IVbcKYMfOmhTBBsQIKq+07W8pgc80trDsJf7FkANsyo=;
        b=LOlQ+6PkVvijfOU+RRvNPkN772jpbHAwX915xYgHgPXAw8VvyYMme3DGQah+OtZbjN
         cTBOLbVHcA2OuPKHlFmnXsQ9CaK32UqJjoezRKO7bQ25971/vU0d5rvF9wsfWnGnG720
         IyTYeN5vuval8vyeFxADUr6mLQm20dTl3KouSGEuJf/BpJHhA45yWcE6m8k/c98AJIU0
         4GFb+LRrVYPXNcSkuFXOGnEK7wd6YJ47k1JwWJt7L7AFAVn1E0qAr3voIhSP37X/vjvJ
         BUtmHlusNNpgWULNWVDzltATOnsuLau4WFwfDpqKB5zcXz9S/L+016qAKTGJcq3mNOXC
         JVKQ==
X-Gm-Message-State: AOAM530aeNXtCEaed+zwCm11qDk5FAIM1kGmv1OgpXjslFHc67Yv4Ng/
        aF/azk9RZUMo+h2SN7Z/GpreQ6gnOWk=
X-Google-Smtp-Source: ABdhPJyHozq0YMg8bxQjLoGBNKnUWXYB5289Ru0LhbFMjm55G4bUm6gaSbltCnOb4n1Vb3ga/kDjJQ==
X-Received: by 2002:adf:df08:: with SMTP id y8mr2622512wrl.124.1629365121386;
        Thu, 19 Aug 2021 02:25:21 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::687e])
        by smtp.gmail.com with ESMTPSA id d4sm2354928wrz.35.2021.08.19.02.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 02:25:21 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v3] staging: r8188eu: fix scheduling while atomic bugs
Date:   Thu, 19 Aug 2021 11:24:23 +0200
Message-Id: <20210819092423.4349-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These allocations are sometimes done under a spin lock so they
have to be atomic. The function call tree is:

-> update_beacon() <- takes a spin lock
   -> update_BCNTIM()
      -> set_tx_beacon_cmd()

Fixes: 79f712ea994de ("staging: r8188eu: Remove wrappers for kalloc() and kzalloc()")
Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
v1 -> v2
Added Fixes: tag to commit message.

v2 -> v3
Correted the commit in the Fixes: tag.

 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 5325fe41fbee..508ef1d330a1 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -8130,13 +8130,13 @@ u8 set_tx_beacon_cmd(struct adapter *padapter)
 	u8 res = _SUCCESS;
 	int len_diff = 0;
 
-	ph2c = kzalloc(sizeof(struct cmd_obj), GFP_KERNEL);
+	ph2c = kzalloc(sizeof(struct cmd_obj), GFP_ATOMIC);
 	if (!ph2c) {
 		res = _FAIL;
 		goto exit;
 	}
 
-	ptxBeacon_parm = kzalloc(sizeof(struct Tx_Beacon_param), GFP_KERNEL);
+	ptxBeacon_parm = kzalloc(sizeof(struct Tx_Beacon_param), GFP_ATOMIC);
 	if (!ptxBeacon_parm) {
 		kfree(ph2c);
 		res = _FAIL;
-- 
2.32.0

