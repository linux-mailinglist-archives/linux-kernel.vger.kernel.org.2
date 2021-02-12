Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A404319949
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 05:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbhBLEq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 23:46:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhBLEqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 23:46:04 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB96C06178B
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 20:44:50 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id n10so5446264pgl.10
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 20:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9abyG2Vp1cLXhsywjnt31DqtLUxfcIOcm8TXna9D69o=;
        b=lmruzMSVPS590bapCwlHYEvlYn1aZkHClysQ4URSxXSo+S+dHuXxKVUFtffc3QVZ6p
         dMissC+xKlUYFkHQT2kyp3inbdvIARqusFgVoFaIDzPbbtJ06FZ8yHgddwhitV/v5Qr2
         gf9UtOpmCyoqD9Ry6jeFuOCRnRF584iWb5LWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9abyG2Vp1cLXhsywjnt31DqtLUxfcIOcm8TXna9D69o=;
        b=EQyGY0Lituh21PNgtw2RQmMOy+n4DlfhqBX27eqzV0PHg1IotX4HTRBqKoTNFtbvTD
         DbxxnmFw0tSE5YjMPr3xd8z48pzeTpNaS2t59ZGaTZZWlZLZ6VLtt1VhemHYkUeoiDxu
         Eb4PQlRKN696YrQl/XBoM9FNCCv2sJU5qx+mht03PtQn87jgJF5eZEry2P9Y7xOgs2LP
         aZ65mjibgd8GaolksiQXTIiHTsHI51sLI1AhXwdAe6hqK32O8x0gMi+w9L3C4poofg1S
         BpP8LfN7lwCZwvGqYhyCiKLTp65gh0xEG+50XQjxCeMtHqSK4rerBCoSQp1EnsgNagws
         8KqA==
X-Gm-Message-State: AOAM531zf3FY9/I3o3JoMQzn0sHeuXCT7bRJL5WAfblYa5o2G9n7jmA7
        oGV9IMiaD9VPONYT2zbhwWBbUg==
X-Google-Smtp-Source: ABdhPJxkvpuJapHSu96fSM0nCiUJlQnvXSBqf3YQtiDR5HXcvGla9rwTtoIcaA6WK+A3g+WiOyIl5w==
X-Received: by 2002:a63:3d8c:: with SMTP id k134mr1479165pga.321.1613105090131;
        Thu, 11 Feb 2021 20:44:50 -0800 (PST)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:a453:d6cd:41b9:5925])
        by smtp.gmail.com with ESMTPSA id 25sm7298904pfh.199.2021.02.11.20.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 20:44:49 -0800 (PST)
From:   Nicolas Boichat <drinkcat@chromium.org>
To:     "Darrick J . Wong" <djwong@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Ian Lance Taylor <iant@google.com>,
        Luis Lozano <llozano@chromium.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Dave Chinner <david@fromorbit.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] sysfs: Add FS_GENERATED_CONTENT to filesystem flags
Date:   Fri, 12 Feb 2021 12:44:02 +0800
Message-Id: <20210212124354.3.I6491a8c94a199f0c71a0c09da2b725968811bcb2@changeid>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
In-Reply-To: <20210212044405.4120619-1-drinkcat@chromium.org>
References: <20210212044405.4120619-1-drinkcat@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sysfs content is generated at runtime.

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---

 fs/sysfs/mount.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/sysfs/mount.c b/fs/sysfs/mount.c
index e747c135c1d1..7e367ae5edc1 100644
--- a/fs/sysfs/mount.c
+++ b/fs/sysfs/mount.c
@@ -91,7 +91,7 @@ static struct file_system_type sysfs_fs_type = {
 	.name			= "sysfs",
 	.init_fs_context	= sysfs_init_fs_context,
 	.kill_sb		= sysfs_kill_sb,
-	.fs_flags		= FS_USERNS_MOUNT,
+	.fs_flags		= FS_USERNS_MOUNT | FS_GENERATED_CONTENT,
 };
 
 int __init sysfs_init(void)
-- 
2.30.0.478.g8a0d178c01-goog

