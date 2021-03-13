Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7898A339DB0
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 11:57:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233248AbhCMK5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 05:57:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232331AbhCMK5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 05:57:08 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC173C061574
        for <linux-kernel@vger.kernel.org>; Sat, 13 Mar 2021 02:57:08 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id a22-20020a17090aa516b02900c1215e9b33so11972879pjq.5
        for <linux-kernel@vger.kernel.org>; Sat, 13 Mar 2021 02:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cf9U3m1rqRNi6855v4YFmZ3jb95Xgz7XQOcp+CqCqzI=;
        b=PUBjwR+0S5+7JzmlOfitCR38CohYfi5iywij2LBgk70A89ukEjJ5soKdlNjPuICW37
         ed1QOHRmG7hkhGDE2KygH2X7CWb4axAEomQhroiKKcFXOPD/e8afcllVfptZW5gZSk8b
         r1bwk9Win8shHKGJqsujWTMp6j+pFOTQ3/JzGMehHAPoC52SgHXLpPrw9TGeUw2+MNSn
         08lojiu5ym0CiHDBt6qeF5p5R/OBlh+m/ZMawmrJ5PT+fKig5f9fjnbPrYXitB1I26io
         E6m8HeRN4ctb2QbfX4F8ljO0txhUDqVfA0/Vw4UOuUTPusSy8nru8JUsz4UPQA98K7/r
         abNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cf9U3m1rqRNi6855v4YFmZ3jb95Xgz7XQOcp+CqCqzI=;
        b=uH8E+G2of23Z/h1qQvh1bk0UE32mJ4O1n0aXPrE5JlFP8aIrkyf1zBc5lvqenK+bpO
         7SMlHvXKveBD2NKr7u1xgQ3kuGiOH0WZ2/8JvdYBlVbN1A6WshvF50sXimc2EjvMrXaM
         25pn4dbYC3vZNbTNuPAE5/JTYIxSrBldHUvvWtaQwq9pHpAA9F+KmW5te9YobUHpCL6j
         qYHlwXMfYmafYQZenKjonkFnzHt9C0t93eMkJBpHhMlRE0IgSFSlbQPg9lByQtxa9ufP
         EauoVdpXyQVRpU8/LmK2BJMlbwZKMgE/4gxTkh35wU7OlnwEWvuNEQXDexmUZYeERFqB
         8xag==
X-Gm-Message-State: AOAM530SZqCKHA4qembpiKqcum4NSFJumUSyDRQprvQdrJkwcFJP2jDf
        ZnpYgoI18lCAuvSXxvuIQm0=
X-Google-Smtp-Source: ABdhPJwcvz1+dydUk1MLSZdM0GRFX+5VYzAwczyiV5Bjy/ejIA99Y1McMmtVppFyxy0/6zC76WkpTA==
X-Received: by 2002:a17:90a:c087:: with SMTP id o7mr3132095pjs.38.1615633028309;
        Sat, 13 Mar 2021 02:57:08 -0800 (PST)
Received: from localhost.localdomain ([178.236.46.205])
        by smtp.gmail.com with ESMTPSA id iq6sm4929497pjb.31.2021.03.13.02.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Mar 2021 02:57:07 -0800 (PST)
From:   menglong8.dong@gmail.com
X-Google-Original-From: zhang.yunkai@zte.com.cn
To:     miquel.raynal@bootlin.com
Cc:     richard@nod.at, vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Zhang Yunkai <zhang.yunkai@zte.com.cn>
Subject: [PATCH] mtd:rawnand: remove duplicate include in rawnand.h
Date:   Sat, 13 Mar 2021 02:57:02 -0800
Message-Id: <20210313105702.365878-1-zhang.yunkai@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Yunkai <zhang.yunkai@zte.com.cn>

'linux/mtd/nand.h' included in 'rawnand.h' is duplicated.
It is also included in the 17th line.

Signed-off-by: Zhang Yunkai <zhang.yunkai@zte.com.cn>
---
 include/linux/mtd/rawnand.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index 6b3240e44310..93e8f72beba6 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -18,7 +18,6 @@
 #include <linux/mtd/flashchip.h>
 #include <linux/mtd/bbm.h>
 #include <linux/mtd/jedec.h>
-#include <linux/mtd/nand.h>
 #include <linux/mtd/onfi.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
-- 
2.25.1

