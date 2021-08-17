Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B28EB3EE80C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 10:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238847AbhHQILK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 04:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234907AbhHQILH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 04:11:07 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B7FC061764
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 01:10:34 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id p22so20925052qki.10
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 01:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=dfE3q4OXpiVQpbNfVoKLEaANxcYqC3T8XxC0IxCHZsc=;
        b=jPESYkkq91jeQiDwQs4TeKi/+i5vQZlhzi+wNgz4UA8+pT+Iw5xltta00A7jASrMoB
         xrv44XXsQwHqrHVXMR2cd3SY4K0izMU2zXd/4m1GMTquYERZQfvAMEek387dVCWk4LKH
         j4qdUn9mLTJ1n2M4X1UxIbJ+U3geInX2P+ixAWHZAG0+wyJxwOMa6DinwtUdyLJe7AFA
         hmpP1GHYz2xpXdLjGoKsGj5g9zYFWLcKoraRyUmRqBDNI8J4FXOMfXyOaf4ZbuAy/Lq3
         YbtJFzJfmQgpsbfxXbKixpfBWtY+7izIQvaorACdBVAG1YglUcI28CUKVwfOxKzWri8j
         bIEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=dfE3q4OXpiVQpbNfVoKLEaANxcYqC3T8XxC0IxCHZsc=;
        b=b+8RcOY/7ShQVeJOAy9UWxaMgs4X+3VlKb1rzC94IRxtEFjV3Sqq+vfOiN+woZAIg3
         NknTd1vHBmmYtyKpn3oXxpgn1gSnL3pd6e9rfbaYCURUR148kAKpk6P30O/fLFEtbrXZ
         G990v8Pp2fZxtRI/w41hCF2gehlpAmyZiSHh2XsSy5j22VX1HngikyxMQ8lEBvsva8fu
         GRP7vmpiYXDqJcmhUoeVLqtX6AEhbEhzz6BEs44AroYqMnNdloIvBWaos3yrQrqgnNlf
         INh6GiimXqtsNNDjCCVLQE0xjnjgNtS2ETJtYVXapGmCkmd5TO/hQBxmvERIy/qY8lhw
         nWvA==
X-Gm-Message-State: AOAM532dnzyNl/cbf5GOysV1kl8rn+oexiKgzGbOFHaF/J/0fG1W3L3U
        oEgiptntLVkergPc2ra0atPX/A==
X-Google-Smtp-Source: ABdhPJxFjAb7CmwY9wmrY5DQiBrSQtn4PIJbTVaSnCE7ZjrwuE8MNykwjZ3v5ynbRguyyjSKqJolTg==
X-Received: by 2002:a05:620a:110d:: with SMTP id o13mr2550467qkk.108.1629187833824;
        Tue, 17 Aug 2021 01:10:33 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id q72sm873408qka.104.2021.08.17.01.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 01:10:33 -0700 (PDT)
Date:   Tue, 17 Aug 2021 01:10:31 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Hugh Dickins <hughd@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 3/9] huge tmpfs: remove shrinklist addition from
 shmem_setattr()
In-Reply-To: <da632211-8e3e-6b1-aee-ab24734429a0@google.com>
Message-ID: <b73b3492-8822-18f9-83e2-938528cdde94@google.com>
References: <da632211-8e3e-6b1-aee-ab24734429a0@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's a block of code in shmem_setattr() to add the inode to
shmem_unused_huge_shrink()'s shrinklist when lowering i_size: it dates
from before 5.7 changed truncation to do split_huge_page() for itself,
and should have been removed at that time.

I am over-stating that: split_huge_page() can fail (notably if there's
an extra reference to the page at that time), so there might be value in
retrying.  But there were already retries as truncation worked through
the tails, and this addition risks repeating unsuccessful retries
indefinitely: I'd rather remove it now, and work on reducing the
chance of split_huge_page() failures separately, if we need to.

Fixes: 71725ed10c40 ("mm: huge tmpfs: try to split_huge_page() when punching hole")
Signed-off-by: Hugh Dickins <hughd@google.com>
Reviewed-by: Yang Shi <shy828301@gmail.com>
---
 mm/shmem.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 24c9da6b41c2..ce3ccaac54d6 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1061,7 +1061,6 @@ static int shmem_setattr(struct user_namespace *mnt_userns,
 {
 	struct inode *inode = d_inode(dentry);
 	struct shmem_inode_info *info = SHMEM_I(inode);
-	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
 	int error;
 
 	error = setattr_prepare(&init_user_ns, dentry, attr);
@@ -1097,24 +1096,6 @@ static int shmem_setattr(struct user_namespace *mnt_userns,
 			if (oldsize > holebegin)
 				unmap_mapping_range(inode->i_mapping,
 							holebegin, 0, 1);
-
-			/*
-			 * Part of the huge page can be beyond i_size: subject
-			 * to shrink under memory pressure.
-			 */
-			if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
-				spin_lock(&sbinfo->shrinklist_lock);
-				/*
-				 * _careful to defend against unlocked access to
-				 * ->shrink_list in shmem_unused_huge_shrink()
-				 */
-				if (list_empty_careful(&info->shrinklist)) {
-					list_add_tail(&info->shrinklist,
-							&sbinfo->shrinklist);
-					sbinfo->shrinklist_len++;
-				}
-				spin_unlock(&sbinfo->shrinklist_lock);
-			}
 		}
 	}
 
-- 
2.26.2

