Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7820435AE22
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 16:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234918AbhDJOVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 10:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234856AbhDJOVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 10:21:08 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B4CC06138D
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 07:20:53 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id e7so9770755edu.10
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 07:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UkQtWRgOp5+rpWKYZKP/ej9vGIRx+ajVCa42c5pIqgY=;
        b=ZHklPETEvXI1Degrc/Q1ml9pwO+qabqvb28Lcx4xGcVNLFzSEyTUihGYIb1kVYh1uW
         UVtVRoVMIZfNIoqyk59z8fuQDIcD1IDuMzHQ/qhzUBhXWxSa8YIOAADMtiAPbZeHlQjK
         5ugFxvxVfr3+tq40WGbF2LxVsCgtHXYBuIhf9MVwP/4vswY7doBercN2yz6pZVqdk8Ej
         xjzcaIE3ukd/+iwLlMU3ND75gIQIJ6tYftvRo7A50MqSA2cCgvTMV/KeqGdRQO44vm6k
         JKQapx4VVqyFBd464hYIlvg9VuGeZQVZZWPpwS5Te+88BymVbGyWvvNmzz65m1X0yq/r
         ZbIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UkQtWRgOp5+rpWKYZKP/ej9vGIRx+ajVCa42c5pIqgY=;
        b=IHSWppIyzuTLpD1EatGlKUnk21/YLtQiKI+1YZ8H3BT3Pt9nRx7VAcxu1LPB6B7SU7
         EV7+69Byx8GoLo6id1LpLRtRUr58YSYkyxdKTN7+AHy8wex7GKnEP2vwt86kcBWIn4LE
         jba94MNtqzdHNyGSaIBH5TOl6nxhOOfvh32swQJOE/gPRkOZGIaQAFDbMu4K3cta1ScP
         2DoqjNlQuaLzWUAb9L+FLlTVfaoDoIWp62KW0qd/kPjJP5G/YXx5siWYKgXOAhz8R2TJ
         b6z7gzgUW2fUstCfSvJIkKOier/OqMLQRrZ9TgAB9Zu0ybx4YYHlxXZDe/pQqMIQsu6j
         2byA==
X-Gm-Message-State: AOAM530Be27B5GtavKzToWE+a/ZjzNsxHIi8xz9BvwAPqARMcSoXZNE1
        g036ms1n2OQSwFyccoRofvlQ7hl2JK5prg==
X-Google-Smtp-Source: ABdhPJwEApXEfATwu6xQYj366aMM8/dP8gzUZqS2lYR0uEqz3+wun+zSQ4cOtwbtj9kL5MHFrvRtHw==
X-Received: by 2002:aa7:dac5:: with SMTP id x5mr13172759eds.286.1618064451929;
        Sat, 10 Apr 2021 07:20:51 -0700 (PDT)
Received: from agape ([5.171.81.28])
        by smtp.gmail.com with ESMTPSA id c16sm2755011ejx.81.2021.04.10.07.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Apr 2021 07:20:51 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 07/25] staging: rtl8723bs: remove commented out DEBUG_RTL871X definition
Date:   Sat, 10 Apr 2021 16:20:20 +0200
Message-Id: <9d04ab2b645e242e35d31abbb1a301e2ad8c4401.1618064274.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1618064274.git.fabioaiuto83@gmail.com>
References: <cover.1618064274.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove commented out DEBUG_RTL871X definition

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/autoconf.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/include/autoconf.h b/drivers/staging/rtl8723bs/include/autoconf.h
index 996198750814..222297a937ab 100644
--- a/drivers/staging/rtl8723bs/include/autoconf.h
+++ b/drivers/staging/rtl8723bs/include/autoconf.h
@@ -48,7 +48,6 @@
 
 #ifdef DEBUG
 #define DBG	1	/*  for ODM & BTCOEX debug */
-/*#define DEBUG_RTL871X */
 #else /*  !DEBUG */
 #define DBG	0	/*  for ODM & BTCOEX debug */
 #endif /*  !DEBUG */
-- 
2.20.1

