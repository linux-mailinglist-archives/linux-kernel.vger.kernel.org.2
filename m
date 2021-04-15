Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 580F4360519
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 10:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbhDOI7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 04:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbhDOI7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 04:59:08 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D73C061756
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 01:58:44 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id j32so1679714pgm.6
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 01:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raydium-corp-partner-google-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H3nwljrpf1jf8bySluxRv8rZgDkPdXANojdvTEFQXIo=;
        b=ixrsZLFMmuaql2Etmu49zksRPb1hdpL95Q86zMxUA19u0RAQgtx54Pd4gUEUtDW9o4
         aRf1OLWDWDSJKpGBJ7P4zz0/E6uxGzTqnjYH4DXNOl+lAnelFGFbN+Ouc8zdUSEGl0yM
         7Iy8B6zhe0e0qIrbLToGdIi9qBp5WAT1mN6qxMhRYPbpy+P1B2ua8D+1QlPNjaC72ko6
         vkYRgYPnpbWP0Ac5elWcCRHmnaT9eSZ5SRoASpIU9I/VlB1rYbQtdwoGsTW9IY6em5v4
         r1Uag2lQILM/b5xtslPeioY0M55xnK6DcDrM+PlJ4dL7Ldd50Lx64hjmKv/RB0/+PAGT
         V8mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H3nwljrpf1jf8bySluxRv8rZgDkPdXANojdvTEFQXIo=;
        b=Y8HgYhEenQoaL/+wHxStcBfqV7yDvh7fkH0qN6OG6vUT0b9cIONPkOp3SxqvcEKlUZ
         iEpfcShiAkJfBOAiysI8O3EtaCIUGrGXxg8dIocSnRqDqJzPSXCnX9JO5uIdsPGSU5gg
         q/1Vb4RrgpjPpoh3Dyumgi7BTkpd1iTUzRsk3m8A6Gw9LjNci3TGmir51jGw9frhWhaM
         su2H13NNgGAKx0571+TLac9pbqDup/JAO5vlLG0zEcVTK4u6P+Revn914Qs/kDiuBsrZ
         pwgxYQypT6QDIPewU12VzdG0sOKz/MKjZYxYQljBFjD8dpn/J25i+PknsoiH29/2zpVU
         oPUQ==
X-Gm-Message-State: AOAM532y2Jihq3CcclK5yfcrPF5D5KRwOveRLIKicajokXA+Efd1UPdb
        r4+Jujz5XMhEI2TbA9BVTMkS6g==
X-Google-Smtp-Source: ABdhPJyGYZQMDrb6VLkEkR/4k9dlcJGA10PNNI1qnL4lyUwtOhzy0MuaOpO5O4nzSO5ai4n6hT8srQ==
X-Received: by 2002:a65:6143:: with SMTP id o3mr2473224pgv.332.1618477124217;
        Thu, 15 Apr 2021 01:58:44 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:568:4ad6:da14:907c:85c9:a997])
        by smtp.gmail.com with ESMTPSA id t3sm1575883pfg.176.2021.04.15.01.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 01:58:43 -0700 (PDT)
From:   "simba.hsu" <simba.hsu@raydium.corp-partner.google.com>
To:     dmitry.torokhov@gmail.com, furquan@google.com,
        seanpaul@chromium.org, rrangel@chromium.org, simba.hsu@rad-ic.com
Cc:     jeffrey.lin@rad-ic.com, KP.li@rad-ic.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        "simba.hsu" <simba.hsu@raydium.corp-partner.google.com>
Subject: [PATCH] driver: input: touchscreen: modify Raydium i2c touchscreen driver
Date:   Thu, 15 Apr 2021 16:58:29 +0800
Message-Id: <20210415085829.1419147-1-simba.hsu@raydium.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This path makes auto-update available when IC's status is
Recovery mode.

Signed-off-by: simba.hsu@raydium.corp-partner.google.com
Change-Id: I5ae54896a201b949eba7514500a7e75574f5726b
---
 drivers/input/touchscreen/raydium_i2c_ts.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/raydium_i2c_ts.c b/drivers/input/touchscreen/raydium_i2c_ts.c
index 444479ef699e..a97403c55f75 100644
--- a/drivers/input/touchscreen/raydium_i2c_ts.c
+++ b/drivers/input/touchscreen/raydium_i2c_ts.c
@@ -298,6 +298,7 @@ static int raydium_i2c_query_ts_BL_info(struct raydium_data *ts)
 					 0x10, 0xc0, 0x01, 0x00, 0x04, 0x00};
 	int error;
 	u8 rbuf[5] = {0, 0, 0, 0, 0};
+	u32 tmpdata = 0;
 
 	error = raydium_i2c_send(client,
 				 RM_CMD_BOOT_WRT, get_hwid, sizeof(get_hwid));
@@ -315,7 +316,8 @@ static int raydium_i2c_query_ts_BL_info(struct raydium_data *ts)
 	error = raydium_i2c_read(client,
 				 RM_CMD_BOOT_CHK, rbuf, sizeof(rbuf));
 	if (!error) {
-		ts->info.hw_ver = cpu_to_le32(rbuf[1]<<24|rbuf[2]<<16|rbuf[3]<<8|rbuf[4]);
+		tmpdata = (rbuf[1]<<24|rbuf[2]<<16|rbuf[3]<<8|rbuf[4]);
+		ts->info.hw_ver = cpu_to_le32(tmpdata);
 		dev_err(&client->dev, "HWID %08X\n", ts->info.hw_ver);
 	} else {
 		ts->info.hw_ver = cpu_to_le32(0xffffffffUL);
-- 
2.25.1

