Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF0C3D217E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 12:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbhGVJTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 05:19:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:49284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231448AbhGVJTp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 05:19:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 908B461260;
        Thu, 22 Jul 2021 10:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626948020;
        bh=rTh9g8+vOJ8HY6y/Q5+gV0OfqKbSG4CGnJLbeNyrTwc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QLDr8sdSjrYiBBujC4q7IQ1ro6gWV2dcQvDPJlwdenX+5DX5pHtFHmXFoNINE6Vdt
         S0c47H2AypTC+QGVgIBihI8YN39VSko7Z8tS3sbYq7Q1uXOMep/WpfHdeHAjvKsny5
         yhXXLyQMscoEGz85dCtXfo0CCM8w1rT2mqpYvCVf6DKa+YHhCNveq0GpCYPnkkhobe
         SS3pOjoUgjLTlUIi0U1tilM3utooRuj6bbnd1h4nO3hCK1yIhh+hZPXFQ3FXbyMBom
         B/adiIh2xRov8xyIiEYAfrGAc8cFOEdFCF3VXMal0+wiVs9yMYF0jdnsYAT80Pps5g
         yewVcIhW/aS4g==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1m6VUz-008mHN-FC; Thu, 22 Jul 2021 12:00:13 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
Subject: [PATCH 01/15] dt-bindings: mtd: update mtd-physmap.yaml reference
Date:   Thu, 22 Jul 2021 11:59:58 +0200
Message-Id: <ab2ff9ee66110c37691b467ec8b4679e9d426416.1626947923.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626947923.git.mchehab+huawei@kernel.org>
References: <cover.1626947923.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset 63f8e9e0ac65 ("dt-bindings: mtd: Convert mtd-physmap to DT schema")
renamed: Documentation/devicetree/bindings/mtd/mtd-physmap.txt
to: Documentation/devicetree/bindings/mtd/mtd-physmap.yaml.

Update its cross-reference accordingly.

Fixes: 63f8e9e0ac65 ("dt-bindings: mtd: Convert mtd-physmap to DT schema")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/devicetree/bindings/mtd/gpmc-nor.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/gpmc-nor.txt b/Documentation/devicetree/bindings/mtd/gpmc-nor.txt
index c8567b40fe13..2133be0d52f2 100644
--- a/Documentation/devicetree/bindings/mtd/gpmc-nor.txt
+++ b/Documentation/devicetree/bindings/mtd/gpmc-nor.txt
@@ -10,7 +10,7 @@ Documentation/devicetree/bindings/memory-controllers/omap-gpmc.txt
 Required properties:
 - bank-width: 		Width of NOR flash in bytes. GPMC supports 8-bit and
 			16-bit devices and so must be either 1 or 2 bytes.
-- compatible:		Documentation/devicetree/bindings/mtd/mtd-physmap.txt
+- compatible:		Documentation/devicetree/bindings/mtd/mtd-physmap.yaml
 - gpmc,cs-on-ns:		Chip-select assertion time
 - gpmc,cs-rd-off-ns:	Chip-select de-assertion time for reads
 - gpmc,cs-wr-off-ns:	Chip-select de-assertion time for writes
@@ -21,7 +21,7 @@ Required properties:
 - gpmc,access-ns:	Start cycle to first data capture (read access)
 - gpmc,rd-cycle-ns:	Total read cycle time
 - gpmc,wr-cycle-ns:	Total write cycle time
-- linux,mtd-name:	Documentation/devicetree/bindings/mtd/mtd-physmap.txt
+- linux,mtd-name:	Documentation/devicetree/bindings/mtd/mtd-physmap.yaml
 - reg:			Chip-select, base address (relative to chip-select)
 			and size of NOR flash. Note that base address will be
 			typically 0 as this is the start of the chip-select.
-- 
2.31.1

