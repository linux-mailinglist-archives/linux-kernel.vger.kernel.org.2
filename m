Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9253B324E51
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 11:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234964AbhBYKcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 05:32:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbhBYKEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 05:04:51 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A413CC061574
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 02:04:10 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id c6so6109359ede.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 02:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=frJ+WzF1K1wG/yxdonqGNnv/EoSLYxyDv9oAC401akQ=;
        b=slA0VDZIniRrGjVJ0k6Dqb9Dm0qtlTkyMFUR3LrPJdAgI8YABddEG5lPY/GaNhM2OQ
         rR0xjB2dx0MbRAAWmehoL/46OyLxkLmFPJOqTWdckiR10S2dMzgPfxCWDt6sT96No9PK
         ZNwLh44wh5LW4EYzK9bZ9jv0xV84qIOcwH/WsSm0u+08qg6uxuY5T7GZ+iz9bs0b4sji
         lBNmLmnGiCyvbLtwzOBQUh4V/HLJcc0tr5ezUaKApemybWqPa9dKfC1NDzZw0OFedYfR
         a7gPLMlH7NxPyWZHdO/zv8vTaqIr4BrQqbqiTdiYzCXxcGrlOlbGFgLNf++heac1bMeq
         /5Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=frJ+WzF1K1wG/yxdonqGNnv/EoSLYxyDv9oAC401akQ=;
        b=Tt4k6KngQt1jOQowbBKklyZGeylKOf7IfFDTti0cwMb6Lvoyb7txUv3nMlI55KxGOZ
         VmsLTFGeup7ndQhM60eISI5WYfnx/EHPBycjstsvjNyztG7oolmebQxSkSa3g2AmF0ss
         xkDyMyiR/FdI/gtUqe840fOpocuUSuoeIjvwdVW80S5exkBPZ5eewuyhud3ahDhGYNg5
         kixqVpBq6JR1KnT8HAezJGeJzDmAHEFp4nHEkhPkW0Yk6iTu+DwepUIeXTSKhLsPUH1+
         OhPekgpIR6SOigNjn/hoSTt50eykB2t1+7psl3S77vhUdKULgLd7ToSJt+kOv3SUPT9g
         VsKg==
X-Gm-Message-State: AOAM530yddQXd1fomq64f5QJaayCaisFigTxrmu5zlGlcgNY0yWd9DgJ
        OkUqcwFoarnlFOFhBEDyq+ac2k8b+g/ftP7r
X-Google-Smtp-Source: ABdhPJwI3ZfJ/u0ynttp+nqwCvgC8NQrVCW5DuPTeCY818h+x5DO3jMpq5ap2PmfutUh/rRLoz2lFQ==
X-Received: by 2002:a05:6402:ce:: with SMTP id i14mr2070306edu.42.1614247449309;
        Thu, 25 Feb 2021 02:04:09 -0800 (PST)
Received: from ubuntudesktop.lan (205.158.32.217.dyn.plus.net. [217.32.158.205])
        by smtp.gmail.com with ESMTPSA id l6sm3298111edn.82.2021.02.25.02.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 02:04:08 -0800 (PST)
From:   Lee Gibson <leegib@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     straube.linux@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Lee Gibson <leegib@gmail.com>
Subject: [PATCH] staging: rtl8192u: minor coding style fix
Date:   Thu, 25 Feb 2021 10:03:51 +0000
Message-Id: <20210225100351.12199-1-leegib@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes this checkpatch warning
WARNING: Comparisons should place the constant on the right side of the test

Signed-off-by: Lee Gibson <leegib@gmail.com>
---
 drivers/staging/rtl8192u/r8192U_wx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192u/r8192U_wx.c b/drivers/staging/rtl8192u/r8192U_wx.c
index d853586705fc..175bb8b15389 100644
--- a/drivers/staging/rtl8192u/r8192U_wx.c
+++ b/drivers/staging/rtl8192u/r8192U_wx.c
@@ -726,7 +726,7 @@ static int r8192_wx_set_enc_ext(struct net_device *dev,
 			idx--;
 		group = ext->ext_flags & IW_ENCODE_EXT_GROUP_KEY;
 
-		if ((!group) || (IW_MODE_ADHOC == ieee->iw_mode) || (alg ==  KEY_TYPE_WEP40)) {
+		if ((!group) || (ieee->iw_mode == IW_MODE_ADHOC) || (alg ==  KEY_TYPE_WEP40)) {
 			if ((ext->key_len == 13) && (alg == KEY_TYPE_WEP40))
 				alg = KEY_TYPE_WEP104;
 			ieee->pairwise_key_type = alg;
-- 
2.25.1

