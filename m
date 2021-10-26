Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44AE143AE4B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 10:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232900AbhJZIsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 04:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbhJZIsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 04:48:45 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C407C061745
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 01:46:21 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id j10so11066074eds.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 01:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YOcpDB2bEq/LBIP5Nmj3ZGIJaD4nDPvU30poT+IIEsQ=;
        b=A0710KYREyF6Yy6YF5gJ7j4HIzjKGGzCoumAmJ+JDr/kQl8eIlFFhEzPsmoqNI4Bbg
         rhYoh3qsewi4Vxqz8Df43kLPtWsCl0IIWliWWxutH3U9H5BsHkkPHcEUyiKeHTX+Xov+
         RUHSovJHkY7R8gxSC8DKi/odx7YV8oF8oUFAuYBKAzvO+90M7zDBitWwhyQ9YUXlA3PX
         8w1uEj1TXHYDUUWpKb19YEkVPYRPsjvCRBmLccZi+tV2Fy7wSCl7Rf9LhIoZvyMNqdGh
         rtLsDwafb75zHmksQKJD4BGRJP4ZbmqXFBolDo9o23rPTFuCvMgxhcGV8LZwTFYGvXrt
         JzOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YOcpDB2bEq/LBIP5Nmj3ZGIJaD4nDPvU30poT+IIEsQ=;
        b=dB/kDt/Fry3/SSUaXtFNURWe8Ee7kUawQtXSHnztYZWxOhpi+PiakXb7aODj2OTcmC
         6Wamq9BA3Al40vuk6IFxVhliPohDioCPJWpW1/SvvrfKxjvXGnv5FQCrEivD7GV4NZPE
         LIXLn0TAi4MDmeJ3H72FpTdFgWMHtDQpg9MyWWxxKyJypZ1T3M0SJrZsYKmp5abcVYek
         IxqoWGYkGrfitljYiIo1dQY8a3Jl6Z4Mxv+kA7EYcUkGlwJCsI7QPQHaA7x0Z6YfiAk4
         OH46bONVYHnWarbKkwH7w/TId+DqiEd4VF/BAtgTliXfBqL5xxSS8KXud4paDm5TyIGs
         RUmg==
X-Gm-Message-State: AOAM533zM21abUnYwxmdlUH+AtwpyC4fGu6W32hQAld4FnGZVJ9o08uj
        qN6XindzncC3pRfu2gYTpDo=
X-Google-Smtp-Source: ABdhPJzDVlKz0SfOSoBJ3/crgkD3XyTHKUP29X1MLkwNOy0zQ++E3JJC28GqgOOxV74MNwWIld6qFg==
X-Received: by 2002:a17:907:a408:: with SMTP id sg8mr23906923ejc.106.1635237979038;
        Tue, 26 Oct 2021 01:46:19 -0700 (PDT)
Received: from md2k7s8c.ad001.siemens.net ([165.225.27.144])
        by smtp.gmail.com with ESMTPSA id r18sm5320226ejs.78.2021.10.26.01.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 01:46:18 -0700 (PDT)
From:   Andreas Oetken <ennoerlangen@gmail.com>
X-Google-Original-From: Andreas Oetken <andreas.oetken@siemens-energy.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andreas Oetken <andreas.oetken@siemens-energy.com>
Subject: [PATCH] drivers: mtd: Fixed breaking list in __mtd_del_partition.
Date:   Tue, 26 Oct 2021 10:46:07 +0200
Message-Id: <20211026084607.3473482-1-andreas.oetken@siemens-energy.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not the child partition should be removed from the partition list
but the partition itself. Otherwise the partition list gets broken
and any subsequent remove operations leads to a kernel panic.

Signed-off-by: Andreas Oetken <andreas.oetken@siemens-energy.com>
---
 drivers/mtd/mtdpart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/mtdpart.c b/drivers/mtd/mtdpart.c
index 95d47422bbf20..5725818fa199f 100644
--- a/drivers/mtd/mtdpart.c
+++ b/drivers/mtd/mtdpart.c
@@ -313,7 +313,7 @@ static int __mtd_del_partition(struct mtd_info *mtd)
 	if (err)
 		return err;
 
-	list_del(&child->part.node);
+	list_del(&mtd->part.node);
 	free_partition(mtd);
 
 	return 0;
-- 
2.30.2

