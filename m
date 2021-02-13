Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6297C31AD3F
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 17:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbhBMQsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Feb 2021 11:48:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbhBMQsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Feb 2021 11:48:11 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DEEC06178B
        for <linux-kernel@vger.kernel.org>; Sat, 13 Feb 2021 08:47:25 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id a4so101831pgc.11
        for <linux-kernel@vger.kernel.org>; Sat, 13 Feb 2021 08:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LuFN5JlbvcMUz61kHz7biAIAIk4OfNdAOsuO5R8F53k=;
        b=JTx47GelbxDf0iIvPQxbGaHqhr0PHAszv7IYTP5WuXTAk4OwNcD0PeY9N1TjuivKuC
         NfS6gDyVMnPiXLAkeUbfn4QpCVp+NiclipStojb/O15Z6oJfVhq+7QH94TXEH9kIvEWu
         ykTZtm+82bA2qIFY4x+EVEa+TIDuOVj2csqPT40R0sPi5kvTyK3+u0EwLVHHtq5V1MBE
         z6ZgRDDzniV21Xa3f04QTtfCi6hRoI55MX3wadZtm8mbxCoEykCLyYn+P7EKfyxvU41R
         aKMtsRPMFyrXr3jRttrErGBCR5/oEslVhFL4BEOIFRAiGHZ2cMM2e/cCeafrSAXmvOwY
         arXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LuFN5JlbvcMUz61kHz7biAIAIk4OfNdAOsuO5R8F53k=;
        b=i89YCsYbds3hS7cnOEk5xxSnf5EV+oY6coQthb56BuS7xnQlwgOPYUg7VvpVOjIq4x
         os2ztInlCtRXgzNDUVmeBN7ouVj51bAZaSKRdSn0l1+64qHJilHxpSPlB8BX2xaXQjNg
         hlIos9pVOi0bYYHl6BGYluKxVUE1R++jVM/ICnqiIorKes7Q0x3w4R335CeePFlm8htS
         714Vhn+xYR5JTf4ZDfQ2oxF+GQ0pg9d+5q/a8k5f9UO5uWqqI/L7zC/c1cnZj3PI0GDK
         i+F/AVnfPC60kfLUD1oBbmIJKVI1F761Vq2z+iGtx6kkbmX7FYZOzrZuanuaKgWZRV22
         7abg==
X-Gm-Message-State: AOAM530VxlZhvFXOLsMVHUi7RwwQK96knGG1YJBb9JlxifIErzYaoVda
        wC5+j7iEQdvJ2ulb2cEpsPk=
X-Google-Smtp-Source: ABdhPJxVsDyiEdMOsS/Msc4pi5ji7V60PGvB+WDlJVuAGPG7VUKQAVdXasVZcMD9FagvbnYrXMBjPg==
X-Received: by 2002:a63:df11:: with SMTP id u17mr7986404pgg.345.1613234845112;
        Sat, 13 Feb 2021 08:47:25 -0800 (PST)
Received: from localhost (185.212.56.4.16clouds.com. [185.212.56.4])
        by smtp.gmail.com with ESMTPSA id m4sm12478650pgu.4.2021.02.13.08.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Feb 2021 08:47:24 -0800 (PST)
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        nixiaoming@huawei.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dejin Zheng <zhengdejin5@gmail.com>
Subject: [PATCH mtd/next 7/8] mtd: nftlcore: Use module_mtd_blktrans to register driver
Date:   Sun, 14 Feb 2021 00:45:59 +0800
Message-Id: <20210213164600.409061-8-zhengdejin5@gmail.com>
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
 drivers/mtd/nftlcore.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/mtd/nftlcore.c b/drivers/mtd/nftlcore.c
index d44641129cdb..bcd0094f172d 100644
--- a/drivers/mtd/nftlcore.c
+++ b/drivers/mtd/nftlcore.c
@@ -797,18 +797,7 @@ static struct mtd_blktrans_ops nftl_tr = {
 	.owner		= THIS_MODULE,
 };
 
-static int __init init_nftl(void)
-{
-	return register_mtd_blktrans(&nftl_tr);
-}
-
-static void __exit cleanup_nftl(void)
-{
-	deregister_mtd_blktrans(&nftl_tr);
-}
-
-module_init(init_nftl);
-module_exit(cleanup_nftl);
+module_mtd_blktrans(nftl_tr);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("David Woodhouse <dwmw2@infradead.org>, Fabrice Bellard <fabrice.bellard@netgem.com> et al.");
-- 
2.25.0

