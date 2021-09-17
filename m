Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD0A40F5B9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 12:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242253AbhIQKRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 06:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242138AbhIQKRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 06:17:33 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1DEC061574;
        Fri, 17 Sep 2021 03:16:12 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id 203so916510pfy.13;
        Fri, 17 Sep 2021 03:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BALrngyLohinwTd6UGWDU0YYIg7HJpZLXZVlrE0q2aE=;
        b=SP6oLp6m+1mMV4KznWY5Uly4XE+0jFnlyIl11iHolBLBskFB/Bk+0Ni7DB8AZvZ1aF
         PEfN3URwo1XOLOHM02mBwLDXtEav2FUAsTmfT7cDMEuSiLVY+XyzEDFGOBcVL1IMZkAj
         yOTsCvTiTFRucgn63mJlr9A9BX4KyMSa4DwWx+L6dk8gcxTbZc6giA3UljkTXTP/+K0C
         LCwwQE126Gdmp7h/0EXbc2lPEuxDD2yxmevaodNhlgcE3TW9X8SBhwbBBtA6mZ4aE7yS
         zPZrW1IRbD3YsU4971TiiOgLIRN5LRvbZFoCk/xAJhNK2VYLHfGgMZGL+bOj+rZXb1b7
         6jOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BALrngyLohinwTd6UGWDU0YYIg7HJpZLXZVlrE0q2aE=;
        b=6YkWMtFG5vwF6otfzX7WZpSEfPSCREswfomToKHaMu6U54yBkJ3+lKuqsczG0MXAt3
         FfCDOxuBuShz5nUlWQ6D0V3ougLbk6lkyC/CDXwbOo5aAYCZMj3xEU3A8b0vrj6ZsBkb
         Czd2eSdp8uCBUhgEsdWnT2o/ePko30uNl8jxdFQ5EcP7HkTct0hAbAxKt5W9LRZhxOV/
         sO/W+Fn5a8xWD6keE1s5KF0Sz+cwnA5DgOlLP9hlQYLoRrvaGpjfioMnqPpuwSDcXRqr
         ltdn6Xf3Ntjcmanjb1fZnLjlRN3wXoPsxrfo4zndiQfpUlTWz/Od757h7jeIYgnEAo5A
         Dsog==
X-Gm-Message-State: AOAM533ZTdZhgZw8tDLwlpx11m8Kot/Vth3/45oexuQkoGYnRJQMFwpr
        SiA6IEppkrnCy3D4/KfkmKNM1EyxcT9jwA==
X-Google-Smtp-Source: ABdhPJwNKs038ZOgumCB5+FTmqTfb6iPk4s7U1dX5mVKeUb2CJF9TJP8sKr/xu6aIovi6RKhyvacVA==
X-Received: by 2002:a05:6a00:d60:b0:43d:f987:66be with SMTP id n32-20020a056a000d6000b0043df98766bemr9845570pfv.37.1631873771373;
        Fri, 17 Sep 2021 03:16:11 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:6005:10e3:be44:5d8a:6628:bf13])
        by smtp.googlemail.com with ESMTPSA id x128sm4388080pfd.203.2021.09.17.03.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 03:16:10 -0700 (PDT)
From:   Utkarsh Verma <utkarshverma294@gmail.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Joe Perches <joe@perches.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Utkarsh Verma <utkarshverma294@gmail.com>
Subject: [PATCH] Documentation: checkpatch: Document some more message types
Date:   Fri, 17 Sep 2021 15:45:07 +0530
Message-Id: <20210917101507.8380-1-utkarshverma294@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added and documented 4 new message types:
- INCLUDE_LINUX
- INDENTED_LABEL
- IF_0
- IF_1

Signed-off-by: Utkarsh Verma <utkarshverma294@gmail.com>
---
 Documentation/dev-tools/checkpatch.rst | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/dev-tools/checkpatch.rst b/Documentation/dev-tools/checkpatch.rst
index f0956e9ea2d8..ea343a7a5b46 100644
--- a/Documentation/dev-tools/checkpatch.rst
+++ b/Documentation/dev-tools/checkpatch.rst
@@ -435,6 +435,11 @@ API usage
   **EXPORT_SYMBOL**
     EXPORT_SYMBOL should immediately follow the symbol to be exported.
 
+  **INCLUDE_LINUX**
+    Whenever asm/file.h is included and linux/file.h exists, a
+    conversion can be made when linux/file.h includes asm/file.h.
+    However this is not always the case (See signal.h).
+
   **IN_ATOMIC**
     in_atomic() is not for driver use so any such use is reported as an ERROR.
     Also in_atomic() is often used to determine if sleeping is permitted,
@@ -661,6 +666,10 @@ Indentation and Line Breaks
 
     See: https://lore.kernel.org/lkml/1328311239.21255.24.camel@joe2Laptop/
 
+  **INDENTED_LABEL**
+    goto labels either should not have any indentation or only a single
+    space indentation.
+
   **SWITCH_CASE_INDENT_LEVEL**
     switch should be at the same indent as case.
     Example::
@@ -790,6 +799,19 @@ Macros, Attributes and Symbols
   **DO_WHILE_MACRO_WITH_TRAILING_SEMICOLON**
     do {} while(0) macros should not have a trailing semicolon.
 
+  **IF_0**
+    The code enclosed within #if 0 and #endif is not executed and is used
+    for temporarily removing the segments of code with the intention of
+    using it in the future, much like comments. But comments cannot be
+    nested, so #if 0 is preferred. But if the code inside #if 0 and #endif
+    doesn't seem to be anymore required then remove it.
+
+  **IF_1**
+    The code enclosed within #if 1 and #endif is always executed, so the
+    #if 1 and #endif statements are redundant, thus remove it.
+    It is only useful for debugging purposes, it can quickly disable the
+    code enclosed within itself by changing #if 1 to #if 0
+
   **INIT_ATTRIBUTE**
     Const init definitions should use __initconst instead of
     __initdata.
-- 
2.25.1

