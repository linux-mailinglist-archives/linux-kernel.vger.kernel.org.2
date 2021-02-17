Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4D9431D59F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 08:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbhBQHH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 02:07:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbhBQHHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 02:07:55 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3884EC061574
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 23:07:15 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id kr16so952281pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 23:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=uUceRMwlX9IZeouSnfen/C1hPvySWdTZkKj9we8Ehb8=;
        b=C89ryAF9aFUedZbGkE/HdZAmPNa4/BiT2AaYiJ+yqQCgBYNbEA46kYNoe/7h6/SNJ7
         b8uGKwpiVe8AcazMajtwsNTQWlki5Qget5ARV1ZsU1Q4WU8HKljLvPeLCR2MbfB+d7cM
         3SQ//bbXKU5vC/TRjSGjJy5MrkBS7qOeJouMK2hYOqys94/LpczvLrjz3ULRx3kTHL7+
         VChboaU0KMJiCkYXi/ADkGt0J6axrgUN9edszMZHvYoOCNjw6SQRn88XkD7FpnUPWLdl
         XY0lKA9AzAvgQFN79g2VBVyY3Zc4QyGjAWg40G5zZS3TfyS0xGO8WR2qWHnZfelCuTSF
         SXMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uUceRMwlX9IZeouSnfen/C1hPvySWdTZkKj9we8Ehb8=;
        b=TrkVdRfRwZ4PNQXOlPXkdqjtkiBrOfYcFRBiGP1G+gxaL2Yrl4nqvbPYaPceiQw77i
         E18MVcr/nl0Z2r1dhszFcD5kLQDHlIUo1nnBjN8/QhTFM4/TTruFFn8TsTJYGI1QFtTo
         9oJ7pa/Rh/2CMTECiH1cML0F27vTSibqEDLaDImq1+j+obwUXpxEgXG6bMeQa6xtdeWp
         eJlSv8PUoJDuYEH4gCevO4T4QqqOT775CMGFpl7zQG5sJR367tKGHPqd2RFqC3hmm411
         6UQZQyaoRh5e/nRZPThH97foiT8oXFqw6e01yKHqXASdzi7UBrSBCQWg2jfM4kw3byhO
         usKQ==
X-Gm-Message-State: AOAM532iRuIkk5QIIiTGoKhlH8DERHkQHbCI40ipR/nhzn/0zKV0q/Zg
        NKdi597c5nvSNUkxB/ZlGL8=
X-Google-Smtp-Source: ABdhPJwbeQHODNxqBptsyO7J6CNit1Ee7v8+7bAZvSQHSoqqUgnQJ5Da0aYS1OI7At+a2ZHBQs0zxQ==
X-Received: by 2002:a17:90a:ab07:: with SMTP id m7mr7883085pjq.74.1613545634469;
        Tue, 16 Feb 2021 23:07:14 -0800 (PST)
Received: from localhost.localdomain ([116.73.175.128])
        by smtp.gmail.com with ESMTPSA id 123sm1117217pfd.91.2021.02.16.23.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 23:07:14 -0800 (PST)
From:   Selvakumar Elangovan <selvakumar16197@gmail.com>
To:     matthias.bgg@gmail.com, gregkh@linuxfoundation.org,
        sergio.paracuellos@gmail.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] Staging: mt7621-pci: fixed a blank line coding style issue
Date:   Wed, 17 Feb 2021 12:37:10 +0530
Message-Id: <20210217070710.7359-1-selvakumar16197@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed an unnecessary blank line before closing brace reported by
checkpatch.pl

Signed-off-by: Selvakumar Elangovan <selvakumar16197@gmail.com>
---
 drivers/staging/mt7621-pci/pci-mt7621.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/mt7621-pci/pci-mt7621.c b/drivers/staging/mt7621-pci/pci-mt7621.c
index c3532bc138fb..1781c1dcf5b4 100644
--- a/drivers/staging/mt7621-pci/pci-mt7621.c
+++ b/drivers/staging/mt7621-pci/pci-mt7621.c
@@ -521,7 +521,6 @@ static void mt7621_pcie_init_ports(struct mt7621_pcie *pcie)

 			if (slot == 1 && tmp && !tmp->enabled)
 				phy_power_off(tmp->phy);
-
 		}
 	}
 }
--
2.17.1

