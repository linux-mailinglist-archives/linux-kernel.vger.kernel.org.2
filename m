Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A48DD3A6799
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 15:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233587AbhFNNVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 09:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232825AbhFNNVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 09:21:47 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FBDFC061574
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 06:19:45 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id j184so38247912qkd.6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 06:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZoAT0mVn0TumaQzoGJVIJ5uw/K29q0wVbz6gDgNRKT4=;
        b=J1sqZNCTE6MYKqbcLEx+8+Qm+RB91WjWJ2F2804yFFXjuMC9wvyRtcbDRc+9DQZz08
         LMWYVXaNDd4gM4AlRkdGOKtXKZVLoaLkAaPNbwl56H4aEIx0Igq3CMMt9NS8dqc7NzjX
         7q5EWn/CzqHJpjhIUI9y7oPTs0RAGh4twNH7CkLrEurud7RSbxwRb4I9YU1Pd679CvTk
         bDihaNMpmLZ5DeZfLF2k99KcB/y7BryL5Ko0ZeL/T4P3621dvgyhqI7Ct1tqp/CfirF9
         mE4DNFAtPxTBegFIdbrSKHsriuhoW7n+agzKCwPD+j0temtwUWsztKrjcgVqy5WLHCYs
         sXLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZoAT0mVn0TumaQzoGJVIJ5uw/K29q0wVbz6gDgNRKT4=;
        b=env4TQExbIakco5XzSoZOGws5m4riw2O50u/XkinsyeXcPBDdb+92vnnCmTS5s9fgL
         +n0tt7qR6UtsEMpvu575PGSrXfxx53yVLdFeDokKRaymh58KDaaYyahG7LBNE7i3CmS8
         MBHbvcyn5+Q/iNnJzv0zEgEhaMN+f3rNVkdOlFy8KOXv8/ocRV/nrv5u1smVJw4bxKk8
         SR+xCPP8Kzrp9QgeEig60UuZVeJXfbW8ukDruxeS9D1WOT6Wnk1lH9lTajK7BJ226m1F
         dH1FgPzQX0+x9KQYqrFxM0gjoib0Tm8HLHlYJz5sT7ve1mjD+LW9AybLos6uMvwJrlDZ
         VVTQ==
X-Gm-Message-State: AOAM532NPhQ9JA2HTXNC5XV1qb2o1OUNC0BP3mccL/V5z7tosX9KLTfy
        /Mk0NavaZKTCorpR+nrjeIEChVDp8gjx9w==
X-Google-Smtp-Source: ABdhPJy4/PraGusjJQFO0vaQPt7AmIT/ieq85/+85/E6yRyTnPfVc31AV1qGJXciHZCBKcxvLJCsOQ==
X-Received: by 2002:a37:a5d6:: with SMTP id o205mr5248665qke.118.1623676784283;
        Mon, 14 Jun 2021 06:19:44 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:125:811b:fbbc:3360:40c4:fb64])
        by smtp.googlemail.com with ESMTPSA id g24sm9564371qts.60.2021.06.14.06.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 06:19:43 -0700 (PDT)
From:   Igor Matheus Andrade Torrente <igormtorrente@gmail.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     Igor Matheus Andrade Torrente <igormtorrente@gmail.com>,
        linux-kernel@vger.kernel.org,
        syzbot+858dc7a2f7ef07c2c219@syzkaller.appspotmail.com
Subject: [PATCH v2] tty: Fix out-of-bound vmalloc access in imageblit
Date:   Mon, 14 Jun 2021 10:18:59 -0300
Message-Id: <20210614131859.9511-1-igormtorrente@gmail.com>
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
---
 drivers/tty/vt/vt.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index fa1548d4f94b..e522f9b249e5 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1219,8 +1219,10 @@ static int vc_do_resize(struct tty_struct *tty, struct vc_data *vc,
 	new_row_size = new_cols << 1;
 	new_screen_size = new_row_size * new_rows;
 
-	if (new_cols == vc->vc_cols && new_rows == vc->vc_rows)
-		return 0;
+	if (new_cols == vc->vc_cols && new_rows == vc->vc_rows) {
+		err = resize_screen(vc, new_cols, new_rows, user);
+		return err;
+	}
 
 	if (new_screen_size > KMALLOC_MAX_SIZE || !new_screen_size)
 		return -EINVAL;
-- 
2.20.1

