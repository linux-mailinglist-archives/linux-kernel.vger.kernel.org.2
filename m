Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2DA43A552
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 22:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233788AbhJYVAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 17:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232467AbhJYVAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 17:00:10 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F36ABC061745
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 13:57:47 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id s1so4444529edd.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 13:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YOcpDB2bEq/LBIP5Nmj3ZGIJaD4nDPvU30poT+IIEsQ=;
        b=IY4fvIjHYJvLGZLrj+xFjbDdvMXERkWz43V8RwClQ/ywmTzOkDyGiNc9dvelYXfZr2
         pn20TkXmNbqgBmRD1AAhSHfMShkfifuIPoqx4IxVA4sPPMGFjnoTMcbJedkXPWBeQBI7
         qe8IJchAAhFp8uSzmj99e76yzjSjkTEpoCPUMUZVw/qyyviOpxgHaQdXeIPwEiBeEl/6
         fk/qazNBvWrxn1o4vNL3JZ0E95ii7yfc1qCNCJfWTR8et/FS3GtK/C4/W/ABbAuWVxSI
         Oqckb3S8gHWvJVtjRQ6QT1Ori7N7//ZYft8cvl/P3UdVD/mC4GPzqxZ1qWNcVt+Kzi7c
         yOpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YOcpDB2bEq/LBIP5Nmj3ZGIJaD4nDPvU30poT+IIEsQ=;
        b=1ou+OAwLaKya42wS4dn9atu8nxAMj9nSwp4sl+vcPqz4Yq/5oewnd0Htv49T+jIMed
         bPtR3PyN0AjuFgtqHL0HdQy7ldmR80cnR61Tcjh0Tf06mHlTPY8OEyQqlT6nf0F5iz7b
         07z1Vjscw80ToVR1nStInUMqzOBSS0OBrui+bfzn1YH0p1upzq3LWQcr6BpKMYsS8iEb
         M9DPbWUMsmowtcXherFrmi3p0c+Nc+mFScDSGCQlwrl+vddBOdxBFqIYWudf6ymgYe/O
         aOBjCar0coaFrDhjZzxYP9axXzq9xlMqEc1JPkixgKmhulpXqWCQrITUvIk9jlnjQDiS
         4yNA==
X-Gm-Message-State: AOAM531p2XVC/eQUqJ6LISrC4m6R+78h5HIOLthZzxfjzpizM9h7dzok
        kSjXhdgOJBJniwg42lLB/3s=
X-Google-Smtp-Source: ABdhPJwPrA3toXmEGj2uIHj0F58/RSx/i9+wqLsWkZ1zSw+2RiVjV0WDE/M7DcHcwxO+jT7bPR2vng==
X-Received: by 2002:a17:906:1707:: with SMTP id c7mr24567045eje.377.1635195466117;
        Mon, 25 Oct 2021 13:57:46 -0700 (PDT)
Received: from md2k7s8c.fritz.box ([2a02:810d:9040:4c1f:e0b6:d0e7:64d2:f3a0])
        by smtp.gmail.com with ESMTPSA id mp9sm6730317ejc.48.2021.10.25.13.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 13:57:45 -0700 (PDT)
From:   Andreas Oetken <ennoerlangen@gmail.com>
X-Google-Original-From: Andreas Oetken <andreas.oetken@siemens-energy.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andreas Oetken <andreas.oetken@siemens-energy.com>
Subject: [PATCH] drivers: mtd: Fixed breaking list in __mtd_del_partition.
Date:   Mon, 25 Oct 2021 22:57:24 +0200
Message-Id: <20211025205724.3306739-1-andreas.oetken@siemens-energy.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not the child partition should be removed from the partition list
but the partition itself. Otherwise the partition list gets broken
and any subsequent remove operations leads to a kernel panic.

Signed-off-by: Andreas Oetken <andreas.oetken@siemens-energy.com>
---
 drivers/mtd/mtdpart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/mtdpart.c b/drivers/mtd/mtdpart.c
index 95d47422bbf20..5725818fa199f 100644
--- a/drivers/mtd/mtdpart.c
+++ b/drivers/mtd/mtdpart.c
@@ -313,7 +313,7 @@ static int __mtd_del_partition(struct mtd_info *mtd)
 	if (err)
 		return err;
 
-	list_del(&child->part.node);
+	list_del(&mtd->part.node);
 	free_partition(mtd);
 
 	return 0;
-- 
2.30.2

