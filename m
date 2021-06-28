Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85B933B5F53
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 15:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbhF1Nsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 09:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbhF1Nsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 09:48:37 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C407C061574
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 06:46:11 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id bb20so10164814pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 06:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VKJuiZY5njObqnbN2t61e+utxYTUMJcrwu9/5wMskiI=;
        b=Zanf+FiiPCnwnD+C2HECqCtIxF3XOGExbD48rg1m0mTm/CiALdJiLyOvPVo4gWTj6d
         9GNIeCT7w7lghDXGI8dJ6wicSMeg9mAlxmM0VJkaFS7MhNT+FbGszGhDXt0t0WkqiDH4
         BzATbLUBfBu1vJgFztD3HYGa+6VPlR3O6lFkvmYarzdNqSydaO9bZtzGVKlxmO3t8ho/
         vo/3qyVops8cbfY75eqxCptluzMCGgPqxDhrIjzYQGxqNUCgq+LjHFZYvl7tXgdFXR81
         cmcUHWf+R5fWTlcG9wDFBOKFbwlRMR5NRzCuUpVf/QP6BkWPADO3FyNjiI3PawjFAZBW
         7nKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VKJuiZY5njObqnbN2t61e+utxYTUMJcrwu9/5wMskiI=;
        b=j2ExpLFIsF7+eY2WWib+5ETLEnfF5coMYLFJU+sOeHlPpmbaLKTGz1ifkIwutBcoX4
         ehceLKZlmIOnoS1mp38IFLLw/0qERnjSTsAmC2YBYGe2B0LVbXcSdHYFbYMZUet0h8/B
         AD4fjzIDUFMyOjfzKKm4PgwTug50C9VeST0zunJBPk/CIMupcz++x+WngerD/6ub8Uao
         RdSTdXo9tW0k8Bzex/8/o8unho2W+yzqaL5aBTDAKtGxb6UcNsafB/swKS1Im+w9h9BE
         rV7q4zC2plG2twDk4VwMVQ6AUFLwCzoYdkUlTMFnFI8Y6Ksv5+0K9g7RWHfdJj7ylw6G
         e9oA==
X-Gm-Message-State: AOAM532ubWyvLFhqWwe376wxsQw/WaNxmm034cCQiVzUCKpZhLIJ+ihm
        fDa7BY3ih3uXJY4Ug2uQ7tY=
X-Google-Smtp-Source: ABdhPJzBSCskmICzu86M/YdHWaIhKcT5eu+OOfQd+pSuRMHe4tlFvJ19oUZxMBOPLgPHFyHUaRkxNg==
X-Received: by 2002:a17:90a:b891:: with SMTP id o17mr5444027pjr.32.1624887970627;
        Mon, 28 Jun 2021 06:46:10 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:125:811b:fbbc:3360:40c4:fb64])
        by smtp.googlemail.com with ESMTPSA id v3sm14913303pfb.126.2021.06.28.06.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 06:46:10 -0700 (PDT)
From:   Igor Matheus Andrade Torrente <igormtorrente@gmail.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     Igor Matheus Andrade Torrente <igormtorrente@gmail.com>,
        linux-kernel@vger.kernel.org,
        syzbot+858dc7a2f7ef07c2c219@syzkaller.appspotmail.com
Subject: [PATCH v5] tty: Fix out-of-bound vmalloc access in imageblit
Date:   Mon, 28 Jun 2021 10:45:09 -0300
Message-Id: <20210628134509.15895-1-igormtorrente@gmail.com>
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
 drivers/tty/vt/vt.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index fa1548d4f94b..f384d251967f 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1219,8 +1219,25 @@ static int vc_do_resize(struct tty_struct *tty, struct vc_data *vc,
 	new_row_size = new_cols << 1;
 	new_screen_size = new_row_size * new_rows;
 
-	if (new_cols == vc->vc_cols && new_rows == vc->vc_rows)
-		return 0;
+	if (new_cols == vc->vc_cols && new_rows == vc->vc_rows) {
+		/*
+		 * This function is being called here to cover the case
+		 * where the userspace calls the FBIOPUT_VSCREENINFO twice,
+		 * passing the same fb_var_screeninfo containing the fields
+		 * yres/xres equal to a number non-multiple of vc_font.height
+		 * and yres_virtual/xres_virtual equal to number lesser than the
+		 * vc_font.height and yres/xres.
+		 * In the second call, the struct fb_var_screeninfo isn't
+		 * being modified by the underlying driver because of the
+		 * if above, and this causes the fbcon_display->vrows to become
+		 * negative and it eventually leads to out-of-bound
+		 * access by the imageblit function.
+		 * To give the correct values to the struct and to not have
+		 * to deal with possible errors from the code below, we call
+		 * the resize_screen here as well.
+		 */
+		return resize_screen(vc, new_cols, new_rows, user);
+	}
 
 	if (new_screen_size > KMALLOC_MAX_SIZE || !new_screen_size)
 		return -EINVAL;
-- 
2.20.1

