Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B340B3BE5DD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 11:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbhGGJvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 05:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbhGGJvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 05:51:19 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E51C061574;
        Wed,  7 Jul 2021 02:48:39 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id b12so1615311pfv.6;
        Wed, 07 Jul 2021 02:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tg8Rx1wWlkNbqejilODw641z/b4x4fF9Uuzm0P4x4D0=;
        b=PrljIE+wuY2ULWNMaoB/MgNZV+baMZEw5jLy1StHdilD/VcS99UswWyI5DXhaoGnEc
         AK4A0yeTJpj7bkQC1MWz2HCkCqXW1ZHPIioYLmu5prnU1wrqtg1CmDK6aMjhYzlbVL67
         3nB+owYsvkETSfWHkXSrJ7bqkCO33K5pLz9eXGDh29BvuaxxTeFylm8m5T5rtWVI4nkz
         garM9kmXjh8FTwyk0Tki6hAMb7fxkX0Lw3Au7we3s03pmxuFOiDkBBW9JXCS+pOvJ0BS
         Ebu3SgcWHAGkBwNkJJOWZyc3jOVTJgaV3Y1UBdKg8y/KvqWA54wIP4HqHEtMrqcrLw9v
         kivQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tg8Rx1wWlkNbqejilODw641z/b4x4fF9Uuzm0P4x4D0=;
        b=r6xGre6ap+T7NQ3a6eWv9vXHiynFrC4x2/eIl5MERb5DJIwJW7lNQgIBI9Ll8DaKGO
         Z2xobVGNNl/65Ouk0/qsDrjtwclmCYdh1cRd+fk5AUvGZNCEhXef6SGHZtjeB6BUd5tV
         fIE4zDGqhZmnHf9LdDbw3h866ybKrhOf8J+zww9lzCrNoxwNgPfu/qX4M+aG7oPouEvh
         fEoItdcdQ0A8x8noYyZK9igPw4ss90c75KnXqQfOYKE1ljj3vznaU6wu6BSO8vUw+6DL
         Uc2W15+E6yOhYGZMBVuYJQGZR5NaORSteN0tU2B38BaRZ3mL64FRxwCb2OSFu1O5T9Ix
         kj5w==
X-Gm-Message-State: AOAM532qJQufzXPrpitT2qnzgJSLqT9ZriLGCXwnzEn0VLbh6f3kQWTw
        Mc+A4QqbxRmtdr0udFDpG5E=
X-Google-Smtp-Source: ABdhPJwzoD7XpLG+ejjR/4L4w+W/UAs4g1cNnqO6ljcsHijn2XYr6O/t1MU6B78EiAdv1CW7ZH0+bA==
X-Received: by 2002:a63:5b02:: with SMTP id p2mr25412371pgb.161.1625651318569;
        Wed, 07 Jul 2021 02:48:38 -0700 (PDT)
Received: from carrot.localdomain (i60-35-90-140.s42.a014.ap.plala.or.jp. [60.35.90.140])
        by smtp.gmail.com with ESMTPSA id gd19sm80137pjb.38.2021.07.07.02.48.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Jul 2021 02:48:37 -0700 (PDT)
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs <linux-nilfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/6] nilfs2: fix memory leak in nilfs_sysfs_create_##name##_group
Date:   Wed,  7 Jul 2021 18:48:23 +0900
Message-Id: <1625651306-10829-4-git-send-email-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1625651306-10829-1-git-send-email-konishi.ryusuke@gmail.com>
References: <1625651306-10829-1-git-send-email-konishi.ryusuke@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nanyong Sun <sunnanyong@huawei.com>

If kobject_init_and_add return with error, kobject_put() is needed
here to avoid memory leak, because kobject_init_and_add may return
error without freeing the memory associated with the kobject it allocated.

Link: https://lkml.kernel.org/r/20210629022556.3985106-4-sunnanyong@huawei.com
Signed-off-by: Nanyong Sun <sunnanyong@huawei.com>
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/nilfs2/sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nilfs2/sysfs.c b/fs/nilfs2/sysfs.c
index 43f660beb9b4..5dc468ff5903 100644
--- a/fs/nilfs2/sysfs.c
+++ b/fs/nilfs2/sysfs.c
@@ -92,8 +92,8 @@
 	err = kobject_init_and_add(kobj, &nilfs_##name##_ktype, parent, \
 				    #name); \
 	if (err) \
-		return err; \
-	return 0; \
+		kobject_put(kobj); \
+	return err; \
 } \
 static void nilfs_sysfs_delete_##name##_group(struct the_nilfs *nilfs) \
 { \
-- 
1.8.3.1

