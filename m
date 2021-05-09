Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACCE3775AE
	for <lists+linux-kernel@lfdr.de>; Sun,  9 May 2021 08:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbhEIG1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 02:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbhEIG1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 02:27:10 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C3B7C061573
        for <linux-kernel@vger.kernel.org>; Sat,  8 May 2021 23:26:07 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id a11so7611841plh.3
        for <linux-kernel@vger.kernel.org>; Sat, 08 May 2021 23:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8rvkZQJPVhhAkzOhR/bQQFLzl3StE78csXvd0uX6Jlg=;
        b=aaGQ6j2CTQOdHRefAP01P2aa+wnbvbWPGEnhBx1cOzloXF0obYmt7ajr9TcTxsGUx9
         jpUqt6EwOux61dIgw0yc2/PaDTluCwXKyMhujfYQ10P9oPzystMTgoVi0OoeAfHSp1PV
         Z+J/pyzpU/R/O6teUBr7ThPI5vZzu4+0Iy4/n+UVD5GuJs4HScl7Hb1hjHKl4lwYZJp3
         fmJpz10hVkx/731EMg87Yp1kW9Q6MP/Lnejq/nc3+MNTLUiglZ7IYE1r0dq2lmT7Q423
         yjhNBzxVGb6ocgHYZnEoJ0YgMYfYQwZzD/IXcF7hfKAOmsuAm9R2JsqKGEL33CvrK4Qv
         RZdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8rvkZQJPVhhAkzOhR/bQQFLzl3StE78csXvd0uX6Jlg=;
        b=KG6IfncQtxJWxSvh3YKsxZqas5OqBo82nAFQ9w+9aJex49RyE8+k4IATXVFw29k4CS
         cTLy9Bnvh0fTMdBFpjeQgfBoOlZXfury50MM6qjpNFgt1AzjsMJpsgWjY4l0ZplV6NLk
         wzpeK1InseAb12M0OOt+9r6M7+xCggvQ72IffwC2Wfyi1h3aBA1tVz6J/Cej7X7Z6SbY
         vEzc9Lucx0tZXXtc4FcFG0AgSzpP4PKufa68xUKKCKl8fJjtj5LIAqHfEMcWHLUrSKgr
         +ihvs/vbRu38QqYVL0nDS9CdTRXPfnXklo+kK/sza+OO3IP1gy0uuXLHF1duVCgGPDSo
         93qw==
X-Gm-Message-State: AOAM533H0/cqEvmKDHP5ciC3q3IaXcQTrEEx11ds352MWXQkR8obXHRP
        M2hHR7MS7xtHe/TRxOKilXZx62Cdggo=
X-Google-Smtp-Source: ABdhPJyTabwy15ul0Axm8iMOkVoOZiHXj90PeRLDL2/hvMYryLCs2QJcs5Hv6o+IRjUDllC+8uA9Vw==
X-Received: by 2002:a17:90a:4108:: with SMTP id u8mr20454056pjf.126.1620541566676;
        Sat, 08 May 2021 23:26:06 -0700 (PDT)
Received: from hyeyoo.42seoul.kr ([121.135.181.35])
        by smtp.gmail.com with ESMTPSA id h1sm8069571pfh.72.2021.05.08.23.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 May 2021 23:26:06 -0700 (PDT)
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: [PATCH] mm: fix typos in comments
Date:   Sun,  9 May 2021 15:26:00 +0900
Message-Id: <20210509062600.23860-1-42.hyeyoo@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tha -> that in mm/swap.c
statments -> statements in include/linux/mm.h

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 include/linux/mm.h | 2 +-
 mm/swap.c          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 322ec61d0da7..ea074f7a9d0c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -155,7 +155,7 @@ extern int mmap_rnd_compat_bits __read_mostly;
 /* This function must be updated when the size of struct page grows above 80
  * or reduces below 56. The idea that compiler optimizes out switch()
  * statement, and only leaves move/store instructions. Also the compiler can
- * combine write statments if they are both assignments and can be reordered,
+ * combine write statements if they are both assignments and can be reordered,
  * this can result in several of the writes here being dropped.
  */
 #define	mm_zero_struct_page(pp) __mm_zero_struct_page(pp)
diff --git a/mm/swap.c b/mm/swap.c
index dfb48cf9c2c9..a1c9d23ef635 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -554,7 +554,7 @@ static void lru_deactivate_file_fn(struct page *page, struct lruvec *lruvec)
 	} else {
 		/*
 		 * The page's writeback ends up during pagevec
-		 * We moves tha page into tail of inactive.
+		 * We moves that page into tail of inactive.
 		 */
 		add_page_to_lru_list_tail(page, lruvec);
 		__count_vm_events(PGROTATED, nr_pages);
-- 
2.25.1

