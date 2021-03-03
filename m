Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA4932BF0C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 00:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1577468AbhCCRso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:48:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244771AbhCCO6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 09:58:18 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86EFC0613E0
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 06:46:42 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id f12so20166103wrx.8
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 06:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WNQAPxGMnqLL7g3LltPLuvKvyAOeTz8LyxGMxNVsyHE=;
        b=sVSVp9AxBtfr9XnMsMLHY+Za2AdiIrWKn4fsk+8hYwtrvDV7QnyEYYyptJ4Kbctavg
         2Mr1ByDFM+WvEJr2kRUwFcR5jblcTFpP3XzGbNKLX8R6J0QAmgVJEPr9qSxdV8r8Sja4
         Rjggve1rDqlK8Bj9wf+F7imYLbeOMy8RnVijKXgyP5LACWRkPa35nfeARfMcIwleM1XY
         BUHCKHOrzAl5Qvzz2Yca8DjZa1EQTJCWVeZF3KBvmvMKkuVkVDzyucKx/dEMNzpGHsno
         goFv0W4F+yAE2kxqNHDYMaABbhaf71ehoTFQOBCH+Ly3U1Lq4xmQIOmdcT/8MvJldPdx
         /Tqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WNQAPxGMnqLL7g3LltPLuvKvyAOeTz8LyxGMxNVsyHE=;
        b=T2NhM3LxKwU8BI8nGgRXWG9wAMMCX+OpzU9V6+fLTK3z1l0tF8Jsz7yhOfz1cWwArT
         diIEKQjGPYs+SfRSxnZD3ggZ092Y3M9Jm9Hv1nyc1dnVFA4aCHSq4yIrfTvoLCk96c7J
         PHAkPlE/tCj0R9LhuFq9X+qRsS3KmGfxi1ZwehjAMR4i743Gzp29azvPMneQgY6GOYNN
         OmgxFSKEBmtk44snxiTA1KMGyLtlZRYuYxwoypMrL6T9ooUEul8Ck6f7OoPtsWlRwwEF
         O8wnR7fGdmdMuqe19fYGcj5Ejd0R+k423KbvBME2nZHlUn1FMeg3nvo0vFDovMsz8j38
         TJNQ==
X-Gm-Message-State: AOAM531JOKmUgQOwMrnThYUSfDF1tRbsBjeyT+uPDoNRN1K0x37A3NKK
        dXQdNjNgFg542QbQbWMvsGnMix5S5yigHg==
X-Google-Smtp-Source: ABdhPJwz7Cbb5q6oZiB21g3fYOlbJ9E2LU3Ob3H595o8I3XgXxqkikxXdx4eIh6JmOjiR51ogLMcIA==
X-Received: by 2002:adf:c101:: with SMTP id r1mr27898465wre.38.1614782801291;
        Wed, 03 Mar 2021 06:46:41 -0800 (PST)
Received: from dell.default ([91.110.221.155])
        by smtp.gmail.com with ESMTPSA id a14sm36567233wrg.84.2021.03.03.06.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 06:46:40 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Subject: [PATCH 03/30] scsi: fcoe: Fix function name fcoe_set_vport_symbolic_name() in description
Date:   Wed,  3 Mar 2021 14:46:04 +0000
Message-Id: <20210303144631.3175331-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210303144631.3175331-1-lee.jones@linaro.org>
References: <20210303144631.3175331-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/fcoe/fcoe.c:2782: warning: expecting prototype for fcoe_vport_set_symbolic_name(). Prototype was for fcoe_set_vport_symbolic_name() instead

Cc: Hannes Reinecke <hare@suse.de>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/fcoe/fcoe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/fcoe/fcoe.c b/drivers/scsi/fcoe/fcoe.c
index 03bf49adaafe6..89ec735929c3e 100644
--- a/drivers/scsi/fcoe/fcoe.c
+++ b/drivers/scsi/fcoe/fcoe.c
@@ -2771,7 +2771,7 @@ static int fcoe_vport_disable(struct fc_vport *vport, bool disable)
 }
 
 /**
- * fcoe_vport_set_symbolic_name() - append vport string to symbolic name
+ * fcoe_set_vport_symbolic_name() - append vport string to symbolic name
  * @vport: fc_vport with a new symbolic name string
  *
  * After generating a new symbolic name string, a new RSPN_ID request is
-- 
2.27.0

