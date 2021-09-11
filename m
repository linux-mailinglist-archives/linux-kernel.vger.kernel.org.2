Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA464407AC3
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Sep 2021 01:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234359AbhIKXUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 19:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbhIKXUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 19:20:10 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F18C061574
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 16:18:57 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id d6so8344090wrc.11
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 16:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gobYDgJ5gtvy9NhVq54xUT6ydjiqWzLgDvmpT5ugARU=;
        b=i33G7BcllSTev6kLlnGGtljMuU6DdrQHwDIARW+sekmAI89dE8OtHx0uJdaL6rEO0j
         y1JLQMZKvjNMk1lu/dlmx1h8pDRGacYEQXuCiE+AXY1EUnsleUKGb9uTQNoOfnbIhFyD
         LO/gnvJI/teS3KyKqzMlH0kOH1+ZIxZKN3ePiPIGgjm0tXrOk2Yra2001qLWB9G8h0tK
         TGU8SkLZYrWx7ahv5R0rx2H826qpHW9WCT4CH1kMUlBDJQqlsEuKzkXv1YOoW287ZnWt
         u85bTR2xHEs5TWYjjdQ/5Tp5hgo/GT7jydtS56wB+8v9jQgBDKK7rkYFkzZxsMRpWQN9
         HYUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gobYDgJ5gtvy9NhVq54xUT6ydjiqWzLgDvmpT5ugARU=;
        b=j0ENjM1MCX553TNidg467nsdd2gxYsE9xF0p1qfK6Y1G3Fmm7UOhsCetqW4KRKbHqf
         gWKrYzAVWmeGa+gUuODd2f5LqCcOnqBI8l4n2KZa1zAD5U5ohGnnPwThC58rPj/ZG1SC
         6m//XjJvnuosUqph0stnxV7oeZEbGC28Q2EEgJ13o3C8ybLnFuGHEdKU7SQYab+lFngl
         /76Om049KPJvz/g0j2pAwggEJ+FgzFO1meCgLOOxjF4xtj0vFo83rh5riTHVdsvq90QC
         cljuOnXDyBa0MIFDGdrwg3nlOhkWQ/+i46ZANnEtaCEOhvgWZtU5qKsdzVY6S+moI6cU
         qGhg==
X-Gm-Message-State: AOAM533hVKFu4mh/ZYHGxJm4DcehRd6JGpcV4lLVerdKcuKYXH40Jh2W
        aGnKBz4TFGqmrhJtD976lQ0jMvZJOBLaiA==
X-Google-Smtp-Source: ABdhPJwhfjgSMEGU+ilWQw4IlJtDT66qcmWiuFtwKzNnreFEa8KHU1cU4FTGN6uednaZt72on3UFYg==
X-Received: by 2002:adf:f208:: with SMTP id p8mr4828820wro.379.1631402335475;
        Sat, 11 Sep 2021 16:18:55 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::1db2])
        by smtp.gmail.com with ESMTPSA id j17sm2852762wrh.67.2021.09.11.16.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 16:18:54 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: r8188eu: remove header file HalHWImg8188E_FW.h
Date:   Sun, 12 Sep 2021 01:18:44 +0200
Message-Id: <20210911231844.16268-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The header file HalHWImg8188E_FW.h is not used in the driver.
Remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 .../staging/r8188eu/include/HalHWImg8188E_FW.h   | 16 ----------------
 1 file changed, 16 deletions(-)
 delete mode 100644 drivers/staging/r8188eu/include/HalHWImg8188E_FW.h

diff --git a/drivers/staging/r8188eu/include/HalHWImg8188E_FW.h b/drivers/staging/r8188eu/include/HalHWImg8188E_FW.h
deleted file mode 100644
index 5ddcd283097b..000000000000
--- a/drivers/staging/r8188eu/include/HalHWImg8188E_FW.h
+++ /dev/null
@@ -1,16 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
-/* Copyright(c) 2007 - 2011 Realtek Corporation. */
-
-#ifndef __INC_FW_8188E_HW_IMG_H
-#define __INC_FW_8188E_HW_IMG_H
-
-/******************************************************************************
-*                           FW_AP.TXT
-******************************************************************************/
-/******************************************************************************
-*                           FW_WoWLAN.TXT
-******************************************************************************/
-#define ArrayLength_8188E_FW_WoWLAN 15764
-extern const u8 Array_8188E_FW_WoWLAN[ArrayLength_8188E_FW_WoWLAN];
-
-#endif
-- 
2.33.0

