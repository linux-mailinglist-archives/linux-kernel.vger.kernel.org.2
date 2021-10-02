Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6C5B41FCAB
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Oct 2021 17:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233452AbhJBPPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Oct 2021 11:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233274AbhJBPPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Oct 2021 11:15:44 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A401C0613EC
        for <linux-kernel@vger.kernel.org>; Sat,  2 Oct 2021 08:13:59 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id r7so8524363pjo.3
        for <linux-kernel@vger.kernel.org>; Sat, 02 Oct 2021 08:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=3CcsIBkjnD7sDWaAM5mdqO8LXPHUnsgkAUC6h+d4KEk=;
        b=J15ChbwXUVu9rh26SHqVY8sa3JxBfK6+NkF3P+sW6CoB7qKhOr0DCh+uWiNSgdfVmn
         2UlJbZNPi1qqbaR2ZodVYqfPRsfBQK98sE1sXV+y/9WSsbE/vh+fTHbV5uacQW8e0gwF
         SwbkM6yq7TuRa+JpqAfsqGTCvs7cQk4rb+a/O7oZmu5EG8iF6j1oWjDNKiwTQ0JzxWSi
         fP//HwDl+cjmVDKh+bQKU0YJk4vFp0ijv+l/5XNshglCev+EraQCX5LMVV2M3fbNmtbU
         4e+eqWBHNXExmEQF6sLqhCdODyRWJOCRFwhBVvqKRZcIUc+EIPkHJoFDP7HnXe/hRcd3
         TnPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=3CcsIBkjnD7sDWaAM5mdqO8LXPHUnsgkAUC6h+d4KEk=;
        b=7NzQPtZDK/35xNH9rgoRLjWfBDu96XZg+A8/OB7KVDrKy2Tx4mNlhC5NmgN79beAnv
         jM4M8BC2lq5v77GC3wuNYakzoKDhdi9TGYTW+Ftc36Bv7QhMuqDfpufWc/3Lv15Hdr6v
         lIayP96Ehgv+y3gzNqQ0glLT0LbXlT7aEZzCa39WikAv0MDdYsqScBYQHSA68b6UZZkC
         FUlSJwYGmQGczCSHQ2Hkx0mTlL3RwUAbvYNQt5FiDoqvU9Z8GxEvcxE2nR4/4pRBHfE+
         yyVb/XNI4QBcNppX7/R94MtnksXrZ4+LRMPx9NpO1KlhmcRn/Cxgki9bfZjCM3pLiobo
         cn7Q==
X-Gm-Message-State: AOAM531d8v+OEKIhkP1Hx4t0U3NgKrOQz701uUNNgcRoap/pRLATr1Hq
        KszA/DGh9ebY6Cg3DPiN6WM=
X-Google-Smtp-Source: ABdhPJyCmF7HojIrD01MKnEYPyf/gWuUwhD9TDFQCO8AAPjwSrA9JATjobIyQV7V4jpi9Ir+BFnKMg==
X-Received: by 2002:a17:902:dad2:b0:13c:a6ce:faea with SMTP id q18-20020a170902dad200b0013ca6cefaeamr15873437plx.45.1633187638437;
        Sat, 02 Oct 2021 08:13:58 -0700 (PDT)
Received: from user ([223.230.105.60])
        by smtp.gmail.com with ESMTPSA id k22sm9472702pfi.149.2021.10.02.08.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Oct 2021 08:13:58 -0700 (PDT)
Date:   Sat, 2 Oct 2021 20:43:52 +0530
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
Subject: [PATCH] staging: r8188eu: core: remove unused variable pAdapter
Message-ID: <YVh3MP/JrUwkKr3Y@user>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused variable pAdapter in Efuse_Read1ByteFromFakeContent.

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_efuse.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_efuse.c b/drivers/staging/r8188eu/core/rtw_efuse.c
index 801887f497cf..d33a5b3b4088 100644
--- a/drivers/staging/r8188eu/core/rtw_efuse.c
+++ b/drivers/staging/r8188eu/core/rtw_efuse.c
@@ -28,8 +28,7 @@ u8 fakeBTEfuseModifiedMap[EFUSE_BT_MAX_MAP_LEN] = {0};
 #define REG_EFUSE_CTRL		0x0030
 #define EFUSE_CTRL			REG_EFUSE_CTRL		/*  E-Fuse Control. */

-static bool Efuse_Read1ByteFromFakeContent(struct adapter *pAdapter,
-					   u16 Offset,
+static bool Efuse_Read1ByteFromFakeContent(u16 Offset,
 					   u8 *Value)
 {
 	if (Offset >= EFUSE_MAX_HW_SIZE)
@@ -96,7 +95,7 @@ ReadEFuseByte(
 	u16 retry;

 	if (pseudo) {
-		Efuse_Read1ByteFromFakeContent(Adapter, _offset, pbuf);
+		Efuse_Read1ByteFromFakeContent(_offset, pbuf);
 		return;
 	}

@@ -134,7 +133,7 @@ u8 efuse_OneByteRead(struct adapter *pAdapter, u16 addr, u8 *data, bool pseudo)
 	u8 result;

 	if (pseudo) {
-		result = Efuse_Read1ByteFromFakeContent(pAdapter, addr, data);
+		result = Efuse_Read1ByteFromFakeContent(addr, data);
 		return result;
 	}
 	/*  -----------------e-fuse reg ctrl --------------------------------- */
--
2.32.0

