Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C87238D5B3
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 13:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbhEVLpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 07:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbhEVLp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 07:45:29 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A0F7C061574;
        Sat, 22 May 2021 04:44:04 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id p39so555502pfw.8;
        Sat, 22 May 2021 04:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NYrmw5RMTV2aEThz0kjImVo1vw9pbKW0fAr4kqrkC5U=;
        b=FS/Gl1Fewy5oyhiSGr7ZZMYAGTWOr5VtIkUwhWPkdngRV0eRo6u71ya9tTqQ+pUXu8
         UgoAvaBYxbLuC0ZBWgOoqQqbm5YcYd0yvIDOO1rLIVkXqHAnpTk5nXZ7aCaYEoKn5eHZ
         AxrK5332IAVsKQQ2df7TDEyyy0bv1WPfUvc2H1URset8B9nvGIX36gxyHLt1K0k4W9VT
         lM391jrsV+edzNtMvqBqhFqigNLS6n5kwvHcvE0/WL8TAA7mLpLy8uPi0+zZkFDK5ItT
         OHpeWx2Nz+Mttz8kRrkB0D+hMnZOpX6pXR2Pk3dxsL2xGl+HAuwkYKWd7oMv+5osN+qc
         SfCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NYrmw5RMTV2aEThz0kjImVo1vw9pbKW0fAr4kqrkC5U=;
        b=RavZEdj/kq4D80JUsYuD2YZI18MYOhy+HQZaJCVEiv2R+jog8AwQylp1pA18cXuPpl
         aMcDqkCbB8zvOO2L4a83dhuQkhDhTH4eOMUWzKshVT/idj0E7H7Erb/Zf6s02EP4SGpt
         +wMU9hUdKQCWn65PNurSMtS6awLXv6s0dwALQGT7SxcLcq2bic9DJiwvUw6HV6G+jgGk
         03OLMm7mxec7q2gajptfvgm+xQ1dKLMFGyzkmRzaPacD3vrnyARpzU0Xr8cScmMmq5uM
         V+mEXlKqe0yyD0SehYykU0OTSUqzP/qn1IiqeLvUSA6Qvnw73gpSowWMpS0f/2EY0tyt
         r1/w==
X-Gm-Message-State: AOAM533tHmND3eWG8DPD90CPJIcBfDpJT0hUBDt7tSqqsgSMcQvWUEtB
        6le3C2zLk+1JifhLZYW6UCvo1MWSNp/BWA==
X-Google-Smtp-Source: ABdhPJwoGHtGQ7e19/ifanrSR37U7sgfx1ePhQ9yHTJ5Quj/3sn448HDDTa5HMl5L8sl0Wza5fDXkQ==
X-Received: by 2002:a63:4b52:: with SMTP id k18mr3790275pgl.190.1621683843669;
        Sat, 22 May 2021 04:44:03 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:600d:a93f:d9c2:4477:9177:8c76])
        by smtp.googlemail.com with ESMTPSA id t25sm6459270pfl.68.2021.05.22.04.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 May 2021 04:44:03 -0700 (PDT)
From:   Aditya Srivastava <yashsri421@gmail.com>
To:     jaegeuk@kernel.org
Cc:     yashsri421@gmail.com, lukas.bulwahn@gmail.com,
        rdunlap@infradead.org, chao@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v2] f2fs: fix kernel-doc syntax and remove file name from file header
Date:   Sat, 22 May 2021 17:13:51 +0530
Message-Id: <20210522114351.9538-1-yashsri421@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <d1e7aaa1-4f59-2480-003d-5a5a37443c75@infradead.org>
References: <d1e7aaa1-4f59-2480-003d-5a5a37443c75@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The opening comment mark '/**' is used for highlighting the beginning of
kernel-doc comments.
The header for include/linux/f2fs_fs.h follows this syntax, but the
content inside does not comply with kernel-doc.

This line was probably not meant for kernel-doc parsing, but is parsed
due to the presence of kernel-doc like comment syntax(i.e, '/**'), which
causes unexpected warning from kernel-doc:
warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * include/linux/f2fs_fs.h

Provide a simple fix by replacing this occurrence with general comment
format, i.e. '/*', to prevent kernel-doc from parsing it.

Also remove the redundant file name from the comment headers.

Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
---
Changes in v2:
- Remove file name information from header comments, as suggested by Randy

 include/linux/f2fs_fs.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index 5487a80617a3..b5a081aa86c4 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/**
- * include/linux/f2fs_fs.h
- *
+/*
  * Copyright (c) 2012 Samsung Electronics Co., Ltd.
  *             http://www.samsung.com/
  */
-- 
2.17.1

