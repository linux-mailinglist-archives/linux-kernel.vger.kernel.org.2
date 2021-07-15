Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4501B3CAE39
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 22:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbhGOVCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 17:02:32 -0400
Received: from mail-pf1-f178.google.com ([209.85.210.178]:35677 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbhGOVC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 17:02:26 -0400
Received: by mail-pf1-f178.google.com with SMTP id d12so6713636pfj.2;
        Thu, 15 Jul 2021 13:59:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oMMgUL7Kpa5DodkxmOydle/piLNprbyMvQ4fO62yTZg=;
        b=gj/xIbk51ySuANdrlX4DpPbsexFAQx4dFG5Tpr6XQtUot7UwMRC0Md6Wb4miWp1tdD
         tUbqMIB7eBpMs/0CY+4rBmVQEnt/sxAE7TSibB0AdUvuxprPogjse7jLRPB3+Ss8UW1W
         khLoB9N6M0suWhPl3tSirM3z7Wq8lvjZEvhF9LVYez93hgOPfodVaxf/Th05z4Gpehou
         kGq0BmDi18jav9WoyBwOcMETvldCkhRS/Su4xhD0+IJDqZ/9/CIYRrLL/PSuyfD7KvSo
         TDh0R/ZuWoJOEqClOaxtHVyT48ni3hx3DPDLqHosKpZAXpi9j/ZYmp7dceQCJQfOLQEC
         4NGA==
X-Gm-Message-State: AOAM533zUc2pDQroGjy0fLGxmiLk+dPuoZcsnw1ZGwHSKXLJpDWmG2HQ
        ePMaSBxlcw5Xuelp4NF6zEY=
X-Google-Smtp-Source: ABdhPJzscM3NnobtI76RWvDOxmZP0Qc/DhYRcDqYiHuXuNrVFiv8xMV6X1JgSUmhYMUfj70h/AlMvw==
X-Received: by 2002:a62:380c:0:b029:2f7:4057:c3ed with SMTP id f12-20020a62380c0000b02902f74057c3edmr6683752pfa.21.1626382772877;
        Thu, 15 Jul 2021 13:59:32 -0700 (PDT)
Received: from localhost ([191.96.120.37])
        by smtp.gmail.com with ESMTPSA id e24sm7553177pfn.127.2021.07.15.13.59.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 13:59:32 -0700 (PDT)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk
Cc:     hare@suse.de, bvanassche@acm.org, ming.lei@redhat.com,
        hch@infradead.org, jack@suse.cz, osandov@fb.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [RFC 02/12] floppy: use blk_cleanup_disk()
Date:   Thu, 15 Jul 2021 13:59:10 -0700
Message-Id: <20210715205920.2023980-3-mcgrof@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210715205920.2023980-1-mcgrof@kernel.org>
References: <20210715205920.2023980-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the blk_cleanup_queue() followed by put_disk() can be
replaced with blk_cleanup_disk(). No need for two separate
loops.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/block/floppy.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index b68f4b6bf737..ba690affc751 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -4950,13 +4950,9 @@ static void __exit floppy_module_exit(void)
 		}
 		for (i = 0; i < ARRAY_SIZE(floppy_type); i++) {
 			if (disks[drive][i])
-				blk_cleanup_queue(disks[drive][i]->queue);
+				blk_cleanup_disk(disks[drive][i]);
 		}
 		blk_mq_free_tag_set(&tag_sets[drive]);
-		for (i = 0; i < ARRAY_SIZE(floppy_type); i++) {
-			if (disks[drive][i])
-				put_disk(disks[drive][i]);
-		}
 	}
 
 	cancel_delayed_work_sync(&fd_timeout);
-- 
2.27.0

