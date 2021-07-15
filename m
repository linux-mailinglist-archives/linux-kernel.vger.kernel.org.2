Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 747123C9D74
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 13:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241590AbhGOLJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 07:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232114AbhGOLJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 07:09:57 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EFF0C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 04:07:04 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id v14so3047857plg.9
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 04:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=a1hReqe6SAPG8cLciVBzs6tSIWDwg7+KCHr7wVxfoQY=;
        b=oqgcIS3Nx7Nt1JyIGeCEZeJfM5uEAJsIp8FJnbmqybuHQPrMzgaM5brHb/kIb1dV8e
         Xa0HeOIEvaY8Q5SbB3HTIzPuMNNobjBykpuoRpT0WGO6JtjtDLqHE/6quh1nptQu6MDx
         fEhXeJq9Tj471tthFrVddVbCG9MJSspey94heIRjOES74Es5vN5TC/lhlyDAAxBJ+ASO
         xFIKXo387zjnrgm9YvvVWe8gnpY7WStjjgFFqOYJscGpKxLX2+vasOQZqjktOILCrse8
         MNeF/ksXL54GBD7MNKArnkml/XHrCXU9XI5nFl1A0c7MVY+pe5W7sxtTeky19OEerhg9
         IjqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=a1hReqe6SAPG8cLciVBzs6tSIWDwg7+KCHr7wVxfoQY=;
        b=Rcq0gRxh1gEwLGHjimH4ypFNJSP46q1SC68v2+1g1OmIqWJ905pOP7GP/KkwFClXdv
         4E/jVSyWtLc6KjJ7qWOLbC+0sxfUPjAYm2phuuduaBr1SSlmBbfuLM08om/e5Z2gnnx9
         vfLUdrOqYVFSUhnM9gokkGTk0MpVpbI5ATmqn2sWskcvllbyYkChtWyG7jywFn7PsBzu
         UWSsulFMJ2St6//4Z0XerUqlVNaPX6aGh2d/trXlvLLWh/CbAjjXbCHQTA0cyXyihUsX
         NL4vlqazDGdZ6NuEK8FfiyEy8MXnoc9g3iESgqR5VZXJDV4SjEuBNSBM8y+Gg/4MowXP
         cQtg==
X-Gm-Message-State: AOAM530s1FcL96XsXPpiHVCAf3NVzRtrWgofCns6Hf4QHuen+WqBg5gW
        TceQGriGyQW1M0dq8unotdY=
X-Google-Smtp-Source: ABdhPJwe4wUSNEI+YxPgt7JodhhP/NdunKLIaqLxtDZ6NYm0csn2HwNi9jF1NxDsnfWxStDd1nQd8g==
X-Received: by 2002:a17:90a:f198:: with SMTP id bv24mr3734009pjb.171.1626347222378;
        Thu, 15 Jul 2021 04:07:02 -0700 (PDT)
Received: from bj10045pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id u16sm7051068pgh.53.2021.07.15.04.06.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Jul 2021 04:07:02 -0700 (PDT)
From:   Zhenguo Zhao <zhenguo6858@gmail.com>
To:     zhenguo6858@gmail.com, keescook@chromium.org, anton@enomsg.org,
        ccross@android.com, tony.luck@intel.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] pstore/zone: Remove redundant check for total size
Date:   Thu, 15 Jul 2021 19:05:36 +0800
Message-Id: <1626347136-19740-1-git-send-email-zhenguo6858@gmail.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhenguo Zhao <Zhenguo.Zhao1@unisoc.com>

The macro check_size contains size check for total size.

Signed-off-by: Zhenguo Zhao <Zhenguo.Zhao1@unisoc.com>
---
 fs/pstore/zone.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/pstore/zone.c b/fs/pstore/zone.c
index 7c8f8fe..93a770c 100644
--- a/fs/pstore/zone.c
+++ b/fs/pstore/zone.c
@@ -1295,10 +1295,6 @@ int register_pstore_zone(struct pstore_zone_info *info)
 	int err = -EINVAL;
 	struct psz_context *cxt = &pstore_zone_cxt;
 
-	if (info->total_size < 4096) {
-		pr_warn("total_size must be >= 4096\n");
-		return -EINVAL;
-	}
 	if (info->total_size > SZ_128M) {
 		pr_warn("capping size to 128MiB\n");
 		info->total_size = SZ_128M;
-- 
1.9.1

