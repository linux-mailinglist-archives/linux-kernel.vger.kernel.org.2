Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E078320BED
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 18:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbhBURG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 12:06:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbhBURGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 12:06:54 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EBABC061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Feb 2021 09:06:13 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id m25so2791650wmi.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Feb 2021 09:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SqoxfJrGmgz3BkYUjwDxf/FRTw/eO/VPz2DolP71aQ0=;
        b=W/LCltHTxD0IWeB9P8fMcI7r2dxXK0Vmu1t6PnU0S3GRAx5V4xr3AHMH7YLeBj6rM+
         bxYhFs5mWyROmg2V1pa/jgqU2xaP8Ymtqnejbn+i3IyCprKPCPou2CR9yDx3H7zz/kbI
         3gOQ/ebPGZ0ItGlxh8c6WsUuwn0xIAUg1/8hlBCll9E+FetnHySrtPnXdI3Ndd2rMsmu
         TPOF/heCVD/YTxXaHKlW2m5McnwiyZrRo5KsQ4BgyftGNie0N0nQGQEzluPkMNArbag0
         dfGGren7oyyBGadlMNV1vPbnR2yGwNB2X6IaoWgkeo71mL+9ojkcq1jIEdAlbDlSikAR
         uACA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SqoxfJrGmgz3BkYUjwDxf/FRTw/eO/VPz2DolP71aQ0=;
        b=IhXprsnFnEVwvLoz0MNTAsbMyQz8RXuOs4Ceb5FInz0nU4X9USQ2VDQD+ynqdb3IQw
         eN9DoPkq2Aw4/oyEgqL68aQq15GK+bo4sEDHOp7I8ocuDaCWDFDo5ZY2Qdhog3ZCAdP1
         RXjKuzZ6KEbBHSEPP7d60iv5377E6TDk1GsmKpM11vg0PRnG9kxqbh0cPefSn+5MxnwL
         mqlzbaw0qadr9yMU49JT5pPlWRHwfQcC72zABF6r19hMCsQIOypWPITlKmywMidUUPck
         qgwAh5IWKP2xete9jySBqfnmvmpO0nGo4O47tASchVU1pJA0XZ2mw8uoeBnkk/E1G53q
         jEeA==
X-Gm-Message-State: AOAM532iwPcbYwXQV1rh0AEEVFJZF+yGXwsuKcjpuS50zCW7QO6ukVih
        3BIE57txJtLbb7V2Juq5wp8=
X-Google-Smtp-Source: ABdhPJwpQR5HD0wA70e9uWkv5nB2QHYnJO64OXGLLkMdL18YlSRl1Kjwx6avWB1ZAGgLwaQMEiAgjw==
X-Received: by 2002:a05:600c:4642:: with SMTP id n2mr17350424wmo.49.1613927171548;
        Sun, 21 Feb 2021 09:06:11 -0800 (PST)
Received: from localhost.localdomain ([2a02:587:8026:d57e:9a17:dcb6:4dc6:8083])
        by smtp.googlemail.com with ESMTPSA id q140sm28112340wme.0.2021.02.21.09.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Feb 2021 09:06:11 -0800 (PST)
From:   George Xanthakis <kompiouterakias@gmail.com>
To:     gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
        maco@android.com, joel@joelfernandes.org, christian@brauner.io,
        hridya@google.com, surenb@google.com, viresh.kumar@linaro.org,
        mani@kernel.org, daniel.vetter@ffwll.ch, dbueso@suse.de,
        dianders@chromium.org, loic.poulain@linaro.org,
        daniel.thompson@linaro.org, akpm@linux-foundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: android: Remove filename reference from file
Date:   Sun, 21 Feb 2021 19:05:42 +0200
Message-Id: <20210221170542.45309-1-kompiouterakias@gmail.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit fixes a checkpatch warning that references the filename in
the the file comments.

Signed-off-by: George Xanthakis <kompiouterakias@gmail.com>
---
 drivers/staging/android/uapi/ashmem.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/android/uapi/ashmem.h b/drivers/staging/android/uapi/ashmem.h
index 5442e0019..134efacb3 100644
--- a/drivers/staging/android/uapi/ashmem.h
+++ b/drivers/staging/android/uapi/ashmem.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 OR Apache-2.0 */
 /*
- * drivers/staging/android/uapi/ashmem.h
- *
  * Copyright 2008 Google Inc.
  * Author: Robert Love
  */
-- 
2.30.1

