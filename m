Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66170381A68
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 20:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234362AbhEOSLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 14:11:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27900 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234189AbhEOSLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 14:11:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621102188;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=a37RUy38tpQv2jdd94Qqtdr4uSz+DEetL1oJyyI6Pv8=;
        b=a4si1hEyIy1gDcJxfYVpxOfKUV4QcVnW1MzsGmk/vhK0UGLWlrslHbtA9DlZ65n1zDIC4y
        xNQGU00kiXvIZf5/vDfAmpWVMpKHucifnnEkRSNhRdF7snY3sVQCI0Imqu3QNzrV4H9QS/
        emMSjZOrWPpziwQLp9wcNNu3+1pCRd4=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-559-e0__X9MoP4S4j0PslkZpYA-1; Sat, 15 May 2021 14:09:46 -0400
X-MC-Unique: e0__X9MoP4S4j0PslkZpYA-1
Received: by mail-qv1-f70.google.com with SMTP id b1-20020a0c9b010000b02901c4bcfbaa53so1806886qve.19
        for <linux-kernel@vger.kernel.org>; Sat, 15 May 2021 11:09:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a37RUy38tpQv2jdd94Qqtdr4uSz+DEetL1oJyyI6Pv8=;
        b=Hh6ftK6vecoKWwFTPPokTkFdSodwgCxkW5cFAceE2yFPPuDLCJpeMPSqcBbY3AH28C
         GF5QRQQ0K1oqtWMLXizlD5IgLqSO1cGl8tbH5KtnOlObwc5Xgcgu6BSShEKlLAkUIcam
         ymH+j8S8JQcimWZNiMMNjvIRgBUEjt7Eo8vNtqjVcuSpqYKmQ3c3S9pOcFoZbR7jLk0u
         lqdHJDnsAHaHUXkGLevvMaqWM5hRAeD39m0amm91dkfZ3gjdZDLyt7W0kgcvtyu3UKsW
         cM0jBDkrbRzMm4U+ZRs7Di6xByh2FxmgWq4dvlztSZHQ1J45Ah0ltb2WstgBwn9NKwqy
         5urA==
X-Gm-Message-State: AOAM5316eTn1OWKphzr1v3dxgw59MuW7CQ+XJiNnjWm8nDFFsk/SWkX9
        WfXbLtXTdrOzx6eT4iyQAAhXkjX6YxICDvZnsh6aIBgYbGgnq3tI2JBVL350pVkcblccjlKWQYI
        9bgrU8OZnfzpfXd9pFC7SLXyv
X-Received: by 2002:a37:ef17:: with SMTP id j23mr45225799qkk.392.1621102186130;
        Sat, 15 May 2021 11:09:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyla+8xaDzC7jNYp70uepVTByVn5MkwxjTVfLndkNLD1XSNnPErIdMTtTRqpHXJ4FywHUjblA==
X-Received: by 2002:a37:ef17:: with SMTP id j23mr45225775qkk.392.1621102185693;
        Sat, 15 May 2021 11:09:45 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id p10sm7077984qkg.74.2021.05.15.11.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 May 2021 11:09:45 -0700 (PDT)
From:   trix@redhat.com
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] f2fs: return success if there is no work to do
Date:   Sat, 15 May 2021 11:09:41 -0700
Message-Id: <20210515180941.1751362-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Static analysis reports this problem
file.c:3206:2: warning: Undefined or garbage value returned to caller
        return err;
        ^~~~~~~~~~

err is only set if there is some work to do.  Because the loop returns
immediately on an error, if all the work was done, a 0 would be returned.
Instead of checking the unlikely case that there was no work to do,
change the return of err to 0.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 fs/f2fs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index ceb575f99048c..bae0f910f5f0a 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3203,7 +3203,7 @@ int f2fs_precache_extents(struct inode *inode)
 		map.m_lblk = m_next_extent;
 	}
 
-	return err;
+	return 0;
 }
 
 static int f2fs_ioc_precache_extents(struct file *filp, unsigned long arg)
-- 
2.26.3

