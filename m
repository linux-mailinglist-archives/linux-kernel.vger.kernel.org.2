Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E53A3F0591
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 16:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238257AbhHROCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 10:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235675AbhHROCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 10:02:50 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC241C061764
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 07:02:15 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id u1so1738362wmm.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 07:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4V48O9fWoi3LlM7GFB2BgAQTwCbhZkKtIH4sRRIdbCs=;
        b=JIuekk3nuNJ9AbToC1X9nKGtC+9mv+ZKeoFXhtPx4zcFDF0Gi+pKJgibf3DvMHNhdU
         vF8igxxlJaTv6e8kwr0LZJ3rnlR3biIDAVRVa+aHOj1MYYTwXf13npnkv1EAp/c4AZr9
         kMhtOgwHhePOE7sfk1GHtEUOBWlie5KNxnEyAVBfwD09RT5/FeuU7Sx7sezmF03Qw8Sk
         1tZs9bQFHEjaMuSlYOn7g87hkb4vCqILO/K5Lpm2vOoro/w0PfI9zS8Zp+5923ubCUWm
         dueeMojx5rqcsW7covDHTMblrDS7ULZiaaeCKQYTcc+YQD9UqFY8QoGXACnjJGqPTcDz
         7BQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4V48O9fWoi3LlM7GFB2BgAQTwCbhZkKtIH4sRRIdbCs=;
        b=Gq0cQ983cm3z28JG20k9o9cSLTamcrJb8ZZxmD2+BwticcnUwRcRm2pWNgFL8wfWZI
         4SfGSYPlDoG3PtDUjKb6HmKUmMN8NlnXgdZZ2G7Al8282N1rtpyZvavEzjvA6qCRqEfU
         G/sytmXvBQ46yEWPiOCfZpQU+JO2rIUmZnI+9G92wZfjdap96zlLQmgLEQXARxykTTbA
         AowDsg7JWnNBSpUAATJRab42lDYnOd5z6j6ZpniNPcCXG7ulL0jXw1PMdObvh6tYpZvv
         rkctGgRoA2pGzH22gDKE5NNSyWGDCWMigJnHG36USt2TC9mJXjFj435NPPtrYMFdK7hV
         lT7A==
X-Gm-Message-State: AOAM531aUvn7qdvaBe7JC+a7gIZfOQ00Rexmtjs30ObtBEPrqI//l6Jm
        63eVsY316+UEoiLFPEntaBc=
X-Google-Smtp-Source: ABdhPJzConzuwapZDx2HsNsCo2N48PTabf0pZvQDszimuVbdYG7Wtav3jxlxeVdF6POOA+ebNAEtHQ==
X-Received: by 2002:a05:600c:290:: with SMTP id 16mr8819248wmk.187.1629295334532;
        Wed, 18 Aug 2021 07:02:14 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::687e])
        by smtp.gmail.com with ESMTPSA id i8sm5300576wma.7.2021.08.18.07.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 07:02:14 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: r8188eu: fix scheduling while atomic bugs
Date:   Wed, 18 Aug 2021 16:01:22 +0200
Message-Id: <20210818140122.10066-1-straube.linux@gmail.com>
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

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index f6ee72d5af09..b7df269e4149 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -8129,13 +8129,13 @@ u8 set_tx_beacon_cmd(struct adapter *padapter)
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

