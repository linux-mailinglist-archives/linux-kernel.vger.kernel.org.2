Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3713220B9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 21:18:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbhBVURo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 15:17:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233423AbhBVURj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 15:17:39 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DC6C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 12:16:59 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id v1so20388561wrd.6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 12:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FNpf1WTmufOquSJigNdqP1VsRu9mN6RPbIuIKJ+aSyo=;
        b=ExmZ0llzHQFOJiIBf3pJwbKdOEK0ywmump7PiCpQF52HrrDVnm4gFtOodkyDtcSGI8
         VOjefbWgGwSrD4QJxoaPmdJtXQBx7FeCZo99xPdTFmg2yMyunoagor0maXQEZ89kfDyQ
         2oRvM0G/1WTfeaMNZtH32XFfmZMVbB3pN5alrfOMISYtFcZn61gMSi05Fk0bdocfOdvZ
         6xAkHEiDMpXGvXuDXTyMmLIbztL1wjgSVHCwusBiIZol0WOXKhcaLlr6V/u6q2v5etbn
         CBSdy4BZC/ZMuNpec+n0mLfVDU3ZTlqyNhAsLKYtqaN8LmNnWgkrIPyC3prxax8Hinps
         y90g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FNpf1WTmufOquSJigNdqP1VsRu9mN6RPbIuIKJ+aSyo=;
        b=FOH/3r0NYHDIuJ1FO2n6SdwJPIeJg49TroDC5ZSVD6IB1v1PrylO+SZyE4u/APnzsM
         Ir4Xfg/+mKHoJajQipWVyEUuUvHxlCkjBn93Nuqylv1EcTUKEnU0Z2IO5NrpYuO9OHjQ
         jdvRSODwjinQb0X0w7QGAsQqjR3eqnK6DxBb8X/UUN47LZHzeJ59UMfqKufkWADy7LkE
         J1kmYqRJNudHOWXaB0zNHLwzIdSHenJUmtTDxE4YnixDkzmfrnw9TJJctYYQUsHfpMab
         GFKbkNbj8y6geftllByCa6DsJ91anXMvHbzXEgEqTbJAwg/jrrjgOg6cVDD/M5GO7UiX
         oagg==
X-Gm-Message-State: AOAM531kTZeKIZUqjHHIv4uEhjd/r8rYxLDp7+hT5dyqA2uhYbL+D3H/
        wvb+yoUsB7BvB3XvnK//MF4=
X-Google-Smtp-Source: ABdhPJx+c/A5IPTtbAYjZmVXoKRDL3SiFrBkLdy+0eTjLBNZwfx3qd/jYJkFn2P7q5twhRj+5Esynw==
X-Received: by 2002:adf:8bd2:: with SMTP id w18mr23261463wra.204.1614025018124;
        Mon, 22 Feb 2021 12:16:58 -0800 (PST)
Received: from skynet.lan (170.red-88-1-105.dynamicip.rima-tde.net. [88.1.105.170])
        by smtp.gmail.com with ESMTPSA id o14sm28489528wri.48.2021.02.22.12.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 12:16:57 -0800 (PST)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     Brian Norris <computersforpeace@gmail.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH] nand: brcmnand: fix OOB R/W with Hamming ECC
Date:   Mon, 22 Feb 2021 21:16:55 +0100
Message-Id: <20210222201655.32361-1-noltari@gmail.com>
X-Mailer: git-send-email 2.20.1
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

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
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

