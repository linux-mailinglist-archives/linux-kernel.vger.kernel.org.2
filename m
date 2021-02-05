Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 025103102A5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 03:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhBECS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 21:18:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34059 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229509AbhBECS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 21:18:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612491451;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GLtb7l4C5f/0d+zXhA+pFdOwjDhfs3fdWjVorElIDGk=;
        b=ZmVbL9YB/1YFON/1lfYw4YgZeHLL0aKoSbJ1wVm9VzJsISYjZonHUakT/WroGsONfhDTSv
        hRCIrZa3N1lK5H3agTPGMoOU3i9i+uZdyA2A4MBLMCXUfk83gEMDbizR53SMju4bv77fea
        icLaDci6AkDhSz+a1gbGc1jWMf4uiC0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386--B1_QthFOOK8xiw91iTNOg-1; Thu, 04 Feb 2021 21:17:28 -0500
X-MC-Unique: -B1_QthFOOK8xiw91iTNOg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D7C58107ACC7;
        Fri,  5 Feb 2021 02:17:26 +0000 (UTC)
Received: from localhost (ovpn-13-14.pek2.redhat.com [10.72.13.14])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 20FFA5D9CD;
        Fri,  5 Feb 2021 02:17:22 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        "Ewan D . Milne" <emilne@redhat.com>
Subject: [PATCH 1/2] block: move partitions check code into single helper
Date:   Fri,  5 Feb 2021 10:17:07 +0800
Message-Id: <20210205021708.1498711-2-ming.lei@redhat.com>
In-Reply-To: <20210205021708.1498711-1-ming.lei@redhat.com>
References: <20210205021708.1498711-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change, make code more readable, and prepare for
supporting safe re-read partitions.

Cc: Ewan D. Milne <emilne@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/partitions/core.c | 51 ++++++++++++++++++++++++++++++-----------
 1 file changed, 37 insertions(+), 14 deletions(-)

diff --git a/block/partitions/core.c b/block/partitions/core.c
index b1cdf88f96e2..154013ea8623 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -599,17 +599,15 @@ static bool blk_add_partition(struct gendisk *disk, struct block_device *bdev,
 	return true;
 }
 
-int blk_add_partitions(struct gendisk *disk, struct block_device *bdev)
+static int blk_check_partitions(struct gendisk *disk,
+		struct block_device *bdev, struct parsed_partitions **s)
 {
-	struct parsed_partitions *state;
-	int ret = -EAGAIN, p;
-
-	if (!disk_part_scan_enabled(disk))
-		return 0;
+	int ret = -EAGAIN;
+	struct parsed_partitions *state = check_partition(disk, bdev);
 
-	state = check_partition(disk, bdev);
 	if (!state)
-		return 0;
+		goto out;
+
 	if (IS_ERR(state)) {
 		/*
 		 * I/O error reading the partition table.  If we tried to read
@@ -647,15 +645,40 @@ int blk_add_partitions(struct gendisk *disk, struct block_device *bdev)
 			goto out_free_state;
 	}
 
+out:
+	*s = state;
+	return 0;
+
+out_free_state:
+	free_partitions(state);
+	*s = NULL;
+	return ret;
+}
+
+int blk_add_partitions(struct gendisk *disk, struct block_device *bdev)
+{
+	struct parsed_partitions *state;
+	int ret, p;
+
+	if (!disk_part_scan_enabled(disk))
+		return 0;
+
+	ret = blk_check_partitions(disk, bdev, &state);
+	if (ret != 0)
+		return ret;
+
+	if (!state)
+		return 0;
+
 	/* tell userspace that the media / partition table may have changed */
 	kobject_uevent(&disk_to_dev(disk)->kobj, KOBJ_CHANGE);
 
-	for (p = 1; p < state->limit; p++)
-		if (!blk_add_partition(disk, bdev, state, p))
-			goto out_free_state;
-
-	ret = 0;
-out_free_state:
+	for (p = 1; p < state->limit; p++) {
+		if (!blk_add_partition(disk, bdev, state, p)) {
+			ret = -EAGAIN;
+			break;
+		}
+	}
 	free_partitions(state);
 	return ret;
 }
-- 
2.29.2

