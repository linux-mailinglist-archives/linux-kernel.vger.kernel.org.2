Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 162F531AD39
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 17:48:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbhBMQr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Feb 2021 11:47:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbhBMQrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Feb 2021 11:47:42 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2CFC061786
        for <linux-kernel@vger.kernel.org>; Sat, 13 Feb 2021 08:47:02 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id z15so1559903pfc.3
        for <linux-kernel@vger.kernel.org>; Sat, 13 Feb 2021 08:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wbOaWE3/W5QAfhUbixoIolMUbq3ZGWOO1rC6q+utlJ4=;
        b=USH7zZ22TdOpZU+R2nYwU8DQ0zcE11vwvqyUhvXFiB/LhYX4hQAzZkkkYQ3mpX3e7b
         8Pg2lISkMJUnWliVap4ny5kNNrRpZPyCbx8zWIdcnyWiWIPZG0yaH33yxmx41zLqpZUr
         ma93VuXvZ9E/+nDE0VTLeWHGROKUQXWbVtFsIM95KV1OODfBUrxBTXQ+NdHJVhBDqfZp
         EEppwrZZnYZyhQ2CcT8XMJGIS3OwWGG5Qs+3XOikxhjQBna8KX64gM7yHAakNHuuCnFZ
         HxpdJav9q9z7QW4eI7qxRpJVTwAsvFqMVoEC1Ih308Ve/9+LqpsUCUnaBSXzZK5/2rvC
         H42Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wbOaWE3/W5QAfhUbixoIolMUbq3ZGWOO1rC6q+utlJ4=;
        b=sWVaRwWudPoa+Npc/tXVMpvIDpkzXZLqhTkaltg+X6frJXSPMdz9C61SmY+1iF8OEK
         BmI4gFtU1x5oD7N7BvQhFw6LLkoFi3KcL/fCSGI6utXzqfNsAdbsF4gLppDVFP3IRIWL
         xa5muB51/dACX9uXuTWckqqq1j4kJ6sd5rLnSLMF7pMQ6MHT8WiRePruleIy6LuJ/A6A
         ZB+ra+PngW1LfTjs+nzLjGFItpyT4zwD28XePU4BJOa8PF9V5O5o9E0zUQGg1OqUf92q
         gKa/oAVLy7xokspRVF1LG6dDd1p8TKBfGAJKiZJDXGBU8bxBNbUXFqHfKFRdwbQZ5orT
         NQQg==
X-Gm-Message-State: AOAM532uAJ5vSC6LDDd9k9QPezQV1pTLZLKVB3dFbpR4DFUToV5HaYUW
        H6GqAi1ynqflpthUnQz2EfjvSKu7c+rkWw==
X-Google-Smtp-Source: ABdhPJxpKYS868siiNRtZD+2OSRs9zy+vudS7dqGQu+4t5Tyhl18+dEaQB4IKirR8ryk3CYBixYSwg==
X-Received: by 2002:a63:d304:: with SMTP id b4mr8123851pgg.299.1613234822070;
        Sat, 13 Feb 2021 08:47:02 -0800 (PST)
Received: from localhost (185.212.56.4.16clouds.com. [185.212.56.4])
        by smtp.gmail.com with ESMTPSA id g15sm12508194pfb.30.2021.02.13.08.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Feb 2021 08:47:01 -0800 (PST)
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        nixiaoming@huawei.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dejin Zheng <zhengdejin5@gmail.com>
Subject: [PATCH mtd/next 4/8] mtd: mtdblock: Use module_mtd_blktrans to register driver
Date:   Sun, 14 Feb 2021 00:45:56 +0800
Message-Id: <20210213164600.409061-5-zhengdejin5@gmail.com>
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
 drivers/mtd/mtdblock.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/mtd/mtdblock.c b/drivers/mtd/mtdblock.c
index 32e52d83b961..a80809543793 100644
--- a/drivers/mtd/mtdblock.c
+++ b/drivers/mtd/mtdblock.c
@@ -346,19 +346,7 @@ static struct mtd_blktrans_ops mtdblock_tr = {
 	.owner		= THIS_MODULE,
 };
 
-static int __init init_mtdblock(void)
-{
-	return register_mtd_blktrans(&mtdblock_tr);
-}
-
-static void __exit cleanup_mtdblock(void)
-{
-	deregister_mtd_blktrans(&mtdblock_tr);
-}
-
-module_init(init_mtdblock);
-module_exit(cleanup_mtdblock);
-
+module_mtd_blktrans(mtdblock_tr);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Nicolas Pitre <nico@fluxnic.net> et al.");
-- 
2.25.0

