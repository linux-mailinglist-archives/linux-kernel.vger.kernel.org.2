Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4712A3EBF39
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 03:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236271AbhHNBKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 21:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235870AbhHNBJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 21:09:54 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 045BDC061756
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 18:09:27 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id f3so14206030plg.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 18:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5D/+fbzE5sNokosW3SJuO12q+qyf/as7HJwwSlZSGn0=;
        b=ncZlge2rIcvnJzYI7PRcWnBtNtgdLh3ETnIGmYI7cdag5xJh+7XA98f/YDMZ5xal6l
         RVGBw7XNAsD6Pdthj3Kr3b9mWrymbm8tIRSo/lNJBNOZdo2dNqbrnVR9XpQdoOhcKt5/
         2ARxnegKHFG927RnQvtw2w9uPGfQ8HyP3wqr1/KXVjz3adUJoZktg7fpi1Gp/396qPgU
         KQtZcS4hULZ6a6aR3JAQEfgQtdCYjALQMH5K+jBCu+ecJpLaUYXN2JKGQbN6sC1dm49M
         AjDCzYkSknQBr+YR8QUqlX2StHykTJhgZ2Zz9ChjocQI4Sll+p+NPoCipc8abIXEvP+U
         OH/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5D/+fbzE5sNokosW3SJuO12q+qyf/as7HJwwSlZSGn0=;
        b=S6vsgjp7wp7aowMuzi0lKvizsyglyxvI2MRtGFPACASNBhX9zm/wPL+79cgyP8BbJu
         bMJVU9m5UUTHnjEQ+EYHtJ0SqD5GJW6V458VS1fQlQXxDzXKEAmCQ47htw8jlsuPg0EY
         bNsSNp5bvhBbt6y+E03xsjzy3E5OnFRK+rfMOiYDOZoKpP/J9UaA8XYkeNgLfuBIbgu8
         yKQJPZxoX0/l0MXj42jAuY2sNBtvAMj/wenxlPqZ1EVugE/Tg0E4AyEQ5iXKdHnGOOvE
         F/0hZAxlDQsWpIqNxZYNBSpOFwO38iqxFsd9Kw/UyMNxET5w620g3vTkoHLiNygbtWdU
         P4wA==
X-Gm-Message-State: AOAM5322nIHLs6kyOGWACWqXIwcv3IUYBnQV5F0cNjh8ewHmJxJe3A6K
        TCFo0aajzeg+5W4nKhKxtUw=
X-Google-Smtp-Source: ABdhPJxm/MRTek6CZZ0jeJciQa83JlPsvJsBAAqNZuUhMX56iBF7Lyt7/7Tiovo/vN7zMjNXfXsonA==
X-Received: by 2002:a17:90a:e507:: with SMTP id t7mr4518482pjy.208.1628903366573;
        Fri, 13 Aug 2021 18:09:26 -0700 (PDT)
Received: from WRT-WX9.. ([141.164.41.4])
        by smtp.gmail.com with ESMTPSA id j5sm2971339pjv.56.2021.08.13.18.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 18:09:26 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Alasdair Kergon <agk@redhat.com>
Cc:     Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH] md: in_irq() cleanup
Date:   Sat, 14 Aug 2021 09:09:09 +0800
Message-Id: <20210814010909.4558-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the obsolete and ambiguos macro in_irq() with new
macro in_hardirq().

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 drivers/md/dm-crypt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 50f4cbd600d5..d1de93873a91 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -2223,11 +2223,11 @@ static void kcryptd_queue_crypt(struct dm_crypt_io *io)
 	if ((bio_data_dir(io->base_bio) == READ && test_bit(DM_CRYPT_NO_READ_WORKQUEUE, &cc->flags)) ||
 	    (bio_data_dir(io->base_bio) == WRITE && test_bit(DM_CRYPT_NO_WRITE_WORKQUEUE, &cc->flags))) {
 		/*
-		 * in_irq(): Crypto API's skcipher_walk_first() refuses to work in hard IRQ context.
+		 * in_hardirq(): Crypto API's skcipher_walk_first() refuses to work in hard IRQ context.
 		 * irqs_disabled(): the kernel may run some IO completion from the idle thread, but
 		 * it is being executed with irqs disabled.
 		 */
-		if (in_irq() || irqs_disabled()) {
+		if (in_hardirq() || irqs_disabled()) {
 			tasklet_init(&io->tasklet, kcryptd_crypt_tasklet, (unsigned long)&io->work);
 			tasklet_schedule(&io->tasklet);
 			return;
-- 
2.30.2

