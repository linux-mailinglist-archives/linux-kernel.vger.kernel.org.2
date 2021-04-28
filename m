Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90FEE36D4BE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 11:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238090AbhD1J1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 05:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbhD1J1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 05:27:33 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC92CC061574
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 02:26:48 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id s22so23192564pgk.6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 02:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=HdBXAeW9ho79sbyDSekS4yet6htvB8OKbQECD3STw9g=;
        b=jkVromoQu4MIvHxNxzjt6BTZYcg0ej3QJP/jMLiFq/+9P/og+Sn79uD7ulFAtyomLD
         w3z7Q1HFewI7wwA5EfDyFfwimsz3zYurtxJnPh8DKTIsFSiDVcJFvvFzTCyoi/FH5eVN
         oqwTTOsyTFT4aW8h/IC55BnG9baY2wkJEeqba78+DIJNuqnUssSESVMsCsfs6HEOXBYS
         DRa+labNc5d194sLzRhzpY5+CA4OxHomBRunlNv/jiETZNyNvHrJIvF9J4d/upFNZ6nN
         dOfie9wM3aY2QYMj23dhe4vHVI372C3k2+rqGIioQilSiHeyUfoqKFYQQAS2x+YvK2+7
         J2kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=HdBXAeW9ho79sbyDSekS4yet6htvB8OKbQECD3STw9g=;
        b=MzCFdmMHfGRbzO2ZU519V2hY4hsPUnPQIz0QbU30zDaqLHiu04IDOsgs75sSksEfgp
         P8iUeoHREPMEoM1kXh9Qvl3qMlnURnmJWegx94lWlVU6W+pAQkUVjg+1/m/TK3N2wMJ0
         6hudApEptBDOTahXzw5ZSYN8hfaOzNjsh2oB+aFYTKmvuHe4fOYj+RPaziSlsdaCO/jj
         tuQkNU1sgjP/YfyPcwgd4UFN0WvpLZKVH3lvVltZOtPx9h+BrfJyHTZmNzrRPxXoM/5K
         p0nHPKYT/+PvwOTWllvU7YqFeE8kdngqrfYaW48P1kxMxK9/memWlcnzfgRnddyirn2u
         2GHg==
X-Gm-Message-State: AOAM5310Eqi6nWQkCYxsYuM5+/5B7MjyVlcewF1rr0lm8dvjO6krF6lZ
        PNg7EuKXg4Ix/LoCrQKYElE=
X-Google-Smtp-Source: ABdhPJw7I0R9nrycMGShtYmIay08lbgPBXI0Aahfaxd0Pcm0k6t0qup20D1I2bQR2lT7PjLsEH1RGw==
X-Received: by 2002:a65:48c5:: with SMTP id o5mr25873562pgs.101.1619602008433;
        Wed, 28 Apr 2021 02:26:48 -0700 (PDT)
Received: from localhost ([115.99.221.24])
        by smtp.gmail.com with ESMTPSA id c26sm4686373pfo.67.2021.04.28.02.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 02:26:48 -0700 (PDT)
Date:   Wed, 28 Apr 2021 14:56:43 +0530
From:   Sanjana Srinidhi <sanjanasrinidhi1810@gmail.com>
To:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com
Cc:     linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Add blank line after declarations
Message-ID: <20210428092643.y2z2bezd2evu5kak@sanjana-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Blank line is added after declarations to maintain code uniformity.

Signed-off-by: Sanjana Srinidhi <sanjanasrinidhi1810@gmail.com>
---
 drivers/dax/super.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index 5fa6ae9dbc8b..1f7cd75e379f 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -477,6 +477,7 @@ static struct dax_device *to_dax_dev(struct inode *inode)
 static void dax_free_inode(struct inode *inode)
 {
 	struct dax_device *dax_dev = to_dax_dev(inode);
+
 	kfree(dax_dev->host);
 	dax_dev->host = NULL;
 	if (inode->i_rdev)
@@ -487,6 +488,7 @@ static void dax_free_inode(struct inode *inode)
 static void dax_destroy_inode(struct inode *inode)
 {
 	struct dax_device *dax_dev = to_dax_dev(inode);
+
 	WARN_ONCE(test_bit(DAXDEV_ALIVE, &dax_dev->flags),
 			"kill_dax() must be called before final iput()\n");
 }
@@ -502,6 +504,7 @@ static const struct super_operations dax_sops = {
 static int dax_init_fs_context(struct fs_context *fc)
 {
 	struct pseudo_fs_context *ctx = init_pseudo(fc, DAXFS_MAGIC);
+
 	if (!ctx)
 		return -ENOMEM;
 	ctx->ops = &dax_sops;
-- 
2.25.1

