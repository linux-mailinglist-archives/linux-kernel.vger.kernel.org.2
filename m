Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFE92405A8F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 18:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234143AbhIIQP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 12:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232192AbhIIQPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 12:15:25 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E26F2C061574
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 09:14:15 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id l11so1377795plk.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 09:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1JGe4D2wjFUfPd6vacYx/JXO6F3wkweoltx6Dqf7HcU=;
        b=QIqfTWdnhHkMYropAtc5L/CGOqbBtD2oaxfwL0irPS5uuhbKq0VHC/EdOES8zCc7y9
         eDSkwfUxkzfCTk53qTHdGV8HbWHDfsKVnGhz92F6lwXXoDbfPtYHySzcJ6MD90Bk7IZn
         t+Ztf7hqWNxjuhP/EgYohW2gDLqqGeY91Yi+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1JGe4D2wjFUfPd6vacYx/JXO6F3wkweoltx6Dqf7HcU=;
        b=LaBGi5AVdWuWlHWQ5DMQfmDK0BwWBXfJre6/IWSiAW7vCUJnJfPSNobhxtUKOiI1tN
         USlGGkOVuTYDTTIf+9fpKO+c5pryjWgtfQVjTX6cAafd6vtN+sfLaQrb/E6kNrbuwuPt
         v32Wm8UJ/eFp7iz0GZGOqZsY+OeaSAwbq+q+pQ8yP2Q1IjM65XgSox536oi2FEjOQdOC
         BZyaJMYkupKsfDNVUBd9MHbIftbya4lAdKGktN30Nyc+tlQW75/oA0+4tO4mup+vIMKM
         unAcWmtowfrp5YfHXl4vle8wTMiac/IYlKWMDWSMtJ0AKVEltvVoj8KInmSNEojJUl0V
         6ahw==
X-Gm-Message-State: AOAM53240f0Ou8GGz4fco9g+51qAlzAjRtmFSSO4U5rBUhdZs/obM4Q6
        wuvY8HWWv/U/nOUEcztvHDTuMg==
X-Google-Smtp-Source: ABdhPJyRLRkbM2YiR/gGbNNvha2UwrK1QhPP0hjYQxgvP/YlN9gWgEqi62vB80VuAEUW/ciKYDsiEw==
X-Received: by 2002:a17:902:d895:b0:13a:2789:d5a with SMTP id b21-20020a170902d89500b0013a27890d5amr3406615plz.38.1631204055025;
        Thu, 09 Sep 2021 09:14:15 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q29sm3113782pgc.91.2021.09.09.09.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 09:14:14 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        kernel test robot <lkp@intel.com>,
        Matt Porter <mporter@kernel.crashing.org>,
        Alexandre Bounine <alex.bou9@gmail.com>,
        Jing Xiangfeng <jingxiangfeng@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] rapidio: Avoid bogus __alloc_size warning
