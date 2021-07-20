Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C492B3D0198
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 20:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233629AbhGTRlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 13:41:32 -0400
Received: from mail-pg1-f177.google.com ([209.85.215.177]:46868 "EHLO
        mail-pg1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232233AbhGTRkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 13:40:20 -0400
Received: by mail-pg1-f177.google.com with SMTP id r21so5114593pgv.13;
        Tue, 20 Jul 2021 11:20:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OW8vToWi5TeJxgtIIMXiyoHDjW9N83Vo9rfwgijIZzs=;
        b=jKolfSeq8R1TJnL2LtyAhWs4+8Uxquh/xS4Ukhibz+3wuWpSEfOLhtq97LPsjhdyJh
         +81cn730MLSlzXW3dAcd8d64q01yAOdgwYKkv7NL8NZzp9RL3VJrXeRZjKAP2VS74num
         1IsNkGHFISOuhtns6NdGgLwP7/1ctHEtl8kJNHQsx5rkbxPXVqzILRoajY6WdAxwng4K
         hnb9t3LXoGJ6OopsFcOkK0ZKkqGa431Zhb4HXIPCmF+3cqUA6KSlAO83m2pXJBIHhSM1
         vx9Fs1sDuQ7suD5MFPuBRXzBLUfCcS19pITg7kX3382kLht/ZxfALqXoQUCbohLH8wUg
         DwNg==
X-Gm-Message-State: AOAM533ynT4iCVRhhlW7l0Ok0THuR+fRStWbxxUcwDW8Amp5Wgkgp/X7
        TCN3BZbBbyUhWznzbjYX/eU=
X-Google-Smtp-Source: ABdhPJxZxE1LO9qC3UmByZ1uabQeug7wLUf8V32uEsfV0Ax/bni061Wjis/KvudbW4B5V5lkIE6Pog==
X-Received: by 2002:a62:76d7:0:b029:32b:a57:884d with SMTP id r206-20020a6276d70000b029032b0a57884dmr32797303pfc.3.1626805256941;
        Tue, 20 Jul 2021 11:20:56 -0700 (PDT)
Received: from localhost ([191.96.121.239])
        by smtp.gmail.com with ESMTPSA id e4sm28911777pgi.94.2021.07.20.11.20.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jul 2021 11:20:56 -0700 (PDT)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk
Cc:     hare@suse.de, bvanassche@acm.org, ming.lei@redhat.com,
        hch@infradead.org, jack@suse.cz, osandov@fb.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 2/5] md: replace GENHD_FL_UP with GENHD_FL_DISK_ADDED on is_mddev_broken()
Date:   Tue, 20 Jul 2021 11:20:45 -0700
Message-Id: <20210720182048.1906526-3-mcgrof@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210720182048.1906526-1-mcgrof@kernel.org>
References: <20210720182048.1906526-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GENHD_FL_DISK_ADDED flag is what we really want, as the
flag GENHD_FL_UP could be set on a semi-initialized device.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/md/md.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/md/md.h b/drivers/md/md.h
index 832547cf038f..cf70e0cfa856 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -764,9 +764,7 @@ struct md_rdev *md_find_rdev_rcu(struct mddev *mddev, dev_t dev);
 
 static inline bool is_mddev_broken(struct md_rdev *rdev, const char *md_type)
 {
-	int flags = rdev->bdev->bd_disk->flags;
-
-	if (!(flags & GENHD_FL_UP)) {
+	if (!blk_disk_added(rdev->bdev->bd_disk)) {
 		if (!test_and_set_bit(MD_BROKEN, &rdev->mddev->flags))
 			pr_warn("md: %s: %s array has a missing/failed member\n",
 				mdname(rdev->mddev), md_type);
-- 
2.27.0

