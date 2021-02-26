Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1421C3269D5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 23:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbhBZWPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 17:15:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbhBZWPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 17:15:48 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2894C061756
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 14:15:07 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id u12so6694824pjr.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 14:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cSPaSClt+uo6Y/kmY2yO/ZDm+u6iS+o8rwLcwzKp/pg=;
        b=Jq1w2xRbWh+l4OEusyeBz69rbK6+PDoF19xCLPqn5z/hhSvC+9ZWIDwxCrE4Lv1Grb
         Hh8D0xc8sLEzjz9fbFwNbk8rED1x9CPmSZ4j+sDtuwJIc78CV5/SoIuePGA/DMilE8fX
         gVffpOaRCNM5BSkFjnhmef8yDeF0ECLTk5Mj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cSPaSClt+uo6Y/kmY2yO/ZDm+u6iS+o8rwLcwzKp/pg=;
        b=FhYfJCsLf9RT8A+A5EYDlgvGnaF08sRpPyJyuGARMwlSQPbarU+HOfzRm1rWEJQmvr
         Pa48Hdyoj0/FtTslw3YJHsykjURVlW5t5N3AN+t8+kYivzPFXcdwIEbcEr2SyJPCo3sj
         /DnH2L4nHrBGSUyRv8k1gOj2b7f5ZYbXwdPHH06E0F41OpZd95g/EyX/e/pMi3slej9B
         LmiE4TX0T7+CqK3YwgN9NDiQ5C0BPYxjKB1iS+UeRRygqoPDtr38CZYC3mmMTvbKUsSk
         CVvY8RvxNJUWTGBhyI1QgsxXlkc0N7wUODZhBWYiWoUN6V4ZVBek0NcgyPGisnyFv01a
         JASA==
X-Gm-Message-State: AOAM531ZEHgJImDN02mIa9weMX8OU79ub/YXWwCSSH2SYuKuHun43UYW
        GNpOJXaWmkPUruB2QlZhktmSwA==
X-Google-Smtp-Source: ABdhPJwYIJLDOJiNMCUOi9wxgZrIh9V1GRLS1EHTu4/84IuxT4jWvwmOUpSSAMEIaLaevH2c0j0uIg==
X-Received: by 2002:a17:90a:b782:: with SMTP id m2mr5437024pjr.220.1614377707290;
        Fri, 26 Feb 2021 14:15:07 -0800 (PST)
Received: from sarthakkukreti-glaptop.hsd1.ca.comcast.net ([2601:647:5a81:1d70::c086])
        by smtp.gmail.com with ESMTPSA id k5sm9374519pjl.50.2021.02.26.14.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 14:15:06 -0800 (PST)
From:   Sarthak Kukreti <sarthakkukreti@chromium.org>
To:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>,
        Sarthak Kukreti <sarthakkukreti@chromium.org>
Subject: [PATCH] ext4: Add xattr commands to compat ioctl handler
Date:   Fri, 26 Feb 2021 14:14:41 -0800
Message-Id: <20210226221441.70071-1-sarthakkukreti@chromium.org>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows 32-bit userspace utils to use FS_IOC_FSGETXATTR and 
FS_IOC_FSSETXATTR on a 64-bit kernel.

Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
---
 fs/ext4/ioctl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index f0381876a7e5b..055c26296ab46 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -1371,6 +1371,8 @@ long ext4_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 			return -EFAULT;
 		return ext4_ioctl_group_add(file, &input);
 	}
+	case EXT4_IOC_FSGETXATTR:
+	case EXT4_IOC_FSSETXATTR:
 	case EXT4_IOC_MOVE_EXT:
 	case EXT4_IOC_RESIZE_FS:
 	case FITRIM:
-- 
2.30.1.766.gb4fecdf3b7-goog

