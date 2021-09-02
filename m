Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03B073FF0FE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 18:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346237AbhIBQRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 12:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346205AbhIBQQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 12:16:47 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E54C0617AD
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 09:15:46 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id s3so4537167ljp.11
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 09:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yD0wYPOfkCihQvCi3sBoNx5SD2s8GvDXW1YwkxFjNE4=;
        b=psuXoDYMDt7deUWU+DIXMOj9Rr+6zWXUXTkV/p1mEGv8yiEBOXswrnOZLjJlU07mhK
         XGYBuR66NNgUYjYUX1gnAQ6zqtFtEnu9RO9TruiAjmDsJfhRjXnz8K9cJFg9Ub87d64x
         1Peb+PMh/V1zqn7QelAOEynZpKURGrkEF+SajvFDgop3fXcGDK29K+VBGctv7lc4TLad
         u+3OSIh+z2jdZeKIdEOb2LNweg/L63hsTwLE3YJbd07y9OnQahEwKRkGl2HQBft2Qg80
         b7JbKZBHlSYyAhQuP0171NMp5rChbeWfsOF7fXoGantAqswyP6P0zrQEP6FY98GgcQG4
         wGTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yD0wYPOfkCihQvCi3sBoNx5SD2s8GvDXW1YwkxFjNE4=;
        b=fYffS9YKG/T2UyyOYFMmmOqNA84e4beAFlu0dywKrmpwJH7XfeSEbio/KwAcPqMRYL
         7jeF5T51Cz3UuZfOCc3Oih3/RA/OBYRmRWOEb+lAzxRa12ZkM9Hrw1ZioG+HBuXoozCU
         QtxmNHsRGafYrdoMNWd76Bjg/dJp4C23DJNWgortZqWBzmKT8NNvM6/r3clnKVkymlAm
         0jNoQtHBEdR89DDlvPLf/ZBejqzVLFjLXZGcyxJiAUt87y11meCEw83UomqXzP9Kyrrc
         3KbDvp50fu9Fzqsg6TxFZr/jOBWyEFkblL4TotyMwAIj0XV0RWU9LCzb3BktoSxeKT/D
         MnDA==
X-Gm-Message-State: AOAM530T3JCt6gS9e6gPT7oVhTVB0e+0JB8hNjo7biDpv9FCT8ozTdvk
        gq41ohdRjjLTQpIunMmAZmlRH5VSOwnpwg==
X-Google-Smtp-Source: ABdhPJyfIb1UjdWimZm/DvPrUeIY+IX5OPMh6IAb6Q3YN9CyrkfB6UkYION52d38omQkCSYDQZF/+g==
X-Received: by 2002:a2e:9ac7:: with SMTP id p7mr3328258ljj.72.1630599345191;
        Thu, 02 Sep 2021 09:15:45 -0700 (PDT)
Received: from kari-VirtualBox.telewell.oy (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id m7sm267811ljj.58.2021.09.02.09.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 09:15:44 -0700 (PDT)
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev
Cc:     Kari Argillander <kari.argillander@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/8] fs/ntfs3: Change right headers to lznt.c
Date:   Thu,  2 Sep 2021 19:15:27 +0300
Message-Id: <20210902161528.6262-8-kari.argillander@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210902161528.6262-1-kari.argillander@gmail.com>
References: <20210902161528.6262-1-kari.argillander@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is lot of headers which we do not need in this file. Delete them
and add what we really need. Here is list which identify why we need
this header.

<linux/kernel.h> // min()
<linux/slab.h> // kzalloc()
<linux/stddef.h> // offsetof()
<linux/string.h> // memcpy(), memset()
<linux/types.h> // u8, size_t, etc.

"debug.h" // PtrOffset()

Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
---
 fs/ntfs3/lznt.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/ntfs3/lznt.c b/fs/ntfs3/lznt.c
index f1f691a67cc4..12ba42518efe 100644
--- a/fs/ntfs3/lznt.c
+++ b/fs/ntfs3/lznt.c
@@ -5,13 +5,13 @@
  *
  */
 
-#include <linux/blkdev.h>
-#include <linux/buffer_head.h>
-#include <linux/fs.h>
-#include <linux/nls.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/stddef.h>
+#include <linux/string.h>
+#include <linux/types.h>
 
 #include "debug.h"
-#include "ntfs.h"
 #include "ntfs_fs.h"
 
 // clang-format off
-- 
2.25.1

