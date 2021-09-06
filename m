Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A996401564
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 06:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232564AbhIFEOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 00:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbhIFEOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 00:14:53 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3296C061575;
        Sun,  5 Sep 2021 21:13:48 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id g13-20020a17090a3c8d00b00196286963b9so3464926pjc.3;
        Sun, 05 Sep 2021 21:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DDfs506elfVQtwvsSc35KPZpNEn95r25l9p9sqG0B24=;
        b=ojfO4IOtMRTy69WphW9Tmy1bAz8RPBeEY38eHzq8DFTANyDHjGN0aHRotHC/g2+3LW
         O7vb9rhbjFmuj4qOI3SCSfq8YtGdoIbcDhNEtw8xUMSMY8xSUlg4O6+QqofS7oRkgwkj
         T9/WH3HKF7xuJFaO/FYSidOxBt0LgN4fWcWK1EYFLOW0uzkaVBlCF5cu1Icjd2O9ygjA
         tKyruamwlIESAymZeo/cEi+2AbLLAjfv62HODSGcVFhWDwZ1KYovTCTC7JfODcT7G3cm
         uiaSgzwRzjDav2ahkjb5jEKQf0exIXIJ9xqT6hrt7lM2CmzMiXe2t1K4lGTlgrfaBgwu
         5SQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DDfs506elfVQtwvsSc35KPZpNEn95r25l9p9sqG0B24=;
        b=qnkikaG/ehC8IIDhQkDKL+9GDkxVZS5q9fTncZdGtB7tLiLD0nkBNy0WVy5h9Jb0UM
         uNxxEaHI8UDZ/JHnyF1ucLKh+9f9puaQO3ufagApaDwzm6YehTkrjPIARwf9RyLTbGVE
         OyPJbQNH1Duj+kpHfMI2oKa0tFmzyJLLt8mafmA9nmKSBWpsvoe8zUbDfnnWQsebJ0cr
         l5HJLu6A7k8X0xKajWoZ3URJGVW5bZ5/voIqdyN2bnhU2oocf7TFIx08nys8W9OVtKMt
         0bFSdE3ESDeLHeVgqwRnqRNvm6+iG9i2xvi3rwM62RZe/VE4iep+0YYPJH2gP+GkidOF
         tjsA==
X-Gm-Message-State: AOAM5334C2qoPTtYsBsTA9awAk1E+aC6RVTnSONZ0t6WIEexTNEuUMbl
        frasxeQvCWrZqAg9bsm4rXeh7CsZbiJwszk4
X-Google-Smtp-Source: ABdhPJxMIxT7Ba2K2PSJoYH9cYbCR30P8NeyOKCf252DtbTCRww6vB8Dg9SHUzoeDxjQVatLA9j6AA==
X-Received: by 2002:a17:90a:5107:: with SMTP id t7mr12145885pjh.74.1630901627994;
        Sun, 05 Sep 2021 21:13:47 -0700 (PDT)
Received: from localhost.localdomain ([45.135.186.104])
        by smtp.gmail.com with ESMTPSA id mv1sm5797989pjb.29.2021.09.05.21.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Sep 2021 21:13:47 -0700 (PDT)
From:   Dongliang Mu <mudongliangabcd@gmail.com>
To:     Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc:     paskripkin@gmail.com, Dongliang Mu <mudongliangabcd@gmail.com>,
        linux-nilfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] nilfs2: fix memory leak in nilfs_sysfs_create_device_group
Date:   Mon,  6 Sep 2021 12:13:30 +0800
Message-Id: <20210906041330.2065214-1-mudongliangabcd@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 8fd0c1b0647a ("nilfs2: fix memory leak in
nilfs_sysfs_delete_device_group") adds a kobject_put to free the leaking
object name. However, it is incomplete to only add kobject_put in the
nilfs_sysfs_delete_device_group. The function
nilfs_sysfs_create_device_group also needs the kobject_put to
free the object name in the error handling part.

Fix this by adding kobject_put in the error handling code of
nilfs_sysfs_create_device_group.

Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
---
 fs/nilfs2/sysfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nilfs2/sysfs.c b/fs/nilfs2/sysfs.c
index 68e8d61e28dd..7ab60711ca76 100644
--- a/fs/nilfs2/sysfs.c
+++ b/fs/nilfs2/sysfs.c
@@ -1024,6 +1024,7 @@ int nilfs_sysfs_create_device_group(struct super_block *sb)
 
 cleanup_dev_kobject:
 	kobject_del(&nilfs->ns_dev_kobj);
+	kobject_put(&nilfs->ns_dev_kobj);
 
 free_dev_subgroups:
 	kfree(nilfs->ns_dev_subgroups);
-- 
2.25.1

