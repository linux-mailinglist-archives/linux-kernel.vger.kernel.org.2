Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2433738DC2D
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 19:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbhEWR2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 13:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231831AbhEWR2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 13:28:44 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2BB2C061574
        for <linux-kernel@vger.kernel.org>; Sun, 23 May 2021 10:27:16 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id f18so7897952ejq.10
        for <linux-kernel@vger.kernel.org>; Sun, 23 May 2021 10:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2Ikx3Ey9eOOYgtxMhcsC4m4OpTqa4FgIx6H9D0TqkdY=;
        b=AEoDORobWuTNWflTFSIYDu2EfSJB0iclnL5RlmGaMrRD2WqJFzP7yByNk1sCZgHunM
         c4oohLU9mXf365+baLadGsme7aO0M5REZeSB3yFCQqs19aohcPNknNxfF/JhjtcTmVMw
         QVi8EG8GpI9eNdTv+poloyQuZU2QqsdbPgKh0Mcms+0kfeLtHKuzdhb1tENAsugvp5SN
         OWAjhhcCdAc/IqCZ6otK/OZpoQxq78gFpqliFQptmtLZAtayYnXYtNopwQn1aeNJwPIv
         KMZohZd2rCA8l5N88Im3zlAuQiX2VyIvmZThDmKRzJ2utt8RKPirpkp1hDM/+U7E3SNY
         ze4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2Ikx3Ey9eOOYgtxMhcsC4m4OpTqa4FgIx6H9D0TqkdY=;
        b=HxIPea1t5xQPKdQstpeLYHP7GLKExvp9wA9/lGiDbdM12Xj/55SjsOcoHFPMjxo8Qw
         MBz5Fr45SY++LS8mYrYCJngWlJyt25P3LVzc62HVsWd4fflFhdx9UJrsNFjYy0YUxirG
         NAf5TThdYaNyK3/aHNVRu6EII3MNpK1MpU6yv1dzRDtNGDnUHDFXNfeimS9drdc6p38D
         1lkNv1CtqL30cOUYyhhIn4b1aRLg7UWTgYgYjBCyd9LKhyb2BOY/TA6wBBuphA8OOBTQ
         gUXyKtfJjRoWp0/+F7kE1O2OXw7kYCFuuxbTCFC/sn/0/UcYtf+mxoDTXqMy9Wuavs33
         dwUQ==
X-Gm-Message-State: AOAM533/gz1dD0rPyKV18nsuzDtcPgeznUKh6B8s1PMuVE5Nkz/nE88f
        cPxduTMksJU5M+yPyauyET8=
X-Google-Smtp-Source: ABdhPJyru8rs7+K4wve5Rz1o0cgb6xcJdRhpMnKGHlQegwjz+Pqd8ruOrMFZnZlSAlb10Fk2ZzgP0w==
X-Received: by 2002:a17:907:1b02:: with SMTP id mp2mr19053359ejc.196.1621790834735;
        Sun, 23 May 2021 10:27:14 -0700 (PDT)
Received: from linux.local (host-79-52-107-152.retail.telecomitalia.it. [79.52.107.152])
        by smtp.gmail.com with ESMTPSA id q18sm7904186edd.3.2021.05.23.10.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 May 2021 10:27:14 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH] staging: hikey9xx: Remove defined but unused macros
Date:   Sun, 23 May 2021 19:27:09 +0200
Message-Id: <20210523172709.19181-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed defined but unused macros. Issue detected by GCC running with
-Wunused-macro warning option set.

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/hikey9xx/hisi-spmi-controller.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/staging/hikey9xx/hisi-spmi-controller.c b/drivers/staging/hikey9xx/hisi-spmi-controller.c
index 0d42bc65f39b..b64594e2a84b 100644
--- a/drivers/staging/hikey9xx/hisi-spmi-controller.c
+++ b/drivers/staging/hikey9xx/hisi-spmi-controller.c
@@ -21,16 +21,10 @@
 #define SPMI_APB_SPMI_CMD_BASE_ADDR			0x0100
 
 #define SPMI_APB_SPMI_WDATA0_BASE_ADDR			0x0104
-#define SPMI_APB_SPMI_WDATA1_BASE_ADDR			0x0108
-#define SPMI_APB_SPMI_WDATA2_BASE_ADDR			0x010c
-#define SPMI_APB_SPMI_WDATA3_BASE_ADDR			0x0110
 
 #define SPMI_APB_SPMI_STATUS_BASE_ADDR			0x0200
 
 #define SPMI_APB_SPMI_RDATA0_BASE_ADDR			0x0204
-#define SPMI_APB_SPMI_RDATA1_BASE_ADDR			0x0208
-#define SPMI_APB_SPMI_RDATA2_BASE_ADDR			0x020c
-#define SPMI_APB_SPMI_RDATA3_BASE_ADDR			0x0210
 
 #define SPMI_PER_DATAREG_BYTE				4
 /*
@@ -64,9 +58,6 @@ enum spmi_controller_cmd_op_code {
 #define SPMI_APB_TRANS_DONE			BIT(0)
 #define SPMI_APB_TRANS_FAIL			BIT(2)
 
-/* Command register fields */
-#define SPMI_CONTROLLER_CMD_MAX_BYTE_COUNT	16
-
 /* Maximum number of support PMIC peripherals */
 #define SPMI_CONTROLLER_TIMEOUT_US		1000
 #define SPMI_CONTROLLER_MAX_TRANS_BYTES		16
-- 
2.31.1

