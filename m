Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 641C2395AE0
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 14:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbhEaMtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 08:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbhEaMtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 08:49:11 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C44C061763
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 05:47:31 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id c15so7810333qte.6
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 05:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bBChdYVjkLlypmoP2TCbru3FnUB7JZaQPFMINdoE7Do=;
        b=Z0p0hSBBHn4UzKtQbjaE6Ot5HQsvAeHl6TphH326NjmPufRhPjZNlddf2cKsX9ToEt
         4ex46EAzJfu1G1DLUwQeY+m/lmEzvi84jMTRugvoKxgjHXCFMaiCqdfxqNOCztg6+HpQ
         phYQYxl2IEoU63twZkL5vVy2/oxI8ZH5f/QckIt6j+tSmonN3BvfmtL5ZEMYP4erXilt
         fG7Kqq0Gi7+ce/Wf/+o8CMMbXR2331hkL/2bTtpISnOfMuM1s1mhVxaAmR2516iibq17
         AsSndTIO7Z5DuoqHqRfWwA2JWhIUi1PrTHoh32G76RFWqTw3gMDETfI204pqvETuEfFd
         hUig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bBChdYVjkLlypmoP2TCbru3FnUB7JZaQPFMINdoE7Do=;
        b=nTlbOVU85sjBFM1UgYD7gtVGvIl3QvfjieJQ/yJTikFlkxhhVmaY3a9M9yKci3keRN
         8V4j4aStJSRjJe4872YMecNoNJzspNk0x/j1dA2QYS/gloX8Z7bqBGxeOif/41dDUVzn
         eGCIcCW/XfsFEkMt7wyK63WQ9gfU6ujwC9yIpM3lez4ssnfhWbftV53AEmECcCwm08rZ
         99P/EzK6WHz7BZ0bN58jua9i034SqU589u5yWtBTqL9EdL+WjdpbO+BrR4kHwocrLnBH
         ws9mUMVX9sFaWb6QU7iXkTVpa7juQX8lEeKT3+nFtgLoHvOpZMMuX6eCXZRvzoTS2pw9
         b0LQ==
X-Gm-Message-State: AOAM5303JUzi0qVXDfQWuuOewEUs+bbjwH1XUbu1X/6TC7Pt4EmFWT/8
        hFTqy7VjDPcSg+EomWzSvpo=
X-Google-Smtp-Source: ABdhPJwyAwYEdudGZApIzHHhQkcl+1Aso5o/9Y+xL0CYFexej+yfZF/1AQx4YsUSj1eij+J4dHR0Iw==
X-Received: by 2002:ac8:4256:: with SMTP id r22mr15083378qtm.207.1622465250325;
        Mon, 31 May 2021 05:47:30 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:125:811b:fbbc:3360:40c4:fb64])
        by smtp.googlemail.com with ESMTPSA id x9sm8340066qtf.76.2021.05.31.05.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 05:47:29 -0700 (PDT)
From:   Igor Matheus Andrade Torrente <igormtorrente@gmail.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     Igor Matheus Andrade Torrente <igormtorrente@gmail.com>,
        linux-kernel@vger.kernel.org,
        syzbot+858dc7a2f7ef07c2c219@syzkaller.appspotmail.com
Subject: [PATCH RFC] tty: Fix out-of-bound vmalloc access in imageblit
Date:   Mon, 31 May 2021 09:47:13 -0300
Message-Id: <20210531124713.9048-1-igormtorrente@gmail.com>
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

To solve this issue I brougth the resize_screen() the
beginning of vc_do_resize(), so it will "fix and fill"
the fb_var_screeninfo even if the screen does not need any
resizing.

Reported-and-tested-by: syzbot+858dc7a2f7ef07c2c219@syzkaller.appspotmail.com
Signed-off-by: Igor Matheus Andrade Torrente <igormtorrente@gmail.com>
---
 drivers/tty/vt/vt.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index fa1548d4f94b..1b90758d8893 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1219,6 +1219,10 @@ static int vc_do_resize(struct tty_struct *tty, struct vc_data *vc,
 	new_row_size = new_cols << 1;
 	new_screen_size = new_row_size * new_rows;
 
+	err = resize_screen(vc, new_cols, new_rows, user);
+	if (err)
+		return err;
+
 	if (new_cols == vc->vc_cols && new_rows == vc->vc_rows)
 		return 0;
 
@@ -1241,14 +1245,6 @@ static int vc_do_resize(struct tty_struct *tty, struct vc_data *vc,
 
 	old_rows = vc->vc_rows;
 	old_row_size = vc->vc_size_row;
-
-	err = resize_screen(vc, new_cols, new_rows, user);
-	if (err) {
-		kfree(newscreen);
-		vc_uniscr_free(new_uniscr);
-		return err;
-	}
-
 	vc->vc_rows = new_rows;
 	vc->vc_cols = new_cols;
 	vc->vc_size_row = new_row_size;
-- 
2.20.1

