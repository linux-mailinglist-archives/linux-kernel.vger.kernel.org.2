Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAC8A38F142
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 18:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235100AbhEXQL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 12:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236466AbhEXQK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 12:10:59 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A3AC056353;
        Mon, 24 May 2021 08:58:04 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id k5so15082817pjj.1;
        Mon, 24 May 2021 08:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o82X5HgymL6cW4VbM9cJTzS1zYiyMTu5/WxGQrdHhxQ=;
        b=XVvCyvQjpE+djzLGq3lowirz+BlxEjm8ZcAH8BbWSQqbUXqwAPYVsgYnB19d3EgLRK
         GXEa+iQdiodDCwNGi5JYBvSAXeh50BuDrPJXV3dcXzcpzGhVm69KCHaZoxZZr8zNk0IA
         mws1l6V5hFBlt49PvyHB+LIlHanmaX8TJizPZCe2Lr3JuIskLH8OjUejdk6KL5ZO6fVz
         mkFxh2HJ+IssU6mWxyHXCIVjjtHJJcoPdD4YNdZox09v5f+pmdDxuMAgzoz1fKtNmaoK
         gbGllmxQ145YtHVKQHwYYU6XXVhPzq5RhmWyjgeXr9IvpTJbOWX25giEe+Q5ZxTwbKdE
         YKMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o82X5HgymL6cW4VbM9cJTzS1zYiyMTu5/WxGQrdHhxQ=;
        b=t+OK9rZuvnEt7/CJzttE9/uQcsW6XdwU9lxCTwPx7JnRlURSy1d5Ka9tcYSeSkGD1w
         Gz6CjCW82BZQoxGJfPuT6+k9sM++Nd7q3gs3pchcCNEkq/jwY3S7CRRDG2tkVUJWzj2+
         THcEIeIKnWx7GT/oHkvmIEJMl90AoB80jmmtGMwu+LEJCXXdIYmqiavbP9xzQsxG4wGA
         pGCrjwcRFg30SiddfIOEVHHIrOrKYKv9mnpg/s9EUeudACZ+oEnC2UhhyFuuzfr+zBzb
         e5r7YC99USsD3H83m8BLuFgkuwEkKDv+/q8VZopKRFFhwsIP90G456HJMOptsyX371Tf
         PsIg==
X-Gm-Message-State: AOAM530JcJbA0LXRmVl076Gxl0ClJU6AuhmaRJKAknwrIvhGX1h9fr0i
        0NFWXVw/hPP0yI1xtwIfZXor9RhRrwmxw9jN
X-Google-Smtp-Source: ABdhPJy58RQghS7ThhJgBfyp36TNHG0kgHWPFJnkTzVarDtqRt4+j2uXn/qXTUeJHfJJSNj2ez0s7g==
X-Received: by 2002:a17:902:6901:b029:ee:e531:ca5f with SMTP id j1-20020a1709026901b02900eee531ca5fmr26064584plk.37.1621871883823;
        Mon, 24 May 2021 08:58:03 -0700 (PDT)
Received: from localhost.localdomain ([139.167.209.203])
        by smtp.gmail.com with ESMTPSA id w26sm11746135pgl.50.2021.05.24.08.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 08:58:03 -0700 (PDT)
From:   Aviral Gupta <shiv14112001@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com, axboe@kernel.dk,
        beanhuo@micron.com, satyat@google.com, avri.altman@wdc.com,
        richard.peng@oppo.com, guoqing.jiang@cloud.ionos.com
Cc:     Aviral Gupta <shiv14112001@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] This patch fixes the warning generated due to use of symbolic
Date:   Mon, 24 May 2021 21:27:06 +0530
Message-Id: <20210524155705.5138-1-shiv14112001@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's better to use octal permissons instead of symbolic ones because  peoples are more
familiar with octal permissons.
WARNING: Symbolic permissions 'S_IRUGO | S_IWUSR' are not preferred. Consider using octal permissions '0644'.
+	md->force_ro.attr.mode = S_IRUGO | S_IWUSR;

WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.
+			mode = S_IRUGO;

WARNING: Symbolic permissions 'S_IRUGO | S_IWUSR' are not preferred. Consider using octal permissions '0644'.
+			mode = S_IRUGO | S_IWUSR;

WARNING: Symbolic permissions 'S_IRUSR' are not preferred. Consider using octal permissions '0400'.
+			debugfs_create_file("ext_csd", S_IRUSR, root, card,

Signed-off-by: Aviral Gupta <shiv14112001@gmail.com>
---
 drivers/mmc/core/block.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 266d62f9dbc8..1b5b0ad41b28 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -2693,7 +2693,7 @@ static int mmc_add_disk(struct mmc_blk_data *md)
 	md->force_ro.store = force_ro_store;
 	sysfs_attr_init(&md->force_ro.attr);
 	md->force_ro.attr.name = "force_ro";
-	md->force_ro.attr.mode = S_IRUGO | S_IWUSR;
+	md->force_ro.attr.mode = 0644;
 	ret = device_create_file(disk_to_dev(md->disk), &md->force_ro);
 	if (ret)
 		goto force_ro_fail;
@@ -2703,9 +2703,9 @@ static int mmc_add_disk(struct mmc_blk_data *md)
 		umode_t mode;
 
 		if (card->ext_csd.boot_ro_lock & EXT_CSD_BOOT_WP_B_PWR_WP_DIS)
-			mode = S_IRUGO;
+			mode = 0444;
 		else
-			mode = S_IRUGO | S_IWUSR;
+			mode = 0644;
 
 		md->power_ro_lock.show = power_ro_lock_show;
 		md->power_ro_lock.store = power_ro_lock_store;
@@ -2851,7 +2851,7 @@ static int mmc_blk_add_debugfs(struct mmc_card *card, struct mmc_blk_data *md)
 
 	if (mmc_card_mmc(card)) {
 		md->ext_csd_dentry =
-			debugfs_create_file("ext_csd", S_IRUSR, root, card,
+			debugfs_create_file("ext_csd", 0400, root, card,
 					    &mmc_dbg_ext_csd_fops);
 		if (!md->ext_csd_dentry)
 			return -EIO;
-- 
2.25.1

