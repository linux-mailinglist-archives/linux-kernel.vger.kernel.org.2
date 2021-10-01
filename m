Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06BB841ECDA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 14:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354214AbhJAMEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 08:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354146AbhJAMEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 08:04:45 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 096E2C061775;
        Fri,  1 Oct 2021 05:03:02 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id k23-20020a17090a591700b001976d2db364so7055474pji.2;
        Fri, 01 Oct 2021 05:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6X7OZ3yKyxWtxfNg1xFjeO1sjefTXPgV8TXGpkXtteM=;
        b=kAcTJBh+fxfpM0kTNrGW5RufHhmq7BdV2ZCMTt/0dw5Hze4VSq0G4o/RNILN0DtXm3
         Bf+gQrKUpFNLlqQJxXTnYsQRg5EgnIGCkKzH/McvfAhKriPDnWW1GKqPlvohzpwvoMs9
         pCs6M34RQF9FN9Z8x9k02kte1oNeV2Y1/vVTnCuNZ5mhA0vi0Ss3QYh1zHoAX9Atd0gs
         cxa6/KhPaCwxjJznv0aMd/QsLjHzfiLyDpi3Ydj6IdqWe3BzLyEWmOLYZiqcKcWJ2wYm
         LWx6/B2mv85igK1km87GjDc+Q9+dveLPWXgYLX970sMrB1fQa9ykY0E4dZFZcVnNMz3V
         JXGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6X7OZ3yKyxWtxfNg1xFjeO1sjefTXPgV8TXGpkXtteM=;
        b=mWZncVqYKqMwyDQD9UL/48q3vfDM89nydpJwCuDvQlxKztk9YbbjBSRTThLWp0ygU6
         k4q56yox5J5M/ulcbe8ob1+7WWF7sNFZlsfZ/eJ8MXLrA56z5CzYDmKVu7N1Wx/QA+22
         z/tiHunT0MQrCd8sOuVrNgP5DoUvePchd4nOqU2YEI3uE4nyAdwF+aGk3xyDotMmFQ1d
         4zVNfnZ3HnwZG9S1ynqHAbOZUg/V7vcEYUd/y4eZZfVaKrkYNqbuHC6VHqt5RF5ADNYW
         Jx9hmn2e9dVVP7MIr6jNLv0WSufVGx4O5fv7WC42Cq/G49l3SbrWx7nqiiVZ33jxgPqB
         LpEw==
X-Gm-Message-State: AOAM5336/Ue6iItjw6dtVQpgaHZdHIO7AvaL8DmbE+TMQ5wSpx8Y3i29
        Pid9OvOtz0nuHy2fqn4DJfMLRaxBCaJuWUOS
X-Google-Smtp-Source: ABdhPJyLWqAkoE+6QLwi05GhH2Xyrd+Ps2OxTlXniNxHksEcUc/3WJb2dOopJUPgbw8CPpPgbwBbXA==
X-Received: by 2002:a17:902:ab58:b0:13e:28bd:cd82 with SMTP id ij24-20020a170902ab5800b0013e28bdcd82mr10391559plb.58.1633089780068;
        Fri, 01 Oct 2021 05:03:00 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:6006:a148:b4a:28d4:38a0:4379])
        by smtp.googlemail.com with ESMTPSA id u22sm3250146pje.10.2021.10.01.05.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 05:02:59 -0700 (PDT)
From:   Utkarsh Verma <utkarshverma294@gmail.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Joe Perches <joe@perches.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Utkarsh Verma <utkarshverma294@gmail.com>
Subject: [PATCH] docs: checkpatch: add UNNECESSARY_ELSE message
Date:   Fri,  1 Oct 2021 17:32:18 +0530
Message-Id: <20211001120218.28751-1-utkarshverma294@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <06f4c72fefeedb5145a940e5a78d50e610acdcc4.camel@perches.com>
References: <06f4c72fefeedb5145a940e5a78d50e610acdcc4.camel@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added and documented UNNECESSARY_ELSE message type.

Signed-off-by: Utkarsh Verma <utkarshverma294@gmail.com>
---
 Documentation/dev-tools/checkpatch.rst | 77 ++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/Documentation/dev-tools/checkpatch.rst b/Documentation/dev-tools/checkpatch.rst
index f0956e9ea2d8..e0f1ea1a0911 100644
--- a/Documentation/dev-tools/checkpatch.rst
+++ b/Documentation/dev-tools/checkpatch.rst
@@ -1166,3 +1166,80 @@ Others
 
   **TYPO_SPELLING**
     Some words may have been misspelled.  Consider reviewing them.
+
+  **UNNECESSARY_ELSE**
+    Using an else statement just after a return or a break statement is
+    unnecessary. For example::
+
+      for (i = 0; i < 100; i++) {
+              int foo = bar();
+              if (foo < 1)
+                      break;
+              else
+                      usleep(1);
+      }
+
+    is generally better written as::
+
+      for (i = 0; i < 100; i++) {
+              int foo = bar();
+              if (foo < 1)
+                      break;
+              usleep(1);
+      }
+
+    It helps to reduce the indentation and removes the unnecessary else
+    statement. But note there can be some false positives because of the
+    way it is implemented in the checkpatch script. The checkpatch script
+    throws this warning message if it finds an else statement and the line
+    above it is a break or return statement indented at one tab more than
+    the else statement. So there can be some false positives like::
+
+      int n = 15;
+      if (n > 10)
+              n--;
+      else if (n == 10)
+              return 0;
+      else
+              n++;
+
+    Now the checkpatch will give a warning for the use of else after return
+    statement. If the else statement is removed then::
+
+      int n = 15;
+      if (n > 10)
+              n--;
+      else if (n == 10)
+              return 0;
+      n++;
+
+    Now both the n-- and n++ statements will be executed which is different
+    from the logic in the first case. Because the if block doesn't have
+    a return statement, so removing the else statement is wrong.
+
+    Always check the previous if/else if blocks, for break/return
+    statements, and do not blindly follow the checkpatch advice. One
+    patch https://lore.kernel.org/all/20200615155131.GA4563@sevic69/
+    even made it to the mainline, which was again reverted and fixed.
+    Commit 98fe05e21a6e ("staging: rtl8712: Remove unnecesary else
+    after return statement.")
+
+    Also, do not change the code if there is only a single return/break
+    statement inside if-else block, like::
+
+      if (a > b)
+              return a;
+      else
+              return b;
+
+    now if the else statement is removed::
+
+      if (a > b)
+              return a;
+      return b;
+
+    there is no considerable increase in the readability and one can argue
+    that the first form is more readable because of the indentation. So
+    do not remove the else statement in case of a single return/break
+    statements inside the if-else block.
+    See: https://lore.kernel.org/lkml/20140925032215.GK7996@ZenIV.linux.org.uk/
-- 
2.25.1

