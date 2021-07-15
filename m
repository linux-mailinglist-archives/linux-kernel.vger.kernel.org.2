Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44EA63C9A02
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 10:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235661AbhGOIDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 04:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbhGOIDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 04:03:24 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A657C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 01:00:32 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d12so4403185pfj.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 01:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QqJStMOrwx7y7UxqlXFPqolNzKNkJRKIij/JVfL5lno=;
        b=WGCbtxAIdNFuHzwJ0qgJxjEXDHpeVLxRJtk/lkavQQF+MkdpIIWbahDqcbfSaS8oQE
         toaT8SLN7dr4x5Z+PtRKAxrc2NVU2echa2BP4eU/I25FjhODNA9srVSnbleQxez6VbGB
         SS7HLa8dMvgNiipst3kA6r3E11nTt8kbkZ7Fl5b+rIJKeml8NkwnECYI/1T+x1efGLlD
         xtxq0KtLaKNbP5uywWprYVf0GPdgTi372tssbPikEN+myyCwS+H/xJgHUfYKTra6TWoF
         5rAFEI0G+jNVUCcgEDobTD/Ptvv0Tjmr+UDFzmD/3H8ARukQ8rxTljEciaL6G8Ch68dR
         Nb9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QqJStMOrwx7y7UxqlXFPqolNzKNkJRKIij/JVfL5lno=;
        b=DWYAGTDcNWnCYdPZcNCqgmy5JZhcw3/tVVDUvcM/ZX/TTC64od+1vnHiwgjVOnHmO1
         eraR/B+WXUKBpSS0eUJiV0qRkwC+Ue/2m9f7kMQy7P9ZxxuA+c21gvpwY5Ygb1Km9F//
         HzF7Hv+E7q7D27o4ocencqu8sNlo9wZdEYo1PvD2pqkrDze2tsmOp4qi+Ksd86c+aqaW
         FYRM+GGQ9QSMckn0DV7BU51X9Pj+TeQZyTCDEsLsI22PdIvPOvYKfdNFVjp9SYCAPwL/
         vE3ZWxmCaziaWWO/ysLtnYYayLqzOgHOWFz04baSZ8o+XrGACwvCmz4jjAfZ5lo0PdPi
         nEMA==
X-Gm-Message-State: AOAM531hC250PPV73FVVprPkkEYHgmhaDHwi5P8YbIYZu8aJQ1AWpe76
        tTIk/htdMEPhLT+IpcbZe47h
X-Google-Smtp-Source: ABdhPJytNgpVN0WaVaQFad9b5YNtnT4utDfbfMiKb9uy89D/YfeDbrOBqAv7/kRcdmhotTYBRw/Qjw==
X-Received: by 2002:a65:5186:: with SMTP id h6mr3274634pgq.62.1626336031622;
        Thu, 15 Jul 2021 01:00:31 -0700 (PDT)
Received: from localhost ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id ce15sm4436691pjb.3.2021.07.15.01.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 01:00:31 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, dan.carpenter@oracle.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] vdpa_sim: Fix return value check for vdpa_alloc_device()
Date:   Thu, 15 Jul 2021 16:00:23 +0800
Message-Id: <20210715080026.242-1-xieyongji@bytedance.com>
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

