Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E71793404A7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 12:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbhCRLc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 07:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbhCRLcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 07:32:42 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4194C06174A;
        Thu, 18 Mar 2021 04:32:42 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id w8so2756536pjf.4;
        Thu, 18 Mar 2021 04:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nsoRVO5MAUfTeyru0kxzkoVrIbOCET+lsu0GRILy5lg=;
        b=m7DerXCdhW/2I8tupKIDo2uQIIsKDtD0mG3nWTUkXMBud8jdCUK8beEuJXm2kiqbxj
         AvHnL850rd1uYgE323mKLb52topo/ygpccFFEypUhoQO0Ezd9pd0JunVRqj4uka9p9Fq
         DEuIUpfUc7GlIeiVtiGYMpuiTrh8BR8NzaDOCgIuQZdXRnx9LyKF0YFZ1R1A5rbFsKAz
         y1iFUwyscgvPb9oDN5u/xMiNIDEe9HlkaXxprF0abOjhwckvIrunrLvTxOxFfXtwOaBt
         yunRI1VF6PZwdYdfAB4EGLIhM8lyuJWYGiosIeClBoaCkdZoojO+ls2sihXamXIYQBwu
         L8/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nsoRVO5MAUfTeyru0kxzkoVrIbOCET+lsu0GRILy5lg=;
        b=FykQlXxvihLw0uQw1exKx136gEFW7mrhmh/qWnC+sCjIhVFS4ovq8ZK7LgPU7khy30
         iNndLl6QFYJq3juORp7fuBsz2h6jLoWRHJzb3oeKC92JAPZ8E7hFH2JWVwur3IizydWQ
         Ikf9lNEdKL0Ux8ZcFnTilT14RJ/Mb+MkjQKTSR7Ed0EOgXEszR0A+yrukgs0T3yvCLeL
         M8BqJ/ffNhtTp2Q9KPtGj//NKD+HhPOe32iwTkYMFySEO8mB34F/+S5ryTLFRGmyfvtz
         HzIiYoEiC7eHigf4JKIS4LaR1gOLyZ+O3nyN55WO8ZkXDaWXsrS33zN25Zkz7T/xNxIR
         ZGfg==
X-Gm-Message-State: AOAM530Y3AeVrezhaGrC/aE8zdzmTpjMmQgH/Qx+5zYzpCCoa6lknqNk
        xVqce6LxiqDumNtncOS8odA=
X-Google-Smtp-Source: ABdhPJztklu8wT+yW6DpqEJILdKxVMosBCmSVXXBox+Mh2itoswCr7xqC7LOe55ksJsNmqkyFIDEdw==
X-Received: by 2002:a17:902:8217:b029:e6:2875:b1d9 with SMTP id x23-20020a1709028217b02900e62875b1d9mr9018908pln.70.1616067162278;
        Thu, 18 Mar 2021 04:32:42 -0700 (PDT)
Received: from localhost.localdomain ([178.236.46.205])
        by smtp.gmail.com with ESMTPSA id j10sm2169918pjs.11.2021.03.18.04.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 04:32:41 -0700 (PDT)
From:   menglong8.dong@gmail.com
X-Google-Original-From: liu.xuzhi@zte.com.cn
To:     konishi.ryusuke@gmail.com
Cc:     linux-nilfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Liu xuzhi <liu.xuzhi@zte.com.cn>
Subject: [PATCH] fs/nilfs2: fix misspellings using codespell tool
Date:   Thu, 18 Mar 2021 04:32:32 -0700
Message-Id: <20210318113233.473329-1-liu.xuzhi@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liu xuzhi <liu.xuzhi@zte.com.cn>

Two typos are found out by codespell tool \
in 2217th and 2254th lines of segment.c:

$ codespell ./fs/nilfs2/
./segment.c:2217 :retured  ==> returned
./segment.c:2254: retured  ==> returned

Fix two typos found by codespell.

Signed-off-by: Liu xuzhi <liu.xuzhi@zte.com.cn>
---
 fs/nilfs2/segment.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index cd4da9535aed..686c8ee7b29c 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -2214,7 +2214,7 @@ static void nilfs_segctor_wakeup(struct nilfs_sc_info *sci, int err)
  * nilfs_construct_segment - construct a logical segment
  * @sb: super block
  *
- * Return Value: On success, 0 is retured. On errors, one of the following
+ * Return Value: On success, 0 is returned. On errors, one of the following
  * negative error code is returned.
  *
  * %-EROFS - Read only filesystem.
@@ -2251,7 +2251,7 @@ int nilfs_construct_segment(struct super_block *sb)
  * @start: start byte offset
  * @end: end byte offset (inclusive)
  *
- * Return Value: On success, 0 is retured. On errors, one of the following
+ * Return Value: On success, 0 is returned. On errors, one of the following
  * negative error code is returned.
  *
  * %-EROFS - Read only filesystem.
-- 
2.25.1

