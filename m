Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDA583C83EA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 13:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239133AbhGNLek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 07:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbhGNLej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 07:34:39 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B80C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 04:31:46 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id h1so1332800plf.6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 04:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xzP9JfDqYJBn+lgkJ5neqY7O14ZLPqoi6I2YFgNMZsE=;
        b=qBF4f564yxbWbWqj3DG79Ntsuw4R0D0YUsnc3p57YClIF0HU4FoYWd4L04VW6zNbKz
         nzf+9Ii61rc06s7ea290CU4F+loflLIeD9D2WZCaCOxOvcrfiXzCb3BZdpyZGA0rV+GS
         LKoFeDqsLVf3ymERmKofS77J9XOaCFUdOzkfhBhO98OFh01WDTz2Eaq3iUgRCjiEB8WE
         cJm9ScsEwFCD0BwkXbfoCwtX4yeHV1oI9oFe8Hoq09Y02HW4ng18DMAw7nkIl4d6GWoe
         j5T+xZ8W0iH0871WC8/fwdY/3Ju98o2rlYUOAJcbkwy4GJty6/crOizpfXyIcdL9AtUq
         Miow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xzP9JfDqYJBn+lgkJ5neqY7O14ZLPqoi6I2YFgNMZsE=;
        b=k3TcGt/jNSatZ2mbBrwFR6lwzdvxuwLSj8zPrfq52zHx27jo81ayrKQT2xB2mO+nZ8
         mgYRmmUxhaWCzIyzBPNhRBTj2DXrtGKXEd8GlBdLN26aKFRRw6fKcnr95ADliNPlUVh8
         YHtLChOf+5mjeb06xo045tWjIM2kBJW2d3ZNeYNNZHok1Ew806WLCWKJR1X/CDhS4hd9
         2nDyEnNCRjMymINmuW+blmThnjTpM37USJkvOUWbmjsZzvgOem2vW64fICVVViHzRJxk
         SHLdyYUlavoFinMEbEEFLAU6rFoOEPdDr5Bt6x1sxrc6mExwYhv01ErF0zwYrL8DmPRI
         Io5A==
X-Gm-Message-State: AOAM533jnv/RYdK8iafn2BO2gJUR0oX7jrb4ihxQdHUynIcQcXUAB5Ud
        lOtplu2JNTv4YDaq9D/isYo=
X-Google-Smtp-Source: ABdhPJwFeuyNMZp1zLa0XAcShrXvkzNL7Gx0wUMWfX8C7tekIfM5jkADKNozUqFglIRoEhMO0shcaA==
X-Received: by 2002:a17:90a:6be1:: with SMTP id w88mr9400355pjj.121.1626262306372;
        Wed, 14 Jul 2021 04:31:46 -0700 (PDT)
Received: from ownia.. ([173.248.225.217])
        by smtp.gmail.com with ESMTPSA id r15sm2830316pgk.72.2021.07.14.04.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 04:31:46 -0700 (PDT)
From:   Weizhao Ouyang <o451686892@gmail.com>
To:     glider@google.com, elver@google.com, dvyukov@google.com,
        akpm@linux-foundation.org
Cc:     kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Weizhao Ouyang <o451686892@gmail.com>
Subject: [PATCH] kfence: defer kfence_test_init to ensure that kunit debugfs is created
Date:   Wed, 14 Jul 2021 19:31:40 +0800
Message-Id: <20210714113140.2949995-1-o451686892@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kfence_test_init and kunit_init both use the same level late_initcall,
which means if kfence_test_init linked ahead of kunit_init,
kfence_test_init will get a NULL debugfs_rootdir as parent dentry,
then kfence_test_init and kfence_debugfs_init both create a debugfs
node named "kfence" under debugfs_mount->mnt_root, and it will throw
out "debugfs: Directory 'kfence' with parent '/' already present!" with
EEXIST. So kfence_test_init should be deferred.

Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>
---
 mm/kfence/kfence_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/kfence/kfence_test.c b/mm/kfence/kfence_test.c
index 7f24b9bcb2ec..942cbc16ad26 100644
--- a/mm/kfence/kfence_test.c
+++ b/mm/kfence/kfence_test.c
@@ -852,7 +852,7 @@ static void kfence_test_exit(void)
 	tracepoint_synchronize_unregister();
 }
 
-late_initcall(kfence_test_init);
+late_initcall_sync(kfence_test_init);
 module_exit(kfence_test_exit);
 
 MODULE_LICENSE("GPL v2");
-- 
2.30.2

