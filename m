Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 853B442452D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 19:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239113AbhJFRv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 13:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239174AbhJFRvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 13:51:17 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52381C061760
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 10:49:15 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id np13so2783595pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 10:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4HcW2GcpsNNL2RNx+V2pvD6LIqeWbRwK56YKpdUfUhs=;
        b=gswwGM44VO0kIjdkDXWhjtflwIMLmTLf6OqX8tmV1DAnYMWArNF8/BNv8L4wyA8pV5
         Sf9oOXYIAsCAHTh4bg1GMiXy+pSuiym0F3AgopjW4dURiusNl3UuLvF/QfVdijJaoth2
         7VQSHpYX6ZZsslgKJiihIA9z11E/YUCxDvwdyWYMSmbtrBXdIbiOOgSm1qHv5McHR6qg
         f6JKhkw9FHdWCz76a45863+kV7LsC5b4OCtdc72b6riu1GMEhY748UJ0VNzySybGkgXy
         u+zh5cckCJaDR/vNHxP2XoA9uR4Yz0aAbrhlRmzfBAdM9Q3K1rp+zrMdaJG7PVLcUZuP
         0a8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4HcW2GcpsNNL2RNx+V2pvD6LIqeWbRwK56YKpdUfUhs=;
        b=ySIXfrAEJpdjFSvjmHUpHkjJyS2IRDGNoyqA6gY8lF6wgUFJAK16IwWEgb+RxQEFM6
         XSpKe5NA3B5jeS7MZwb1Lfr5AyCavRY+VClQ/kY5aPeNw6tN4pmFCnZCKHDUHWRTEkfh
         YvPaa0SPWy2SgVPcaB6pCBa0N7sonOFO8Qe918rVQ1IMF7nqCnQYxYSHYD/6yUAWhwyT
         m5M1qlXsX5+3itm3aTn/W8YjW08q5pxc4fZ2lzOsBe4s4ZHyAdaOTDFmPNE6efhdAtnf
         43TIpuehEPgXdgQGln/xUSdiWxc+RIqAIfS41PGK1rtdCnxDHNZ0yHAyTqLuIKsAMJYC
         GPJw==
X-Gm-Message-State: AOAM532t1JM3D4xX6GrPacxMq27Nf6dyZl8On7jrRbqdGf67b0n6J0Eo
        EltZTcX9dsOErdDZLUQC8hexZjE6H7o=
X-Google-Smtp-Source: ABdhPJyQFhGksSNRCJjvOaq5f9X7UwV1Difk/RELkxVheHp1T5Zr/27kUa/bMc3TtYDkwqO5/6EIOw==
X-Received: by 2002:a17:90b:3901:: with SMTP id ob1mr1636pjb.24.1633542554531;
        Wed, 06 Oct 2021 10:49:14 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2620:15c:211:201:4a09:1ff8:fcd9:33e6])
        by smtp.gmail.com with ESMTPSA id s2sm20981068pfe.215.2021.10.06.10.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 10:49:13 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH] f2fs: include non-compressed blocks in compr_written_block
Date:   Wed,  6 Oct 2021 10:49:10 -0700
Message-Id: <20211006174910.2964885-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daeho Jeong <daehojeong@google.com>

Need to include non-compressed blocks in compr_written_block to
estimate average compression ratio more accurately.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/compress.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index c1bf9ad4c220..9b663eaf4805 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1530,6 +1530,7 @@ int f2fs_write_multi_pages(struct compress_ctx *cc,
 	if (cluster_may_compress(cc)) {
 		err = f2fs_compress_pages(cc);
 		if (err == -EAGAIN) {
+			add_compr_block_stat(cc->inode, cc->cluster_size);
 			goto write;
 		} else if (err) {
 			f2fs_put_rpages_wbc(cc, wbc, true, 1);
-- 
2.33.0.882.g93a45727a2-goog

