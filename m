Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C49E3320E5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 09:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbhCIIjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 03:39:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbhCIIjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 03:39:12 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F19AC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 00:39:12 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id kk2-20020a17090b4a02b02900c777aa746fso4786732pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 00:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=+5eeJcJYQlUo+55ExUdi0rlAWB1hTePo43XNL4GdBGo=;
        b=jcUDw2dNH4Cqg1cZUwJU3k3LIhqUIXqBdPGMLcvtSh6vS2nNoxsVMGzwRIYOXWhCem
         0kxdVXgPBndsbydFBNWCK8yp9AN8DrT9Zk+4mWTvMwbPVUawxxNT7ayGhxiMxATJHQOW
         aKW83aOnbV7i/+TZwU7eEinK8OP98Xo7sr2LUQYWVvW+Q+0QEGhb4U/Aj+Q5cwkbyXgR
         ExN0SSxYm3lvI/Yocpxywa8fjNPdXwI3QqfdOqYzJ0yKaSJFrwUHhEuA/miemm5j02ep
         6K9ej47KB2ZV4hjLQtpI6pJQCInQfAvBDFw3rBYrekpu6RvbVbiBJsVCrA58qILFr1/L
         MueQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+5eeJcJYQlUo+55ExUdi0rlAWB1hTePo43XNL4GdBGo=;
        b=QENPQKGtvapQVtcm2YWLCtKO1F1driEYzvwxxgwc8w8uV6KHRgTTnIVkBqMdftqOtf
         5Pf5ZLvnng9RMXrGOczGeFlNXpBThM0qdvEi/dyA78ZOiOKYPMvtdDZ7IX5ynZ5frP5C
         xtOzPfc4kTLxzx+aPY8CjAJSzFApfNyidnNu3QJjDKnxHb01+nh4WI3XiOAmRs0qwW0V
         cc2RRmtZ9ujfCKGdfNJobp6zOFOKMXDWAlvbGeYY7vstwiram8faL2YgpafMlCkxeyLB
         LARQS4YiHt8yqa1fshGPA1MFDOgrhYaXUZpbVfblIXzp6EERrr7TsARYl6OIfsla0fAl
         Zkkw==
X-Gm-Message-State: AOAM533T8pAcCFSPAKQpL9KtpHN/zhFSRk0nSie5G3961vvxAy77u9DD
        jY2Tx+z8he3i4pGGUxh66+k=
X-Google-Smtp-Source: ABdhPJzsvcBs9MlQa9NnV90Aqgba/XY9CS8PlTlethNngPoF/V/EjY0eueeh+xIFTomM5Yzf/thUaA==
X-Received: by 2002:a17:90a:7884:: with SMTP id x4mr3434850pjk.185.1615279151986;
        Tue, 09 Mar 2021 00:39:11 -0800 (PST)
Received: from localhost.localdomain ([45.135.186.97])
        by smtp.gmail.com with ESMTPSA id p17sm1964512pjv.49.2021.03.09.00.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 00:39:11 -0800 (PST)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     ebiederm@xmission.com
Cc:     kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] kernel: kexec_file: fix error return code of kexec_calculate_store_digests()
Date:   Tue,  9 Mar 2021 00:39:04 -0800
Message-Id: <20210309083904.24321-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When vzalloc() returns NULL to sha_regions, no error return code of
kexec_calculate_store_digests() is assigned.
To fix this bug, ret is assigned with -ENOMEM in this case.

Fixes: a43cac0d9dc2 ("kexec: split kexec_file syscall code to kexec_file.c")
Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 kernel/kexec_file.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 5c3447cf7ad5..33400ff051a8 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -740,8 +740,10 @@ static int kexec_calculate_store_digests(struct kimage *image)
 
 	sha_region_sz = KEXEC_SEGMENT_MAX * sizeof(struct kexec_sha_region);
 	sha_regions = vzalloc(sha_region_sz);
-	if (!sha_regions)
+	if (!sha_regions) {
+		ret = -ENOMEM;
 		goto out_free_desc;
+	}
 
 	desc->tfm   = tfm;
 
-- 
2.17.1

