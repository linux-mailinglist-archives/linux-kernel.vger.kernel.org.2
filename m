Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A73323B9133
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 13:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236246AbhGALdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 07:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236130AbhGALdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 07:33:52 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B96C061756
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 04:31:21 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id bu12so9905135ejb.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 04:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=9oog+xmVR928n6mJH7bqtEVwXKUR5JhDthT/lE48R94=;
        b=NQDavI3g3o2CKEkXHVt/GB0KHPmKsvOJ6ikJvuIhW0IfNhAVSIGa0oRxpkPGy5M6Ec
         Enf/qL5G6QVNavba1w2JXcHyYKPbdn8FbzDbNDbXDm0mD2dcv77wSwSb19FKSzQkIl/5
         67PecX2ER8OyYzCA3VG45M1APTaHMZupp60TZPasrB0lMGW3gzT3DHjcpwuqxOL7RDoT
         nUy3HUEV6UMPjQ7RK6RSng3dzP7fZhi6HvZLx+RCWYbyYQKua6OdLTe6DaJCdZAfWMHd
         AZHYXWjxrP97P1BJtRrqCXNlpIMdZUiF96WWQk8K4hCu/Yk2zEeX7SNSQGE3P/VtBVy+
         pLqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=9oog+xmVR928n6mJH7bqtEVwXKUR5JhDthT/lE48R94=;
        b=HrGXBM1hWzxivITI+yZOV161VojPVWMfalCpQQSog0WJvR9kl2vLb8zbcO7D4Yw8cZ
         AoQ1PTjt9BEbGKcoU6R3U97+qubMfz9ZqtfXOptP+ZlaoM7FLDxnHm6ARoi373o1Kohz
         rfWmsHoGBWpms48o0x03HP/EqnZ/pLIoh5hP41RPW1M8BgzfaAEd9GAOPAIB7n0aV6E4
         DfoPAiqQynrxQbNFwZ1p9LXK8DCp7L7kvvEySublr8G1rF4vX42NV5eXVNhxJOAlJzD6
         8I6RDE3kngjjMvSqOxsAlAoJ3y3nUrvJm52U8B/+y/TL/UWbt76d01TPJ2E8o/xSA+i7
         qf4w==
X-Gm-Message-State: AOAM531aEsUxEFz7PNotAU5hytNCZ0mxI4ReR27dnp5RKwVnU6nacteS
        oTqXXnk9vcW7Xh4CXApVf+/QKlYa/B4=
X-Google-Smtp-Source: ABdhPJyd1OkWaYfHu44tgKVhsS5dUhiU7KoT8VMWmAS9v9R4s23WiGN5O/Rl3GJObEXhUYUdfkgS8g==
X-Received: by 2002:a17:906:3a8e:: with SMTP id y14mr40790660ejd.153.1625139079678;
        Thu, 01 Jul 2021 04:31:19 -0700 (PDT)
Received: from gmail.com (178-164-188-14.pool.digikabel.hu. [178.164.188.14])
        by smtp.gmail.com with ESMTPSA id n13sm10628069ejk.97.2021.07.01.04.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 04:31:18 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Thu, 1 Jul 2021 13:31:17 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation/features: Add THREAD_INFO_IN_TASK feature
 matrix
Message-ID: <YN2nhV5F0hBVNPuX@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 .../core/thread-info-in-task/arch-support.txt      | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/Documentation/features/core/thread-info-in-task/arch-support.txt b/Documentation/features/core/thread-info-in-task/arch-support.txt
new file mode 100644
index 000000000000..9f0259bbd7df
--- /dev/null
+++ b/Documentation/features/core/thread-info-in-task/arch-support.txt
@@ -0,0 +1,32 @@
+#
+# Feature name:          thread-info-in-task
+#         Kconfig:       THREAD_INFO_IN_TASK
+#         description:   arch makes use of the core kernel facility to embedd thread_info in task_struct
+#
+    -----------------------
+    |         arch |status|
+    -----------------------
+    |       alpha: | TODO |
+    |         arc: | TODO |
+    |         arm: | TODO |
+    |       arm64: |  ok  |
+    |        csky: | TODO |
+    |       h8300: | TODO |
+    |     hexagon: | TODO |
+    |        ia64: | TODO |
+    |        m68k: | TODO |
+    |  microblaze: | TODO |
+    |        mips: | TODO |
+    |       nds32: |  ok  |
+    |       nios2: | TODO |
+    |    openrisc: | TODO |
+    |      parisc: | TODO |
+    |     powerpc: |  ok  |
+    |       riscv: |  ok  |
+    |        s390: |  ok  |
+    |          sh: | TODO |
+    |       sparc: | TODO |
+    |          um: | TODO |
+    |         x86: |  ok  |
+    |      xtensa: | TODO |
+    -----------------------
