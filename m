Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A688D323846
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 09:04:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbhBXIDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 03:03:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234387AbhBXICz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 03:02:55 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A327C061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 00:02:15 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id k66so988742wmf.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 00:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z7NDGuuBGpr0KObSoWksVh7Rk18owzLbRpVZKUClVHk=;
        b=phSaXRdNBIcPj+25JdRCrfUfBMQMOTXde8Kv7aE5D7NUM4w/odWQeDNODqpanDm+Ji
         c+tQTl0IERpCPCtIITxwUmaPGU6kJoCZEatltPyS0zhTpVskoTJNXd+PkQWNZCTvisl9
         8EeMzXJLoFXID2nXlKpAYlPMrgXu4iagh8RIQ1EoGFGVJcoMyV3OZn3D1t3nuWZuEmpn
         Ny41u/6ZoQE90f2SIAaHSqaL9sA8poFnJw0IY80cceDubkCvERoStM/UAZO9Zl5igqL8
         qh48P5Hw2XO55yZJ5h7tU8Aq0FyM+wOXSHGxgbYnQdxSaMibVu5c7NVE9KvdBvtUJuCv
         UxdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z7NDGuuBGpr0KObSoWksVh7Rk18owzLbRpVZKUClVHk=;
        b=Yh709KjdAimAE9HBVumZ4OAiR06cEUzSO80bbxCaaSCzwg7XQOcuomvJVDySVhURBu
         /5LeiuTp6E1VP3R/2+8kIvpk/V5ibccbhXuhEjR/6lWVDImGWSr1YqMKaJMmDsGAWCz4
         gGR7AnQztnjdGMO2PvUaIrDdmXk2SAX2g6iAFcvek49PMu93UgCYjVHL7ceGIDm8aoys
         eXVEOEE63WZX2Sfo9V/hFE5vg2yCAkzNxLh9D1r8AXRVrBSs9lDfFFuGPeKW2tmJmwLR
         T/54EM7iPLrlYMXQFZMdLhEzkSDAg3qVcb8DyfsedsMBKFuD/+MJM+bdlhazuZdXUOF+
         /9Fg==
X-Gm-Message-State: AOAM532g9xeps4WhLqCEqu63wkgCV7x0jlLxbfPIxkNYKHeUhwkpZPoP
        wWJ/YJLH2Q8t1dhqOugw4t0=
X-Google-Smtp-Source: ABdhPJxj2t7kjl3+qt+9micKV54J8dXmVOUHc/fDxjZMccJim1Rw+YD+y4T3p+Lc1UcOzaLYVjee6A==
X-Received: by 2002:a7b:c20a:: with SMTP id x10mr2486521wmi.137.1614153734148;
        Wed, 24 Feb 2021 00:02:14 -0800 (PST)
Received: from skynet.lan (170.red-88-1-105.dynamicip.rima-tde.net. [88.1.105.170])
        by smtp.gmail.com with ESMTPSA id 2sm2098489wre.24.2021.02.24.00.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 00:02:13 -0800 (PST)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     f.fainelli@gmail.com, Brian Norris <computersforpeace@gmail.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH v2] nand: brcmnand: fix OOB R/W with Hamming ECC
Date:   Wed, 24 Feb 2021 09:02:10 +0100
Message-Id: <20210224080210.23686-1-noltari@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210222201655.32361-1-noltari@gmail.com>
References: <20210222201655.32361-1-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hamming ECC doesn't cover the OOB data, so reading or writing OOB shall
always be done without ECC enabled.
This is a problem when adding JFFS2 cleanmarkers to erased blocks. If JFFS2
clenmarkers are added to the OOB with ECC enabled, OOB bytes will be changed
from ff ff ff to 00 00 00, reporting incorrect ECC errors.

Fixes: 27c5b17cd1b1 ("mtd: nand: add NAND driver "library" for Broadcom STB NAND controller")
Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 v2: Add fixed tag.

 drivers/mtd/nand/raw/brcmnand/brcmnand.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
index 659eaa6f0980..5ff4291380c5 100644
--- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
+++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
@@ -2688,6 +2688,12 @@ static int brcmnand_attach_chip(struct nand_chip *chip)
 
 	ret = brcmstb_choose_ecc_layout(host);
 
+	/* If OOB is written with ECC enabled it will cause ECC errors */
+	if (is_hamming_ecc(host->ctrl, &host->hwcfg)) {
+		chip->ecc.write_oob = brcmnand_write_oob_raw;
+		chip->ecc.read_oob = brcmnand_read_oob_raw;
+	}
+
 	return ret;
 }
 
-- 
2.20.1

