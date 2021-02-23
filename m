Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C88573223C1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 02:35:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbhBWBeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 20:34:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbhBWBeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 20:34:15 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE64C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 17:33:34 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id j12so7757562pfj.12
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 17:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=smby/yISrTbD7Ag5so/UjLKlT0IUNUKC9xD+ASY5i6s=;
        b=GYiiiqrxbRd+SU8wAVkJr23hjPHL5TkJHMn9MBGknejuNggofVq+D4MW7jg95gPm+o
         bPzJ2eaVI6AeO0DLsAyS3u9jeBoQCzKuMpnbmNVpUtwdieYuuOY0WjGq0WT6O6gFpUPW
         QHjz7g647ZgCIZ4j7uYR8e/ioxHrmNYhAZQgZ0AZdeD4owMyO/3QKSy82BfOUVkls5A6
         PwQ7YgUzqUpxZsQCzm1cFpUK/PyxGrBwcHssCChZFTIndByZWjPHYPtveXUJdovcL/U3
         pdrajkACfwU6JxWqGuY29Xg2ozpu08DML00uC97GpLnN3BaBOnMgBUQTaGYuFtf7wvad
         jP6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=smby/yISrTbD7Ag5so/UjLKlT0IUNUKC9xD+ASY5i6s=;
        b=nUuvRm3PoJXQ2iKDYgbRND75/QQXGY11H/YGQ+dRwnl5qXj3gg3z1BR301JTKoK8Oi
         XO602ZX3y5UUmE8yw/LtFkDdJi+bBbJcMdO5gKV3UbRtiI+8dHcEQJjqnZg3esFfdH5M
         mOO9cGJwPv1t4pMSUyMm/zdPep+dWrwqu3TqqHkE+NwVScXVGtgPHUYal6xSjC1MjQLb
         Sxxdw1zmou0MINwPigITKJ2W7iTxkECeOXxkvhWbVuKE/4+14Ttf9wy8AWW07GgRrMXQ
         zVmY2jsPFT9fs+qKh+d87TQkfKmmJHVEr16q8Pwe9RuwD2f6BGLUBTcBWpBcgzS4hKbv
         44rQ==
X-Gm-Message-State: AOAM530VEEc1wJGNKevfdlEWQOkAVJ9lDIYg1CCJXb4WIHf7Jvs86Xuh
        T4L3qfczTxcI2cjFu37o0T6XPAg6QAkVZoDv
X-Google-Smtp-Source: ABdhPJwYiDQufR4zO8udNMr9DXChprskj8Oty96PpE28zbNvz5ztdwNJ6ZFpPxVzdt8muKvcxDKwCw==
X-Received: by 2002:a63:4d52:: with SMTP id n18mr21659838pgl.237.1614044014321;
        Mon, 22 Feb 2021 17:33:34 -0800 (PST)
Received: from mi-HP-ProDesk-680-G4-MT.mioffice.cn ([209.9.72.215])
        by smtp.gmail.com with ESMTPSA id u7sm19976983pfh.150.2021.02.22.17.33.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Feb 2021 17:33:33 -0800 (PST)
From:   Yehan Xu <yehanxu1@gmail.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, xuyehan <xuyehan@xiaomi.com>
Subject: [PATCH v2] f2fs: fix a spelling error
Date:   Tue, 23 Feb 2021 09:31:43 +0800
Message-Id: <1614043903-31388-1-git-send-email-yehanxu1@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: xuyehan <xuyehan@xiaomi.com>

Delete the letter 'e' before 'number'

Signed-off-by: xuyehan <xuyehan@xiaomi.com>
---

changes since previous version
- modify the title of patch 

thank you very much for your help Mr. Chao Yu

 Documentation/ABI/testing/sysfs-fs-f2fs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index 3dfee94..21d14fa 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -276,7 +276,7 @@ Date		April 2019
 Contact:	"Daniel Rosenberg" <drosen@google.com>
 Description:	If checkpoint=disable, it displays the number of blocks that
 		are unusable.
-		If checkpoint=enable it displays the enumber of blocks that
+		If checkpoint=enable it displays the number of blocks that
 		would be unusable if checkpoint=disable were to be set.
 
 What:		/sys/fs/f2fs/<disk>/encoding
-- 
2.7.4

