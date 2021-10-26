Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 579F243BAEE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 21:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238838AbhJZThC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 15:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238825AbhJZTgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 15:36:48 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C80BC061348
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 12:34:24 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id k7so80739wrd.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 12:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZX+m9eRP3G6qa3o26UuCwjfzdvb0rxacvbcUwg9LjVM=;
        b=yTCQeaUgyQ77dr9b2Tas/r0wJ3HPcbupOrQjRBkua/PfAuEuXTXMwtxto/o3HU79is
         NmLl9oDzcOdghZbtMlbaHabKQ2UB3EAC63EGGX7nzfEttHH8JIuyEuu1m6pwU4Yxoy1S
         Tmqf/6fYkmrZXx2GePhaTP5vCWlzSUiTUKPOLVf+xkxmpXoqZSiyxfMcjG2kA8mQZr5W
         MDSLSvsLjpGFVthu/fU3iAmVWgXtm2cAmvGL/pGsZuS+9T3gCuAk9E5HaTJ8yYwZVbXv
         IU4NDVhcnr8XD+eekoSB5qnM4rOpYTcHQbfw1/mzq6kCVMQeXBNMWh0zWc7Nrqw5LaX+
         petQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZX+m9eRP3G6qa3o26UuCwjfzdvb0rxacvbcUwg9LjVM=;
        b=koNxRkl2MjGfofwMvmCQCMPK4YEQCMmd99hQm6FemyBnLUiZsDKgLaaIZX6KVyZ/l5
         yXwlzU7Wy/i3mozplNpgqm3m2+yzidwNhudZ3jAjGahltVvCh9d6LuEYn0VH7tX6fIYK
         T6RsdPxd6505HD+4NXe0sIT0o8gBeZvjqjZOpTejPyw/pY1Vm4ElyBi+CcvadeHFoFkO
         ieK0WTIcisn2uWCNuDmY3G25QoMAyBAbFWVolOt9ogJx6V0ZvU0CBu+TDa7BiCgBViOw
         rhswPGCzp+3gGwERJ145MyZWklQtUXi51ptn58+5yhXrd5bwc5mdGYUp137q84dSnWe+
         UTwg==
X-Gm-Message-State: AOAM530WempWHdhkcNqy6GtupbNK7x/t2665TPdklJszbM0B0f132ztF
        dLACbdc4kuGn5elq7xFmpppo+Q==
X-Google-Smtp-Source: ABdhPJw3HDmUSQ8StzDpfTOvfI979TWeAuUk5h+MXHiF/2I1HBt1rTdwIYUJA+bXbYnM2R8M3B5XsA==
X-Received: by 2002:a5d:4b51:: with SMTP id w17mr35244771wrs.47.1635276862764;
        Tue, 26 Oct 2021 12:34:22 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id s18sm17676123wrb.95.2021.10.26.12.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 12:34:22 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     mchehab@kernel.org, hverkuil@xs4all.nl, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, mjpeg-users@lists.sourceforge.net,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v3 02/14] staging: media: zoran: use module_pci_driver
Date:   Tue, 26 Oct 2021 19:34:04 +0000
Message-Id: <20211026193416.1176797-3-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211026193416.1176797-1-clabbe@baylibre.com>
References: <20211026193416.1176797-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify code by using module_pci_driver()

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/staging/media/zoran/zoran_card.c | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/drivers/staging/media/zoran/zoran_card.c b/drivers/staging/media/zoran/zoran_card.c
index 3bc0e64f1007..f1465fbf98af 100644
--- a/drivers/staging/media/zoran/zoran_card.c
+++ b/drivers/staging/media/zoran/zoran_card.c
@@ -1314,23 +1314,4 @@ static struct pci_driver zoran_driver = {
 	.remove = zoran_remove,
 };
 
-static int __init zoran_init(void)
-{
-	int res;
-
-	res = pci_register_driver(&zoran_driver);
-	if (res) {
-		pr_err("Unable to register ZR36057 driver\n");
-		return res;
-	}
-
-	return 0;
-}
-
-static void __exit zoran_exit(void)
-{
-	pci_unregister_driver(&zoran_driver);
-}
-
-module_init(zoran_init);
-module_exit(zoran_exit);
+module_pci_driver(zoran_driver);
-- 
2.32.0

