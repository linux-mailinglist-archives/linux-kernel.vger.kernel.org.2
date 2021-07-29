Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59EAE3DA9BB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 19:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbhG2RJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 13:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbhG2RJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 13:09:48 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43C7C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 10:09:44 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id t128so9384092oig.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 10:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fDH5oDQo3GKNWw3GY2+wBrlJzi+kH97aAK8oF0HRhxs=;
        b=B+Fos1Kk8qq5aAvfvt87/gp+H43Vk0ymXaWpo98mOeMvhg0gfWMI6CD/nd9y+Qv/UQ
         wAurh355WUJkDpE0yGyh1pomLSqUAOORTxeCzrn602sHh1alDRx8fMbSvJ1/qtqhTFlA
         DSDZ/1+86JNiexnkWUMaWXokcXrNwmuua+XwczBZ0PfHHB2s7/odCwKcbsgSY1OjH6KE
         xKMv2sBFYCXcCgJId2XARZFAKfs4hAQWt5PydRsCzVwc1GO7VmLtvPhc5WQ+MjEi22dD
         UkIg3BPOZrD04+93ZaiogDN6lMjf9rpdubLfanwWyPGH8y43OteMa21wy0PQjeG1BjXC
         LaSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=fDH5oDQo3GKNWw3GY2+wBrlJzi+kH97aAK8oF0HRhxs=;
        b=UA1s+ltNzJShIvQEWtEaqVxXTTbP2iScPOS+fsr2eyNG2ak1qjeuKuh90oOv2Rihrl
         Sj3Cch/rP9Z2vVrDQVQaJfd+STkaeHrdZ78j4mzr1mDWpZTroho6vcun4md/CPLZm1mr
         lmDvNkeeEOE1jaPtSc7hW+jRJadxNH+Wd84DzXZXrvOKDXKI04NeXq5aU20nkH8/t3Qy
         5OpTfBUPxLUbOwzr4RtHpIfi5NZkDY6JtHGJabBibLf3bprMJye/CL3g4XmQEs4t4BvE
         yt7o/uFQr/2Qwjkh8nbFjWs5W9mHhXZmIgNMlZTXO0GnbGbN3YCZ/cu+xelxCKbiZYOn
         D5Pw==
X-Gm-Message-State: AOAM5303+87q4q5z9h9dEk3ID8VqIpPVgplQb/cb7ML9RP6KsHIM0L4u
        MN+vgSx1fJGV5z3Ij8l8Jy0=
X-Google-Smtp-Source: ABdhPJx0ju+8BkqwvO2KtTox4u6fKuyCgsUad31tJ1v9zEMvbKOF8yB0pHW5Fjp3GaDYNf5xH2LQvg==
X-Received: by 2002:aca:4e91:: with SMTP id c139mr3785338oib.72.1627578584348;
        Thu, 29 Jul 2021 10:09:44 -0700 (PDT)
Received: from 2603-8090-2005-39b3-0000-0000-0000-100a.res6.spectrum.com.com (2603-8090-2005-39b3-0000-0000-0000-100a.res6.spectrum.com. [2603:8090:2005:39b3::100a])
        by smtp.gmail.com with ESMTPSA id a23sm614358otv.79.2021.07.29.10.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 10:09:43 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     gregkh@linuxfoundation.org
Cc:     phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 1/6] staging: r8188eu: Remove empty header file
Date:   Thu, 29 Jul 2021 12:09:25 -0500
Message-Id: <20210729170930.23171-2-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210729170930.23171-1-Larry.Finger@lwfinger.net>
References: <20210729170930.23171-1-Larry.Finger@lwfinger.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

File include/drv_types_linux.h is empty. Remove it.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
 drivers/staging/r8188eu/include/drv_types.h       | 1 -
 drivers/staging/r8188eu/include/drv_types_linux.h | 7 -------
 2 files changed, 8 deletions(-)
 delete mode 100644 drivers/staging/r8188eu/include/drv_types_linux.h

diff --git a/drivers/staging/r8188eu/include/drv_types.h b/drivers/staging/r8188eu/include/drv_types.h
index dce4c602ffe6..eed807d5dbc2 100644
--- a/drivers/staging/r8188eu/include/drv_types.h
+++ b/drivers/staging/r8188eu/include/drv_types.h
@@ -16,7 +16,6 @@
 
 #include <osdep_service.h>
 #include <wlan_bssdef.h>
-#include <drv_types_linux.h>
 #include <rtw_ht.h>
 #include <rtw_cmd.h>
 #include <rtw_xmit.h>
diff --git a/drivers/staging/r8188eu/include/drv_types_linux.h b/drivers/staging/r8188eu/include/drv_types_linux.h
deleted file mode 100644
index 068a7bcee82f..000000000000
--- a/drivers/staging/r8188eu/include/drv_types_linux.h
+++ /dev/null
@@ -1,7 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
-/* Copyright(c) 2007 - 2011 Realtek Corporation. */
-
-#ifndef __DRV_TYPES_LINUX_H__
-#define __DRV_TYPES_LINUX_H__
-
-#endif
-- 
2.32.0

