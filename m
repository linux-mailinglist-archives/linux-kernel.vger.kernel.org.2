Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8F7344841
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 15:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbhCVOyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 10:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbhCVOy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 10:54:28 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C6EDC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 07:54:28 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id v11so17330052wro.7
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 07:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=3adB6sKudon1MuX58WU4P9T9cyOQ2k59HLNzNYzg43U=;
        b=UUS0OB7Q/kVZJ/eSjJoXtBfRIEqj8hJCWQyYQES5Psg/RYv415R2AI5fAJIdRmsWpI
         h+jz+opJL7agweiYA2QlBGhahu/Aq0cLSnL0bZjmuVzkyv9b5NQp81KC8MxyogwEq04y
         1UXCYUKoHYvYPHLZg0PwZeANCuQfKCdfvClh9jcafX6SGocrkeR2ZTrWnHMsC5NJE3OL
         gaA8e/OodElr0lE+BK5SNTVS7oWepJSf1hSvFrkneD2QxpodRL5e8Xh3UIUDei1f+ElB
         6XpZ3nMR2oqKt2lfGsJY2fSWCi47wj2ky2rjZ+Q1ZV1Y6rxsiDLIzrh1G61OrnWXtNGn
         XorQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=3adB6sKudon1MuX58WU4P9T9cyOQ2k59HLNzNYzg43U=;
        b=Si7Jc+8mBvA2o8xgRSu3yG/hLrLlAYaUEHNheUU0dnuwt1FJRRLS8c8WpgKwTSvzFx
         h4NkCbZEiMwGksrFoqGBS5i2EV7cLWLf/xre7W7dep2GLmbaT3JB6GPjeilsD34UxbeU
         V6wojEm0C/gC8M1vQ91/RsrQ5U/gm5WnKjIEB2t2iedEJeNmMtgrrkp3+5UyOM0TZXME
         T3Cip9vNRSfTBxVBkfQooPKeMS8TRL4Ns8WJDS5cUjbtDiBTEDSuALx8pnGT41XBF4mC
         hyUj736i1cDi+g1hkhVdOl5EXjuiH8EnNdnDffeGbXFCkFL54q+UOL+InsUszffPudvS
         AFFQ==
X-Gm-Message-State: AOAM532D9K1wa2mmdNkSSA4ZAk0MyvYsFUuxBsjLd9nyGb75CvW1JgHO
        9AJhCeGLJjt9St6k0EpgpCR/GeK+xlo=
X-Google-Smtp-Source: ABdhPJzTckCXlBm4qT48HJQihFL/HxV0lDad4PR+4UYNNM4UyVuAdOKT/7X+ft7f5LUOOGDmd01UvQ==
X-Received: by 2002:a5d:5904:: with SMTP id v4mr18677170wrd.261.1616424866551;
        Mon, 22 Mar 2021 07:54:26 -0700 (PDT)
Received: from LEGION ([111.119.187.56])
        by smtp.gmail.com with ESMTPSA id j26sm20246626wrh.57.2021.03.22.07.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 07:54:26 -0700 (PDT)
Date:   Mon, 22 Mar 2021 19:54:20 +0500
From:   Muhammad Usama Anjum <musamaanjum@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        dvyukov@google.com
Cc:     musamaanjum@gmail.com
Subject: [PATCH] media: em28xx: fix memory leak
Message-ID: <20210322145420.GA2063636@LEGION>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If some error occurs, URB buffers should also be freed. If they aren't
freed with the dvb here, the em28xx_dvb_fini call doesn't frees the URB
buffers as dvb is set to NULL. The function in which error occurs should
do all the cleanup for the allocations it had done.

Tested the patch with the reproducer provided by syzbot. This patch
fixes the memleak.

Reported-by: syzbot+889397c820fa56adf25d@syzkaller.appspotmail.com
Signed-off-by: Muhammad Usama Anjum <musamaanjum@gmail.com>
---
 drivers/media/usb/em28xx/em28xx-dvb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/usb/em28xx/em28xx-dvb.c b/drivers/media/usb/em28xx/em28xx-dvb.c
index 526424279637..471bd74667e3 100644
--- a/drivers/media/usb/em28xx/em28xx-dvb.c
+++ b/drivers/media/usb/em28xx/em28xx-dvb.c
@@ -2010,6 +2010,7 @@ static int em28xx_dvb_init(struct em28xx *dev)
 	return result;
 
 out_free:
+	em28xx_uninit_usb_xfer(dev, EM28XX_DIGITAL_MODE);
 	kfree(dvb);
 	dev->dvb = NULL;
 	goto ret;
-- 
2.25.1

