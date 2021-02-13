Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74E7231AD3C
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 17:48:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbhBMQsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Feb 2021 11:48:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbhBMQrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Feb 2021 11:47:47 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80BE3C061788
        for <linux-kernel@vger.kernel.org>; Sat, 13 Feb 2021 08:47:07 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id z21so1693074pgj.4
        for <linux-kernel@vger.kernel.org>; Sat, 13 Feb 2021 08:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hd0XeNcDl34Bc3bSJsO4EUPKljKLsAj3/6PQiNsgU6E=;
        b=p9HYM9P0+l3KL3Iy6Ya7fPNHzAfYI1cc22dSsIUoszUtQP984ZBMaCzFgB8my8CpqK
         0HDzjsKw2x/j/4BurkPP3F+ICE0RtblzncPim57aaD2rA3si3ahrAqDnguLJE9IeCmSS
         gYl/gdxDqc24OUjlF1gCHifSJmVbBDdQJTES7Celv3V0sF9XCkJeICFHkmqzKXgs/4H+
         Gpn/WDfOIo1SWoINIO/p/W7p3td6+aH1P5KEd2TaRIW0VT26hW17lG8F2ST6kXKAwwgd
         T7IIOjXBsUd2k1B3qYSnlD6mFg4HMwqZkS/rZkikKRQi6i5q7ZyjYkjPct0rg3rt2zGy
         wMDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hd0XeNcDl34Bc3bSJsO4EUPKljKLsAj3/6PQiNsgU6E=;
        b=CVtvoUR/olc9U8AQ3zsoxH3+dHUKsNMNLrNhgGyL7Cyb4HYUljo7cJ2FHibIBhixZT
         Fij0hxG9bpMjCxnGeowFUQrrUWe0hcXSSQHdYlAOITsPNbmq8oNOWikl16JnGlS3yIpt
         xFeH/lpgrgqojvU2ExhD/nOmYZ23UvDQTupcZVryj3pfdT3ZXBMKfqBgdgaFFnegofx2
         eLGPkeAf668bWKG43FBhoX/nR+vUdasVgiaeuSo2TBdym9M9bJOeAr1CQjjfspayX9ah
         TKl0rKXbaVAADLuHdUzNMpwEd/Ko/3kviQ50WTzTrAK8bp/3NFQFswv9xoCWWrWCktZ6
         GMXg==
X-Gm-Message-State: AOAM531/YewXMkIXhEDrBOnAGOVuG+k+yVdFkbdQ9I4qeUir/5v15BYf
        ZZW5WnMzP/IdIbwtE6DFAuE=
X-Google-Smtp-Source: ABdhPJx/juqQWWNmEy194K6ggF8hqEloAQt1XRk/1ChVGfjBVKZNgG2nkPowP7oXney+1gc9y4uFZw==
X-Received: by 2002:a63:555b:: with SMTP id f27mr7996694pgm.365.1613234827142;
        Sat, 13 Feb 2021 08:47:07 -0800 (PST)
Received: from localhost (185.212.56.4.16clouds.com. [185.212.56.4])
        by smtp.gmail.com with ESMTPSA id 137sm6890590pgb.80.2021.02.13.08.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Feb 2021 08:47:06 -0800 (PST)
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        nixiaoming@huawei.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dejin Zheng <zhengdejin5@gmail.com>
Subject: [PATCH mtd/next 5/8] mtd: mtdblock_ro: Use module_mtd_blktrans to register driver
Date:   Sun, 14 Feb 2021 00:45:57 +0800
Message-Id: <20210213164600.409061-6-zhengdejin5@gmail.com>
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
 drivers/mtd/mtdblock_ro.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/mtd/mtdblock_ro.c b/drivers/mtd/mtdblock_ro.c
index 7fcf29ef2bdc..d92914f73d52 100644
--- a/drivers/mtd/mtdblock_ro.c
+++ b/drivers/mtd/mtdblock_ro.c
@@ -67,18 +67,7 @@ static struct mtd_blktrans_ops mtdblock_tr = {
 	.owner		= THIS_MODULE,
 };
 
-static int __init mtdblock_init(void)
-{
-	return register_mtd_blktrans(&mtdblock_tr);
-}
-
-static void __exit mtdblock_exit(void)
-{
-	deregister_mtd_blktrans(&mtdblock_tr);
-}
-
-module_init(mtdblock_init);
-module_exit(mtdblock_exit);
+module_mtd_blktrans(mtdblock_tr);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("David Woodhouse <dwmw2@infradead.org>");
-- 
2.25.0

