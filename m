Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62F80357CB5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 08:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbhDHGlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 02:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbhDHGlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 02:41:44 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8197C061760;
        Wed,  7 Apr 2021 23:41:32 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id bg21so615167pjb.0;
        Wed, 07 Apr 2021 23:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=+ayU6agm7dGKxsfyYagzLZgme/BHOALbAfqPjDZCbBw=;
        b=vAVpeboIaVj2cKD6E6KjWY8OSGsnPhEhHGcYumoLuTOn3iSK2tiN1BVRK9n+UcAjEQ
         V/2YS0KKJHLO6ldmMhaO4xGtk/zC+xsbnaTTyAxAPM20av8lHgHtg6FkoK3tiuMHR3zS
         recp7/ZsujPEiC/XjjWLaW9rz5yyxYJG0Y1Ck4mxw8xrOIQtNksKJAcpM9hyHcfsOXKp
         MkWBE6Suh48QLwXE422ZXDYz2Xxuy11AV6SmCh/GRbGiJT3rVdZWHKwQ8vhnSEwMHwCO
         urMt36limi5izOZgpMEKreGZ5sLIIkormtt49in2boHYz8R8hYSo0d0Ge2qxyaSQuiLs
         L3Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+ayU6agm7dGKxsfyYagzLZgme/BHOALbAfqPjDZCbBw=;
        b=DoXIel1VeYXfkknLgiAtJWiO3cOFgA3YFAtOqa1mgPSJYY90scmbEWM46jd84Wt6pT
         dtMFsZCgkHH/bIov7MgJZvH+NpxXqLv5GQ+qwANBvjrGVboa2AcCOLbxDjt7EN1QC4UL
         MVUCfSB7rjKXEH8677x/6aJQ6m+AzWlsv4sJA5jtBX0VKxT7wlR0CsvI3VNQPSQK82Kd
         UmpiZzjiTGejrzHiCf+eViddf5sOWQ0N4aPagmCiVIf7UEaZJPfvgbtSb8Y3o2U3w6Ot
         u+V5us/YKtYWH404pDCisbgZk65BSLSTc/s6O4sxZ/3vdKCguSxwoHSFvnIuWex/yt1i
         Weaw==
X-Gm-Message-State: AOAM532rfwy4T8BhpojTvQ/DydprWZsw+H9Hn5ooRJq/YUbcmcVA4vR5
        X/2MEqSvdTiRQIApQTI48udZoCQW4Ew=
X-Google-Smtp-Source: ABdhPJytGCz5/MX9PFEBxv4PuRZuSbjrfZROXRTK91VX+qhP/hPdsKh9ohxXuoCcs7IeeXtic7cjXw==
X-Received: by 2002:a17:902:9a0a:b029:e6:bf00:8a36 with SMTP id v10-20020a1709029a0ab02900e6bf008a36mr6318236plp.51.1617864092305;
        Wed, 07 Apr 2021 23:41:32 -0700 (PDT)
Received: from carrot.localdomain (i114-185-13-113.s42.a014.ap.plala.or.jp. [114.185.13.113])
        by smtp.gmail.com with ESMTPSA id e3sm23316314pfm.43.2021.04.07.23.41.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Apr 2021 23:41:31 -0700 (PDT)
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs <linux-nilfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] fs/nilfs2: fix misspellings using codespell tool
Date:   Thu,  8 Apr 2021 15:41:27 +0900
Message-Id: <1617864087-8198-1-git-send-email-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liu xuzhi <liu.xuzhi@zte.com.cn>

Two typos are found out by codespell tool \
in 2217th and 2254th lines of segment.c:

$ codespell ./fs/nilfs2/
./segment.c:2217 :retured  ==> returned
./segment.c:2254: retured  ==> returned

Fix two typos found by codespell.

Signed-off-by: Liu xuzhi <liu.xuzhi@zte.com.cn>
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/nilfs2/segment.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index cd4da9535aed..686c8ee7b29c 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -2214,7 +2214,7 @@ static void nilfs_segctor_wakeup(struct nilfs_sc_info *sci, int err)
  * nilfs_construct_segment - construct a logical segment
  * @sb: super block
  *
- * Return Value: On success, 0 is retured. On errors, one of the following
+ * Return Value: On success, 0 is returned. On errors, one of the following
  * negative error code is returned.
  *
  * %-EROFS - Read only filesystem.
@@ -2251,7 +2251,7 @@ int nilfs_construct_segment(struct super_block *sb)
  * @start: start byte offset
  * @end: end byte offset (inclusive)
  *
- * Return Value: On success, 0 is retured. On errors, one of the following
+ * Return Value: On success, 0 is returned. On errors, one of the following
  * negative error code is returned.
  *
  * %-EROFS - Read only filesystem.
-- 
1.8.3.1

