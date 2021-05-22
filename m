Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5BDC38D5AF
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 13:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbhEVLfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 07:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbhEVLfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 07:35:44 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A523AC061574;
        Sat, 22 May 2021 04:34:18 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id c12so5300406pfl.3;
        Sat, 22 May 2021 04:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bgUWkCDqcn8rn8EVjMGY9qbgt9aD2gR/He6gdEJMpaA=;
        b=pNob/g57qUIhlmbaSaWjftxJsLdRX4guzY0/tekGisr5kdZH8dT32tbVeBhxfXK12Y
         iI3Zh6iMREvBlC5tQMVoNjIK4ti3MweQRtWy6tlpp3vUGfVvVf3VtdWAEKXwgrDTn2Te
         WgRgnYdMgzuCsqO+wfZRL7dDgLglQ6GVEkBRC4yOAkdo1py5KEDhv35Z8F346Qummq+w
         rv11gAi2U4PrgJp23JtyyfAbPZNGLpC+m5ZMEvNse/uIAPEZeFMO2FVAV1Hg1FO9GNP6
         0lw9fJAOqcfN2gB37Wvx4/Hb/s9pRUlfU9wJ0ViyxmqOfG6oSgKEy59EdTRvPJDG784e
         9evQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bgUWkCDqcn8rn8EVjMGY9qbgt9aD2gR/He6gdEJMpaA=;
        b=rhNU2deFic1kF6d8so+5hF5JOFnHL0Om5GkslvqYGevQpx7jK3zt6srQluJa3zIaoq
         sE8BqQv6xmRPe17p/lK384X5xo3ZKtUZ9mNsLuaIDuS55nBbFcsnK/AG3/fHwr2NUe3j
         UAEAjGcYgX5jOo6dAxkhZIkK6c6pl/WhlhcrVRhSrtd/fuDQzMuQgSa+fZJI0k+Zfahy
         GSTYBnG3nc7V86eTI7euFJlOl5hNdyv8bXsCPkjAMWxU9UHn9ZDsRwjKBMBd2ZCh1JYE
         Cn7O/j1U8UDypsq3utnx7Es2xZ3Pv5929h3//FdbHkIc0ATLZ2RLC7eHxAxE6EfwUD7g
         ASLQ==
X-Gm-Message-State: AOAM530/++zEg5SZgnkwL1RqLXKTqoChKXVHsKhghbjiZ/XABHxF3w70
        DYqFrH2/HsAkIsKziQ0gG50=
X-Google-Smtp-Source: ABdhPJyVa8KNBd5sjjDaXi6GuW9UOGFzXNj+COS9vwf/JLmc+QdQDZIr3G0RDT/SlS6dZQyBsGz0Hw==
X-Received: by 2002:a62:7e41:0:b029:249:287:3706 with SMTP id z62-20020a627e410000b029024902873706mr14472123pfc.76.1621683258045;
        Sat, 22 May 2021 04:34:18 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:600d:a93f:d9c2:4477:9177:8c76])
        by smtp.googlemail.com with ESMTPSA id d131sm6530491pfd.176.2021.05.22.04.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 May 2021 04:34:17 -0700 (PDT)
From:   Aditya Srivastava <yashsri421@gmail.com>
To:     courmisch@gmail.com
Cc:     yashsri421@gmail.com, lukas.bulwahn@gmail.com,
        rdunlap@infradead.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] Phonet: fix kernel-doc syntax in file headers and remove file names
Date:   Sat, 22 May 2021 17:04:08 +0530
Message-Id: <20210522113408.8766-1-yashsri421@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <52313028.m8L9TnScQ9@philogene>
References: <52313028.m8L9TnScQ9@philogene>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The opening comment mark '/**' is used for highlighting the beginning of
kernel-doc comments.
For e.g., the header for include/linux/phonet.h follows this syntax, but
the content inside does not comply with kernel-doc.

This line was probably not meant for kernel-doc parsing, but is parsed
due to the presence of kernel-doc like comment syntax(i.e, '/**'), which
causes unexpected warning from kernel-doc:
warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * file phonet.h

Provide a simple fix by replacing this occurrence with general comment
format, i.e. '/*', to prevent kernel-doc from parsing it.

Also remove the redundant file name from the comment headers.

Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
---
Changes in v2:
- Remove file name information from comment headers as well, as suggested by Randy and Remi

 include/linux/phonet.h      | 4 +---
 include/uapi/linux/phonet.h | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/include/linux/phonet.h b/include/linux/phonet.h
index bc7d1e529efc..6117a0e462d3 100644
--- a/include/linux/phonet.h
+++ b/include/linux/phonet.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
-/**
- * file phonet.h
- *
+/*
  * Phonet sockets kernel interface
  *
  * Copyright (C) 2008 Nokia Corporation. All rights reserved.
diff --git a/include/uapi/linux/phonet.h b/include/uapi/linux/phonet.h
index a2f6b37a5937..e7e14b5e59c6 100644
--- a/include/uapi/linux/phonet.h
+++ b/include/uapi/linux/phonet.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-/**
- * file phonet.h
- *
+/*
  * Phonet sockets kernel interface
  *
  * Copyright (C) 2008 Nokia Corporation. All rights reserved.
-- 
2.17.1

