Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD7D941845C
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Sep 2021 22:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbhIYUTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Sep 2021 16:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbhIYUTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Sep 2021 16:19:50 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6E4C061570;
        Sat, 25 Sep 2021 13:18:15 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id m21so13450739pgu.13;
        Sat, 25 Sep 2021 13:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cFRX5oL5e2qGvMdyNPty95jtsNRe9TW7d1DbDiCxj1k=;
        b=X0wbusJsedFo1QDWNmK6wN1BorZqQPIrG96Zppcsje3ck5aWklO1gORETJ6VSpIKsu
         pgVq6v01S+Ri3Ezxn32RtpGM99jc4v5bSn1PRwcaLPiPy24vtZ2XXQFNMRb21R2a/s+D
         CzJKMtyBfkiRPm7qKTnigRjhryulYAv3gF6cGRkg6zjZyn1R1sv2oWuKbtwbq3Ghf5Vf
         F6PA68Xeyjyf58zGJrCv5hxdp056F7KTzjQdnS93+5st/52CleS/5tVI/w+jErsuqs8+
         I6J+CALfFp+UByrgdB3h8EJwya6agkS8R2WClnW4Q9c37WHWG8WNocO/Hl60Q072p8+g
         MP3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cFRX5oL5e2qGvMdyNPty95jtsNRe9TW7d1DbDiCxj1k=;
        b=17q1cINJLA7ZgNjCpn/7woeKCTlbjuzip/J5SbWhLmmXLvyCF3bLNdRO/07IbtaYLx
         jV95i98xXcvaYsWk9M1nnImwXDeczlbKpPd4QLb1ecer1lgaYVsFurjLMBRZ7fAyiq0F
         DXWTePmME8HTGPiodCt89yrrRD1O+yEJ0ZMvCDEb1RYDInKWFYpsUoqF3spxl+qri9dp
         00gyWT/PQbZPQbHzBSF3Pwtm/Jz2sl1MTHkn8e0/6ZOlhutP0yonMKEj4eaaW2384gUL
         FBxbUVA/JWjh+3/2KudpH44KydkBf6JYfo/IAzpzmEYX15eiUdhqFs7mIAXvxxLrZqO2
         P3uA==
X-Gm-Message-State: AOAM533XJlqmeDDjv8qONNESYnrLSlVb/oJFeVbDQONpPUr4TDCXYwQZ
        LGEOjyyvD58PoPkHdjPHT8iaYj6zu9fjawpSzr8=
X-Google-Smtp-Source: ABdhPJzUFwQEa9xx9U0N8XthCPNRmf/PRh58ITRSU8CNDBfO+5RgNT5zyKevCwi3WJewo3FYtcHu6A==
X-Received: by 2002:a05:6a00:2410:b0:40e:7d8:ad7f with SMTP id z16-20020a056a00241000b0040e07d8ad7fmr15837402pfh.25.1632601095146;
        Sat, 25 Sep 2021 13:18:15 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:6005:10e3:6238:12b8:7d27:c5e3])
        by smtp.googlemail.com with ESMTPSA id o11sm4811023pjr.17.2021.09.25.13.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Sep 2021 13:18:14 -0700 (PDT)
From:   Utkarsh Verma <utkarshverma294@gmail.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Joe Perches <joe@perches.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Utkarsh Verma <utkarshverma294@gmail.com>
Subject: [PATCH] Documentation: checkpatch: Document some more message types
Date:   Sun, 26 Sep 2021 01:47:46 +0530
Message-Id: <20210925201746.15917-1-utkarshverma294@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added and documented 3 new message types:
- UNNECESSARY_INT
- UNSPECIFIED_INT
- UNNECESSARY_ELSE

Signed-off-by: Utkarsh Verma <utkarshverma294@gmail.com>
---
 Documentation/dev-tools/checkpatch.rst | 47 ++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/Documentation/dev-tools/checkpatch.rst b/Documentation/dev-tools/checkpatch.rst
index f0956e9ea2d8..2dc74682277f 100644
--- a/Documentation/dev-tools/checkpatch.rst
+++ b/Documentation/dev-tools/checkpatch.rst
@@ -929,6 +929,13 @@ Functions and Variables
 
       return bar;
 
+  **UNNECESSARY_INT**
+    int used after short, long and long long is unnecessary. So remove it.
+
+  **UNSPECIFIED_INT**
+    Kernel style prefers "unsigned int <foo>" over "unsigned <foo>" and
+    "signed int <foo>" over "signed <foo>".
+
 
 Permissions
 -----------
@@ -1166,3 +1173,43 @@ Others
 
   **TYPO_SPELLING**
     Some words may have been misspelled.  Consider reviewing them.
+
+  **UNNECESSARY_ELSE**
+    Using an else statement just after a return or a break statement is
+    unnecassary. For example::
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
+    So remove the else statement. But suppose if a if-else statement each
+    with a single return statement, like::
+
+      if (foo)
+              return bar;
+      else
+              return baz;
+
+    then by removing the else statement::
+
+      if (foo)
+              return bar;
+      return baz;
+
+    their is no significant increase in the readability and one can argue
+    that the first form is more readable because of indentation, so for
+    such cases do not convert the existing code from first form to second
+    form or vice-versa.
-- 
2.25.1

