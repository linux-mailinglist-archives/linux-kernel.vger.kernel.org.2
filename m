Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F29844101ED
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 01:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241454AbhIQX7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 19:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241169AbhIQX7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 19:59:39 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577E9C061757
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 16:58:16 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id h29so12071990ila.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 16:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iEwpCdHpCUMK6ZYhkRZ63EGoiK2SIHmWKpqoZAtsUSk=;
        b=fbi1JaFCOUNGamRDuc+XgjKosx83lIsqgu7zvOd9DvcMNHIu1TkQunLfc1XQLJ/uPb
         sjujlsYnNNIT2gR008/E9OerXXZycMli4b6jzvygcR0aDb9dq4reMaGRXbi5veXxVdDr
         64VBhMIi8rLrvaXrJUl/uqrsSW4GXhPmrAHXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iEwpCdHpCUMK6ZYhkRZ63EGoiK2SIHmWKpqoZAtsUSk=;
        b=4mR9d0vx7oc0Hx4O67EdYJCjPl1L7cKKrkxObZC/KLVPdRLzccOr0fKf49ZqDAR7Oi
         xXxTZar5ksjtPhgASiCp3lhgPUxFnfSuYJoHFQESI46jjZ3JaEgPERjGShEc69vyTL4S
         U7wbCbrJOTYOjP3Rfo47rpd584e5rYpYfNMgqDD6J6JXW35dOGK9xCFcQ/ukohR7KjlX
         VeBTEMd01mXiVScv1QkHQCBx2iI+zr5Qla835pxnAC49qzH/Y6yt3Rp6Z3Iu/NM+ItDi
         6+J8xd0lmIdpxGjD/QVFsEmhxmecu7a8QC4en0CoD0YLOJL6+5nDLAbwvPk1DWMGIWfZ
         ofrw==
X-Gm-Message-State: AOAM531LW6XXAyrtQlWHrMlGq+eqCLFE1+TdlyrzKO8OMQzIQtyJ2Jlq
        r9jUvKkTiS86JEkmdhp1mv5WGw==
X-Google-Smtp-Source: ABdhPJz7pg3FiGuvl67HjuZzVblMpfpUNjBO9Y5beoN1SzVXB1yROx05BJxP2yUP8LIYorBnW3ZuEg==
X-Received: by 2002:a92:7f0a:: with SMTP id a10mr10298794ild.22.1631923095529;
        Fri, 17 Sep 2021 16:58:15 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id c11sm4443035ilq.26.2021.09.17.16.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 16:58:15 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     shuah@kernel.org, skhan@linuxfoundation.org
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: drivers/dma-buf: Fix implicit declaration warns
Date:   Fri, 17 Sep 2021 17:58:13 -0600
Message-Id: <20210917235813.42410-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

udmabuf has the following implicit declaration warns:

udmabuf.c:30:10: warning: implicit declaration of function 'open';
udmabuf.c:42:8: warning: implicit declaration of function 'fcntl'

These are caused due to not including fcntl.h and including just
linux/fcntl.h. Fix it to include fcntl.h which will bring in the
linux/fcntl.h. In addition, define __EXPORTED_HEADERS__ to bring in
F_ADD_SEALS and F_SEAL_SHRINK defines and fix the following error
that show up when just fcntl.h is included.

udmabuf.c:45:21: error: 'F_ADD_SEALS' undeclared
   45 |  ret = fcntl(memfd, F_ADD_SEALS, F_SEAL_SHRINK);
      |                     ^~~~~~~~~~~
udmabuf.c:45:34: error: 'F_SEAL_SHRINK' undeclared
   45 |  ret = fcntl(memfd, F_ADD_SEALS, F_SEAL_SHRINK);
      |                                  ^~~~~~~~~~~~~

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/drivers/dma-buf/udmabuf.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/dma-buf/udmabuf.c b/tools/testing/selftests/drivers/dma-buf/udmabuf.c
index 4de902ea14d8..de1c4e6de0b2 100644
--- a/tools/testing/selftests/drivers/dma-buf/udmabuf.c
+++ b/tools/testing/selftests/drivers/dma-buf/udmabuf.c
@@ -1,10 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#define __EXPORTED_HEADERS__
+
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
 #include <string.h>
 #include <errno.h>
-#include <linux/fcntl.h>
+#include <fcntl.h>
 #include <malloc.h>
 
 #include <sys/ioctl.h>
-- 
2.30.2

