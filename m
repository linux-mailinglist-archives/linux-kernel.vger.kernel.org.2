Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A61FF38B60C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 20:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235311AbhETScT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 14:32:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20935 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233857AbhETScS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 14:32:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621535456;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=WMVLkroGznixoNyjbJwPulQLiUxwQzLRzXIYgKX9DDk=;
        b=dta0JpN+E838v4kR0ai5DzTSWUzqWHm0eof9APZ0ee8WSjQ6HY4adoEK8XtWj9chWjoPYL
        tLabztvbkam8NV3ISStXbhmE1z/n8XpLCdRLVc7Z/+BuWhmv/KQ6i7pHWkNkPEZjracRXT
        kvt0pH7rpZK7VpuGXgNQ3l1Dg8CB9Zk=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-KkcoFy_GP7qmemcl-h44ug-1; Thu, 20 May 2021 14:30:54 -0400
X-MC-Unique: KkcoFy_GP7qmemcl-h44ug-1
Received: by mail-qt1-f200.google.com with SMTP id h2-20020a05622a1702b02901b9123889b0so12952789qtk.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 11:30:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WMVLkroGznixoNyjbJwPulQLiUxwQzLRzXIYgKX9DDk=;
        b=gxKmaHbksQf/TW21s/pK3KR5y8bvL9njlG9NfGXCdBB8jaobsBo1vGFfCywT2fQqmf
         9oRsGF78ja6RLJnwVo+8m7A6SKWQjVEAFU7w/kJODg3qBH0Lys4l/Vy0LfvsWn8RE5c/
         7ps9sbKpJSB9cJ7YgXYt+l7HRHqSNFpuVlnPfgGgw6hY1vMkyv16aWw5X93G8HPt6WQm
         MNQQde3TTqZot8Lw3oJzP++may0JvbWVg9YoPo61cfXA2Wgk4n11k5lEYGfax6kMxH6x
         yIEqZTTJPYfC6aZhc5zO+U3GC7esHFZ83uzPwN5xIVqDzcYHJE/kN26Si1GXl5L7EIf7
         IBfg==
X-Gm-Message-State: AOAM533j0KT57k10jU6dSzd/hFSgaXVxWEw0gaUJVR+A7NNNgoA7SrUl
        TnrRW6Eve1CbX3sxCKwtDUa5Kx+rtqiJPzFhfdUcDFCl9jFUsl+h6mEKj3rlSiUQ+YBuDi/+Yz3
        yAqnlQEfM6wMuLYwTDySIluYm
X-Received: by 2002:ac8:7ef2:: with SMTP id r18mr6698649qtc.333.1621535453807;
        Thu, 20 May 2021 11:30:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJypqNQnjLGYPT9cwZhXzhzvHWqROXjiEksYjG//nhkya+T2M49M4zItRGoqs+JifXjOAf4e0g==
X-Received: by 2002:ac8:7ef2:: with SMTP id r18mr6698627qtc.333.1621535453658;
        Thu, 20 May 2021 11:30:53 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id t17sm2377264qto.92.2021.05.20.11.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 11:30:53 -0700 (PDT)
From:   trix@redhat.com
To:     mdf@kernel.org
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH v2 4/5] fpga: defer checking for update ops until they are used
Date:   Thu, 20 May 2021 11:30:48 -0700
Message-Id: <20210520183048.2022642-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Which update ops need to be used will depend on the
FPGA_MGR_REIMAGE bit in the fpga_image_info flags.
reimaging is optional, no drv that does not need
to remimage should be forced to provide stub functions.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/fpga/fpga-mgr.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index 4263c9e94949d..5247703a3743d 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -369,6 +369,14 @@ int fpga_mgr_load(struct fpga_manager *mgr, struct fpga_image_info *info)
 {
 	const struct fpga_manager_update_ops *uops = &mgr->mops->reconfig;
 
+	if (!uops->write_complete ||
+	    !uops->write_init ||
+	    (!uops->write && !uops->write_sg) ||
+	    (uops->write && uops->write_sg)) {
+		dev_err(&mgr->dev, "Attempt to load an image without fpga_manager_update_ops\n");
+		return -EOPNOTSUPP;
+	}
+
 	if (info->sgt)
 		return fpga_mgr_buf_load_sg(mgr, info, uops, info->sgt);
 	if (info->buf && info->count)
@@ -579,10 +587,7 @@ struct fpga_manager *fpga_mgr_create(struct device *dev, const char *name,
 	struct fpga_manager *mgr;
 	int id, ret;
 
-	if (!mops || !mops->reconfig.write_complete || !mops->state ||
-	    !mops->reconfig.write_init || (!mops->reconfig.write &&
-						 !mops->reconfig.write_sg) ||
-	    (mops->reconfig.write && mops->reconfig.write_sg)) {
+	if (!mops || !mops->state) {
 		dev_err(dev, "Attempt to register without fpga_manager_ops\n");
 		return NULL;
 	}
-- 
2.26.3

