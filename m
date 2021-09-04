Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 972D0400A4A
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 09:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233802AbhIDHn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 03:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233631AbhIDHn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 03:43:26 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D987C061575;
        Sat,  4 Sep 2021 00:42:25 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id r2so1286487pgl.10;
        Sat, 04 Sep 2021 00:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CFW88EsdFTG/uHl515vVt1AHdJMDeY6+hJs8Jtyin+k=;
        b=h0rAajVHXZVfMraBKEkp7jd5xK2sm5axB9cC8kfhDEkUfObXKC3hIOCXD8wErwnLxu
         IRDd86yhnyGB8tjsqYouJBa/FkknDCDyFy8qXgJ9ywRrZj038tsxbJcnrLosRppiQpw7
         4sz4r/ev6GCS2s9M6Ul3GPh9FM5YkbIUD4kJixuR2bu0klWGwp0fIxRAIor04z1yE5Xh
         mH2UFdUcjSjXiexj9ihoGDIeyqZnNxfEmUPIPnItDQuzgfdRZxeJL2jZhY6H+5ypy9gc
         084yBTPpEKjdpAgA5RihyX6t0aFChOY4XDpJEWHhNeiww1GMWZc/hVUg0qXl5euTisXZ
         MQjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CFW88EsdFTG/uHl515vVt1AHdJMDeY6+hJs8Jtyin+k=;
        b=nbMhBLk9CNPRvWmT9/6DKQ2mPsCW3VrfviaXb+rMjeFg3EzvYKsaOk7tI5Ew6RSL5u
         wUAYIub3y42/NNyynTuBSesfVGN+ePlp2SpuCKZNQ4p9ofoIazhRHPICJa81b8Ygm5aB
         egYBzZTDvpdb/bkQu7W+c2FP2pe4CtVvYiNKMxvvQO7zEL0V7z2i3i/GIuvvLd9ibFJ3
         stus+cLE4XLsg5rHyVa/avhWCI7cm7lVWCgLpuuVwnXYTZJSZjtl41N6e1Nar4PaHlzK
         XU8HHb71i5drRlKLpJ4rGNnO7Pj6aY2vq5JLQwJloj5HHEqnJKZ4wbjOzr8J/r2k3NFi
         ZPug==
X-Gm-Message-State: AOAM533MA7PhbOPTU2VvHkXk18JgUrwGEbKCbp3gTc2hRXeBANNLpALo
        iU6wcRCBcBlp3Tok194vCZcu1s3F6LDR7xBO
X-Google-Smtp-Source: ABdhPJxE0le/McowG26nZDxVfwSuDbelctC3UxDqotMp9K08qYiMV9gW7u6PTqZK2kFUC3p6q9CMsA==
X-Received: by 2002:a62:7d84:0:b029:3b8:49bb:4c3f with SMTP id y126-20020a627d840000b02903b849bb4c3fmr6861178pfc.49.1630741344353;
        Sat, 04 Sep 2021 00:42:24 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:6006:a148:82a8:3271:93dc:763c])
        by smtp.googlemail.com with ESMTPSA id x19sm1477046pfa.104.2021.09.04.00.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Sep 2021 00:42:24 -0700 (PDT)
From:   Utkarsh Verma <utkarshverma294@gmail.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Joe Perches <joe@perches.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Utkarsh Verma <utkarshverma294@gmail.com>
Subject: [PATCH] Documentation: checkpatch: Add TRAILING_SEMICOLON message
Date:   Sat,  4 Sep 2021 13:12:01 +0530
Message-Id: <20210904074201.13532-1-utkarshverma294@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new message type TRAILING_SEMICOLON for the macro definitions
that conclude with a semicolon.

Suggested-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Signed-off-by: Utkarsh Verma <utkarshverma294@gmail.com>
---
 Documentation/dev-tools/checkpatch.rst | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/dev-tools/checkpatch.rst b/Documentation/dev-tools/checkpatch.rst
index f0956e9ea2d8..30eda8f4a8bd 100644
--- a/Documentation/dev-tools/checkpatch.rst
+++ b/Documentation/dev-tools/checkpatch.rst
@@ -845,6 +845,27 @@ Macros, Attributes and Symbols
     Use the `fallthrough;` pseudo keyword instead of
     `/* fallthrough */` like comments.
 
+  **TRAILING_SEMICOLON**
+    Macro definition should not end with a semicolon. The macro
+    invocation style should be consistent with function calls.
+    This can prevent any unexpected code paths::
+
+      #define MAC do_something;
+
+    If this macro is used within a if else statement, like::
+
+      if (some_condition)
+              MAC;
+
+      else
+              do_something;
+
+    Then there would be a compilation error, because when the macro is
+    expanded there are two trailing semicolons, so the else branch gets
+    orphaned.
+
+    See: https://lore.kernel.org/lkml/1399671106.2912.21.camel@joe-AO725/
+
   **WEAK_DECLARATION**
     Using weak declarations like __attribute__((weak)) or __weak
     can have unintended link defects.  Avoid using them.
-- 
2.25.1

