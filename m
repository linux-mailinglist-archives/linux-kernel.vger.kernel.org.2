Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA8F3D5310
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 08:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbhGZF2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 01:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231759AbhGZF2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 01:28:49 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC64C061757
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jul 2021 23:09:17 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id o5-20020a1c4d050000b02901fc3a62af78so7366148wmh.3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jul 2021 23:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IL1TsERkpfeL/Up3TsKMyalrufqRTmEKYRINP+hI3xg=;
        b=fr53vy8vVWxfCipACfzo6OlpNTVZxQhrskrTxm+c1isLJ0n1J59QY15jO/Be7EFU/o
         oD3sLh9dx0PNVPIDeFKxrBlcn9Wf/z89oMjAaRCCAGyn/a3lenC1WWmk7BbxqGtr1Aif
         WjL7qFFTFPhk00lXOSGcIrG9pfxwf2VSh0z43/vZmyga/ChF3+PIq1YzVRXPsR+Rw4rQ
         /kYsYa32EHoquXbPiW/XxjSeuEAKNp6+3DPCHR8FJl7F9hmtc8r4TeNdQCMu79ojILBY
         OJxlJZ9mwoMERlTys6gc6Yt4chF6i/FNvmBsgQGnXUA3fO+E0Oa8nnzCncp0Kh800uxe
         dK3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IL1TsERkpfeL/Up3TsKMyalrufqRTmEKYRINP+hI3xg=;
        b=mbGfZANTf6Ra/UwCqDqL0tWwV2P8T10TQuC8LX6z91rYolmuUCuPY3VuarynaEe+KA
         EjclCA0oYeoKgJuseFON3hEgbFDgobhwrgrgI/Il75RnVpE+x9D5JooQZcltqP0lwtLp
         tMYrrFMn+Cjnv/hNqCj0X+Lu2gXq8iPegqM/xyhDYmYXLN6c2J6mhL5/E6dwnYO4rdK6
         R2z2EVS9//BYo6dLuXlH8Bpf1BrZIn7xed1nFefZJjTNwSoBaLYaZ0LV38zeIpCidEC8
         oo/cZaLNSTEOnOHtDRSmHoujk29U1CZHsL+PaXfuQeoH64DzjEjXBojz2Q3fhi6DISgg
         +Vvw==
X-Gm-Message-State: AOAM530eZpcB4A6npRpMWkzOigNmxRjKFXTd56BiTFbKTf6h99X7Vpmo
        tfrDnH9SXcnuJOsg9pQOe8Q=
X-Google-Smtp-Source: ABdhPJwmyKXLP9krJ3B0G0CWCA1t47tOg2fGWtfdbhZbG1Ckqr26Gw8QYAoFirIOiJtIS7WHYomgIw==
X-Received: by 2002:a1c:f003:: with SMTP id a3mr25841640wmb.82.1627279756045;
        Sun, 25 Jul 2021 23:09:16 -0700 (PDT)
Received: from lb01399.fkb.profitbricks.net (p200300ca572b5e23c4ffd69035d3b735.dip0.t-ipconnect.de. [2003:ca:572b:5e23:c4ff:d690:35d3:b735])
        by smtp.gmail.com with ESMTPSA id j2sm5817548wrd.14.2021.07.25.23.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jul 2021 23:09:15 -0700 (PDT)
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
To:     nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     dan.j.williams@intel.com, jmoyer@redhat.com, david@redhat.com,
        mst@redhat.com, cohuck@redhat.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com, ira.weiny@intel.com,
        pankaj.gupta.linux@gmail.com, Pankaj Gupta <pankaj.gupta@ionos.com>
Subject: [RFC v2 2/2] pmem: Enable pmem_submit_bio for asynchronous flush
Date:   Mon, 26 Jul 2021 08:08:55 +0200
Message-Id: <20210726060855.108250-3-pankaj.gupta.linux@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210726060855.108250-1-pankaj.gupta.linux@gmail.com>
References: <20210726060855.108250-1-pankaj.gupta.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pankaj Gupta <pankaj.gupta@ionos.com>

Return from "pmem_submit_bio" when asynchronous flush is in
process in other context.

Signed-off-by: Pankaj Gupta <pankaj.gupta@ionos.com>
---
 drivers/nvdimm/pmem.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 1e0615b8565e..3ca1fa88a5e7 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -201,8 +201,13 @@ static blk_qc_t pmem_submit_bio(struct bio *bio)
 	struct pmem_device *pmem = bio->bi_bdev->bd_disk->private_data;
 	struct nd_region *nd_region = to_region(pmem);
 
-	if (bio->bi_opf & REQ_PREFLUSH)
-		ret = nvdimm_flush(nd_region, bio);
+	if ((bio->bi_opf & REQ_PREFLUSH) &&
+		nvdimm_flush(nd_region, bio)) {
+
+		/* asynchronous flush completes in other context */
+		if (nd_region->flush)
+			return BLK_QC_T_NONE;
+	}
 
 	do_acct = blk_queue_io_stat(bio->bi_bdev->bd_disk->queue);
 	if (do_acct)
@@ -222,11 +227,13 @@ static blk_qc_t pmem_submit_bio(struct bio *bio)
 	if (do_acct)
 		bio_end_io_acct(bio, start);
 
-	if (bio->bi_opf & REQ_FUA)
+	if (bio->bi_opf & REQ_FUA)  {
 		ret = nvdimm_flush(nd_region, bio);
 
-	if (ret)
-		bio->bi_status = errno_to_blk_status(ret);
+		/* asynchronous flush completes in other context */
+		if (nd_region->flush)
+			return BLK_QC_T_NONE;
+	}
 
 	bio_endio(bio);
 	return BLK_QC_T_NONE;
-- 
2.25.1

