Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA5263775B1
	for <lists+linux-kernel@lfdr.de>; Sun,  9 May 2021 08:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbhEIGfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 02:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbhEIGfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 02:35:51 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14138C061573
        for <linux-kernel@vger.kernel.org>; Sat,  8 May 2021 23:34:49 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id p17so8051851pjz.3
        for <linux-kernel@vger.kernel.org>; Sat, 08 May 2021 23:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=9cHDGycB4MlPMMHx0InSbLIU3y0mqIv2WQS7zeqfSX4=;
        b=dYmSfCvTNlA8GCsxF+M4TUXwBKIbKIk0SWZ1rdCnib4FWDSykcrVzIpmBHoGLesPEL
         TVOcbNKrVvusani65j47pD/lmfYzOHnsYJN20moDr5Hdu3eC/IP1X1R2BbPhAP2cGa1C
         T0/mmoUE1FXYUFM2/73t4wzIV2xP8bISfSDGtgN4WRafIBg0uYTTvkjonXDtZDC7ucxf
         vl0o+GEF7U3f4nln0kNLX1EJERD3o8WqO6Xg3M9Za7akY8Io6NJhUnqp25O94QNFHdhv
         BOASGA3QMvEN0rD3j7EsN+5mm5vDfXu5snIzOo6tpXdJ81OQ/zB98eDyKODIa1urwLcb
         VVPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=9cHDGycB4MlPMMHx0InSbLIU3y0mqIv2WQS7zeqfSX4=;
        b=RnpOAVw//tLJc0kBOeAFQxHsfvgVPsA3p/bIlLuqWchHGz+8TMFyklrRMVE/rXwAc0
         44OQ82gdxEAJ1peAhgiyX3olYDCgpCdu7itMnYuAmtmeyeoV1lcm4nbIWU4eqznap0H9
         qWIF2RMFLi6uW0TELsChY68mq5/fZBNuWpJ5IRRyU0HLJuBiEYol07WacYlcOaZyZoGb
         qtOgUuHewQUxauh3+5IyozoXza0omV3N3fC5pPuCwxkdMrckcCeEXH1HqQr6rJpCK3wS
         8rtWxA3s7JK+UeMrKvj1LuaNr5S1An2aJ/GRZ0eZ4KgM5BeT3uw0iMV1dO91q57XWfsY
         pJ0Q==
X-Gm-Message-State: AOAM532mktVG5T5cUl/QK7RASSm+yPhqAEJX+gnog/jyU+F7IGicUtLq
        1Q7oPUCmFbD/pxU0RRJDtA4=
X-Google-Smtp-Source: ABdhPJxya7fNTk7qEC+fGvp0zvXqd/KdSUhTXQ7XDOjeCX64aw9ltJaAeUs/4n3carxqQ9WhJkhsBA==
X-Received: by 2002:a17:90b:1bd2:: with SMTP id oa18mr20284880pjb.72.1620542088524;
        Sat, 08 May 2021 23:34:48 -0700 (PDT)
Received: from hyeyoo ([121.135.181.35])
        by smtp.gmail.com with ESMTPSA id 21sm4968771pfh.103.2021.05.08.23.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 May 2021 23:34:48 -0700 (PDT)
Date:   Sun, 9 May 2021 15:34:44 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] mm: fix typos and grammar error in comments
Message-ID: <20210509063444.GA24745@hyeyoo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We moves tha -> We move that in mm/swap.c
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
index dfb48cf9c2c9..9ca78a283ace 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -554,7 +554,7 @@ static void lru_deactivate_file_fn(struct page *page, struct lruvec *lruvec)
 	} else {
 		/*
 		 * The page's writeback ends up during pagevec
-		 * We moves tha page into tail of inactive.
+		 * We move that page into tail of inactive.
 		 */
 		add_page_to_lru_list_tail(page, lruvec);
 		__count_vm_events(PGROTATED, nr_pages);
-- 
2.25.1

