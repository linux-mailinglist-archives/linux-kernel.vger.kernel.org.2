Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6A63FB5D6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 14:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236728AbhH3MQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 08:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbhH3MQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 08:16:37 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26FD6C061764
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 05:15:44 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id u16so22141632wrn.5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 05:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C0jDxgei4bh80NCLp4kQich3bBzgtekPwpab1aROVMA=;
        b=r8t3DDqn0SQcZvx1pXh8E1rCQrWuemDJD98NFhU0nzSDRbVsJh/pp11rEBaofoCD2B
         +hxjTx32ZA4AuePGO3r/3gK9+fb25qj6vLuQWk+pOvrsGTs0P4uPsFgqXAClVl3tlMH8
         x8LGz+v4iaI75LTuLYZTUodzvTLmanBl4dP0j9W/e8E8RTR12wtGZbH3da8sm88G62H5
         Qf2DuahTQAsNnkKpKQs/IK/XbigYpZnK5Gnrp3/ofXiOuP0dr2FN/m7Lx6yfQEN/eKrd
         XdS/QKNT9gwJcTHnIbBlKnRDR+SlRRsaJ3hXaqaemq3yOryB8VifOU3VW3IRwslt1x+r
         2n4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C0jDxgei4bh80NCLp4kQich3bBzgtekPwpab1aROVMA=;
        b=n2WBckUdvU6ZkOgaXO38pp98yA5KEUGsFuqM/SYvMglMnH1lNjRX5WjlCzTpoiOWQ3
         fMYFVjgQ02Jr91r18m4CycZFtBFu0dk+S0YzfT1EDQG8/JfFGJveCP1fV3LFna1Uly9K
         ZYadLSGSEicO5/eKzVkZER+a8kR4vjBoaI/3OlvV9fG/uzgVw6QJ1Xam/AAguXeJJmuy
         YPnwr5BVY/Duc0rhW4+djtrrycic358BcGOJxah3cJ9lKrT+OktirPZmenX1HbHpOp0O
         L5U0vJveHb7P+bIb1bvnUx66ozGgbPrcg2Z0lBgYkxKG49l3XwhUIrsGu5OKQNX0t0Rx
         Isrw==
X-Gm-Message-State: AOAM533/eG4HVGNd6UbK1NckRlx+BvltrfYd1zd/48WAdB8HM22oszLu
        LyIkawFSfjQbj2OV/UZNKd4=
X-Google-Smtp-Source: ABdhPJx1JqT2NS8B8Fr8XH3AQRj7OSzN1Ze8DZO658jh2OZAh1NDmuhjRSvp3jFcjQ8iyNFC6cpOfQ==
X-Received: by 2002:a5d:69cf:: with SMTP id s15mr25175000wrw.403.1630325742783;
        Mon, 30 Aug 2021 05:15:42 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::16fa])
        by smtp.gmail.com with ESMTPSA id x11sm15492116wro.83.2021.08.30.05.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 05:15:42 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 2/8] staging: r8188eu: ensure mac address buffer is properly aligned
Date:   Mon, 30 Aug 2021 14:15:02 +0200
Message-Id: <20210830121508.6411-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210830121508.6411-1-straube.linux@gmail.com>
References: <20210830121508.6411-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure the mac address buffer in struct eeprom_priv is properly
aligned for use with functions from <linux/etherdevice.h>.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/include/rtw_eeprom.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/include/rtw_eeprom.h b/drivers/staging/r8188eu/include/rtw_eeprom.h
index 9f8a9c070339..fb591a764dac 100644
--- a/drivers/staging/r8188eu/include/rtw_eeprom.h
+++ b/drivers/staging/r8188eu/include/rtw_eeprom.h
@@ -99,7 +99,7 @@ struct eeprom_priv {
 	u8		bautoload_fail_flag;
 	u8		bloadfile_fail_flag;
 	u8		bloadmac_fail_flag;
-	u8		mac_addr[6];	/* PermanentAddress */
+	u8		mac_addr[6] __aligned(2); /* PermanentAddress */
 	u16		channel_plan;
 	u8		EepromOrEfuse;
 	u8		efuse_eeprom_data[HWSET_MAX_SIZE_512] __aligned(4);
-- 
2.33.0

