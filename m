Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3923FF0F1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 18:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346200AbhIBQQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 12:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346169AbhIBQQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 12:16:38 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA6AC061575
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 09:15:39 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id s3so4536547ljp.11
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 09:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ob2HCfLbexy1luGulrKway4plF2/kkuH1W1saHNOCQo=;
        b=pBCxKSVw9Ji4JYB5OCdXI+l/dHNLz3ePATOIic0bMy2s5V1v1K7+nJuX+gJ9McOrFL
         +y40utIyAcTazzv0nwWgFvKYak5VSSfbWPc06wD6eDnYR7S+0DtOsUj90gmrjUevQeRR
         NxKzJzah5fFZXFgLTek90NBWN5ppDC3qHVGU/nK9BwnoEh+GFmpDexeEhwu6BfOJAEkA
         rKVyQJ+fqhXNXlgomeR326ZuS7nWIkQRwHLm7lBDC2W7iZfZZtO/1EI+RF3PW2bPtGQk
         YGDKuNEZtnarz69TTUHP7456py1We+6cUXuMVf0vvnvm4yovuQmogJlXiGRF5a/epk8C
         SEvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ob2HCfLbexy1luGulrKway4plF2/kkuH1W1saHNOCQo=;
        b=dIrjHBdQ+rU8xGfouBVl0s2XMBpbwosM6H70KPkkv/Yt/XAE0tI4xBMajuoCy1CWS5
         kpdsnMHSBrvE7hgz3VDe5XUoHdBrYAvIoNlgB1vdsLMxlHNCmmPH3qvv1gzYtoCpI7EO
         oYSYNFEG3y9Ukaeo7uGdchpVFy84FuzS9vYQeUFjCtmlSXd4HcLPAQFEVLb9YtdckbTt
         zX+paeFQNJY/4zt+hiLQ1QUEf6MjTljKDUzgmlXm8G7D5PCVcmwN4+8gMAvNImOsNc0d
         B4RrXv49IIxaObx0549wbFe36jcBc+f6FVnJnD3tybgL/WCFRmY007TcexGUKEy+drq5
         euQQ==
X-Gm-Message-State: AOAM530/cHDXzdQIL1Gax+mkmgzukCx7QGUrFUbMdcbHgI9cCMhmkP/O
        08YmXKxjSAUW0ljWw7KtnqnPfdhQ1g4qTA==
X-Google-Smtp-Source: ABdhPJyUWIfCl011zCkaBs+2pmSQuInn2PxqJd8IYtR8wyl/+dBK3vvWaVV6Tp6YsYo9hRx1az3E+w==
X-Received: by 2002:a05:651c:98c:: with SMTP id b12mr3248586ljq.83.1630599338250;
        Thu, 02 Sep 2021 09:15:38 -0700 (PDT)
Received: from kari-VirtualBox.telewell.oy (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id m7sm267811ljj.58.2021.09.02.09.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 09:15:37 -0700 (PDT)
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev
Cc:     Kari Argillander <kari.argillander@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/8] fs/ntfs3: Add missing header files to ntfs.h
Date:   Thu,  2 Sep 2021 19:15:22 +0300
Message-Id: <20210902161528.6262-3-kari.argillander@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210902161528.6262-1-kari.argillander@gmail.com>
References: <20210902161528.6262-1-kari.argillander@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We do not have header files at all in this file. Add following headers
and there is also explanation which for it was added. Note that
explanation might not be complete, but it just proofs it is needed.

<linux/blkdev.h> // SECTOR_SHIFT
<linux/build_bug.h> // static_assert()
<linux/kernel.h> // cpu_to_le64, cpu_to_le32, ALIGN
<linux/stddef.h> // offsetof()
<linux/string.h> // memcmp()
<linux/types.h> //__le32, __le16

"debug.h" // PtrOffset(), Add2Ptr()

Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
---
 fs/ntfs3/ntfs.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/ntfs3/ntfs.h b/fs/ntfs3/ntfs.h
index 6bb3e595263b..695b684bce20 100644
--- a/fs/ntfs3/ntfs.h
+++ b/fs/ntfs3/ntfs.h
@@ -10,6 +10,15 @@
 #ifndef _LINUX_NTFS3_NTFS_H
 #define _LINUX_NTFS3_NTFS_H
 
+#include <linux/blkdev.h>
+#include <linux/build_bug.h>
+#include <linux/kernel.h>
+#include <linux/stddef.h>
+#include <linux/string.h>
+#include <linux/types.h>
+
+#include "debug.h"
+
 /* TODO: Check 4K MFT record and 512 bytes cluster. */
 
 /* Activate this define to use binary search in indexes. */
-- 
2.25.1

