Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D39F631AD40
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 17:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbhBMQtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Feb 2021 11:49:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbhBMQsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Feb 2021 11:48:12 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C615C06178C
        for <linux-kernel@vger.kernel.org>; Sat, 13 Feb 2021 08:47:30 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id o38so1675511pgm.9
        for <linux-kernel@vger.kernel.org>; Sat, 13 Feb 2021 08:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e7rP+FiAvuVb6aK9LL07jkn9OaioHOHo8nBGBg3+txw=;
        b=mNFhmTwyUc2LCO/jLz4SaMP2Lj2ABopQxgAwfIrVpDr7ndHmpqbupyk0y8Ahz83e0k
         hwisM0BEE8oUXameZ/D6f+ktGAxGtk8UCggPTECgGPwNwbTVkytI10+IKvsjKYickdQF
         /dp3ye20oHb6uI1XUKthUDCVLf5+V6iXpSJKx3UfqWfREShgMgqUyt1w8nTMNi98ckFT
         ny25Vk5XZ0EZV53H3CrmEJ0syxtGg8dcl/lBNe57qFvEInN+XoxjyPOwP6gSb9SLTKET
         DU0Egd1hHuetj2drWItSaNkLoUj+aVI+OZ921ZxcOUHMIBVtLFNu27T11ZypD8KBSqgi
         IpOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e7rP+FiAvuVb6aK9LL07jkn9OaioHOHo8nBGBg3+txw=;
        b=ulTYmhhh/j06gcx3BPMjZdqpSeyyfByTVZR8ni46O3cyqc/f0Ke8fY+Ul/tcLSunyx
         FQzPXnGggOEv2y+ofML6wXx7iVK2YaUfNKrq7T7iTuSyVmw4/d+Zlj9wqkq7F2SAoTWz
         ZNJ4o1jU4GcKeXWH0IOVvsB28wW/NderQAtu6tlW9WJNptN106jbekJJAyE+6bC+xivq
         Z38I8/O9jz98WzcbPPnpFYKIPd5nPq85bSc9p4ciFPK8PSFejYknuMQ7TZnehvdZpwyA
         5zHfTi9p4GR12aLd+baBDwDBP3X0GN3TJ4mg1CMJy7/eGwbf6H3Z3HdWynb3yeqjxOL8
         8ceg==
X-Gm-Message-State: AOAM531Phb28+GV767DNkx8KCvLiT9v8fmexutLbmJjLL97iGbuOW/+0
        J6DRDNdHCEa24DqMwAkk5EE=
X-Google-Smtp-Source: ABdhPJys5U/r0NwIzKRqe04a4gYr7Upl62J62lKvLdFaYPu5ekQOAMLBTpazgZp0tykehiIzuaWKIQ==
X-Received: by 2002:a62:6382:0:b029:1d2:46ed:d813 with SMTP id x124-20020a6263820000b02901d246edd813mr7819089pfb.44.1613234849948;
        Sat, 13 Feb 2021 08:47:29 -0800 (PST)
Received: from localhost (185.212.56.4.16clouds.com. [185.212.56.4])
        by smtp.gmail.com with ESMTPSA id 9sm12484844pfw.48.2021.02.13.08.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Feb 2021 08:47:29 -0800 (PST)
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        nixiaoming@huawei.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dejin Zheng <zhengdejin5@gmail.com>
Subject: [PATCH mtd/next 8/8] mtd: rfd_ftl: Use module_mtd_blktrans to register driver
Date:   Sun, 14 Feb 2021 00:46:00 +0800
Message-Id: <20210213164600.409061-9-zhengdejin5@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20210213164600.409061-1-zhengdejin5@gmail.com>
References: <20210213164600.409061-1-zhengdejin5@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removing some boilerplate by using module_mtd_blktrans instead of calling
register and unregister in the otherwise empty init/exit functions.

Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
---
 drivers/mtd/rfd_ftl.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/mtd/rfd_ftl.c b/drivers/mtd/rfd_ftl.c
index 3d1df82fa105..cce3bf6f99b4 100644
--- a/drivers/mtd/rfd_ftl.c
+++ b/drivers/mtd/rfd_ftl.c
@@ -794,18 +794,7 @@ static struct mtd_blktrans_ops rfd_ftl_tr = {
 	.owner		= THIS_MODULE,
 };
 
-static int __init init_rfd_ftl(void)
-{
-	return register_mtd_blktrans(&rfd_ftl_tr);
-}
-
-static void __exit cleanup_rfd_ftl(void)
-{
-	deregister_mtd_blktrans(&rfd_ftl_tr);
-}
-
-module_init(init_rfd_ftl);
-module_exit(cleanup_rfd_ftl);
+module_mtd_blktrans(rfd_ftl_tr);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Sean Young <sean@mess.org>");
-- 
2.25.0

