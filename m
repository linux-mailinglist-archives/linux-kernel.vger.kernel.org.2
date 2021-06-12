Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DDFB3A4F2F
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 16:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbhFLOJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 10:09:54 -0400
Received: from mail-lj1-f180.google.com ([209.85.208.180]:36662 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbhFLOJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 10:09:53 -0400
Received: by mail-lj1-f180.google.com with SMTP id 131so13553133ljj.3;
        Sat, 12 Jun 2021 07:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5JZMHW5UG5CyvDN0SOE2Y9hqb0tFNng+vhQJCVqivJ8=;
        b=D6A/v3863n804431JpJ/EPCUtfVYDzi5Uhzhb4quMvA3+UiYYEvk1ssSEFIblDNXjC
         fduAtA1lKSPuxgPLQ1aIklkw8rwfDwxNlOJgWtwURLw/DCPAXr4mHVcxF4wD1R/bgMx/
         OJ3EKf41fIzJJkYiWoQu8gZ1qgV6zWqngjpvUZmSLJC2zIUaKz6JsnM+uTv42IY3f7O4
         APCOatnS29cF08zfcyOzV0CGUbWgukwmnxsc6/GlA8V0Jkehu7zGnpF5Heg09wES22i0
         37haeWAjqYEcrjqK6G3pI5MrbZrP+cr8TwuA3A7ubAFNxsTSlkEhYVnKnx36yKOsgSlk
         KeRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5JZMHW5UG5CyvDN0SOE2Y9hqb0tFNng+vhQJCVqivJ8=;
        b=Jw5to0LzmgW2ozFN+afjvJi1ratfVoYmRCI+ZNNOWTvkwCRAGC9/iMJx/tcDDMGzMU
         snL9JMLIq4+NMI+OlVaHEKOUw4Qjj7KsIr7wbETJh8cbzckd+mBpfeV5yx7sdgyXAb0p
         L18r6BF/CQNlv9uDVefsJs1icXfaNuAOCNSwpCMZLo6q3PTmAvnHBknFO+IIEpOwZAJP
         CFPe6yFBiUXxGAAcW1YGkhF6ZB/3G0rHh3abdxsDgAIC4d+S7owk6SC8WEOwVLOY6Fyq
         yBeGS9hc8RfaLezjc7fDsnTI2aEE8FFCgZ3y1M6Qjk5Atx8PDNI816MKtY5tKcV+Xycr
         bbJA==
X-Gm-Message-State: AOAM533r27gtzFdEE17m7LFoGVC3hlfWZMqu9+94fWPOg4zjzQYTj/mu
        x3MG9LAo9BHqNvQXZJTfdAI=
X-Google-Smtp-Source: ABdhPJwDIoSLztHI0HZlTQOE8nq1yqZDO6sHg/1dhl3DUU54eWh1CO8Dhf8podmF3gKUPOzdddIrWA==
X-Received: by 2002:a2e:9192:: with SMTP id f18mr6692919ljg.77.1623506806242;
        Sat, 12 Jun 2021 07:06:46 -0700 (PDT)
Received: from localhost.localdomain ([185.215.60.70])
        by smtp.gmail.com with ESMTPSA id y18sm1118264ljy.95.2021.06.12.07.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jun 2021 07:06:19 -0700 (PDT)
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     konishi.ryusuke@gmail.com, Vyacheslav.Dubeyko@hgst.com,
        akpm@linux-foundation.org
Cc:     linux-nilfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>
Subject: [PATCH] nilfs2: fix memory leak in nilfs_sysfs_delete_device_group
Date:   Sat, 12 Jun 2021 17:05:59 +0300
Message-Id: <20210612140559.20022-1-paskripkin@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My local syzbot instance hit memory leak in nilfs2.
The problem was in missing kobject_put() in
nilfs_sysfs_delete_device_group().

kobject_del() does not call kobject_cleanup() for
passed kobject and it leads to leaking duped
kobject name if kobject_put() was not called.

Fail log:

BUG: memory leak
unreferenced object 0xffff8880596171e0 (size 8):
  comm "syz-executor379", pid 8381, jiffies 4294980258 (age 21.100s)
  hex dump (first 8 bytes):
    6c 6f 6f 70 30 00 00 00                          loop0...
  backtrace:
    [<ffffffff81a2c656>] kstrdup+0x36/0x70 mm/util.c:60
    [<ffffffff81a2c6e3>] kstrdup_const+0x53/0x80 mm/util.c:83
    [<ffffffff83ccc698>] kvasprintf_const+0x108/0x190 lib/kasprintf.c:48
    [<ffffffff83e99926>] kobject_set_name_vargs+0x56/0x150 lib/kobject.c:289
    [<ffffffff83e99fd9>] kobject_add_varg lib/kobject.c:384 [inline]
    [<ffffffff83e99fd9>] kobject_init_and_add+0xc9/0x160 lib/kobject.c:473
    [<ffffffff8304e840>] nilfs_sysfs_create_device_group+0x150/0x800 fs/nilfs2/sysfs.c:999
    [<ffffffff830159f6>] init_nilfs+0xe26/0x12b0 fs/nilfs2/the_nilfs.c:637

Fixes: da7141fb78db ("nilfs2: add /sys/fs/nilfs2/<device> group")
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
---
 fs/nilfs2/sysfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nilfs2/sysfs.c b/fs/nilfs2/sysfs.c
index 303d71430bdd..9c6c0e2e5880 100644
--- a/fs/nilfs2/sysfs.c
+++ b/fs/nilfs2/sysfs.c
@@ -1053,6 +1053,7 @@ void nilfs_sysfs_delete_device_group(struct the_nilfs *nilfs)
 	nilfs_sysfs_delete_superblock_group(nilfs);
 	nilfs_sysfs_delete_segctor_group(nilfs);
 	kobject_del(&nilfs->ns_dev_kobj);
+	kobject_put(&nilfs->ns_dev_kobj);
 	kfree(nilfs->ns_dev_subgroups);
 }
 
-- 
2.32.0

