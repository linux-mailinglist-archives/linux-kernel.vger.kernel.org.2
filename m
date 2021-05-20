Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64E2C38B5FE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 20:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235062AbhETSbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 14:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234165AbhETSbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 14:31:06 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E12C061574;
        Thu, 20 May 2021 11:29:43 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id h20-20020a17090aa894b029015db8f3969eso5128386pjq.3;
        Thu, 20 May 2021 11:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=A5d5aXdYt4hUl4+OV6UCI0Ehr+lwjM7hULNb+KOTJBk=;
        b=mHfOQeUu443DNLDYLp+xnnQrdjLJ9NJVfNCnG8FbZQmy/mHxwfnSZrF6h3w2bB/FGG
         4/LGzuyWtTWnFozYltQlLTcWw45iYC/cMWdv2yw2wwOAU7AK8Qiad11ZkSYEc2mQSLDk
         RIquag+KH3ks4SDPhJZYEYhjEtxJ/4A0AEoDAG0kLVPHPFlS93ce8HmwDhPEyuezmHYi
         a5V6gsuwKD7TSWzTB2iauRm9pgKf3dbjQHracgbofMh4Ybnm8hmb9sJA3g9vecOe0PgC
         aExfunlVz8ZmyC8qwRMRQr0cX1lrogoITi2Tb+FoATqys39dHsZuXM3fyDKAwBAIougB
         qLDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=A5d5aXdYt4hUl4+OV6UCI0Ehr+lwjM7hULNb+KOTJBk=;
        b=f6iEqrSfuUkdqoNCJuD1O9OSUMw67eum6oApg8mtygTI6fSsZ7FZUxmievwl90RY7f
         XHJMUB557w6jlOaXxW0yTIHdKfkoP8G4Ae4pjOT1ezS25JN3Gv2oIo5QOLCd1demaMsT
         fJXfHuau6HCsW90k8Gj7cR4LE/7zFZJjcqgu9QF2TzqJd4TPbZfsKEpfBF3pyXBpjZkl
         J00ygLuZ0Fbt0keaJwJdAxFho2HhR+c/Cpnn2c15G48GNxtBHs0I3A4u6OIt/jx9fbHt
         5HlV0Sr/c2oG21nkdbkeBqzXLJNfZfLtaNoni5rUqnbVXZtS+rcMQkL06pSPHxd7m29x
         IOfg==
X-Gm-Message-State: AOAM533kd3qSL+Hft0uPORwKFpSa7GjRvSKuxTk279FjujelRk6HzSVA
        J/h2+1g/1e8vAtT+p2OrInNCCXaHNbM9JA==
X-Google-Smtp-Source: ABdhPJxOsKiisPY6gD0XTtm54BHxN5/X6kqG62g5FH1fZk9hUMPUlWOM4/wQPAZ7w0t0LCRDV5Vt8Q==
X-Received: by 2002:a17:902:8d83:b029:ef:9dd8:4d9 with SMTP id v3-20020a1709028d83b02900ef9dd804d9mr7421444plo.40.1621535383183;
        Thu, 20 May 2021 11:29:43 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:600d:a93f:4822:12f2:8c52:6d8b])
        by smtp.googlemail.com with ESMTPSA id 66sm2764268pgj.9.2021.05.20.11.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 11:29:42 -0700 (PDT)
From:   Aditya Srivastava <yashsri421@gmail.com>
To:     jaegeuk@kernel.org
Cc:     yashsri421@gmail.com, lukas.bulwahn@gmail.com,
        rdunlap@infradead.org, chao@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org
Subject: [PATCH] f2fs: fix kernel-doc syntax in file header
Date:   Thu, 20 May 2021 23:59:33 +0530
Message-Id: <20210520182933.31965-1-yashsri421@gmail.com>
X-Mailer: git-send-email 2.17.1
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

Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
---
 include/linux/f2fs_fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index 5487a80617a3..028d1b18f0e7 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-/**
+/*
  * include/linux/f2fs_fs.h
  *
  * Copyright (c) 2012 Samsung Electronics Co., Ltd.
-- 
2.17.1

