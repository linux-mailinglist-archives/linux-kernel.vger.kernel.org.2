Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A89D339FDC
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 19:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234256AbhCMSbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 13:31:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234010AbhCMSak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 13:30:40 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C527AC061574
        for <linux-kernel@vger.kernel.org>; Sat, 13 Mar 2021 10:30:39 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id u6so23035534oic.2
        for <linux-kernel@vger.kernel.org>; Sat, 13 Mar 2021 10:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=esEtWy9nM436CPDJLtFWuCh5LHQvPlgdcQs641np8Pk=;
        b=XP8on/ZWNaaJyW18QgpGYeaCi+36r7oVSc/pUeP4SS16c3fQ9g4CLgz7m6kT/1scxF
         7FFlmVz7Hd6658q3YgnTkkt1zoILizGjH5dncQGeN69nSv8D1+f70NnEKwVRWsF5afpf
         uyITP3x00bJJ8+DRhuNi/e2MRDtmIJ0H+Reozl4mNoPWqMTTm5Les1HzMuKcmmmIYBIf
         NXmQiUxbRykx8iDt0fdrUIgUbluhNAwq+pKmM+oaghcECM6VtgHXrGSSzs1lFl+qEGCQ
         0XsJNljIEBeE4ncJGmZUEiClHMkpwBPhfHqqX5JcV/MrlpaS05dRLImiuwUZECHAR4/B
         xZQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=esEtWy9nM436CPDJLtFWuCh5LHQvPlgdcQs641np8Pk=;
        b=KU1x7GYiKqidoFOvtuPx/hgBRY5vJtQcmqUlR+aCXgDqjrTIhzgFDV/OxVAX3Ow2QQ
         w60OWR76q7l2AWs5ZksoQRR7azZulzsnDUdz2hGzh0LRxZ5y9MF3IkpCUGCyKJBrBW2b
         NuYmhQNfYG44H7GqmlCzPZJMy/riO8UEb2zAzjL4O49x03cL071pVzAmYh1zP4XLiVte
         hp6TPgkiCUNvIxqlVqBxMNRNiCwDI1ssthXf+aBKc8OfKp5howpAt1P/NOO1OMzFFnl0
         qsPGz+z9M139SYxYMNHjDuTwo7yohr5OWZ+lktrN0edsJu4giBWVajghqvib3wUc2Js6
         /YRg==
X-Gm-Message-State: AOAM531O6XQ+7lSN12gZG3wzDFN/PAHzVuToOoKji7yA6fm1VKQFu27E
        1AYmtbG89ciXqpjo4F8EOto=
X-Google-Smtp-Source: ABdhPJxwZP7d9ngg67hP3VC+8ZmowUd6n5lBgFHup6+OYmKwdCDxbfk+DGSDChlwWie9gQbOycRUpw==
X-Received: by 2002:aca:47c4:: with SMTP id u187mr13814265oia.136.1615660239144;
        Sat, 13 Mar 2021 10:30:39 -0800 (PST)
Received: from madhuleo.lan (cpe-24-27-52-237.austin.res.rr.com. [24.27.52.237])
        by smtp.googlemail.com with ESMTPSA id f192sm2438948oig.48.2021.03.13.10.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Mar 2021 10:30:38 -0800 (PST)
From:   Madhumitha Prabakaran <madhumithabiw@gmail.com>
To:     forest@alittletooquiet.net, gregkh@linuxfoundation.org,
        sbrivio@redhat.com, briana.oursler@gmail.com, rapiz@foxmail.com
Cc:     madhumithabiw@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: vt6655: Fix camelcase
Date:   Sat, 13 Mar 2021 12:30:19 -0600
Message-Id: <20210313183019.368317-1-madhumithabiw@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checkpatch.pl - Avoid CamelCase: <byVT3253InitTab_RFMD>

Signed-off-by: Madhumitha Prabakaran <madhumithabiw@gmail.com>
---
 drivers/staging/vt6655/baseband.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/vt6655/baseband.c b/drivers/staging/vt6655/baseband.c
index 1aa675241599..d89163299172 100644
--- a/drivers/staging/vt6655/baseband.c
+++ b/drivers/staging/vt6655/baseband.c
@@ -52,7 +52,7 @@
 /*---------------------  Static Variables  --------------------------*/
 
 #define CB_VT3253_INIT_FOR_RFMD 446
-static const unsigned char byVT3253InitTab_RFMD[CB_VT3253_INIT_FOR_RFMD][2] = {
+static const unsigned char by_vt3253_init_tab_rfmd[CB_VT3253_INIT_FOR_RFMD][2] = {
 	{0x00, 0x30},
 	{0x01, 0x00},
 	{0x02, 0x00},
@@ -2002,8 +2002,8 @@ bool bb_vt3253_init(struct vnt_private *priv)
 		if (by_local_id <= REV_ID_VT3253_A1) {
 			for (ii = 0; ii < CB_VT3253_INIT_FOR_RFMD; ii++)
 				result &= bb_write_embedded(priv,
-					byVT3253InitTab_RFMD[ii][0],
-					byVT3253InitTab_RFMD[ii][1]);
+					by_vt3253_init_tab_rfmd[ii][0],
+					by_vt3253_init_tab_rfmd[ii][1]);
 
 		} else {
 			for (ii = 0; ii < CB_VT3253B0_INIT_FOR_RFMD; ii++)
-- 
2.25.1

