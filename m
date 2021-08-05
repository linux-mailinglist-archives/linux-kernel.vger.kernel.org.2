Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4B9E3E1D56
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 22:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240541AbhHEUZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 16:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbhHEUZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 16:25:05 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29605C061765;
        Thu,  5 Aug 2021 13:24:50 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id a8so11714643pjk.4;
        Thu, 05 Aug 2021 13:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=eSz15u2Dr58SUSS8iBu0Kd6ph2ETfdlo7oBGAWFRQOI=;
        b=N2kw+98bMHkhFXp99bdwGdKd2H3OHPsb68wa7iybe0aETGkew2LxxmzSBLu0YB8/Fi
         fSzHgLcIZFXFkYhGQrTEGXxi4U/LcH/yP4RIK5GA+HiLieN9AhiYQdJWmLjdKTdX+uLo
         vZ1KYbqUYGQXADLw0Vk30bYqHes3rujA8OdrPhiMVvO166Sukzw2dtzJISNGeKfrYunQ
         VFFAwiDvD3C+i1Yrb1PxVtvgZzRjdq2hC074tjc/fbazDfcJzhH0/TcAxddW+vjeMPDj
         1iGIz8zj4TIIy/6nl6ZQZQ2ojgrIZnksmj5D+2FoEX7M/NH5WcHKUv2+2lede2E22BFj
         x6yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eSz15u2Dr58SUSS8iBu0Kd6ph2ETfdlo7oBGAWFRQOI=;
        b=aczp1hYxlvi22EWJWoirfiHweXQB+iSz8q2OtZokJVaCiexyue3SVNO7UI+j+QQ9HO
         WGVHvYU8fcpw0mBmlCt5oiHu272IelPR6jkddD6sA/EH3S/Trm7/ywxwPDXbOJUcOH0w
         nDIo9pbAgaIflAB9FbRDXTg5PIc/McaJgewGtWq11eTGHV4+4VAEZfxLog1FbaGqgZIJ
         Q8CH1xtSiP5HntoLBuZDgaxLguxHWUnOF3usV06QZa1BxwhMoXhId2kBomSg+PT9PeZL
         94dl1uWtm6pMi9qaTSldJD1XhyIL9aAU3up9uuE0yXA/fkaTjl/J5wgg6c//AWBZgA74
         Rwcg==
X-Gm-Message-State: AOAM531Ms5wws6vPcpgdfS28NqfGssbxBgLIc4SksOOykT+Fj3EAKkpe
        GRWElTpA8i7i8czRzm8qpLI=
X-Google-Smtp-Source: ABdhPJz2tGsZB9vn1nmrCekZhMXi0xFcP5sKnookc92bAs0GoTOv2mDbfdy1S+xyDQoTt+/0hlefGQ==
X-Received: by 2002:a17:902:ed82:b029:ef:48c8:128e with SMTP id e2-20020a170902ed82b02900ef48c8128emr5423301plj.72.1628195089196;
        Thu, 05 Aug 2021 13:24:49 -0700 (PDT)
Received: from localhost.localdomain ([106.51.233.109])
        by smtp.gmail.com with ESMTPSA id b10sm7645656pfi.122.2021.08.05.13.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 13:24:48 -0700 (PDT)
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>, Jens Axboe <axboe@kernel.dk>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Bean Huo <beanhuo@micron.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Avri Altman <avri.altman@wdc.com>
Cc:     Nishad Kamdar <nishadkamdar@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: core: Return correct emmc response in case of ioctl error
Date:   Fri,  6 Aug 2021 01:54:29 +0530
Message-Id: <20210805202429.23127-1-nishadkamdar@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a command is sent via ioctl to the kernel, and the command fails,
the actual error response of the emmc is not sent to the user.

I have tried this by sending CMD17 (Single Block Read) from user space
via ioctl with and out of range address as an argument.
The response I receive is 0x00000000.
This is because the actual response is copied later in the function
__mmc_blk_ioctl_cmd() after the data error is detected.
This output is misleading to the user as the actual emmc response is
0x8000900 which clearly shows that is an OUT_OF_RANGE error.

The patch fixes this issue by copying to contents of the response to
before issuing the error.
Thus the user will get the correct response and will see the error as
well.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/mmc/core/block.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index a9ad9f5fa9491..efa92aa7e2368 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -522,11 +522,13 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
 	if (cmd.error) {
 		dev_err(mmc_dev(card->host), "%s: cmd error %d\n",
 						__func__, cmd.error);
+		memcpy(&idata->ic.response, cmd.resp, sizeof(cmd.resp));
 		return cmd.error;
 	}
 	if (data.error) {
 		dev_err(mmc_dev(card->host), "%s: data error %d\n",
 						__func__, data.error);
+		memcpy(&idata->ic.response, cmd.resp, sizeof(cmd.resp));
 		return data.error;
 	}
 
-- 
2.17.1

