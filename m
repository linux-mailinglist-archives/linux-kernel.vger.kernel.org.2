Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74A253AAB96
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 08:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbhFQGEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 02:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbhFQGEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 02:04:39 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C980C061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 23:02:32 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id y15so4133510pfl.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 23:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=qjqA3nA8Tl2YBMBX5M5Jdn9XuXHXzYsUtKNnmWCU9Ns=;
        b=nmHfpCNtr4GmAYArofqZQyiYhOEx2b+3cS0sMAKLWzYH5A7op0SLKAWlwvEOxp9HmP
         hAB/0FnuFPecXdhxeuhbu9luRDufH2lEvWN2h3yDp8b1BPor/n2qDCgz1iWyBUbetSf/
         uEuHqF2UoG2p/pLAmFiah88r/zYd5BYC0RQjXIZ2895+zOlP4NYBOzuFcpXCBI2U+DGA
         leS+gIGNvs/4nLSh5+dEKWyGmuVLGuHWw7uMYCCkzo5JYY0TRjbmTcBXr8FYtqzxpeno
         k0NkYV1iIC4gvcXsr5ih0HokqtAa2j1JBkHPAWAGPc2mm5V2QFBXXbWkmdBdqtLllDQt
         3FMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=qjqA3nA8Tl2YBMBX5M5Jdn9XuXHXzYsUtKNnmWCU9Ns=;
        b=tO2XfOU90e2+RRH8IcuURoTn7AnBaqFCXVXCu6DpEGeOE1mxI+C8q+5UR2fGJzhxH8
         v0qcfCJSK/rWTVzpngLkpkwj2o2ms8WndNXPAvLLrupY1Cs4+m0ss9/9468/6SWomN7G
         80522Jx+BJovvj1WzvizLW2PsQVJZ9q8wan5/K4xaFG5IOmkfNpqL3+2n6TzHpfrgmxm
         iPh8HLSNpTHJU/BWsZH2cD4ZUTKErqHHGnEs8nb2gpa3TPp3tK5h380Evl59ovEfKQJ6
         M3gOAf1rHWtIyJYvzZfIZ45vJOeK4AfjMVqpdp/POTO5USeQtpTurvrijhB0hHAikfnU
         gUoQ==
X-Gm-Message-State: AOAM530nWryhJGpHSDbBUzNI3Z/A7Woe5or8PIZ+q9bhytRIpo2fZNzm
        JTt0P5eKYLtLm1bhJfCF/3o=
X-Google-Smtp-Source: ABdhPJz7sBAS39BFY+QlEa8hF6jVMcgxy/VWDF85SOxrPW4RCgFPKSNKbDaZQcJfkrDwek8iiIADQQ==
X-Received: by 2002:a63:4241:: with SMTP id p62mr3538370pga.264.1623909752220;
        Wed, 16 Jun 2021 23:02:32 -0700 (PDT)
Received: from localhost ([211.36.156.70])
        by smtp.gmail.com with ESMTPSA id m1sm4148875pgd.78.2021.06.16.23.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 23:02:31 -0700 (PDT)
Date:   Thu, 17 Jun 2021 15:02:17 +0900
From:   JK Kim <jongkang.kim2@gmail.com>
To:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] nvme-pci: fix var. type for increasing cq_head
Message-ID: <YMrlaTjfyy9slGg6@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nvmeq->cq_head is compared with nvmeq->q_depth and changed the value
and cq_phase for handling the next cq db.

but, nvmeq->q_depth's type is u32 and max. value is 0x10000 when
CQP.MSQE is 0xffff and io_queue_depth is 0x10000.

current temp. variable for comparing with nvmeq->q_depth is overflowed
when previous nvmeq->cq_head is 0xffff.

in this case, nvmeq->cq_phase is not updated.
so, fix data type for temp. variable to u32.

Signed-off-by: JK Kim <jongkang.kim2@gmail.com>
---
 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index a29b170701fc..2995e87ce776 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1032,7 +1032,7 @@ static inline void nvme_handle_cqe(struct nvme_queue *nvmeq, u16 idx)
 
 static inline void nvme_update_cq_head(struct nvme_queue *nvmeq)
 {
-	u16 tmp = nvmeq->cq_head + 1;
+	u32 tmp = nvmeq->cq_head + 1;
 
 	if (tmp == nvmeq->q_depth) {
 		nvmeq->cq_head = 0;
-- 
2.30.1

