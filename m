Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84F293ABF05
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 00:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbhFQWjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 18:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232203AbhFQWjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 18:39:40 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F009C061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 15:37:32 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id f5so2587175qvu.8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 15:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pn6g3eNC+84kFutfemqiNnJtzJH9dWQbHnhIxfRAM3Y=;
        b=gQY9F+W+wWLxvkjfNRQCFVsj5/FDyHdHOHuhxANLEk+yXerPv3dMS3TeaFkJ518fFH
         EnKEOy/RcExbpCzdsSLui1dngRdBqpyyw4QsByAde6x0l5Ge54NKaF3PZe6UqVkLF1zs
         Dnf08vnONh8GwUimT3DPW/hqoTPcehrzwFUj6pGypIcFXsI+eHC8zdyIzrAk01byRR9l
         Dv1vBuLgEQla8lQsZ6C2Kq3QhQI83wZDvwESNO7+Q1QUMPX3wbOiUXloOf08mj5iUPiT
         5vLbMCHlsbS1IK6XLH1kCx34Ns2Am2c1U04BwMaZOnsaaGQ8EvvaTRQrFGZAZQLjyEr4
         su/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pn6g3eNC+84kFutfemqiNnJtzJH9dWQbHnhIxfRAM3Y=;
        b=Fqs11XtIyocjCskELD9ABQ338no3RTKOXsGdqNbqeK2lUICykAAS1peCD9n7GX1mY6
         z8eA+w+IQ5z5QRdGQFTzTmJvIzmA3nCnlt4oWGJA4JBA96KAYiGeB1QXZHve+ePPkr3e
         daQk9roZU5wDtYK5h4xb/Nlrt1Geji864sQvpyw+2Tm0hcAWcbWlO9jJztiqOH899qg1
         S3Cb9eM077Zl+zyM+xJ1+O+vSNOjFXWvka23rcQxyddeVcfdZ3oGBHSVVwyvLY6npwhs
         sy3tqvLBm/DHRD2+l9dXlMgyT0A8xRMaMKbsX5aJcFVlcqbJH+bNJ92x9ag7/2/KiPlJ
         Jxzw==
X-Gm-Message-State: AOAM533KxExexOv3+dcRZ6nCfY9R1rtavhm7KVouvLzFveR0nftEfIy/
        iyp/k5NVvuUCIWGRdP/gQ3I=
X-Google-Smtp-Source: ABdhPJwVQp7J/7SWz2eDU1o9MeqX7Ublt8VfOB+sm8nkQN2kZ8Pwcl8LJXjRtq0FnHMlG7eBz7FZvg==
X-Received: by 2002:ad4:4ae4:: with SMTP id cp4mr2441778qvb.44.1623969451504;
        Thu, 17 Jun 2021 15:37:31 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:125:811b:fbbc:3360:40c4:fb64])
        by smtp.googlemail.com with ESMTPSA id 5sm2698540qkj.99.2021.06.17.15.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 15:37:31 -0700 (PDT)
From:   Igor Matheus Andrade Torrente <igormtorrente@gmail.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     Igor Matheus Andrade Torrente <igormtorrente@gmail.com>,
        linux-kernel@vger.kernel.org,
        syzbot+858dc7a2f7ef07c2c219@syzkaller.appspotmail.com
Subject: [PATCH v3] tty: Fix out-of-bound vmalloc access in imageblit
Date:   Thu, 17 Jun 2021 19:37:20 -0300
Message-Id: <20210617223720.29378-1-igormtorrente@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This issue happens when a userspace program does an ioctl
FBIOPUT_VSCREENINFO passing the fb_var_screeninfo struct
containing only the fields xres, yres, and bits_per_pixel
with values.

If this struct is the same as the previous ioctl, the
vc_resize() detects it and doesn't call the resize_screen(),
leaving the fb_var_screeninfo incomplete. And this leads to
the updatescrollmode() calculates a wrong value to
fbcon_display->vrows, which makes the real_y() return a
wrong value of y, and that value, eventually, causes
the imageblit to access an out-of-bound address value.

To solve this issue I made the resize_screen() be called
even if the screen does not need any resizing, so it will
"fix and fill" the fb_var_screeninfo independently.

Reported-and-tested-by: syzbot+858dc7a2f7ef07c2c219@syzkaller.appspotmail.com
Signed-off-by: Igor Matheus Andrade Torrente <igormtorrente@gmail.com>
---
v2: It Tries to avoid the problem found by Greg in the previous
    patch.

v3: Add a big comment explaining why this is being done the way
    it is.
---
 drivers/tty/vt/vt.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index fa1548d4f94b..a0207525a945 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1220,7 +1220,20 @@ static int vc_do_resize(struct tty_struct *tty, struct vc_data *vc,
 	new_screen_size = new_row_size * new_rows;
 
 	if (new_cols == vc->vc_cols && new_rows == vc->vc_rows)
-		return 0;
+		/* This function is being called here to cover the case
+		 * where the userspace calls the FBIOPUT_VSCREENINFO twice,
+		 * passing the same fb_var_screeninfo containing only the
+		 * fields xres, yres, and bits_per_pixel with yeird(but valid)
+		 * values.
+		 * In the second call, the struct fb_var_screeninfo isn't
+		 * being modified by the underlying driver because of the
+		 * if above, and this eventually causes out-of-bound
+		 * access by the imageblit function.
+		 * To give the correct values to the struct and to not have
+		 * to deal with possible erros from the code bellow, we call
+		 * the resize_screen here as well.
+		 */
+		return resize_screen(vc, new_cols, new_rows, user);
 
 	if (new_screen_size > KMALLOC_MAX_SIZE || !new_screen_size)
 		return -EINVAL;
-- 
2.20.1

