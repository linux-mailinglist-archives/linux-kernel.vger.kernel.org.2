Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 420FB3C9A01
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 10:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234555AbhGOICz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 04:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbhGOICw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 04:02:52 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B7C6C061762
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 01:00:00 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id u3so2773558plf.5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 01:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QqJStMOrwx7y7UxqlXFPqolNzKNkJRKIij/JVfL5lno=;
        b=jdEE6sSV6+Yhgufmd98J9IbsyVgWyk4b9BJPl6on0YYMY+HqBqzloFvyBCFBV5TB2E
         CSZggYQ5/hIaPWvY/4mim8Tf7K8NCOHtzU4FswtSGeCtd1lkRQMxX/ReQSFKnv6PW9o1
         noeYi2nt47z6MLCqQiWZonXwzZDyxp/Qel/u5rowv1DStj8F1qe9RcyivAaKJI3XFZIG
         U1TIRNaLq+FLtUFE9oz/RcWjLUG6ysSSfGjs9kw9jKH3dIFQIHLGftA2G3YwJwrXj92Y
         gh7A4fAnA4mBFCq8BvT/hv+DdeAY6JnfOWsHklq0pPKnjoxDCW8i4BIVcq8Uug//9M/q
         5SVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QqJStMOrwx7y7UxqlXFPqolNzKNkJRKIij/JVfL5lno=;
        b=kl7EFsmo6pEhqpmQsjoJ1ttzMcatsB0mT6m+/RL1+LUaOBsiy08NIpcjrCm6GbW4Mz
         umU1dc1K6rXxtQAbRoJp7K+K90Cjcuikb1kFIsBeCcb2kawjsYdf6GwVwVDnEMNACoRq
         xnHgwg4zaEYSQ4uoBreDNakRcC4lV7rVhw6vINeJ1Bdhk1Lpk6070hfk9ql7nmM7xjN5
         8/zsBdRI9hpSyTt6MTW5eKEzjB1aekK3pZo/kFd0rpZjmgS0TlK8Lu6lJfMjZrZ0l4Po
         NA1Q+n8wT5HafnEhBW/dcgZH0U7o+Leq1x+JdSzXSSFS9o2XPu2abdPDOVn3BFziL7bi
         J0rg==
X-Gm-Message-State: AOAM530xCAa/Qi+Z6GeWFOKZNNNiGA49jhVc7CKz+GeF4iVZLi1YXsuW
        b04R+4Zbv2YzywuV4Uq4HnJA
X-Google-Smtp-Source: ABdhPJwJuR8lVc6Gv0vxGRjzHmkX/ad8tCit1Fxz11zkQp4aUlomNlr0mRASYfM8+hl8kwPgb1f+0g==
X-Received: by 2002:a17:90a:3c8d:: with SMTP id g13mr8828461pjc.229.1626335999498;
        Thu, 15 Jul 2021 00:59:59 -0700 (PDT)
Received: from localhost ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id m16sm5103192pfo.152.2021.07.15.00.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 00:59:59 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, dan.carpenter@oracle.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] vdpa_sim: Fix return value check for vdpa_alloc_device()
Date:   Thu, 15 Jul 2021 15:59:33 +0800
Message-Id: <20210715075936.180-1-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vdpa_alloc_device() returns an error pointer upon
failure, not NULL. To handle the failure correctly, this
replaces NULL check with IS_ERR() check and propagate the
error upwards.

Fixes: 2c53d0f64c06 ("vdpasim: vDPA device simulator")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index 14e024de5cbf..c621cf7feec0 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -251,8 +251,10 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr)
 
 	vdpasim = vdpa_alloc_device(struct vdpasim, vdpa, NULL, ops,
 				    dev_attr->name);
-	if (!vdpasim)
+	if (IS_ERR(vdpasim)) {
+		ret = PTR_ERR(vdpasim);
 		goto err_alloc;
+	}
 
 	vdpasim->dev_attr = *dev_attr;
 	INIT_WORK(&vdpasim->work, dev_attr->work_fn);
-- 
2.11.0

