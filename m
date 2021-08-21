Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCE63F377D
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 02:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240871AbhHUAF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 20:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239600AbhHUAFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 20:05:52 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8094C0613D9
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 17:05:12 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id x10so16433715wrt.8
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 17:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CPPKZTwnH+W0mWx2lzjsDYZFP7mzeq1SizrimQ09eEQ=;
        b=LaPIB1U0uB3MYYiCnj4wHaK+WqyPja6yHp6fdwrbWxBi99AFiZCHUuU/URcCI4P98i
         GFmz5qbyduaRVCX2qdt2vLZtHE+rGf53gr5sD/xnQio4xVHfVq4ZSzzdAgq0hLvQJxeU
         X4C1o0B8JchjWct/rtAhFil+DMALf7h8+gjw+x42n/X3eBhk125NtqmZ+E2ksJP0LtmL
         ZI62Dk7Ym1AV4PU4kOguVGoAMXCz78v3DV6dQjeGFcD2gI1cVwpg90e1nQcLxYFYyhRJ
         9Xk4jaKnNMPshhAHyeYCjidGPR67y6NfRntykQnyiqiPCDLCJsGfKG1i1JWLhjaIHaAe
         CxDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CPPKZTwnH+W0mWx2lzjsDYZFP7mzeq1SizrimQ09eEQ=;
        b=I15Paz0wqhuac8KFytfsqFM9DLofDrRcP4jP6vOe/ymL8G1wAJ3SlQ4AVpBLfp1LyW
         QuE9ziqPHe5djgcAbb47zIHXqZOSqVHsPP03/x0WjK/EdJC17hsASYgbEOIUtvlTPjUr
         CeUEdnZQzDWYnD6nCorCORUDqORSGqbo6QliAaXcIoanMgcZtg26a6AAQ3AaGCPCIOug
         /6W1xCydUnOwv4SBvQiGBhyJ1fKgCHs/GqMqIoCHL0qW+Cb/Gt6YUO8Wt8n5Ug3l87UR
         BFmRFtiEoXquGU0M7nEebj5sJxl0DZF2jwKV3ommMnlSsLSsu4oYwsDf4HNbo40eTFH5
         hIIg==
X-Gm-Message-State: AOAM532NvAZBxQY1RWCw6Hrw8bd7XQm0I8rRGGGPOt97Dm7tLV6Wu71q
        j1GOx00zHOc/6tejsUiiGpsUIr21kweb7Al3
X-Google-Smtp-Source: ABdhPJye52P8cdV2I3vBEArHJV9VVKWoUAzIZGe5rSHkbvepwySVadWk1l6lQxgq7O25ZT9eOqUmJw==
X-Received: by 2002:a05:6000:1043:: with SMTP id c3mr1277776wrx.144.1629504310131;
        Fri, 20 Aug 2021 17:05:10 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id l2sm6404010wme.28.2021.08.20.17.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 17:05:09 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        martin@kaiser.cx, straube.linux@gmail.com,
        Larry.Finger@lwfinger.net
Subject: [PATCH] staging: r8188eu: remove forward declaration of Efuse_Read1ByteFromFakeContent
Date:   Sat, 21 Aug 2021 01:05:08 +0100
Message-Id: <20210821000508.79422-1-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove forward declaration of Efuse_Read1ByteFromFakeContent function
from core/rtw_efuse.c, as the function is defined in full directly
after this and therefore this forward declaration is redundant.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/core/rtw_efuse.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_efuse.c b/drivers/staging/r8188eu/core/rtw_efuse.c
index decccf7622f0..45b757ab64e1 100644
--- a/drivers/staging/r8188eu/core/rtw_efuse.c
+++ b/drivers/staging/r8188eu/core/rtw_efuse.c
@@ -29,12 +29,6 @@ u8 fakeBTEfuseModifiedMap[EFUSE_BT_MAX_MAP_LEN] = {0};
 #define REG_EFUSE_CTRL		0x0030
 #define EFUSE_CTRL			REG_EFUSE_CTRL		/*  E-Fuse Control. */
 /*  */
-
-bool
-Efuse_Read1ByteFromFakeContent(
-			struct adapter *pAdapter,
-			u16 Offset,
-		u8 *Value);
 bool
 Efuse_Read1ByteFromFakeContent(
 			struct adapter *pAdapter,
-- 
2.31.1

