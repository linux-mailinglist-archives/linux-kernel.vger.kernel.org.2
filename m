Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB6B7418364
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Sep 2021 18:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbhIYQlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Sep 2021 12:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbhIYQlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Sep 2021 12:41:06 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 180BCC061570;
        Sat, 25 Sep 2021 09:39:32 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id t4so8737711plo.0;
        Sat, 25 Sep 2021 09:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AHBJp+MjeLCe3b43/RSU7R6aEcfBrxWE3oKFx9hyVok=;
        b=oT7FcjHWUH+wtdkvL69Y7Uyd+3Cboq+KDSIAG/J64L0XK61PMYzeWetNaifsSjmk5H
         SuGvjlCHhwp7sDUkExGO5i4YnECa7/JR5FN6o8E6bxw2vPMWX2i79/cJYbzsQPDZCRsc
         /JJcN5/I7X8cAdjMI4n9MOTB7SfBXhrHhGmABmXuAjO+8oqGoJA1EbIOvWxRG5TJQFpK
         qQuC+/3Chd+p9oPr38jaUvzs9bDJocyhrZOmCzfGwPQTlEfuWEqwP4gD3bvJGihEOZ9y
         3yYyfHSQ0bU7SsXZOLwpi02luf5AD1BWwDt4PqTpZeXG6OeImxuBQc7Da8YRDoApPPt7
         Z4sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AHBJp+MjeLCe3b43/RSU7R6aEcfBrxWE3oKFx9hyVok=;
        b=0e1i82AcK7yleQHZO/lh8s0YgW0honVwBKNfd6sMVfDHsl1vzPsheFjhHcBx4l0iN+
         UJgkM1DZPAu2FO8QjT+HIQuqDjULKC/yqE7lqLhm90LDL+G0VLMKm6CBI8eS+bVhrWO9
         mWeWGP2cRhzam4FrFpRfINkKgItXEea3/ITsji+QfNySexb6imFGNlM+z/RAm0P4hQNK
         CS1QOq3GfE03e3Q7XejmvUaWSSdQ1kGMaDsSlgOQcE4994FpaoA9q8g7zEwjF3xwlS34
         t/x566gOpPqwoHDlghCU42jJMO14anfDelV8vW+sCJZmmeBMcSasGXX5MWI4HYLYubGU
         D2xA==
X-Gm-Message-State: AOAM530PFy6SMj8gSFwZgwtHjDPbud5g4ymAxtWS22gWIoSl3vOoc2kg
        25Txo/iIOe7fk3DEIRC0xPs=
X-Google-Smtp-Source: ABdhPJyuy5tKNOoKz7FdMPE3OZdYtEyXHupzN0azbvGowMiT6RWmEXaRzaQf0pQ5MtxqE9kS1rr+0Q==
X-Received: by 2002:a17:90b:17d0:: with SMTP id me16mr9062267pjb.49.1632587971281;
        Sat, 25 Sep 2021 09:39:31 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:6005:10e3:6238:12b8:7d27:c5e3])
        by smtp.googlemail.com with ESMTPSA id n9sm13609961pjk.3.2021.09.25.09.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Sep 2021 09:39:30 -0700 (PDT)
From:   Utkarsh Verma <utkarshverma294@gmail.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Joe Perches <joe@perches.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Utkarsh Verma <utkarshverma294@gmail.com>
Subject: [PATCH] Documentation: checkpatch: Document some more message types
Date:   Sat, 25 Sep 2021 22:08:52 +0530
Message-Id: <20210925163852.12096-1-utkarshverma294@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added and documented 3 new message types:
- MULTILINE_DEREFERENCE
- SINGLE_STATEMENT_DO_WHILE_MACRO
- MULTIPLE_ASSIGNMENTS

Signed-off-by: Utkarsh Verma <utkarshverma294@gmail.com>
---
 Documentation/dev-tools/checkpatch.rst | 43 ++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/Documentation/dev-tools/checkpatch.rst b/Documentation/dev-tools/checkpatch.rst
index f0956e9ea2d8..dac5b89a3082 100644
--- a/Documentation/dev-tools/checkpatch.rst
+++ b/Documentation/dev-tools/checkpatch.rst
@@ -710,6 +710,33 @@ Indentation and Line Breaks
 
     See: https://www.kernel.org/doc/html/latest/process/coding-style.html#breaking-long-lines-and-strings
 
+  **MULTILINE_DEREFERENCE**
+    A single dereferencing identifier spanned on multiple lines like::
+
+      struct_identifier->member[index].
+      member = <foo>;
+
+    is generally hard to follow. It can easily lead to typos and so makes
+    the code vulnerable to bugs.
+
+    If fixing the multiple line dereferencing leads to an 80 column
+    violation, then either rewrite the code in a more simple way or if the
+    starting part of the dereferencing identifier is the same and used at
+    multiple places then store it in a temporary variable, and use that
+    temporary variable only at all the places. For example, if there are
+    two dereferencing identifiers::
+
+      member1->member2->member3.foo1;
+      member1->member2->member3.foo2;
+
+    then store the member1->member2->member3 part in a temporary variable.
+    It not only helps to avoid the 80 column violation but also reduces
+    the program size by removing the unnecessary dereferences.
+
+    But if none of the above methods work then ignore the 80 column
+    violation because it is much easier to read a dereferencing identifier
+    on a single line.
+
   **TRAILING_STATEMENTS**
     Trailing statements (for example after any conditional) should be
     on the next line.
@@ -845,6 +872,17 @@ Macros, Attributes and Symbols
     Use the `fallthrough;` pseudo keyword instead of
     `/* fallthrough */` like comments.
 
+  **SINGLE_STATEMENT_DO_WHILE_MACRO**
+    For the multi-statement macros, it is necessary to use the do-while
+    loop to avoid unpredictable code paths. The do-while loop helps to
+    group the multiple statements into a single one so that a
+    function-like macro can be used as a function only.
+
+    But for the single statement macros, it is unnecessary to use the
+    do-while loop. Although the code is syntactically correct but using
+    the do-while loop is redundant. So remove the do-while loop for single
+    statement macros.
+
   **WEAK_DECLARATION**
     Using weak declarations like __attribute__((weak)) or __weak
     can have unintended link defects.  Avoid using them.
@@ -920,6 +958,11 @@ Functions and Variables
     Your compiler (or rather your loader) automatically does
     it for you.
 
+  **MULTIPLE_ASSIGNMENTS**
+    Multiple assignments on a single line makes the code unnecessarily
+    complicated. So on a single line assign value to a single variable
+    only, this makes the code more readable and helps avoid typos.
+
   **RETURN_PARENTHESES**
     return is not a function and as such doesn't need parentheses::
 
-- 
2.25.1

