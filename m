Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA1973AB1F7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 13:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbhFQLLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 07:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbhFQLLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 07:11:12 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D222C061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 04:09:04 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id p4-20020a17090a9304b029016f3020d867so1548499pjo.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 04:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ubwQxfJ7r76nVrpUfP56UmNpDWURO/0W1EJ6byvdhqE=;
        b=b5XI3pLjW8Bkk/y11RUW1X7ngiOhbQFGpfWTdcOaHe5dmr05zK6CWVzeaz4OzqyEEc
         PquhzWGNflnMM4bLsK/zokD2Dq5JCGWKPp9aw6QWSqbHj5hS8b2s2kmkSbzaQf1u1CLJ
         uhJ1pxjoR62dGO69hVN5zfYOrXoeZunG3st/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ubwQxfJ7r76nVrpUfP56UmNpDWURO/0W1EJ6byvdhqE=;
        b=Vo2azmE6kCZL8r+C7+3dSgw2obnHEmdMEhhhk0DraqoavmxelYn3PfWfuoDg5YzcrA
         H0A4LC3jvPAEAuE1RBJcfu7R+LW3VDVFGgS4cSPnDnrq9dqaWUV3yNtlexKKWvv0Nwy4
         ne8o1Q+tMyHTe9yLj1L5tv6y/X5fqBzzCYdMfa7/I6v86/7+OYtBMa35RI/l7XypTOB5
         CZlAyGrZJ1+hcPTrU6CzOtqk5RaxIDQtiGC3sElxsMGHYaWlsS/gT4vNiQNzziFqjK//
         PgoKVm0MOSUdkiZ2k8Gv7GJ1cvW0DcP2jdfHe2EzRTNn1ttbGqIeZUCTMOpbevITcli8
         y+/g==
X-Gm-Message-State: AOAM530BSrjmTI6NNZ3XsBTOZvhlsXDQQBmYX6I5sweYh0bf1M9YhUYs
        bmSQy1jXV95MNQei+P/I+vbfNg==
X-Google-Smtp-Source: ABdhPJycLWzQ7dy1nlmhvg7TDELG8aFVZlwmZYpNF4L7lWSgp591SZSMCq+urKC1TyrjVB7unThsUQ==
X-Received: by 2002:a17:90b:108f:: with SMTP id gj15mr5213022pjb.124.1623928143531;
        Thu, 17 Jun 2021 04:09:03 -0700 (PDT)
Received: from shiro.work ([2400:4162:2428:2f01:7285:c2ff:fe8e:66d7])
        by smtp.googlemail.com with ESMTPSA id n23sm5094397pff.93.2021.06.17.04.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 04:09:03 -0700 (PDT)
From:   Daniel Palmer <daniel@0x0f.com>
To:     miquel.raynal@bootlin.com, richard@nod.at
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Daniel Palmer <daniel@0x0f.com>
Subject: [RFC PATCH] mtd: spinand: core: Properly fill the OOB area.
Date:   Thu, 17 Jun 2021 20:08:42 +0900
Message-Id: <20210617110842.2358461-1-daniel@0x0f.com>
X-Mailer: git-send-email 2.32.0.rc0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comment in spinand_write_to_cache_op() says that
spinand_ondie_ecc_prepare_io_req() should 0xff fill the OOB
area but it doesn't.

This causes the OOB area to get filled with zeros
and anytime the first page in a block the bad block marker
is cleared and it becomes a bad block on the next boot.

This was observed on Longsys FORSEE branded parts and
might be specific to these parts.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 drivers/mtd/nand/spi/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 6f2d39f9bb06..f1c76fa0e220 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -281,6 +281,9 @@ static int spinand_ondie_ecc_prepare_io_req(struct nand_device *nand,
 	struct spinand_device *spinand = nand_to_spinand(nand);
 	bool enable = (req->mode != MTD_OPS_RAW);
 
+	memset(spinand->databuf + nanddev_page_size(nand),
+			0xff, nanddev_per_page_oobsize(nand));
+
 	/* Only enable or disable the engine */
 	return spinand_ecc_enable(spinand, enable);
 }
-- 
2.32.0.rc0

