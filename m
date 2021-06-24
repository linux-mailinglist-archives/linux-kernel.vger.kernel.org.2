Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4323B37CB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 22:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbhFXU3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 16:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbhFXU3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 16:29:52 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5165AC061574
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 13:27:33 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id 19so6464116qky.13
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 13:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=40Mge7y/9QfJuI6Ey14vgOBtPmuwBebSpX/wRu9mWM4=;
        b=lC9AWZuifVA3cF/RX6szuZm61A01FFWuJqUXAw0/HVx8q5X6ip4b7OR+AEw1VRxzsx
         o0TssngnI08SazLGLd4JW2O2sRP7JMDNU6Q0D9vTenVIxbe/Ek8mRO9uhnXCQZM8mcbV
         Thg9eAA7tp9XpYU+Lex56NEQlPO5pvZOQn1F1RyrtFtrU6cr2xi0ZNFq7UfqJ7HzogvD
         2303VcQVUhsPmNWmiPgx2z4Ug3HDz6tAZRqFIZPgSvXuX5SXFYl9KHvLx9/V15zvUE92
         hThnxTFQXD35kWbosW7jZnP7Holzxw+iSVBgoHmcP1q5+JE500TmHYMLOe+8dSwYBNpc
         hY7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=40Mge7y/9QfJuI6Ey14vgOBtPmuwBebSpX/wRu9mWM4=;
        b=YtAQc0npnszsZ3ey6YXXg4AAHTCAOQLo54J9wbZZYu0jhn/BiU/C0CRmrqaRPCzop9
         sxunLCho+ADQeM9cPYF7bJJDV/jWhKlngSYFHZ9BIokdB610NRCfn2GW4Jn/mTX/9gcs
         X8Vbij8XJoegtkDtOQNx0+pK0K4x9mIUjKmwOjmwEzeFr0uyYcGaJRy+cIwJ/nNDvqcy
         H6cjioo78qkc3RgIwmRUToh6/AfI/JC/khZGQiHwlHOQol8P7w5rJRoeD5yC/OtLmDEL
         oeW0CEp4Ct8wSyDnoQnslthFuCYz6fNJ57nghYPDsVFd3SYn/HAxb6wp8gQuce7M3gre
         MhBA==
X-Gm-Message-State: AOAM530E2mPn5vZC7VqXI/jeTexD2+IVSLzLmQjJm3hJO7tZzl+aUhvd
        ZApP5jtB43nzQ7BbTaDOz2Y=
X-Google-Smtp-Source: ABdhPJy0vh5rY1XkFaraEVytKi7Z4Cl77YOFZmLi9qKgkP/+iHeKRE8mGZvttplIzPSRJSnmpqaUnw==
X-Received: by 2002:a37:a248:: with SMTP id l69mr7630078qke.394.1624566452523;
        Thu, 24 Jun 2021 13:27:32 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:125:811b:fbbc:3360:40c4:fb64])
        by smtp.googlemail.com with ESMTPSA id f25sm2539323qto.13.2021.06.24.13.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 13:27:32 -0700 (PDT)
From:   Igor Matheus Andrade Torrente <igormtorrente@gmail.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     Igor Matheus Andrade Torrente <igormtorrente@gmail.com>,
        linux-kernel@vger.kernel.org,
        syzbot+858dc7a2f7ef07c2c219@syzkaller.appspotmail.com
Subject: [PATCH v4] tty: Fix out-of-bound vmalloc access in imageblit
Date:   Thu, 24 Jun 2021 17:27:25 -0300
Message-Id: <20210624202725.20415-1-igormtorrente@gmail.com>
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
 drivers/tty/vt/vt.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index fa1548d4f94b..e342f5c905bc 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1220,7 +1220,22 @@ static int vc_do_resize(struct tty_struct *tty, struct vc_data *vc,
 	new_screen_size = new_row_size * new_rows;
 
 	if (new_cols == vc->vc_cols && new_rows == vc->vc_rows)
-		return 0;
+		/* This function is being called here to cover the case
+		 * where the userspace calls the FBIOPUT_VSCREENINFO twice,
+		 * passing the same fb_var_screeninfo containing the fields:
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
 
 	if (new_screen_size > KMALLOC_MAX_SIZE || !new_screen_size)
 		return -EINVAL;
-- 
2.20.1

