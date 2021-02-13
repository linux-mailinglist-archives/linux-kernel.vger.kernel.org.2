Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9991D31AD38
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 17:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbhBMQru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Feb 2021 11:47:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbhBMQrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Feb 2021 11:47:35 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C0EC0613D6
        for <linux-kernel@vger.kernel.org>; Sat, 13 Feb 2021 08:46:54 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id z15so1559769pfc.3
        for <linux-kernel@vger.kernel.org>; Sat, 13 Feb 2021 08:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BfmzqMjdUtEQ0m0SGfMEZGmDtfwGnZKPpB8xw0rX8N4=;
        b=vYZJYp7+EwWHOWg5oVcaALOO2pm6+Im7QYneBYejiC6LkA1X1G+tRmP1PjeRD44E2p
         wXQlwEgfGZEB4WZemo4eN4mXemBIzJREal4zteg9j8W3LDCTOld/jBhwHTYYcOI4GZll
         UuBv25MoV5JvUnV1prVMko+4EmoV6OZCnpD+4ouawv23aWuR7EGpc5iypwVvLuYLrIZu
         RkwGXZjLcg/EswAbHNQt5E51pxvAqxw2u3UKaJOt0jcyenxbz1tDBz9FYlnO+qpHAdwH
         XwSCyjy13Q1w/sp/iX96pvqGdaxhRHz8eyZ6noAzxoJyExIGQCHEzreUxTY9+uizGDi/
         rsHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BfmzqMjdUtEQ0m0SGfMEZGmDtfwGnZKPpB8xw0rX8N4=;
        b=INtfOynCf3ZtBO7U/0ffCLLJCx8hGT2EzEQBC3SFcrr1f6o4kzFXqjs1si4jULVXzx
         d46/i+9KOZVHmq629JQRJnxhkMd7zyALau/SwwN9V4HTtj33+yaPyZUmvtQXUnsUfuuD
         w3c5zu9QVLYLsa2JjCEJY1/AjDWhSELpEpZkB8lQ46BubkMXrL8IXUtduYD0rB0OySxc
         LaDssg9gdtUYjpg1CVI2kiqrXZYP2nB37CG110d9M8Qfu67DQmrs7gyHwWR71pydKjbY
         Ga28nJm1TsgZ5S0B022WoIGNtU2sY+xB8b3eOAuZzEBppCAucby3ivGYsGENdCwlu+F5
         vlRQ==
X-Gm-Message-State: AOAM533wmRXM9CwN4WBAgQ+e5LwZGtw0J/hHxLhCHTVfTexntFVNRLZ3
        FDd12RGuvlanScWHaOJqYD0=
X-Google-Smtp-Source: ABdhPJyPHW0mtP9lwfKRcZBcDtyrmJTBOmtEMDzI14i1bvOzj9cEDBvIED0rKdKG138JH0jRMNVjaw==
X-Received: by 2002:a62:8cd7:0:b029:1d9:447c:e21a with SMTP id m206-20020a628cd70000b02901d9447ce21amr8181346pfd.2.1613234814511;
        Sat, 13 Feb 2021 08:46:54 -0800 (PST)
Received: from localhost (185.212.56.4.16clouds.com. [185.212.56.4])
        by smtp.gmail.com with ESMTPSA id 25sm12814475pfh.199.2021.02.13.08.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Feb 2021 08:46:54 -0800 (PST)
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        nixiaoming@huawei.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dejin Zheng <zhengdejin5@gmail.com>
Subject: [PATCH mtd/next 3/8] mtd: inftlcore: Use module_mtd_blktrans to register driver
Date:   Sun, 14 Feb 2021 00:45:55 +0800
Message-Id: <20210213164600.409061-4-zhengdejin5@gmail.com>
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
 drivers/mtd/inftlcore.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/mtd/inftlcore.c b/drivers/mtd/inftlcore.c
index a0d6c00e7b85..6b48397c750c 100644
--- a/drivers/mtd/inftlcore.c
+++ b/drivers/mtd/inftlcore.c
@@ -937,18 +937,7 @@ static struct mtd_blktrans_ops inftl_tr = {
 	.owner		= THIS_MODULE,
 };
 
-static int __init init_inftl(void)
-{
-	return register_mtd_blktrans(&inftl_tr);
-}
-
-static void __exit cleanup_inftl(void)
-{
-	deregister_mtd_blktrans(&inftl_tr);
-}
-
-module_init(init_inftl);
-module_exit(cleanup_inftl);
+module_mtd_blktrans(inftl_tr);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Greg Ungerer <gerg@snapgear.com>, David Woodhouse <dwmw2@infradead.org>, Fabrice Bellard <fabrice.bellard@netgem.com> et al.");
-- 
2.25.0

