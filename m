Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13C233B0584
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 15:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbhFVNMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 09:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbhFVNMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 09:12:25 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B59E0C061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 06:10:09 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id m41-20020a05600c3b29b02901dcd3733f24so1730220wms.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 06:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6pwu5pM4dbgTBood6EBI5joCOsJM78eFvHusKdHfshs=;
        b=B1xw1/tFWI4m27i5R2W+50PxPXrN+0bGQ8viZRX4euUCm+pAv8LpPIusUc6yOnaT7B
         OfOKY7Bho/KBPdrDYZtf3JRw5n69YqcdmcOf7raB8zNsklf/MoXh/puHKD7Kua5bRMzC
         i7w5rBjxzPDG0hmPhSeagFh2OiolGldI1+2RUJaUob9bBr/06y1WXbXFqw+J7NKOkf9e
         8r/T5Hkv7FmFggpc3qIx9o5HG8Gw+hZ/6jR50QfySydlmVxYfbVbO269+gPdGdbXGYBW
         N60I6CFgibG1bXn0BoPX4prF6cUb0XzILf21AfxlpK9+ZgGOXoD/rPlSjNkrh4xHkpZ9
         XhXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6pwu5pM4dbgTBood6EBI5joCOsJM78eFvHusKdHfshs=;
        b=SkoXOIR81UmJl9YNCBVlkU6sHKhPfFPOnyJinXF/54joTJxhvdEh1fPXt8+gncvQWC
         X/P2JBzWNx1V5e1xROgM5atGmkGfccK6kzii6BenAM+Rh8OU/0HLZfvCKzinJ9wLjL+b
         GNpqWjfwRw3okeI9X8PB+ZxN2iHC2hNKmtk/EtjHpGD7wuHxNaQ4RZiKL7bMeELRT+lo
         CeyGXN36HYe2hdL+hJT1ifnCSdb6GVDg+SqVzjkWvUKsBVAkDPOKx2UbHQPGLeKysqhX
         4tPEluHytZ2pmix6pFNj9/EDqqiPUMnu0molig2olJFGsh7KQu/MQe3rGdvGK/4hd33J
         oxig==
X-Gm-Message-State: AOAM533vohk97Zac6nYskEUXZoh3GT0O98//lEXsa4cWydr3dT/7auOT
        ysUc6RSrJJlXjKJ/T2cv6wOLVrgIUkCjPw==
X-Google-Smtp-Source: ABdhPJzxr5gG+GqGYkYein8UnpRd9OFuSEt/4gXPcXLnxRptI4EbJRbTCDzdQVT7LQvdDRx7pqK3dA==
X-Received: by 2002:a7b:c089:: with SMTP id r9mr4411431wmh.167.1624367408158;
        Tue, 22 Jun 2021 06:10:08 -0700 (PDT)
Received: from agape ([5.171.73.108])
        by smtp.gmail.com with ESMTPSA id c21sm2356376wme.38.2021.06.22.06.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 06:10:07 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3 03/17] staging: rtl8723bs: remove unused enum items related to channel bonding
Date:   Tue, 22 Jun 2021 15:09:47 +0200
Message-Id: <beb6760c04116b4720edf7257149828653bbda26.1624367071.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1624367071.git.fabioaiuto83@gmail.com>
References: <cover.1624367071.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused enum items related to channel bonding.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtw_rf.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_rf.h b/drivers/staging/rtl8723bs/include/rtw_rf.h
index 98bc274e5e81..550471637315 100644
--- a/drivers/staging/rtl8723bs/include/rtw_rf.h
+++ b/drivers/staging/rtl8723bs/include/rtw_rf.h
@@ -98,14 +98,6 @@ enum {
 	VHT_DATA_SC_DONOT_CARE = 0,
 	VHT_DATA_SC_20_UPPER_OF_80MHZ = 1,
 	VHT_DATA_SC_20_LOWER_OF_80MHZ = 2,
-	VHT_DATA_SC_20_UPPERST_OF_80MHZ = 3,
-	VHT_DATA_SC_20_LOWEST_OF_80MHZ = 4,
-	VHT_DATA_SC_20_RECV1 = 5,
-	VHT_DATA_SC_20_RECV2 = 6,
-	VHT_DATA_SC_20_RECV3 = 7,
-	VHT_DATA_SC_20_RECV4 = 8,
-	VHT_DATA_SC_40_UPPER_OF_80MHZ = 9,
-	VHT_DATA_SC_40_LOWER_OF_80MHZ = 10,
 };
 
 /* 2007/11/15 MH Define different RF type. */
-- 
2.20.1

