Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4786631F735
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 11:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbhBSKQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 05:16:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbhBSKPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 05:15:22 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E478FC061756
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 02:14:40 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id c19so3430417pjq.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 02:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fxwt0LNnBaNEyLNutCuPu1/fH/EypxrHSZ/cBh21iQg=;
        b=U7n1nSSwOyny+PZaUjmG3dPPk6+1DZ2VBH2Ls31h3H9n8EZEIjzty6WqRMYBxt6lOI
         UkYhy6YQTenNETlGQSBkw7QCsVTGXpw7QrRnuKFj6ObUYVg66VNF/nZ1OQkzPxvguB5w
         yV56FPtReqPJxQ7E0/ykgPkJ/+aTawdFm4EhjH5gtye/LeFRjQ0SLnm1I0ZN5m7EMOjb
         isWKOI2WREppE4Zv9XeY2wgJ4sSxLixAQxgMAVp0DymhrovSByvcsWOLjEzrYKii4Bqu
         CnF8E1dGd4WjYiF1iVYzpCVUD1GS9TZfvqG5NfaD5T8Od6ZOja5xQf5YOv85r0SDVSXk
         iJXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fxwt0LNnBaNEyLNutCuPu1/fH/EypxrHSZ/cBh21iQg=;
        b=HEn8MidHuV1Py60WOyD8aFZ6yQaLsJQMNTprHVYT83O7sakczo1SXluhUGzpTSy6hU
         fgN/AGO3IF5xVmyZ9GvLkfX8sxd9gP+HdzTRY/30rnwAU32rB5nOhG+/4DUn6qxH5n4X
         28iVCQbZ+NBNhAiH6oIYdlrL666JmY1sDzuA2UVoGw90VV4h2fN7KS/Dka+pqP+Wx9Zk
         JDketuLYEn1EPpFLz1p0Q4R4bKCp22Wvxy45vHjT0ERzQoVYYV5eyDglOOvdvgwIv3iR
         2XM0i2ZMQA/Z2lbu5YwpX0J2JxM4sScDXc7XXxKQhPUZcCH613l7EMta4SSNA9FeYzuG
         Fl7w==
X-Gm-Message-State: AOAM533HfNqtVoyUxJp7WzzRPHZLOQXhZC8NtHNsUY5p7l6LgAgwmtIT
        ruPkCHJBXILqRPC4s/bvetI=
X-Google-Smtp-Source: ABdhPJxhODRTDvT8y588cer3Is86ut6WPBL/dlKuxOE4IlpTz2KQAOMr+YE6j7QRII59CmIKOUbzNA==
X-Received: by 2002:a17:90b:224e:: with SMTP id hk14mr8804603pjb.140.1613729680249;
        Fri, 19 Feb 2021 02:14:40 -0800 (PST)
Received: from localhost.localdomain ([49.36.144.93])
        by smtp.gmail.com with ESMTPSA id p7sm4958843pgg.2.2021.02.19.02.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 02:14:39 -0800 (PST)
From:   Amrit Khera <amritkhera98@gmail.com>
To:     gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
        maco@android.com, joel@joelfernandes.org, christian@brauner.io,
        hridya@google.com, surenb@google.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Amrit Khera <amritkhera98@gmail.com>
Subject: [PATCH] staging: android: Fix const keyword style issue in ashmem.c
Date:   Fri, 19 Feb 2021 15:43:39 +0530
Message-Id: <20210219101338.2670-1-amritkhera98@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change fixes a checkpatch warning for "struct file_operations should normally be const".

Signed-off-by: Amrit Khera <amritkhera98@gmail.com>
---
 drivers/staging/android/ashmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/android/ashmem.c b/drivers/staging/android/ashmem.c
index d66a64e42273..7854fd410efa 100644
--- a/drivers/staging/android/ashmem.c
+++ b/drivers/staging/android/ashmem.c
@@ -376,7 +376,7 @@ ashmem_vmfile_get_unmapped_area(struct file *file, unsigned long addr,
 
 static int ashmem_mmap(struct file *file, struct vm_area_struct *vma)
 {
-	static struct file_operations vmfile_fops;
+	static const struct file_operations vmfile_fops;
 	struct ashmem_area *asma = file->private_data;
 	int ret = 0;
 
-- 
2.20.1

