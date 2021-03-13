Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1541339F20
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 17:37:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233988AbhCMQhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 11:37:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233570AbhCMQgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 11:36:45 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D84C061574
        for <linux-kernel@vger.kernel.org>; Sat, 13 Mar 2021 08:36:45 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id lr10-20020a17090b4b8ab02900dd61b95c5eso9984844pjb.4
        for <linux-kernel@vger.kernel.org>; Sat, 13 Mar 2021 08:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=f/ATcZDgkpa69P3OCF6HCVINJhil+2RUrXNv8f9zA+k=;
        b=BISTZwpWpzDorRYdwWsudjSDVsnv0cvr7roJ9xg7jQyRR+rkzMPUoyS4QqddE4pPNt
         l2KgWSxiPZMdqi2PHDqcJUSy+lmpK6GcbPfLO6z81nsEV38lR8rqOlVh0XtvgiHKTlaB
         JSKjXm3v05+rlgTP3gxnr0EhUX1lvF+sybMKCx7hIpHTlSJ9faoDcqg52PBrUB/6KPn0
         w6THmLrkLo+fPf3z7Vqhey6uvZ0gHn+AsLZMpGkRp2Jnv7JiXB3C5pqxJD75dqAPbLS7
         AplHlGqA1tuwEh0SPHenDhTEOXjdaCXFkNG1AeeZ+u4roLvdlYkTxG5UkDbA09xE9I2I
         089w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=f/ATcZDgkpa69P3OCF6HCVINJhil+2RUrXNv8f9zA+k=;
        b=NFuLEY4J3hEG+R1g85TRNVkAvhlfDudY6AhC0NBeWeSF5WIrIeYpCCzbB+RLFygErm
         kMCOGKRQ+h6/D2r8w42mU0z9pdTZ6dQ/j5sGW/bS1MuWj3nto7fCjhOFFkYB83nFys11
         TbiXTwEbjcBkph6jsNzHoImYN85CyQWfrkEs50x5FBRebrl+UoXuvgMpDafkJoQva2/j
         nYvwPOo8gBiTjI/wtOzznQnkKtpJ7Oi5oa8eJwQmi07sF83qtmoMMsNYRNkyaDurbrUF
         /7HAtNrlCGl96bK4+6g9tXVDB/orjh8BTAX8TurVYA0uwjNQ4bGDHAlZ/ZYTV+5/UNha
         HNTw==
X-Gm-Message-State: AOAM530XLBRsxgvcKOkItpWgbOKHMnq+yOFpklgiApjtiW3yY7eB61Vd
        IEnj/JvdcfvgM28jHqFk7SsRGm8Mo2/eqSp9
X-Google-Smtp-Source: ABdhPJyp5Cfo2IeSGYAHMWfG44hpCWGLBdA/oiD7BM9sGH4JSnkuudGFYRWmKbyA3dAI6AtJq5TzTQ==
X-Received: by 2002:a17:902:ee06:b029:e4:ba18:3726 with SMTP id z6-20020a170902ee06b02900e4ba183726mr3869011plb.17.1615653405036;
        Sat, 13 Mar 2021 08:36:45 -0800 (PST)
Received: from client-VirtualBox ([223.186.9.86])
        by smtp.gmail.com with ESMTPSA id v14sm5930740pju.19.2021.03.13.08.36.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Mar 2021 08:36:44 -0800 (PST)
Date:   Sat, 13 Mar 2021 22:06:35 +0530
From:   Chinmayi Shetty <chinmayishetty359@gmail.com>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH] Bio: Fixed the code indentation by using tabs
Message-ID: <20210313163635.hisfsmzoxaeoyf73@client-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed coding style issue

Signed-off-by: Chinmayi Shetty <chinmayishetty359@gmail.com>
---
 block/bio.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index a1c4d2900c7a..7c1354f7065c 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -501,6 +501,7 @@ void zero_fill_bio_iter(struct bio *bio, struct bvec_iter start)
 
 	__bio_for_each_segment(bv, bio, iter, start) {
 		char *data = bvec_kmap_irq(&bv, &flags);
+
 		memset(data, 0, bv.bv_len);
 		flush_dcache_page(bv.bv_page);
 		bvec_kunmap_irq(data, &flags);
@@ -616,15 +617,15 @@ void bio_put(struct bio *bio)
 EXPORT_SYMBOL(bio_put);
 
 /**
- * 	__bio_clone_fast - clone a bio that shares the original bio's biovec
- * 	@bio: destination bio
- * 	@bio_src: bio to clone
+ *	__bio_clone_fast - clone a bio that shares the original bio's biovec
+ *	@bio: destination bio
+ *	@bio_src: bio to clone
  *
  *	Clone a &bio. Caller will own the returned bio, but not
  *	the actual data it points to. Reference count of returned
- * 	bio will be one.
+ *	bio will be one.
  *
- * 	Caller must ensure that @bio_src is not freed before @bio.
+ *	Caller must ensure that @bio_src is not freed before @bio.
  */
 void __bio_clone_fast(struct bio *bio, struct bio *bio_src)
 {
@@ -657,7 +658,7 @@ EXPORT_SYMBOL(__bio_clone_fast);
  *	@gfp_mask: allocation priority
  *	@bs: bio_set to allocate from
  *
- * 	Like __bio_clone_fast, only also allocates the returned bio
+ *	Like __bio_clone_fast, only also allocates the returned bio
  */
 struct bio *bio_clone_fast(struct bio *bio, gfp_t gfp_mask, struct bio_set *bs)
 {
@@ -1009,7 +1010,7 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 				put_page(page);
 		} else {
 			if (WARN_ON_ONCE(bio_full(bio, len)))
-                                return -EINVAL;
+				return -EINVAL;
 			__bio_add_page(bio, page, len, offset);
 		}
 		offset = 0;
-- 
2.25.1

