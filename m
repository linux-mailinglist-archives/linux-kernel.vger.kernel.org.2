Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B49AE41FC99
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Oct 2021 16:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233430AbhJBOrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Oct 2021 10:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbhJBOrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Oct 2021 10:47:23 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE732C0613EC;
        Sat,  2 Oct 2021 07:45:37 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id r201so6302120pgr.4;
        Sat, 02 Oct 2021 07:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nxHNwN/IZVw4dmnEIbmDPrePZ8gOd6ZA6sVAKz4Y2u0=;
        b=W3Vp62ZyhHKMdLgxO5EFSAcZ57XnFRUfAvuHonde+anM+i/cMhoUjZRde+fM94KYgf
         qukqhjbBHy5pgHD7lp0WK7X+4NLzhUXeKd9OC37Pqd/LAy7BR/YiO4IAHzDH/bHQbIs4
         M+QpvjTqy6k879CTjCtHSW//Bk4vVqL5M2wNQRJ2ohrVZ8g5zd+n3dNgYX7Dxlb4Gx+a
         t+WXm1mYyKWeevCRTFBWDSSzQan/t1SSppmMIia3PZLUj6eHqIC6UvLux92CH5XPxrv5
         Tuhyw1K811oA8oveNFbVLPWYe1v3SfU45FkwWqMKjMRV/xM+PoA1Z1rqdiJAOdHkWSBn
         t6kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nxHNwN/IZVw4dmnEIbmDPrePZ8gOd6ZA6sVAKz4Y2u0=;
        b=Jlf1iLmyPy4Z38BeI2zdju6LpRxOo3biEcRzQfbPCbMqUsaha7NSQEZOVyR7weReyW
         h09NPPIZNva2tHA2bHfjgOujEtMEX+DuWkE90So/uGg18tpPDn9PP6aDAEJ8fOBSoJPY
         NvzlKsFNHCozlIVo5uoE7HUGDOjk8KboD9CfGMVh55vrOiP0stGZMPLW34Jors5ca1Lf
         8f+n+gi5SO0/1qM6qXKLrF0GwU7MeP0EVgHFZPm10LHC6bUSDb4/zMO6uQSAgwC/thz6
         tM7WqUsKLSsTul9OtW4pX7rbuSPDzGht9huLaX9jmwZF6YJboA/99ChglIJkM2Y3tFSv
         q44w==
X-Gm-Message-State: AOAM532QhYgg+UU4qdm/L3KQmkUjchTe1E1USUyZ491z3aYUIJd8/5en
        CQc++TBeurzs4eGIzpY8ZdqowoXjAtF23suDPec=
X-Google-Smtp-Source: ABdhPJx/wu4MUilt2DGxHuqo3pqfpoKZsxRoN/aNu9Z2o/4Xm25ORUCeeqFd8ZaMXEdo38e7BCjUCg==
X-Received: by 2002:a63:3648:: with SMTP id d69mr3080725pga.295.1633185937212;
        Sat, 02 Oct 2021 07:45:37 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:6006:a148:5133:c24f:f24a:a8c])
        by smtp.googlemail.com with ESMTPSA id x10sm8818058pfq.0.2021.10.02.07.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Oct 2021 07:45:36 -0700 (PDT)
From:   Utkarsh Verma <utkarshverma294@gmail.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Joe Perches <joe@perches.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Utkarsh Verma <utkarshverma294@gmail.com>
Subject: [PATCH v2] docs: checkpatch: add UNNECESSARY_ELSE message
Date:   Sat,  2 Oct 2021 20:15:06 +0530
Message-Id: <20211002144506.29974-1-utkarshverma294@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211001120218.28751-1-utkarshverma294@gmail.com>
References: <20211001120218.28751-1-utkarshverma294@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added and documented UNNECESSARY_ELSE message type.

Signed-off-by: Utkarsh Verma <utkarshverma294@gmail.com>
---
Changes in v2:
  - Included the continue statement.

 Documentation/dev-tools/checkpatch.rst | 77 ++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/Documentation/dev-tools/checkpatch.rst b/Documentation/dev-tools/checkpatch.rst
index f0956e9ea2d8..b7c41e876d1d 100644
--- a/Documentation/dev-tools/checkpatch.rst
+++ b/Documentation/dev-tools/checkpatch.rst
@@ -1166,3 +1166,80 @@ Others
 
   **TYPO_SPELLING**
     Some words may have been misspelled.  Consider reviewing them.
+
+  **UNNECESSARY_ELSE**
+    Using an else statement just after a return/break/continue statement is
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
+    statement. But note, there can be some false positives because of the
+    way it is implemented in the checkpatch script. The checkpatch script
+    throws this warning message if it finds an else statement and the line
+    above it is a break/continue/return statement indented at one tab more
+    than the else statement. So there can be some false positives like::
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
+    from the logic in the first case. As the if block doesn't have a return
+    statement, so removing the else statement is wrong.
+
+    Always check the previous if/else if blocks, for break/continue/return
+    statements, and do not blindly follow the checkpatch advice. One
+    patch (https://lore.kernel.org/all/20200615155131.GA4563@sevic69/)
+    even made it to the mainline, which was again reverted and fixed.
+    Commit 98fe05e21a6e ("staging: rtl8712: Remove unnecesary else
+    after return statement.")
+
+    Also, do not change the code if there is only a single return statement
+    inside if-else block, like::
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
+    do not remove the else statement in case of a single return statement
+    inside the if-else block.
+    See: https://lore.kernel.org/lkml/20140925032215.GK7996@ZenIV.linux.org.uk/
-- 
2.25.1

