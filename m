Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6660E3F1CCA
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 17:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240348AbhHSPa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 11:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240304AbhHSPaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 11:30:55 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E091FC06175F
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 08:30:16 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id bt14so13781404ejb.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 08:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XaGQNjoFDqClYFNGQw17hG3Sx6lRDKqVTcPsNKf9+H8=;
        b=j0ySqt6FojZ9+3ONUFQ9SqyXGH9+BPy2DoBRXKxyLkXadoUE1hn+9ajGqg3acb5sBg
         J47h3ELWE+MfMQ4obhd163Oq7CQ3CZpJGfzClNZZ6UR59+HPpMHKro/rZI2sI/l/A62v
         NdDZ46RUbe29w8gzfqvuESJpdY3M6ZuuT/Qq8Bn4ykt9WaSI0G+E1HVKMB3EviJEVzga
         WyH+vJRX1ku0McgDzJjmIgiDAoWrOfyv3VB22YEyotDN6fEDu4ykQz5EV67hmUyQuFWH
         taljKh8lkx5r9T9zf8TaPjRPW1dEov/40ObTcic1zz68xsinvEizIxi9MljMntoGAoDw
         51hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XaGQNjoFDqClYFNGQw17hG3Sx6lRDKqVTcPsNKf9+H8=;
        b=n6MlOl1SSxP0EpI0281XzDkp2E+tKG1uRgmoNNa9gcDxQDlPW53ER8ArtCu6TjyLAZ
         GsFj9Z0xNH7W9/Pz5sZDy2fjA53/HD5W94rS8NSi8ELAW9FqqT4up9NR9MajW4Yb4xFs
         3oDZbMiZQ+yaWpC+W2bJMon2K13oWX7Al8LQ3plh3JmKQjpqCs5J+AUObBDCe9k4FAbJ
         2I32YGS6MA3DVkHy6kPFFCAHppy7DLIXlPYMcha1yAvbXpxU4s4kIZ9fNvKCpXbPXbjs
         4oX3/Vcy5A4s4YTa22ilzQVd/pNxJUBVx6Z+HunHx1w1gc6tO5KKJC/Amighg9o3wJ1t
         y80A==
X-Gm-Message-State: AOAM5300S7hrKuDwN6iIIbQd+3hK/ZWf4qEouVOEOQRD81QN+qmMufA9
        sur7D20q1tS3/f6W+kelXv0=
X-Google-Smtp-Source: ABdhPJzpYgp+/flMjF241aQ9cCXe2tbGEsvGFt5hyAVQxypvqlM74H3TMEBe/x5CQ0kBFYbAnC7hiQ==
X-Received: by 2002:a17:906:c251:: with SMTP id bl17mr16314325ejb.219.1629387015517;
        Thu, 19 Aug 2021 08:30:15 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::687e])
        by smtp.gmail.com with ESMTPSA id m18sm1958658edr.18.2021.08.19.08.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 08:30:15 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: r8188eu: use GFP_ATOMIC under spinlock
Date:   Thu, 19 Aug 2021 17:29:14 +0200
Message-Id: <20210819152914.17482-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmalloc() in function update_bcn_wps_ie() is called under a spinlock
so the allocation have to be atomic.

-> update_beacon() <- takes a spinlock
   -> update_bcn_vendor_spec_ie()
      -> update_bcn_wps_ie()

Fixes: 79f712ea994de ("staging: r8188eu: Remove wrappers for kalloc() and kzalloc()")
Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_ap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/core/rtw_ap.c b/drivers/staging/r8188eu/core/rtw_ap.c
index 1f3aa0092ef9..41b5668d080b 100644
--- a/drivers/staging/r8188eu/core/rtw_ap.c
+++ b/drivers/staging/r8188eu/core/rtw_ap.c
@@ -1192,7 +1192,7 @@ static void update_bcn_wps_ie(struct adapter *padapter)
 	remainder_ielen = ielen - wps_offset - wps_ielen;
 
 	if (remainder_ielen > 0) {
-		pbackup_remainder_ie = kmalloc(remainder_ielen, GFP_KERNEL);
+		pbackup_remainder_ie = kmalloc(remainder_ielen, GFP_ATOMIC);
 		if (pbackup_remainder_ie)
 			memcpy(pbackup_remainder_ie, premainder_ie, remainder_ielen);
 	}
-- 
2.32.0

