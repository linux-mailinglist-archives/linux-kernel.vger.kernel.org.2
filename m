Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A049C3A7C7C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 12:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbhFOKzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 06:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbhFOKzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 06:55:08 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6866C06175F
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 03:53:04 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id b12so8253000plg.11
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 03:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=77abVvtdAdpsdW3TjnJbPbQceAD3ngpH/aIswkPaxEg=;
        b=Tds1GT4722acJuoNKaEMvAWaA5jVqpeaFseEXRr4CEjsZ+sfaupbI4X1/nZ6k0dr9y
         OYfv7o4sX3rV3oWwgL5Z6vG3F7Fpf+9kWzj3krKou8Ng04U5gjxRPPjOJ0bivqaNR0p0
         EQLz5jB2n8Sfqm0XEnOdk7og6nyuMMD905ZP8mZhRwh0H0gezjRmQVQzfkguifvE/IP2
         1aDMqRsWalb9xqDVyl/g6yjTZE2mf10cSyPLbjBhV4fUqdXtlPrsFFuwO7Kp0wX3DHtu
         Gq1T8Y4Pf+PhX39zYEeouiXnjg38o8KJpcERHDaVrTwDE5WpL7uVdDrpsvJM5uoW3NMk
         trgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=77abVvtdAdpsdW3TjnJbPbQceAD3ngpH/aIswkPaxEg=;
        b=V2ANYeDRhvi1hVeQhOuzNgotidSERXYBjRXpdacpt+Gw0oub7yQmWUkK1Rv5PuyHsU
         Ej06zuDn72mqJe5maCR+RXs0Sf+avS3w584EqMxeMz20zfQgNpKTr8qP4+sLD4ZvSv4s
         U47mnOZxCTwz+tFXsp0g2W6AggRJqWttI8XV9To/Up8tQXrdds7Ms+Z8KxUOXM5fnNo4
         0IydZ2sA7KQPgnhCcaICoFNhynxMf19HTuGuA2/XrGOUrm69gO/6EqSwr25cZry3eTZ7
         i4V4WdA61IRkv3q8+HWwG5HAIjbRn84CjdGcotNBtswuQGpt2WIl6IielgrvyES0dssy
         SieQ==
X-Gm-Message-State: AOAM532moujeSiFNUoufhGbLxqEiFUoNyNhrO5Ej7HuPDSn7tRlRwEas
        JfkKLMugluGZyX/Tatakvac9
X-Google-Smtp-Source: ABdhPJzseDWG1hjfL7mLTTag7psIODvVANSAUopVS9dBKHkwKyJbNHvAanyQPDK+CDEj8Lfxl/ttsg==
X-Received: by 2002:a17:902:c3d5:b029:100:742f:fce9 with SMTP id j21-20020a170902c3d5b0290100742ffce9mr3438730plj.46.1623754384193;
        Tue, 15 Jun 2021 03:53:04 -0700 (PDT)
Received: from localhost ([61.120.150.78])
        by smtp.gmail.com with ESMTPSA id g6sm15522184pfq.110.2021.06.15.03.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 03:53:03 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] virtio_scsi: Add validation for residual bytes from response
Date:   Tue, 15 Jun 2021 18:52:18 +0800
Message-Id: <20210615105218.214-1-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This ensures that the residual bytes in response (might come
from an untrusted device) will not exceed the data buffer length.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/scsi/virtio_scsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
index b9c86a7e3b97..2badc3c80d73 100644
--- a/drivers/scsi/virtio_scsi.c
+++ b/drivers/scsi/virtio_scsi.c
@@ -97,7 +97,7 @@ static inline struct Scsi_Host *virtio_scsi_host(struct virtio_device *vdev)
 static void virtscsi_compute_resid(struct scsi_cmnd *sc, u32 resid)
 {
 	if (resid)
-		scsi_set_resid(sc, resid);
+		scsi_set_resid(sc, min(resid, scsi_bufflen(sc)));
 }
 
 /*
-- 
2.11.0

