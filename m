Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8053C41E3E7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 00:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344758AbhI3W3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 18:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344445AbhI3W2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 18:28:52 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE09C06176A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 15:27:09 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id n2so5008779plk.12
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 15:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GaXhZfS3SkuPHPb6xTQTxvCajWqyFQ1hefFZoAWnwRc=;
        b=m/jZ9lSLkAVVF6mTXVVWjFv9AqESJN0KqU12E/BMpoLdOJPPpIkGJTwQV1mwZVxN6G
         ATyOjcAXqlX8YUbI8bMpmoo0sJ0Um/+GRNCA+oSDXsv3Un+NQjqWYTL5fgoCTts/OQc4
         FywvqNC2+qAoY1d8Ed2zjUd3krt+fFcauSdU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GaXhZfS3SkuPHPb6xTQTxvCajWqyFQ1hefFZoAWnwRc=;
        b=f5lvCJfU3EC9DrPnxLd5U96OsU4z2h4ipZYr5mrd+fokWxUA1aJ/S73ZckPR6vMKoL
         ZRRpgNp+4IKX1DM/r2NR5N8Sp/TQ1brMFUpNM768WmUx0Jgv39Urp8ni9ogfnj1rReM6
         c5zvCgII9ldD5w4di7Nkq0zqFBx8oeWcwkL5zN2uzl0awjftWPwkfiZ8iH0hOdsPPHaz
         CBbqgsMec63mIX8iLNOZdb9h+0b4OmopAjHVu1mV9WdjX931r0x4ySANUcs6bZ3WIkAz
         VBL/461QDwx+b5UVUmy53ydMCaQ7BNzN8p93wm3InVjbdfxUip3/0Gq5fuVEA+jcPnct
         ZshA==
X-Gm-Message-State: AOAM530Bq+YB503GgFxj6SyC8btdv5/lwHzSz3wyldp4nHQDiV++WPRY
        /EB60cIBXAPMNV0lC7zPuV9WiA==
X-Google-Smtp-Source: ABdhPJzftNnOZom4YbdrJDsQbfPg6hKnTJpKhFYuH780j2abTGY0bRzbD2ok15tI+WMORBPimueYwg==
X-Received: by 2002:a17:902:ce8c:b0:13e:6848:b996 with SMTP id f12-20020a170902ce8c00b0013e6848b996mr6365750plg.11.1633040829416;
        Thu, 30 Sep 2021 15:27:09 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 67sm310724pfw.89.2021.09.30.15.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 15:27:07 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        kernel test robot <lkp@intel.com>,
        Matt Porter <mporter@kernel.crashing.org>,
        Alexandre Bounine <alex.bou9@gmail.com>,
        Jing Xiangfeng <jingxiangfeng@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Joe Perches <joe@perches.com>, Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Daniel Micay <danielmicay@gmail.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        clang-built-linux@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH v3 1/8] rapidio: Avoid bogus __alloc_size warning
Date:   Thu, 30 Sep 2021 15:26:57 -0700
Message-Id: <20210930222704.2631604-2-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210930222704.2631604-1-keescook@chromium.org>
References: <20210930222704.2631604-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3560; h=from:subject; bh=d94GdIidGnmnix6Lfr4v5jKawcjolJm1KlCBxnnJy6k=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhVjm22lbILpU3a928XS7AjfDqGHN2fNCgtxXpqL4C vZpYRAqJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYVY5tgAKCRCJcvTf3G3AJoJAEA CkQ4KHKGJZGbYmK+l1h5sRm1VUBh6JfQZa/gzvXJbs5XaNgP24EPw8Dnih4znZJD1ATTwTmsErFD+Q GZ6OxclhvrD/Vl0n+y95WYCyiegLqupRVyVFFRo/b1orpbSJhekIx+wLfu5K82nwfR/z3fqHspd6Jb C25b2/S4YVArCQx5p/IuFXg8MkHWWwVJGUtFz8bBY4Q1tNHUXbXLWxD6TrGhzWXHRTElkTlX6qC8L2 kkoQerLVTHGEpiXZ7dRR87HWTpaWfUDSt7bcTbf3OEIwZMiD2CUSmascMBmaCN9Lm2CYzFbnJj59Z3 QhDesB6qHk3d2G31rFJolLcoutGjK3X+AJiFJX8Q5LkbMNhoM1xPVcrkb1hill82zRek3uIYvFmoal TWtTKlV7b7M04qtOznFW+wyE1HsAIF/XWpHZ/T7dmjAY38+EG/JV8bSiWFJ3DN2/kMH3opOPMPqLm8 7HktqHnvYvAiun7gBTv+lcoY76OVlmWVuhVEqb+NeVsK0ycLvO6PlLnO5x+btj22XbuHnKNCRG4k2S OeBHJ+KPdk9sja34I/vFVHDfMVK5iy4mXCdbe4ip4w3Ov6jjqjsb6epT+yg3BIMUCScGfAsg7fyA0v HNNTdQCNlDpTzp5mOY3uIkDpIfjNhHWJg4S5+XL+hlGt8+9O4d6fE//ZNtVA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After adding __alloc_size attributes to the allocators, GCC 9.3 (but not
later) may incorrectly evaluate the arguments to check_copy_size(),
getting seemingly confused by the size being returned from array_size().
Instead, perform the calculation once, which both makes the code more
readable and avoids the bug in GCC.

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
Cc: Souptick Joarder <jrdr.linux@gmail.com>
Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
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

