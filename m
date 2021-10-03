Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78F80420160
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 13:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbhJCLn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 07:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhJCLn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 07:43:28 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF75C0613EC;
        Sun,  3 Oct 2021 04:41:41 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id d13-20020a17090ad3cd00b0019e746f7bd4so1893120pjw.0;
        Sun, 03 Oct 2021 04:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/D8bXyu49DxBdYOqHuSui3s+tc6MfuSn1HC3CjVWP6g=;
        b=l3/+qZ+lxn3ZuJlc69ANU1xZBUFyjznJ/dhb5dnFZVdSQ6HSE+KfbSegxcLYg5Hclx
         yk+jTUbwXtdJ1i3Ta7MkC1dYj/VU422S7zXSRcLo47vfYzEWjmfB73PKT9C3TpDc6ule
         Czeo7Ee0CSGlfe0ghoqVFLiQmUHG4S7UEySK5SDhF2eHoenmBw36f60g6468/0yY9RTx
         wS2GbwToeD3CD4wtdyuoBnaDkPG33H5U/zNEVkll0EWIaRitIN3EHraSxCBbcH3KHtfd
         7+E0ELX49iOjLVArhmmAAMLe7rqvDzS+L+E6KZCClR2wvU38LSby6Ht7kpKPtHI3AvM8
         sX8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/D8bXyu49DxBdYOqHuSui3s+tc6MfuSn1HC3CjVWP6g=;
        b=loUZZBcCgl8jY5tDfmWVMjYR8lMuN2fsNAA9YCnTN3Vj9L2LbwFFy6HrpInVhpa+PY
         KH4lem35O5x/f8lORgKgEKXDh6byXuMe7vDnCpDPuid9qgO2ZhCAuopcZ6lIDxRefA++
         unBzeWgzSzkmCPSE2Oi99AE5aFoyTFRNhSdtDYDD1NS9HLUKWi48cZJ2Ibt6Ftl6A1kr
         Gekg61+gYZ0halMW8eAOcB1jDbEinBYXzDTGc3JFaeVd9eDN3Jsm4t+2tYE3YxW/7sDJ
         CvSByhaf7UJeyrkoEXYX0z8L8plgLr5ALC0JKUeDZwa9Icb3ua7zBB9fHqF+pEb/mkfc
         UuCw==
X-Gm-Message-State: AOAM531H2LxmQXsIJaMad2Y+nurHcZtWosS2TQ0lM0Gdj+UEk/lTlHIn
        DKF15stDIFQXX1t6KvS371s=
X-Google-Smtp-Source: ABdhPJzEXo5XpNXHFNgCL+WuGLFf0o5O5/LmEBJzprQr6lzDPqEAs4lqCoAZYlQZi2cIIC1OjnsqKw==
X-Received: by 2002:a17:90b:1d84:: with SMTP id pf4mr8614263pjb.107.1633261300673;
        Sun, 03 Oct 2021 04:41:40 -0700 (PDT)
Received: from ubuntu.localdomain ([171.224.177.7])
        by smtp.gmail.com with ESMTPSA id d5sm10071574pjs.53.2021.10.03.04.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 04:41:40 -0700 (PDT)
From:   Nghia Le <nghialm78@gmail.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        nathan@kernel.org, ndesaulniers@google.com
Cc:     Nghia Le <nghialm78@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        lukas.bulwahn@gmail.com, kernel-janitors@vger.kernel.org
Subject: [PATCH] mm/hugetlb.c: remove dead store in demote_size_show()
Date:   Sun,  3 Oct 2021 18:41:13 +0700
Message-Id: <20211003114113.109463-1-nghialm78@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The command "make clang-analyzer" detected a dead store.

Remove demote_size and corresponding assignment in function
demote_size_show() to fix dead store, as demote_size is never read.

Signed-off-by: Nghia Le <nghialm78@gmail.com>
---
 mm/hugetlb.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 993efa70bce4..ef00e6ad0f6a 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3706,11 +3706,9 @@ static ssize_t demote_size_show(struct kobject *kobj,
 					struct kobj_attribute *attr, char *buf)
 {
 	struct hstate *h;
-	unsigned long demote_size;
 	int nid;
 
 	h = kobj_to_hstate(kobj, &nid);
-	demote_size = h->demote_order;
 
 	return sysfs_emit(buf, "%lukB\n",
 			(unsigned long)(PAGE_SIZE << h->demote_order) / SZ_1K);
-- 
2.25.1

