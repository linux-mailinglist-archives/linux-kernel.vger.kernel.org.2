Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28B6E31AD37
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 17:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbhBMQrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Feb 2021 11:47:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbhBMQra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Feb 2021 11:47:30 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283E2C061756
        for <linux-kernel@vger.kernel.org>; Sat, 13 Feb 2021 08:46:50 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id o38so1674866pgm.9
        for <linux-kernel@vger.kernel.org>; Sat, 13 Feb 2021 08:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R7Pvgb3akR3Oq4fua7s4G8xA2ZE29AxfWMgMKg+V6GQ=;
        b=ZGN8haYxxgwvXkuOWjI8pHScUM7pnodbWPESjdZ5MhNOHbXT2kBpH3YQLdzGtqXJcJ
         eEbg0iFQa3toEhPD33NKIFkZtK5IA4rnnhH/SUslhYJAFpNWlu6puvRKH28iWLN6HLxT
         9OcH63HsANP8GuZJxk52x0PcS1kIa/ra2zB92OIH2w8VTyEX2eyLweJPS49P/hMSRyP/
         37BVlXQFTInv2bu1HWrV/mvBOGRk1iYoTl/TdcnV/IOQSsMkSfZB41o+4IzF7po6+58e
         73XFnlgMNTGesyVZnm5kPVA+ZjCffRjvVvbqjnefcNmvgmYq31WuZ5RssPTUoo0xfBpp
         hEsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R7Pvgb3akR3Oq4fua7s4G8xA2ZE29AxfWMgMKg+V6GQ=;
        b=WSjkX6OJ0XpzqyY7PHpIuxrhgd6nGIrEdsTsJJjtVriSMlmaaEhLY+xz0CllwV3kjY
         ot8Lhv4SIRVsrTdK2uCL31elJIZ0T/Cv1KlFBsc6mNw0a5k65t9fQKgqrfmpsJnWK8bR
         GnPU39dccK9kK0fK1qANRyV5eMuJS3DuWUa7p+y9Mf16bFVHw3g0EyEb2jcw6IfIjqSe
         5BKWzfG2LBlB7MrRQB401Gfvy20j8LbgLwDikutDzCPy1UaW6FqF2OdccORoqrZ6O6Tb
         o/T4m4mG2OPpXVtAREBkpqNMdwWy+GbLGQj1HNGkDSPyc27d6WSI32AqfbQEolB3aGjJ
         Wi3Q==
X-Gm-Message-State: AOAM5311orWi+OSQ+iRuVIRc2n8JWS9RgZ4GqMoNOA+INx0ZvKWHzROj
        GjxCVaA6MyojUOCCge+IJ48=
X-Google-Smtp-Source: ABdhPJzKq+D3FGV/FEbvngLXiMiR9yRKLox0BW9HT3xzNMV4L2F6UdYgyRqi3Jq/hit+diSLceldsg==
X-Received: by 2002:a65:60d1:: with SMTP id r17mr8228072pgv.210.1613234809820;
        Sat, 13 Feb 2021 08:46:49 -0800 (PST)
Received: from localhost (185.212.56.4.16clouds.com. [185.212.56.4])
        by smtp.gmail.com with ESMTPSA id y2sm11309320pjw.36.2021.02.13.08.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Feb 2021 08:46:49 -0800 (PST)
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        nixiaoming@huawei.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dejin Zheng <zhengdejin5@gmail.com>
Subject: [PATCH mtd/next 2/8] mtd: ftl: Use module_mtd_blktrans to register driver
Date:   Sun, 14 Feb 2021 00:45:54 +0800
Message-Id: <20210213164600.409061-3-zhengdejin5@gmail.com>
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
 drivers/mtd/ftl.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/mtd/ftl.c b/drivers/mtd/ftl.c
index 2578f27914ef..9b33c082179d 100644
--- a/drivers/mtd/ftl.c
+++ b/drivers/mtd/ftl.c
@@ -1056,19 +1056,7 @@ static struct mtd_blktrans_ops ftl_tr = {
 	.owner		= THIS_MODULE,
 };
 
-static int __init init_ftl(void)
-{
-	return register_mtd_blktrans(&ftl_tr);
-}
-
-static void __exit cleanup_ftl(void)
-{
-	deregister_mtd_blktrans(&ftl_tr);
-}
-
-module_init(init_ftl);
-module_exit(cleanup_ftl);
-
+module_mtd_blktrans(ftl_tr);
 
 MODULE_LICENSE("Dual MPL/GPL");
 MODULE_AUTHOR("David Hinds <dahinds@users.sourceforge.net>");
-- 
2.25.0

