Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B394236FCA8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 16:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233131AbhD3OpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 10:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233055AbhD3OpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 10:45:10 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83406C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:44:22 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id u3so26942548eja.12
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3tIIreTX1B9CMYOHSzNQF8ZG+/YV3WWYfSInXojnLbE=;
        b=kY2fuWFzZBQPYrKQUvmoawyPfZ8i88hcoDHVmSaEqx9xQK8WaBtIQ2TkUxLeOWayKD
         b67AcQkhOKkhIvABqfdbVxVLHos2bnBtSQbOC7zFTB86+D8X2F2+QVzhnHuTSgomAgue
         aW4f2N+390budIEDSoOua9ce/myMycUpRdpGPlE9HpHX1WoVq2Y+DGg7Acq7WCiefLl3
         P4vPbGOlfztXK214RPiQNLsPLEHdp9vO+ihrz8BtScLZP6wMPqJkDpUsmAV9tvUK5Rha
         wQGOkMCCyavqDjaB0hoSi5gsmJl6L9T8haKN6mBZZgp4SMAe0WsY5Jc0knbl5iEqqsYz
         LIqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3tIIreTX1B9CMYOHSzNQF8ZG+/YV3WWYfSInXojnLbE=;
        b=rGj4RdP1Ctw6BFRhoaPgYt586FSJjwF6sjgefmzMmK/ZfPARKGbv3yMebsBL2Uusqm
         6OpqOzrNQZTm0WINDXcb5INKIcK4ZoH7vlYUsVa7V2jI08+9N/1+1jVdiX+Q0MxymsmA
         0hd/2DhFNz6FsiDtei61QlKdU0yqya78K/zHM/EuW7ZwQeKAL1GMzhSZ5ly5W8fdT0nu
         mzaS/GEzITGaJOHATGV8c0UXC2VJC9di4jj6N74ZXZ5B1WbUnb8YVp4ldCE2GDLVz6yz
         nEqYZLjo2FQJ6Ynq2hzEwP/Z55jwrq0GJV+22GQQw/9xFLhyuesxYVqhqu7LGAtaIgN8
         H1Ew==
X-Gm-Message-State: AOAM5308b3djvjAHqVS06q4bypZYV8WcayLCqUJF8kiO36OPNrlwpzX4
        wD7Eld7lceEHHhNkOMgcWD8=
X-Google-Smtp-Source: ABdhPJx6Mg50k2nUqbrwHIZ9haYq2cUe72jmceQ346gKUj9Y2MfcEeHNWbDM3ywDB9J0DNxLXYl63g==
X-Received: by 2002:a17:906:cd27:: with SMTP id oz39mr1098247ejb.129.1619793861245;
        Fri, 30 Apr 2021 07:44:21 -0700 (PDT)
Received: from agape ([109.52.244.36])
        by smtp.gmail.com with ESMTPSA id rs28sm2047845ejb.35.2021.04.30.07.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 07:44:20 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2 04/43] staging: rtl8723bs: remove empty hal/odm_PathDiv.c source file
Date:   Fri, 30 Apr 2021 16:43:34 +0200
Message-Id: <508498001a7c0665c2b4ff1c09385018e4a72655.1619793405.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619793405.git.fabioaiuto83@gmail.com>
References: <cover.1619793405.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove empty hal/odm_PathDiv.c source file.
remove related target in Makefile.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/Makefile          | 1 -
 drivers/staging/rtl8723bs/hal/odm_PathDiv.c | 9 ---------
 2 files changed, 10 deletions(-)
 delete mode 100644 drivers/staging/rtl8723bs/hal/odm_PathDiv.c

diff --git a/drivers/staging/rtl8723bs/Makefile b/drivers/staging/rtl8723bs/Makefile
index dfe410283ca0..c40983496608 100644
--- a/drivers/staging/rtl8723bs/Makefile
+++ b/drivers/staging/rtl8723bs/Makefile
@@ -35,7 +35,6 @@ r8723bs-y = \
 		hal/odm_EdcaTurboCheck.o \
 		hal/odm_HWConfig.o \
 		hal/odm_NoiseMonitor.o \
-		hal/odm_PathDiv.o \
 		hal/odm_RegConfig8723B.o \
 		hal/odm_RTL8723B.o \
 		hal/rtl8723b_cmd.o \
diff --git a/drivers/staging/rtl8723bs/hal/odm_PathDiv.c b/drivers/staging/rtl8723bs/hal/odm_PathDiv.c
deleted file mode 100644
index 1a2e367bb306..000000000000
--- a/drivers/staging/rtl8723bs/hal/odm_PathDiv.c
+++ /dev/null
@@ -1,9 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/******************************************************************************
- *
- * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
- *
- ******************************************************************************/
-
-#include "odm_precomp.h"
-
-- 
2.20.1

