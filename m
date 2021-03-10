Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECC2D3336B0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 08:52:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232362AbhCJHvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 02:51:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbhCJHvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 02:51:32 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CEA8C061760
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 23:51:32 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id p8so36585206ejb.10
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 23:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f3NyUVmUs5v8cil49pIJNqQQz4DaHo1vkszaPirCaxo=;
        b=Ypi3V62zNn07jIH5RVoVdvyATHjdPZWvOc3LNNjQoId5D2k9IGXQL24cMW9mAgL5Dc
         ASvsAmXd6mVLYFyqHMea/C5A5MACaZZRMEsbycjakNbxNH8mOzi5zqnHLPhkwO5qJ2Ax
         2/UjIkgkp1OqXua8BWWQymaja4VbKI3HgWmgQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f3NyUVmUs5v8cil49pIJNqQQz4DaHo1vkszaPirCaxo=;
        b=AzIezRFe84jktS65pWRliFWx8A070O9RWp4L4kpOKdJiwNoCUp9NtpQrjkOWQev5BG
         kAMRLbBMWv9LVQ3tn5KpvHeMC7ayHbeo8/rzy3o7VC8UafWbGs1NTVYb8A38hEG33+4s
         P8PUr7MLFw2GiZI2dbzx+BKot4JgHn0SVRD27LPtXtFQoZEDf15Kj+e49Gfa68NoVDQR
         USF7/K9obJ2LR+T9CgJ3EdrWJV9nGpxq+c3E/849pYhBjnubAoBPv4LmyoklX7MeMrcM
         wL2fIAPszoNDWLpT240oApLXuk3zOMQDN3q+BfWo09yr+qfEKvwATMNNiZFESWhxP+7B
         STlA==
X-Gm-Message-State: AOAM530vtf4Y3nkoEPI0ecKl1gjxrHnVyhsSSqaU6CBxyYNjRFESyJ7H
        ryHMBZevSKqMRVBnUIFWzfhatw==
X-Google-Smtp-Source: ABdhPJzSKcWgVNaL6kreWfdn6+jX0OeM/ZbsAuRfopka4VQCGRuudEO5alraEKo30Pa5K7awra6LJA==
X-Received: by 2002:a17:906:130c:: with SMTP id w12mr2224583ejb.253.1615362690959;
        Tue, 09 Mar 2021 23:51:30 -0800 (PST)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id gj13sm9097940ejb.118.2021.03.09.23.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 23:51:30 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Tomasz Figa <tfiga@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Cc:     Ricardo Ribalda <ribalda@chromium.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        stable@vger.kernel.org
Subject: [PATCH v2] media: videobuf2: Fix integer overrun in vb2_mmap
Date:   Wed, 10 Mar 2021 08:51:27 +0100
Message-Id: <20210310075127.1045556-1-ribalda@chromium.org>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The plane_length is an unsigned integer. So, if we have a size of
0xffffffff bytes we incorrectly allocate 0 bytes instead of 1 << 32.

Suggested-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: stable@vger.kernel.org
Fixes: 7f8414594e47 ("[media] media: videobuf2: fix the length check for mmap")
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/common/videobuf2/videobuf2-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
index 543da515c761..89c8bacb94a7 100644
--- a/drivers/media/common/videobuf2/videobuf2-core.c
+++ b/drivers/media/common/videobuf2/videobuf2-core.c
@@ -2256,7 +2256,7 @@ int vb2_mmap(struct vb2_queue *q, struct vm_area_struct *vma)
 	 * The buffer length was page_aligned at __vb2_buf_mem_alloc(),
 	 * so, we need to do the same here.
 	 */
-	length = PAGE_ALIGN(vb->planes[plane].length);
+	length = PAGE_ALIGN((unsigned long)vb->planes[plane].length);
 	if (length < (vma->vm_end - vma->vm_start)) {
 		dprintk(q, 1,
 			"MMAP invalid, as it would overflow buffer length\n");
-- 
2.30.1.766.gb4fecdf3b7-goog

