Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14AC73124D2
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 15:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbhBGOsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 09:48:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhBGOst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 09:48:49 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1625DC06174A
        for <linux-kernel@vger.kernel.org>; Sun,  7 Feb 2021 06:48:09 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 190so10354931wmz.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Feb 2021 06:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U+FD4FX1W6U2mWTuvI4YJ635kqsngjRjhMWM6RDCGfA=;
        b=AECeStMnc4+w96Ilr4WY6VqwAL2P4HRo4cUt0DESevLEYIhDDNkBfSniM/3y/4Uo2Y
         bChGzp3f4vOV1p4vJ0d5TbBGwvXnNSTASbQYda66AK2zsLyDnI8qtF0AQG4oFF9Th2N5
         5WHD09gLTQt7dTZRSvXYLaT5u3vz0/pMbECdcUYNcFSqMR/dzFb/WzuiIy+1NvtLIrfL
         v4Sve+eF0wqJYGOVoi7RDCYSeTxM8oWQiCjrh26fu3jLprOnIG2FzAcoHzf54fG0Lrz1
         pePfhjEyU4iyfoq78IwmVwNc1h9SZx3ZmUehwiVu6hQRBiiqNOT6+FkJ34aXpYmxM7Ha
         gukA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U+FD4FX1W6U2mWTuvI4YJ635kqsngjRjhMWM6RDCGfA=;
        b=ueO3wFq1i3dSzdudqQypX3iJQR+BC60AzYpFQbITc5hLWjEpKZN27bFV4NVX/yYN5H
         kTKLRmq1hf0/Np/cTn6sZMVVSq3B8gmW+Ltkk19ss+8s0wnX1fXSJUVFyl6Q+4ynU1a8
         4N0VGhdMcRaTmcwrqJDMfL2sP32Yg/x4sSQrw+nNGZ2UOdtCcoDGXGZLmOvqdGYWSpmt
         vun3lj01IHEZD1UO1PVi6arshLOjbPfXfCWu7daNsdYsxPiDlT4L6Ik43dSdleVQP2CK
         k93RfclvSTGFecjE3Ag83fO5YsIUWNb3rPfh1HKq4VD4MKhZBfwSbUOKDYK2m3d+sPVR
         3d2A==
X-Gm-Message-State: AOAM532zzDYLtqdYn2wFpcd07a1YPNDWDiCfU+65B1sqGkJEVQmDnujM
        63uK2/6P33Ayg2HvNzQHnEDRnw==
X-Google-Smtp-Source: ABdhPJwlfr8M4W6SCuEjqXkYxolOOvi+szVjPfeMJ08gbEUvM9Uo19BSqfM2i4Uhet5G1C42HsixIw==
X-Received: by 2002:a1c:e402:: with SMTP id b2mr11359221wmh.122.1612709287404;
        Sun, 07 Feb 2021 06:48:07 -0800 (PST)
Received: from localhost.localdomain (2.0.5.1.1.6.3.8.5.c.c.3.f.b.d.3.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16:0:3dbf:3cc5:8361:1502])
        by smtp.gmail.com with ESMTPSA id n10sm22600578wro.39.2021.02.07.06.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Feb 2021 06:48:06 -0800 (PST)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     alexander.sverdlin@nokia.com, andrew@lunn.ch, davem@davemloft.net,
        chris.packham@alliedtelesis.co.nz, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: octeon: convert all uses of strlcpy to strscpy in ethernet-mdio.c
Date:   Sun,  7 Feb 2021 14:48:04 +0000
Message-Id: <20210207144804.88330-1-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert three calls to strlcpy inside the cvm_oct_get_drvinfo function
to strscpy calls. Fixes a style warning.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/octeon/ethernet-mdio.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/octeon/ethernet-mdio.c b/drivers/staging/octeon/ethernet-mdio.c
index b0fd083a5bf2..b3049108edc4 100644
--- a/drivers/staging/octeon/ethernet-mdio.c
+++ b/drivers/staging/octeon/ethernet-mdio.c
@@ -21,9 +21,9 @@
 static void cvm_oct_get_drvinfo(struct net_device *dev,
 				struct ethtool_drvinfo *info)
 {
-	strlcpy(info->driver, KBUILD_MODNAME, sizeof(info->driver));
-	strlcpy(info->version, UTS_RELEASE, sizeof(info->version));
-	strlcpy(info->bus_info, "Builtin", sizeof(info->bus_info));
+	strscpy(info->driver, KBUILD_MODNAME, sizeof(info->driver));
+	strscpy(info->version, UTS_RELEASE, sizeof(info->version));
+	strscpy(info->bus_info, "Builtin", sizeof(info->bus_info));
 }
 
 static int cvm_oct_nway_reset(struct net_device *dev)
-- 
2.29.2

