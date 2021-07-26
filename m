Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61FF13D5C19
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 16:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234658AbhGZOJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 10:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233206AbhGZOJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 10:09:32 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F12C061757;
        Mon, 26 Jul 2021 07:49:59 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id c16so1569218wrp.13;
        Mon, 26 Jul 2021 07:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=xLmMVn1uoLATlywyndSzCwv/MROV9xIhKUlgFoTwd7k=;
        b=JlM/3iQLY7TfHfUPiWz2d2R/A8LnY1phSqqsMTbyRdF+6wMhlD9S+CmVkFcPZWx0P3
         kVVuvFfBIamUbsXqv+ba3OMyb0GkECfrL+lFWYtOVty5GmYKF5DN18gcSqMbLwqzB3Lp
         K2vbQZnEUQyNlG5VmeWMT17DJ9z5yWrJFiwuvf084qye+5QHTrf7paHWK7u1AMOzf3vz
         MnMzQK0yXeZcwyxQ6lKekh/EbSGmUHiPQSIl6nN950wvprkhGwbDPX7APkZ+JivWq2OV
         ej9Lgv4RW2wAUedkNqRUhStDLHgviXoyqlV3olLq2o+8L4FiRfIwyEaZir7J8zA8/wlM
         wSaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xLmMVn1uoLATlywyndSzCwv/MROV9xIhKUlgFoTwd7k=;
        b=N6sgXMKUsqcQArWY//II3EIixB59OE8slCOOXvD0QczL6hbcKB0v65CahRBNiNH0D0
         bbNR5JkEsZAi8SdExwh3fcwxKz9lFsKR+4fqwn2jGFzIacPyGWuJhr+UJSLRqsxoyAdy
         yJv9k2tyN+FN4285up88XTlvH9EqBmVoT0Fe1a/OoYnjmfSKGYowZejLrGujo7xjMAqb
         Fa9Khico11vynmZefXc8HD92ewmbpgeLVimTfmOYZkxkHOpmCQV2KeB67f87D9sOjvsv
         jJgnBvRUR2zCLpflvmgFTjG5fk/U4Rt5G/3Aq3R8duZHrE3/v6X4NGMUsS4pFmTWdIRM
         rOzQ==
X-Gm-Message-State: AOAM5337vqk9EQzOgpzf1+cfwfjBHjzgRhU/2mwhwINTLuj9wBKyzYRS
        KrpCGO2zvOa+ESgeyo4DUZE=
X-Google-Smtp-Source: ABdhPJxlbCS5XzYEqJbNfoMho+XsFVH5CnPgy+fdBeBMGxuBsqfFlF3fLjhd7F0oc4QoPCEF7oc6ow==
X-Received: by 2002:adf:e90e:: with SMTP id f14mr380018wrm.191.1627310998260;
        Mon, 26 Jul 2021 07:49:58 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2d1a:1100:c32:37a3:94e9:cfea])
        by smtp.gmail.com with ESMTPSA id q19sm13480481wmq.38.2021.07.26.07.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 07:49:57 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>,
        linux-mtd@lists.infradead.org,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: repair Miquel Raynal's email address
Date:   Mon, 26 Jul 2021 16:49:49 +0200
Message-Id: <20210726144949.10439-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit d70c6b026069 ("MAINTAINERS: Add PL353 NAND controller entry") and
commit 813d52799ad2 ("MAINTAINERS: Add PL353 SMC entry") adds Miquel
Raynal as maintainer with an obvious invalid email address, which can be
easily fixed.

Repair this copy-and-paste error in Miquel Raynal's email address.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Miquel, please pick or ack this patch.
Krzysztof, please pick this patch if Miquel does not.

 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d69b2d4646be..f31922d0503a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1476,7 +1476,7 @@ F:	drivers/amba/
 F:	include/linux/amba/bus.h
 
 ARM PRIMECELL PL35X NAND CONTROLLER DRIVER
-M:	Miquel Raynal <miquel.raynal@bootlin.com@bootlin.com>
+M:	Miquel Raynal <miquel.raynal@bootlin.com>
 M:	Naga Sureshkumar Relli <nagasure@xilinx.com>
 L:	linux-mtd@lists.infradead.org
 S:	Maintained
@@ -1484,7 +1484,7 @@ F:	Documentation/devicetree/bindings/mtd/arm,pl353-nand-r2p1.yaml
 F:	drivers/mtd/nand/raw/pl35x-nand-controller.c
 
 ARM PRIMECELL PL35X SMC DRIVER
-M:	Miquel Raynal <miquel.raynal@bootlin.com@bootlin.com>
+M:	Miquel Raynal <miquel.raynal@bootlin.com>
 M:	Naga Sureshkumar Relli <nagasure@xilinx.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-- 
2.17.1

