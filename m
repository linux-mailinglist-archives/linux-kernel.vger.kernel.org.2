Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DACE8445D69
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 02:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbhKEBmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 21:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbhKEBmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 21:42:43 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1065C061714
        for <linux-kernel@vger.kernel.org>; Thu,  4 Nov 2021 18:40:04 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id bj27so5876951qkb.11
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 18:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N07tUT+lLzgpnAEI2n4kk0ncM8QorW6AozB/rbyg1yQ=;
        b=pr6wdPNNnsR4u/Y8vij1dzDL5zm+5AkjtSI7s2Tzsn2qNi7ICcCgoimLq48y0OxHv+
         j1/QKNgaZn6j2PRznP6u2E4+EKBGXqa+hIli3JW6o3gLPh/cuDGfZwyqWk64kxz1TFQk
         P+svOkaYLXMDnEjD96zaYehMB5PnGWRmto86/DYgXZUIGyHZHiicTS3a6cfOLdprmIkt
         fkZoxPXiHvZbD9oDNqWSkrBZ239nvWFLoJt05cIoU1sBGyulMWdoqJM0m9g7i5WbkK8Q
         cy9awyGEe8KbZHoWNIsokRQ+WrCQpAqPdAqGEhFr+roWJUDVKFYcBGI88vS47gbAY0yM
         pxiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N07tUT+lLzgpnAEI2n4kk0ncM8QorW6AozB/rbyg1yQ=;
        b=My1l7XfXS3pZlq5/GzI9+gDgv1tX8dZz40XvT5LlwUHyykcz6pI8LEyAIkS0awjdnu
         mIjexVYvJUv05wHkjQ679PtGzLGhvUl4XSAOo2OQeBTTRJBOh+c9+Rw9rccC5Y1u82LG
         GQARhtwHQwlKE+0CbpsSnZimcNzsFmzNTN4smsj1YVXPDnfDq1huwd7dRj1jjRL/WRqV
         iZjL0MswxpIA4MA5lhtw6NPAV/A2ssV0TpUjLWi1kLGwHIggB1+v6yW8qUT/YTb83D6w
         ruGg2Pb5ZR0BBUAXW9KbHF/tWgU42wHSyaMa+Wf0G4tUO4b1TJFQlMCA5RxLyeekDlHx
         bV9Q==
X-Gm-Message-State: AOAM532hJ17u1jEL2abJAK4GaB5A36etaChGu2vjy8BoThU4W5UbK6xY
        W1qSqfQLPE+LhAWdEQF9fnw=
X-Google-Smtp-Source: ABdhPJyi4XiEsBkLSd36dcBA6TRrH/mQ+Yb3BYMRdiS1wCjc+zWWrmYcfAqWwGSmfXDsmCMixN4SRA==
X-Received: by 2002:a05:620a:4088:: with SMTP id f8mr27537567qko.418.1636076403997;
        Thu, 04 Nov 2021 18:40:03 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id e10sm5047984qtx.66.2021.11.04.18.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 18:40:03 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: zhang.mingyu@zte.com.cn
To:     anton@tuxera.com
Cc:     linux-ntfs-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Zhang Mingyu <zhang.mingyu@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] ntfs:Remove unneeded semicolon
Date:   Fri,  5 Nov 2021 01:39:54 +0000
Message-Id: <20211105013954.75112-1-zhang.mingyu@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Mingyu <zhang.mingyu@zte.com.cn>

Eliminate the following coccinelle check warning:
fs/ntfs/super.c:1615:2-3
fs/ntfs/super.c:1684:2-3

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Zhang Mingyu <zhang.mingyu@zte.com.cn>
---
 fs/ntfs/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
index 5ae8de09b271..500e6bd7c827 100644
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

