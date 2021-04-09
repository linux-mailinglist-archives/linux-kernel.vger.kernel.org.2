Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE18035A2EF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 18:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233395AbhDIQWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 12:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232395AbhDIQWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 12:22:30 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67674C061760
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 09:22:17 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id q26so6370269qkm.6
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 09:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LPSR+SFooTaPgtBFedHf7Y31wtqhJOh5AqAapK2wyzs=;
        b=Q056bBDn7nbWunIqwgtUvNhy/EQyhNM6musYnQj7QpKC9MnxsY0qm7rHMSKR3wlLwF
         VxsdZFCvdQ9fTWUyEUR3SjENQ7y9DL/o82sAd385sro4Quk8mw1CAvc0/6fv8gxLtS0V
         aFyhjYa2+fANtrshg5ulm/gR2QV3RzKaIacy+FqTT4M0KLq1n7wV1C1NBytz8vbgByn0
         Tt7V/5Cvn3y/72itgyTGQBE4y/pAbCz3FKu5UtR+jbAUJmOLxCvEfrYtw9bfL9LkP1EH
         yPVhSTzhuDRTzpD/R+B2Wj1/C276yeop31/JV2jlLQv7n/jN/tTxIOgIKA5zpI9MOXgC
         P8ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LPSR+SFooTaPgtBFedHf7Y31wtqhJOh5AqAapK2wyzs=;
        b=UdkQl6XB2Xglr+L13NHnz8wc4FltxGUrRvdHMQ3UiVW/pDQ59r0w6gQKwccZXbMtv+
         rzrwccn3n+oGB/6zolGfL25ejYowDmexngBQAzHm7qVaQHlvpA5BRfvzs6hQwTX16p1G
         dzR3PL7JYjPsgJ7dyGOg6H2IXh8bvPrverwtraGhM30dMaOiNyELfpuw0eL5VL6ssnP7
         cgX3b6Zzqlzpot+MLlR7y1BMmTlsiwUuxvgbkJc89WS0Udnmd5hF/YZZtEeVjARfewOA
         o7MJOJRswB++DJfK/5fcG7cNfY+d7xZItQ4uAnvdun3VYSRrIDmCVGwRH/CL+PxG97fi
         AJxg==
X-Gm-Message-State: AOAM530ATE/fUYX4a3igSZk8Tsfk0e0RZ8Eu8N3OBc+mu8CI8B1SQ8y4
        8GROTJsatD/nIX/N4sNsjTQ=
X-Google-Smtp-Source: ABdhPJyV0BE86hD+1Lz1UISNzlxC1GNIuBKcE2RdCuH2q3ucvcY4bff6RxkyRVea7Of5FCyOz2hY0Q==
X-Received: by 2002:a37:6288:: with SMTP id w130mr6932186qkb.70.1617985336747;
        Fri, 09 Apr 2021 09:22:16 -0700 (PDT)
Received: from localhost.localdomain ([192.141.93.162])
        by smtp.gmail.com with ESMTPSA id f13sm2205268qtg.2.2021.04.09.09.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 09:22:16 -0700 (PDT)
From:   Gonzalo Matias Juarez Tello <gmjuareztello@gmail.com>
To:     linux-mm@kvack.org
Cc:     Gonzalo Matias Juarez Tello <gmjuareztello@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/mmap.c: logic of find_vma_intersection repeated in __do_munmap
Date:   Fri,  9 Apr 2021 13:21:26 -0300
Message-Id: <20210409162129.18313-1-gmjuareztello@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Logic of find_vma_intersection() (which is an inline fc) is
repeated in __do_munmap().
Besides, prev is assigned a value before checking vma->vm_start >= end
which might end up on a return statement making that assignment useless.

Calling find_vma_intersection() checks that condition and returns NULL if
no vma is found, hence only the !vma check is needed in __do_munmap().

Signed-off-by: Gonzalo Matias Juarez Tello <gmjuareztello@gmail.com>
---
 mm/mmap.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 3f287599a7a3..59ceaa474a00 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2822,16 +2822,11 @@ int __do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 	 */
 	arch_unmap(mm, start, end);
 
-	/* Find the first overlapping VMA */
-	vma = find_vma(mm, start);
+	/* Find the first overlapping VMA where start < vma->vm_end */
+	vma = find_vma_intersection(mm, start, end);
 	if (!vma)
 		return 0;
 	prev = vma->vm_prev;
-	/* we have  start < vma->vm_end  */
-
-	/* if it doesn't overlap, we have nothing.. */
-	if (vma->vm_start >= end)
-		return 0;
 
 	/*
 	 * If we need to split any vma, do it now to save pain later.
-- 
2.31.1

