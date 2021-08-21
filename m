Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB553F3A51
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 12:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234015AbhHUK47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 06:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbhHUK45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 06:56:57 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32065C061575
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 03:56:18 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id u16so17990362wrn.5
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 03:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f8308s6LzNzwxOqQwJQBOWsN8iyKJJAOplsgCOJjsWo=;
        b=lEw5huwNwg814rRpxPoc6pPmJPScyh50FIR+/CmNlAcmamXnTyaIApzjV5ygCDRYpK
         UkA8PBQPSj6UuFZwCourYxMc/2AEmk2AVAzzU4kJoSfhOgRBBi5DAVioA2Dz6fWi+a7T
         /O1dPhyKnyk7lfNNj5yAERrCwiMv9/+A3y8xuF/HJHsUDUt7fiBBkDp7aiDPOEbeGC8T
         QNcTGXvgdYauywqC0CxoKesKT+H5AwdyA9Ykz0lYOuY2VHQo3zNE/l06JOTyhaCGWKtV
         ckU3mmcc/yrDrnT/AUIq+sSQv0Viw70GcUiIwPEDa9XdA4e/rqKVbZO9mM6HAVc3nTVb
         Hbuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f8308s6LzNzwxOqQwJQBOWsN8iyKJJAOplsgCOJjsWo=;
        b=Y8cFjso3Tfb5Zo1pwJ6A28P7YMTgM/+G9fsn+rP77JHkxOxBsPUrY/d+unqjlZT3q3
         tHRbgF206qvAyQ8GMIww/6UNW/UKOPyw9SHhDwPM6K5X4GCvORyGe1iQTiHmnara7YE/
         xbqpsWeOsO3u6YRBhS2ZWhH0F9YjGNjywTQrLrWiVui+rcvV3ee7iRuYg6+dyTVlXKAM
         Zcp/aQhVfZdowhNV+7q42jGdR3PWkQ8r+Qq0rJxXM+2/cYUoEwrdSRHZim5MYzBbrFHd
         o/M8HcE18p30PwjbR3cMRrdIwf3RHiLsxz9KE7ct2V8vo4JxmBX7IaDuJuK/DVwaeTCe
         EQYw==
X-Gm-Message-State: AOAM532hzOc5yJ7sK2fTc2nlf6YvOblAfTMmNLI4SzlrS8Q8NCMAnfqQ
        6uomynKetG0QyzCV8PcJM0350DB50XrxFjdK
X-Google-Smtp-Source: ABdhPJzna+c9+x4htAGBrT5mumu6CIlLz5PfTkQMTHR4+dHYFRX+yiZBkpB2McR3aZBohfbE9Ua53w==
X-Received: by 2002:adf:e5c7:: with SMTP id a7mr3405087wrn.312.1629543376806;
        Sat, 21 Aug 2021 03:56:16 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id z126sm8012969wmc.11.2021.08.21.03.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Aug 2021 03:56:16 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        martin@kaiser.cx, straube.linux@gmail.com,
        Larry.Finger@lwfinger.net, fmdefrancesco@gmail.com
Subject: [PATCH v2] staging: r8188eu: change declaration of Efuse_Read1ByteFromFakeContent
Date:   Sat, 21 Aug 2021 11:56:15 +0100
Message-Id: <20210821105615.6307-1-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove forward declaration of Efuse_Read1ByteFromFakeContent function
from core/rtw_efuse.c, as the function is defined in full directly
after this and therefore this forward declaration is redundant.

In addition, convert the storage class of the function to static, as the
function is only used with rtw_efuse.c, and tidy up the signature
alignment.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---

V1: Removed forward declaration.
V2: Takes account of feedback from Michael Straube and Fabio M. De
    Francesco to make storage class of the function static.

---
 drivers/staging/r8188eu/core/rtw_efuse.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_efuse.c b/drivers/staging/r8188eu/core/rtw_efuse.c
index decccf7622f0..c1c70648f5bc 100644
--- a/drivers/staging/r8188eu/core/rtw_efuse.c
+++ b/drivers/staging/r8188eu/core/rtw_efuse.c
@@ -29,17 +29,9 @@ u8 fakeBTEfuseModifiedMap[EFUSE_BT_MAX_MAP_LEN] = {0};
 #define REG_EFUSE_CTRL		0x0030
 #define EFUSE_CTRL			REG_EFUSE_CTRL		/*  E-Fuse Control. */
 /*  */
-
-bool
-Efuse_Read1ByteFromFakeContent(
-			struct adapter *pAdapter,
-			u16 Offset,
-		u8 *Value);
-bool
-Efuse_Read1ByteFromFakeContent(
-			struct adapter *pAdapter,
-			u16 Offset,
-		u8 *Value)
+static bool Efuse_Read1ByteFromFakeContent(struct adapter *pAdapter,
+					   u16 Offset,
+					   u8 *Value)
 {
 	if (Offset >= EFUSE_MAX_HW_SIZE)
 		return false;
-- 
2.31.1

