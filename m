Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33EC336954E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 16:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243010AbhDWPAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 11:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239383AbhDWO7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 10:59:41 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12EFC06138D
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:59:02 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id t14-20020a05600c198eb029012eeb3edfaeso1403608wmq.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AsQ6es43IHoyLDmIOwsDHm5ujGzK3kUKyhDSjmmPsb0=;
        b=TLZnCBa8FQOfcTzeLwaoom49TpkcDPn7oK71lFC+SCA4KnD2JmCyZT+wZOZCf4Zt0Y
         d6wnUPdmRxQ3WCMVpdWnjQR55bg68oDhGU3Yg+g2XIxfpjYEmrIBfcFA86KdblytD9zF
         pFwxEAysfzEdlAfmiKy5bj6+r8FwOdk5BBs0St4uihavO2HbxEjtrNflI6y93a9qxXAN
         jQDbu1qvMtzCUOrK6AAh9MW8L/r1yN6Ft0Aw5Di3bq32rQuBC/nKZ2UyDzUxiiLGD/4K
         JA+pIhfEekO26aUxftPSyu9ejcpHWkMqTpwkKqaFwpAUQAveXB1zrP8Vo7dC0+VAWBXL
         RSzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AsQ6es43IHoyLDmIOwsDHm5ujGzK3kUKyhDSjmmPsb0=;
        b=fiL30mOYKq6nc1R5RNixk6B6mxWVSM4e2AocsWyemQ37KDxr6+ZpvUf3VR/ti3iFGF
         zrAG9qVE1enH6g02i69tPuUZxPrIG8+ep/A8rMxNqeD3xj5ldBCkbgqWcRkOqEF8ePFL
         0MG2fo0dmTE3+FS0pWuR7W+odFvNh3CkBiR0pRXDgSOEGU8colIX4zOS+WN3SoAmv8W+
         uDR7UTMyQ3t0EnErMw8G+T+Crw70dCol7tHvsRxY/jV2bc/1CIsVdrMRN70d+AvqLRn1
         LUkGUY9BxkKgZpCoqJLsz5/DCVGrHBCm9S4C+QSaHTWQ2ggRSwVcw5ACNLsZCWQb03aU
         Wfjw==
X-Gm-Message-State: AOAM5319wVjXkwI24Z0OLEuZTe+DkNGjF5PQMwTVleIrTSLksaE6c784
        D0afr7RHT6NnwH7+qm72VMPWe6pCoko=
X-Google-Smtp-Source: ABdhPJyiqgBMZuaaFjw5zCnf4QP+Drn/gNWpul2inH8qy5oEYaElPQ9kJ6fHNnXqe5SxqXzpd2RJFg==
X-Received: by 2002:a1c:3983:: with SMTP id g125mr6027848wma.163.1619189941517;
        Fri, 23 Apr 2021 07:59:01 -0700 (PDT)
Received: from agape ([5.171.72.99])
        by smtp.gmail.com with ESMTPSA id t63sm8084347wma.20.2021.04.23.07.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 07:59:01 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 12/49] staging: rtl8723bs: remove unused debug macro definitions
Date:   Fri, 23 Apr 2021 16:58:03 +0200
Message-Id: <e69d637471148968af4fa17bb4f805961a0c513b.1619189489.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619189489.git.fabioaiuto83@gmail.com>
References: <cover.1619189489.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused debug macro definitions related to
private log level tracing.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtw_debug.h | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
index acf4deacd3a7..8f56d1e7e644 100644
--- a/drivers/staging/rtl8723bs/include/rtw_debug.h
+++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
@@ -7,18 +7,6 @@
 #ifndef __RTW_DEBUG_H__
 #define __RTW_DEBUG_H__
 
-#define _drv_always_		1
-#define _drv_emerg_			2
-#define _drv_alert_			3
-#define _drv_crit_			4
-#define _drv_err_			5
-#define	_drv_warning_		6
-#define _drv_notice_		7
-#define _drv_info_			8
-#define _drv_dump_			9
-#define	_drv_debug_			10
-
-
 #define _module_rtl871x_xmit_c_		BIT(0)
 #define _module_xmit_osdep_c_		BIT(1)
 #define _module_rtl871x_recv_c_		BIT(2)
-- 
2.20.1

