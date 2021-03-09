Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 321F8332983
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 16:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbhCIPBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 10:01:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbhCIPAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 10:00:55 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40AC9C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 07:00:55 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id n9so7979497pgi.7
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 07:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=UVX6yhkhZJaYTUj2gA+yCgge5D0I9vFDtLFEQfPvprw=;
        b=EpfhMd+1+TAKUuxk9q5BVgmdp21lkwE833OTzKkFUW41fP551wb8w7Ys5KPeDqDjrt
         tRMWpLmBd/u7HRX312J48xHBkRv4Q7wRO5eheWh+UKBL1oOsIzYTiPPTNBzHJZ332Mmq
         sfgOpjWi31XPXuRyKckH/1eo0R367ckBEP1BRRQKL44ePNk9oMHo3bKst+wV98luibnj
         zON6p40jSUT459A0YxxO2tvWpdKLgaj/GauQFRqN0w9JzPFGMYZIE3S0e7uuqWJVA6pd
         KWVjQLuYIBLBXi9Zk71rvXaqOOGhKZHyFIGGJ4uF5dzNZ1Nkprg1+OmaPe4KpmAv22yv
         aTaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UVX6yhkhZJaYTUj2gA+yCgge5D0I9vFDtLFEQfPvprw=;
        b=iYDFI+DgtRAHi7uo9n+kW+6DYpR1r+5NryJAnlry9C0mh3plTd9XvJfEjwnUJis7OD
         oZaUFuPNY6fuUtiEJLmLLGh3KvVXbfHU3aabfrH4H3A/xG2Z2bIALYoKzUl5VFmGAZIq
         i0mpOCze4kADgbaoBaobLAzNvcaxmUlWn2PKUCcQXkSFSFwYBmOqt1KVZMq1n9wm98Xz
         89C5j7Jn/6phW5GsPsgESSHy25C2+AafYs+i7leD3HOBATsSVohrPVjLJx9KqKYb+yL/
         nRwWmXl0rckF6vjKe04FYBR4l5x1WbXAH1Z1GFVxRBYCiTBEdFeWChYb+kApsI+2Gmw0
         fvcA==
X-Gm-Message-State: AOAM532Z+5NS6mn+DraVYsLUm01FqyGV2CuC2daj13Y5vojC2cX1ThfC
        F4BxEsRcOS4YQjjfjUkS5Vc=
X-Google-Smtp-Source: ABdhPJw+aeKbyDxj4LBUB98GD/ciTuULhhK2slQ5Pfd0hduriTNlCrnjwNVSfbrZphEcW3atgs+SQQ==
X-Received: by 2002:a62:602:0:b029:1ed:d3fb:7edb with SMTP id 2-20020a6206020000b02901edd3fb7edbmr26242650pfg.22.1615302054756;
        Tue, 09 Mar 2021 07:00:54 -0800 (PST)
Received: from localhost.localdomain ([116.73.168.170])
        by smtp.gmail.com with ESMTPSA id m21sm12774536pff.61.2021.03.09.07.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 07:00:54 -0800 (PST)
From:   Selvakumar Elangovan <selvakumar16197@gmail.com>
To:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        florian.c.schilhabel@googlemail.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] staging: rtl8712: fixed whitespace coding style issue
Date:   Tue,  9 Mar 2021 20:30:37 +0530
Message-Id: <20210309150037.17883-1-selvakumar16197@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed additional whitespaces in the rtl8712_xmit.h file.

Signed-off-by: Selvakumar Elangovan <selvakumar16197@gmail.com>
---
Changes in v3:
 - Done one logical changes instead of two different changes in the same
   patch.

 drivers/staging/rtl8712/rtl8712_xmit.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl8712_xmit.h b/drivers/staging/rtl8712/rtl8712_xmit.h
index 0b56bd3ac4d0..e4c0a4bf8388 100644
--- a/drivers/staging/rtl8712/rtl8712_xmit.h
+++ b/drivers/staging/rtl8712/rtl8712_xmit.h
@@ -36,10 +36,8 @@
 #define MAX_AMSDU_XMITBUF_SZ 8704
 #define MAX_TXAGG_XMITBUF_SZ 16384 /*16k*/
 
-
 #define tx_cmd tx_desc
 
-
 /*
  *defined for TX DESC Operation
  */
@@ -89,7 +87,6 @@ struct tx_desc {
 	__le32 txdw7;
 };
 
-
 union txdesc {
 	struct tx_desc txdesc;
 	unsigned int value[TXDESC_SIZE>>2];
-- 
2.17.1

