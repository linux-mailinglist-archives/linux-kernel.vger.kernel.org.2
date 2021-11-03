Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CDC7443B38
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 03:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbhKCCMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 22:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbhKCCMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 22:12:42 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B666C061714
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 19:10:02 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id gn3so235173pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 19:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JWcAzAJwFyEX20kiIgOysZ+EjN9Q2rmcEhAoAq/Hw+4=;
        b=ftn4niXwlfXg0KAgoRYTpOjBX0DmSrZqbu64lUmu5jQGRQUcfl8LlHqk4aU+O0XP/c
         Hlx8mhMkD1CBpO4LgBjH/k+Qhs4dEwwaQxajN/EMtX33cPTy8WR7M3QEC8YI4VLKmkY4
         6EU0FcvTao5WhGcU4IV9okTr2dD7pSCKRHzNEBxKPfnQhoTpr5fZBMhLkkEFOKa7oQa/
         EnJ3juXLL/uwtu/oAjtchHAtFjPcZGK93IePyZmXy/deGgfM48BDNyw3iS+ZL8y+cCpA
         OT/4TsSVJsAw5PKtEVwatD/XXiTBRG3bUPfXUTlHRfjO7GFBZSmLb0DemiOXq5Gv5YWK
         d5ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JWcAzAJwFyEX20kiIgOysZ+EjN9Q2rmcEhAoAq/Hw+4=;
        b=CPfVgUrLV1XGeHPkqaBw3OXVK72k0zSQwTtDvd6gq87UsaLNZrxgV7v/bqrF0Igj44
         hVdk9K5ZcgeMsNK76V0ieOjqWe4VCfMcFQWXfFIXCth/XQgA8/CkYjouKL6L0iR4lS3A
         UrElnWwWXU1mH62MjZUruZNg1egJT4jZsacx0tWJ00jzV47Vs7pxbUIIQEj46eX4tDRT
         hREFDQw8o92McbCiUlpmPc5BRxtKjvSq4/RTy/KQZFcj3owmXvyABL0sAhhvhm+gD5UK
         JWv9FBFyaMzfmoRrjNF2+Zb3Q9T8DJATSs97KZmCVdUfuC59q1URpUsQf6PYzPkUTFZr
         bFPA==
X-Gm-Message-State: AOAM531/iTPmK0QLfXb3RHidPyZRzW/tRLqSLBZKhUt7pC5L9rcx8RVz
        A0SuKKCPBxbAkvzyNE2BeR8=
X-Google-Smtp-Source: ABdhPJzEjUBhFBa9JNyzfgf4pbiCTAasGDwJmHlECMAMn9YhBj0RYWb794EUFZ7Infey4RkYKPRGdQ==
X-Received: by 2002:a17:90a:e613:: with SMTP id j19mr11373961pjy.182.1635905401572;
        Tue, 02 Nov 2021 19:10:01 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id na13sm313174pjb.11.2021.11.02.19.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 19:10:01 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: deng.changcheng@zte.com.cn
To:     anton@tuxera.com
Cc:     linux-ntfs-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] ntfs: Remove unneeded semicolon
Date:   Wed,  3 Nov 2021 02:09:56 +0000
Message-Id: <20211103020956.24466-1-deng.changcheng@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changcheng Deng <deng.changcheng@zte.com.cn>

Fix the following coccicheck review:
./fs/ntfs/super.c: 1615: 2-3: Review: Unneeded semicolon
./fs/ntfs/super.c: 1684: 2-3: Review: Unneeded semicolon

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
---
 fs/ntfs/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
index 0d7e948cb29c..a45e06fa8a73 100644
--- a/fs/ntfs/super.c
+++ b/fs/ntfs/super.c
@@ -1612,7 +1612,7 @@ static bool load_and_init_attrdef(ntfs_volume *vol)
 		memcpy((u8*)vol->attrdef + (index++ << PAGE_SHIFT),
 				page_address(page), size);
 		ntfs_unmap_page(page);
-	};
+	}
 	if (size == PAGE_SIZE) {
 		size = i_size & ~PAGE_MASK;
 		if (size)
@@ -1681,7 +1681,7 @@ static bool load_and_init_upcase(ntfs_volume *vol)
 		memcpy((char*)vol->upcase + (index++ << PAGE_SHIFT),
 				page_address(page), size);
 		ntfs_unmap_page(page);
-	};
+	}
 	if (size == PAGE_SIZE) {
 		size = i_size & ~PAGE_MASK;
 		if (size)
-- 
2.25.1

