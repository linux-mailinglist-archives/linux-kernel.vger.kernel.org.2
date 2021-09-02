Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 762063FF061
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 17:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345895AbhIBPmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 11:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234405AbhIBPmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 11:42:11 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 421F0C061575
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 08:41:13 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id m4so4360683ljq.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 08:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S9bncv85/JJCCaREC35kjKL89O+ainDxXdQOs8Fi7i0=;
        b=OWUFbUhT0oofSMmrvEFc6NIXYk/HSsKtJtrGNZ4STbrpJMaiQLcCMMjTZ+HTRwGvPR
         xYiGyDPSddJvVoxs4ZFJKH7DFETpzTJMfn7v+xXZIYBSplg8JDfSmwcbBoDjaxeYKLy9
         E3Q1EmX6GHK/UjX+NDkbVRlZIVKF9uKoqfDpqnqsEd2p8UDn71H1PugdkcrP+ph73Nzw
         /iv1fnViiOv+NNoyO98Zm75WNc00CoR3Uyc9glyoDtb42j9dVvCfE6e1JUVrRjZ+E53h
         +IUlH0QYLkYuZ/3vuSryLm+hK3ajIfl+/juJNcuVv0aaKhdayUXQ4d06I2NXyObN4tJ3
         iVOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S9bncv85/JJCCaREC35kjKL89O+ainDxXdQOs8Fi7i0=;
        b=YF2u7khAKATESOMFhP1h9BeP3knicepj2npWHpfc/q1ucuetePf/PECb5ekoyVA+UX
         Ott9GSeoKEJWvqGuRYJsMaSl7l0ihRLCNhwfUqqT7SzIvfbldnJIA3gVANyqnpfm01Ay
         PGIzM5dOcxYPTA3VSFjIz6cCeV5p//Rei3XYvBPnllnObmtAWXLclDQo1nRstll5M70/
         wDFeoVKgNNmSLwpe1bq1gLOzuCsG6WjhjjmY7+kmO5UjKkmZPU+OmqTSiHHMcdBBXtJi
         /DJ8Y/cqVLiH2KQN3x+fIsHk2Jea+RF15YsC7n53L/9CagaivwzWwxt9KguP+dumw5Ro
         nJ2w==
X-Gm-Message-State: AOAM531viSeyBPJxUiacwAn8D6oeyMc+nQabGaXwf217jBW5ZE8h2Qxs
        jbGigajeeXtPGFdpIkrQfoA=
X-Google-Smtp-Source: ABdhPJwt5RqLRFRoiLF0iWsD6NCFK14WaR63lDmRlTtIwMBnSqPofnHaoviREKu680dl1bK34xo0Og==
X-Received: by 2002:a2e:4e09:: with SMTP id c9mr3172997ljb.62.1630597271616;
        Thu, 02 Sep 2021 08:41:11 -0700 (PDT)
Received: from kari-VirtualBox.telewell.oy (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id 25sm258630ljw.31.2021.09.02.08.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 08:41:11 -0700 (PDT)
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev
Cc:     Kari Argillander <kari.argillander@gmail.com>,
        linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>
Subject: [PATCH 2/3] fs/ntfs3: Make binary search to search smaller chunks in beginning
Date:   Thu,  2 Sep 2021 18:40:49 +0300
Message-Id: <20210902154050.5075-3-kari.argillander@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210902154050.5075-1-kari.argillander@gmail.com>
References: <20210902154050.5075-1-kari.argillander@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We could try to optimize algorithm to first fill just small table and
after that use bigger table all the way up to ARRAY_SIZE(offs). This
way we can use bigger search array, but not lose benefits with entry
count smaller < ARRAY_SIZE(offs).

Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
---
 fs/ntfs3/index.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
index 8bac9d20e7e3..e336d5645628 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -8,6 +8,7 @@
 #include <linux/blkdev.h>
 #include <linux/buffer_head.h>
 #include <linux/fs.h>
+#include <linux/kernel.h>
 #include <linux/nls.h>
 
 #include "debug.h"
@@ -680,8 +681,9 @@ static struct NTFS_DE *hdr_find_e(const struct ntfs_index *indx,
 #ifdef NTFS3_INDEX_BINARY_SEARCH
 	struct NTFS_DE *found = NULL;
 	int min_idx = 0, mid_idx, max_idx = 0;
+	int table_size = 8;
 	int diff2;
-	u16 offs[64];
+	u16 offs[128];
 
 	if (end > 0x10000)
 		goto next;
@@ -701,7 +703,7 @@ static struct NTFS_DE *hdr_find_e(const struct ntfs_index *indx,
 		off += e_size;
 
 		max_idx++;
-		if (max_idx < ARRAY_SIZE(offs))
+		if (max_idx < table_size)
 			goto fill_table;
 
 		max_idx--;
@@ -719,6 +721,7 @@ static struct NTFS_DE *hdr_find_e(const struct ntfs_index *indx,
 				return NULL;
 
 			max_idx = 0;
+			table_size = min(table_size * 2, 128);
 			goto fill_table;
 		}
 	} else if (diff2 < 0) {
-- 
2.25.1

