Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 998333FA6E7
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 19:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234640AbhH1RJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 13:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234570AbhH1RJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 13:09:37 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E00C061756
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 10:08:46 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id u15so5968318wmj.1
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 10:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4vE/Cb1JpypKyZ8g1mn3fwNhnyQED17T1jZXZclaen0=;
        b=nM49oPSgWF18YFAWypKALIlbBPhBuDeFQX7dH6/7z1QEjuc67BmwoFQilAZNUTYLQQ
         OqkWu6GiP1zXBsZYwKOZk4+3ygtblnuzSJlX2xElbW68mAHg+I3MejBDRhmg5IYvLQhn
         u6MoUToSXjevN4unPUIAQHTkBjDG4m8Mylid6tMh3YjeVndNQV7ukR132we1RH7oq3pO
         I6fKEzO3JuHiSzRSpZJqGqMXSbM34NmKB+JvhJHas7SAKpTRonVR2oK8wgauk+38EmQF
         XBeU3O79/vTRaN9MJspRHJtA1NUbAV++JrJom/iYQxtvA3/UFN1cwOcXgqrriEi9LVC9
         2L6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4vE/Cb1JpypKyZ8g1mn3fwNhnyQED17T1jZXZclaen0=;
        b=W74O8kSC0gFI/0FKR9B1DPlac5xZJ+xcg5iIBOLMtr5gmpOzAtrBTbOsnB2dprJrfE
         uXKPpN7qM2j4P2YAfLVcKaEgrW1sFyxoJ4cM5m4wPKvThYnGVLd5E5XxjSLv507V8b1F
         Z/fVjo/gzuCux71SNSVgbWcepx1Aa6nexWavIU1eReb4y+wzK0BDCS+mjLikrRqR8ElS
         P7bPYjdYdXow/7BVY+0My8DfxH5yIzQsxwNUwGvGkSfCUKSUqfDo0QFxDLbd47Kq5MZs
         ge5bld/1OgS00JM7h6hnXmcIbLG56E6fCvEWC5YQYuHuKFEh7udVhI/ZzREP4X6b3qjC
         BtQw==
X-Gm-Message-State: AOAM532NjAW3eYVraQD1GC64YPlHsPfHRLGtObd+d9LUggM+bUP2nW7J
        jYfZQn8oJ5O6XHlEi2eDvbg=
X-Google-Smtp-Source: ABdhPJwVydkeaDGl7YASlJQG4eND6KNdkuHPcjB7feaFFi+aaIvjTnAmBB+uEVJwMBfUHsI8gnnUIg==
X-Received: by 2002:a1c:19c1:: with SMTP id 184mr25408435wmz.98.1630170525567;
        Sat, 28 Aug 2021 10:08:45 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::884b])
        by smtp.gmail.com with ESMTPSA id u10sm10046515wrt.14.2021.08.28.10.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Aug 2021 10:08:45 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/2] staging: r8188eu: remove rtl8188e_PHY_ConfigRFWithHeaderFile()
Date:   Sat, 28 Aug 2021 19:08:33 +0200
Message-Id: <20210828170834.31388-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function rtl8188e_PHY_ConfigRFWithHeaderFile() is not implemented,
remove the declaration from Hal8188EPhyCfg.h.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/include/Hal8188EPhyCfg.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h b/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h
index 4370ec2fa981..d15ff69b8485 100644
--- a/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h
+++ b/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h
@@ -188,8 +188,6 @@ int PHY_RFConfig8188E(struct adapter *adapter);
 /* RF config */
 int rtl8188e_PHY_ConfigRFWithParaFile(struct adapter *adapter, u8 *filename,
 				      enum rf_radio_path rfpath);
-int rtl8188e_PHY_ConfigRFWithHeaderFile(struct adapter *adapter,
-					enum rf_radio_path rfpath);
 
 /* Read initi reg value for tx power setting. */
 void rtl8192c_PHY_GetHWRegOriginalValue(struct adapter *adapter);
-- 
2.32.0

