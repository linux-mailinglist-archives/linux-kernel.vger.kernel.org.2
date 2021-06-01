Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB16397518
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 16:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234346AbhFAOKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 10:10:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21185 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234294AbhFAOKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 10:10:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622556506;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=4ZBYz8sTwcymT4m7/VsSlUijuy4ubxvglEedfFP9Ajg=;
        b=ZoSn3FQKEjJGjlryuAotGK2kHwEq7nH9ZT7pTn1vAyXyxIu52h3HSKBE8LlTuJSDhqbCrX
        aEYRX/QDEAAhmj8CG3co8F646e2A0T94K05uiefu58jnm95JJOhmykQ4zYr7uBTv1/sVg2
        wbq1JWArJ93IzSU2vQ2us+CpwCJtsEI=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-iwJEbaDfOZiIV3o4K0KJIg-1; Tue, 01 Jun 2021 10:08:25 -0400
X-MC-Unique: iwJEbaDfOZiIV3o4K0KJIg-1
Received: by mail-oi1-f197.google.com with SMTP id 23-20020aca11170000b02901f182d8a121so2551638oir.19
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 07:08:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4ZBYz8sTwcymT4m7/VsSlUijuy4ubxvglEedfFP9Ajg=;
        b=KV8pfXoL+PwwCq+gidtiFYNTpBrZY+yt/EdNApn1VwGtQS0aNSegID0GPfT/hMvVUW
         8woi38w7pW+Jz1euHCv8Y4ozGUJPNQCKplWkpx8cpVR4INlL2lkH6NYXlxv8X267Eme6
         +OgHMCr0kAZ6oM6JfV/VFew3KVoE7zV8IJxFdUGgdtUnQd/jJYGgQV4s1zTKbg7TpaRQ
         NV5lubdTepcqgpdpMxAOd3PxCKqR4v50KkKx9EYkKKHv24IK4GCnoQOTo5iFO/eoIPUT
         TtyocHCUUg2rVDxYjLYLGcGz9+hzxtjkY4B1HRd8ZQwKM2GPJKDIzWBZlKKEt8phLFu+
         +XKQ==
X-Gm-Message-State: AOAM531MKWQkSptUhTprWyQDDHxlvfVH+SENv3h3uB5SDxoUGFsxe9ZH
        RCOnKOLFgq4mU+3lp4CZe3kUEFy13OzMMuBysD5jxtLI3rf6J7oF9oySk9bB3nXxln6pqu62cEt
        rq+XKu+kuYR4R2eBbPvfR9hs4
X-Received: by 2002:a9d:6b84:: with SMTP id b4mr21378162otq.152.1622556504760;
        Tue, 01 Jun 2021 07:08:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzGPDkeZ++PYbJQDkh2NlAHEbqcgkMjVVtiLuOsHdoiVMz/rUtG45Zur3MFSbt6Qc3Q6Af0EA==
X-Received: by 2002:a9d:6b84:: with SMTP id b4mr21378149otq.152.1622556504596;
        Tue, 01 Jun 2021 07:08:24 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id p5sm3433756oip.35.2021.06.01.07.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 07:08:24 -0700 (PDT)
From:   trix@redhat.com
To:     dhowells@redhat.com, marc.dionne@auristor.com
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] afs: add a return to afs_dir_set_page_dirty()
Date:   Tue,  1 Jun 2021 07:08:20 -0700
Message-Id: <20210601140820.2626615-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

With gcc 10.3, this compile error is reported
dir.c: In function 'afs_dir_set_page_dirty':
dir.c:51:1: error: no return statement in function
  returning non-void [-Werror=return-type]

Even though the code is unreachable, add a return
to silence the error.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 fs/afs/dir.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 78719f2f567e..988766f88d8b 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -48,6 +48,7 @@ static void afs_dir_invalidatepage(struct page *page, unsigned int offset,
 static int afs_dir_set_page_dirty(struct page *page)
 {
 	BUG(); /* This should never happen. */
+	return -EINVAL;
 }
 
 const struct file_operations afs_dir_file_operations = {
-- 
2.26.3