Date:   Thu,  9 Sep 2021 09:14:09 -0700
Message-Id: <20210909161409.2250920-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3491; h=from:subject; bh=P1lUMvX1H8HLf+qzdl7h1sq7hz8im87SJa/BT7GjmDw=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhOjLQzNf+JyoFp+8+uFIn0W83GW4rwhl8RZ9NWo0X sug5K4WJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYToy0AAKCRCJcvTf3G3AJlQMD/ 93Y1qYVZrgypPvqY4Ut8xrc9WPQh8jQr3gaJrPLNVdI8CIJbjOfG9r+GLul4bA8p6S6i9K9AJpW1Si rlA1aUZkDijoa39HxUhmk9oolXNJC5YwsYYTMaqWkqZoYHbllNdSsLCRbp1jvsd6XvfDXaQ1xS4ucK ah+920AoEV2Lg7mr/OD//SG4q5EJZUsZRo0xrspuDbm+LviTZw4FxtYt9gVW2/FBz2whkCTjm4N+Wv IbiVkq2w84BGWFrqroWKlb7qFx4MwpoPVLXCFuBLGXLH1KFyS/jw557QHJ7aF0fsMEvJDLBzyViUOF hP36PYx9mw1zsQXYzjzH5M/W6uDNdr5qfpkmbsZG9mcxOXXMJ7zdGPcZZ0ac+g2D4aLaSu7OZ9GF6r ADlOcsSbOBh+ltzulhM37Oglt4aiPZ98VW+STqkB7duh27Vn2mI9+xcMXQVPYajVD7j9GZBlUcM8Sz 8CJuwNY53M6k3lPoskUx70sKJ6DTt2m3QItXCM+pMyUr9DJIeUm7j8FDsdSANbnzTlS6uDofwzvZFP yDbE6V2zJ4vgEEf0Wq2Q8ZGo6ji25hYkzQR8tPsXB1ePTyxsd9Gu2VsqnLaPDOSRc81tir7mXDqjnb s5BN+ExnjUek2OEGRonGWWSKfMHuUXxiVHxbWuGBMAx9BbImUewNbKXS9xyg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC 9.3 (but not later) incorrectly evaluates the arguments to
check_copy_size(), getting seemingly confused by the size being returned
from array_size(). Instead, perform the calculation once, which both
makes the code more readable and avoids the bug in GCC.

   In file included from arch/x86/include/asm/preempt.h:7,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:55,
                    from include/linux/mm_types.h:9,
                    from include/linux/buildid.h:5,
                    from include/linux/module.h:14,
                    from drivers/rapidio/devices/rio_mport_cdev.c:13:
   In function 'check_copy_size',
       inlined from 'copy_from_user' at include/linux/uaccess.h:191:6,
       inlined from 'rio_mport_transfer_ioctl' at drivers/rapidio/devices/rio_mport_cdev.c:983:6:
   include/linux/thread_info.h:213:4: error: call to '__bad_copy_to' declared with attribute error: copy destination size is too small
     213 |    __bad_copy_to();
         |    ^~~~~~~~~~~~~~~

But the allocation size and the copy size are identical:

	transfer = vmalloc(array_size(sizeof(*transfer), transaction.count));
	if (!transfer)
		return -ENOMEM;

	if (unlikely(copy_from_user(transfer,
				    (void __user *)(uintptr_t)transaction.block,
				    array_size(sizeof(*transfer), transaction.count)))) {

Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/linux-mm/202109091134.FHnRmRxu-lkp@intel.com/
Cc: Matt Porter <mporter@kernel.crashing.org>
Cc: Alexandre Bounine <alex.bou9@gmail.com>
Cc: Jing Xiangfeng <jingxiangfeng@huawei.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Souptick Joarder <jrdr.linux@gmail.com>
Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/rapidio/devices/rio_mport_cdev.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/rapidio/devices/rio_mport_cdev.c b/drivers/rapidio/devices/rio_mport_cdev.c
index 94331d999d27..7df466e22282 100644
--- a/drivers/rapidio/devices/rio_mport_cdev.c
+++ b/drivers/rapidio/devices/rio_mport_cdev.c
@@ -965,6 +965,7 @@ static int rio_mport_transfer_ioctl(struct file *filp, void __user *arg)
 	struct rio_transfer_io *transfer;
 	enum dma_data_direction dir;
 	int i, ret = 0;
+	size_t size;
 
 	if (unlikely(copy_from_user(&transaction, arg, sizeof(transaction))))
 		return -EFAULT;
@@ -976,13 +977,14 @@ static int rio_mport_transfer_ioctl(struct file *filp, void __user *arg)
 	     priv->md->properties.transfer_mode) == 0)
 		return -ENODEV;
 
-	transfer = vmalloc(array_size(sizeof(*transfer), transaction.count));
+	size = array_size(sizeof(*transfer), transaction.count);
+	transfer = vmalloc(size);
 	if (!transfer)
 		return -ENOMEM;
 
 	if (unlikely(copy_from_user(transfer,
 				    (void __user *)(uintptr_t)transaction.block,
-				    array_size(sizeof(*transfer), transaction.count)))) {
+				    size))) {
 		ret = -EFAULT;
 		goto out_free;
 	}
@@ -994,8 +996,7 @@ static int rio_mport_transfer_ioctl(struct file *filp, void __user *arg)
 			transaction.sync, dir, &transfer[i]);
 
 	if (unlikely(copy_to_user((void __user *)(uintptr_t)transaction.block,
-				  transfer,
-				  array_size(sizeof(*transfer), transaction.count))))
+				  transfer, size)))
 		ret = -EFAULT;
 
 out_free:
-- 
2.30.2

