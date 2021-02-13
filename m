Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7CB231AD3E
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 17:48:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbhBMQsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Feb 2021 11:48:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbhBMQr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Feb 2021 11:47:57 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40512C06178A
        for <linux-kernel@vger.kernel.org>; Sat, 13 Feb 2021 08:47:17 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id a16so1434611plh.8
        for <linux-kernel@vger.kernel.org>; Sat, 13 Feb 2021 08:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i3UdIVSSuURDI57tdd0BCH+jV4GtgWbV5jFchWdmFUY=;
        b=l8ErE7wl4pOLqd/yR9n0JH/jrUbN0WFdooPPosXNLr4kOAEVFjlXwge/9IUlJ6bsT7
         lfq3LyH41GDI80QwF2atjbh3vYUGHQFp2G+eIAYsgMyJ8XORvRCB+eGlSps7/OaoLTaZ
         QCQbot6cCppQJD19DIeP9EpZvInbdINfWfbKwMJOqdl8ybBEg9NqPcpQaYVhTuJloyeX
         5QfQw5kuy0cDddzLzyiai31QxZs6t4GIrv5deoB9SItIq1AI1AIxhp7EVREjl7FHYm/4
         +h1Bt1DMWZem1mntQKaXJLSjxUoONLS1paHC8J43ql/XgkSMcdrlsYO+izIcMHD157bj
         mzKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i3UdIVSSuURDI57tdd0BCH+jV4GtgWbV5jFchWdmFUY=;
        b=AE8DXqGGUeVNBCcnqZ49Fq4vAEyM7v2XiKXGi2SlXo9rn9BHzKJPyUYtmcqpkUbdVK
         6DzFemm1U63DmFmoKe2xo1qAEUNT4i1pzB1hJcxNCA4tblBQt9Snr49B4Hz68ZgUG7AE
         QSip+yJPF1yZ+bIYzUCAmazv0orYAza4PyA+G31m+AhRWjkcSDil7a1IcMUGKj7KZUCy
         tTKBO1AAcwCFTgsdY2Jx5pN5J3bNBI6WreEQIh5uUerJoZfOep31r1C+vLut3oPd35qi
         1jLJVx59y6i6O5QK5LqFRiU6ig5bGAXhewXkiGSG0Nju8zyDWdbtOOQu+prxKodjlP7H
         BgGg==
X-Gm-Message-State: AOAM533NFoJ6Xum7/WpXQbjeTCTtzh9RgjgxKGtpThCtOZzDb1clh6HU
        WMZWgFQa9CfDmR6UHFWflnM=
X-Google-Smtp-Source: ABdhPJwaCSDXVDctDI9DD2i3tzfva2SfC/2na5lwwDGCjtlL1wCzvrHDiVlDkjy9Ehs9o4hM1Icvjw==
X-Received: by 2002:a17:902:8548:b029:e2:ecb5:3e4 with SMTP id d8-20020a1709028548b02900e2ecb503e4mr7446861plo.79.1613234836830;
        Sat, 13 Feb 2021 08:47:16 -0800 (PST)
Received: from localhost (185.212.56.4.16clouds.com. [185.212.56.4])
        by smtp.gmail.com with ESMTPSA id 68sm13132805pfg.90.2021.02.13.08.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Feb 2021 08:47:16 -0800 (PST)
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        nixiaoming@huawei.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dejin Zheng <zhengdejin5@gmail.com>
Subject: [PATCH mtd/next 6/8] mtd: mtdswap: Use module_mtd_blktrans to register driver
Date:   Sun, 14 Feb 2021 00:45:58 +0800
Message-Id: <20210213164600.409061-7-zhengdejin5@gmail.com>
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
 drivers/mtd/mtdswap.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/mtd/mtdswap.c b/drivers/mtd/mtdswap.c
index 795dec4483c2..7e309270ddd4 100644
--- a/drivers/mtd/mtdswap.c
+++ b/drivers/mtd/mtdswap.c
@@ -1484,19 +1484,7 @@ static struct mtd_blktrans_ops mtdswap_ops = {
 	.owner		= THIS_MODULE,
 };
 
-static int __init mtdswap_modinit(void)
-{
-	return register_mtd_blktrans(&mtdswap_ops);
-}
-
-static void __exit mtdswap_modexit(void)
-{
-	deregister_mtd_blktrans(&mtdswap_ops);
-}
-
-module_init(mtdswap_modinit);
-module_exit(mtdswap_modexit);
-
+module_mtd_blktrans(mtdswap_ops);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Jarkko Lavinen <jarkko.lavinen@nokia.com>");
-- 
2.25.0

