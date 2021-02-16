Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6658131D20A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 22:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbhBPV1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 16:27:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbhBPV13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 16:27:29 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608E2C061756;
        Tue, 16 Feb 2021 13:26:49 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id 7so15125823wrz.0;
        Tue, 16 Feb 2021 13:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kxwOUxUdnljLW686/SnZ2RHKtLcEjcyiO3FyMtlRrN4=;
        b=X4RzOuaEh/2mkJifv7IpFpIYZYQduaATcsKxtcHnSPyjRTfUTJhNhcnFZYWBVLmYM5
         pQIqvQnT5pEAFMv+79lSHPfGziI0Omjfqa+xQspACVzEQ+kMxrB3NTGDfavIRevZZxIp
         0XkOMufMufIXbAA9xYkax5DN96SkZkcQpMtjZxvtCBzdeqZEm8ShRRjSP3G0o2bVA9Z3
         2lBAVZAYpPkHUr6CeOKlEvTuSEy/7ef5/5OdvW6CtFi9ul3pF6FdG8PX1clegt/GObn4
         jnQtQ+QsKNTymM+YK9qVm7TsiD9zoPHeY7hffKgUvyNsiI2JuISyHdZ24gYaSvH9zW3m
         EWBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kxwOUxUdnljLW686/SnZ2RHKtLcEjcyiO3FyMtlRrN4=;
        b=rJ5ps1Ezj7R/cEDvRzJi+zt1GXreXiuhU02c7o3CBayLOZmMBAGCAr/ZPD8BTHqkXN
         wSty9rj0Bf4ccVw42ehFWbJaEMbNV3WQKNNJzsoa95gz8pDd4Turj3NAV8s3Sfqp+TJA
         4R4yz6HKHXPfpw2UUKhlgCgkTAOd1tSFhHk7vPYtBRpV7ne04WnIpUdLkcK/fAlVqT4k
         tzd8vX2D7fry6/3rDGI2hF6sS+WhDpR92ZHSNscQk6CBgwc6AOZNtjJ0kat0127NLRnU
         i2Xt8WRJbYy/tuAiKvhQ6tMbIcfPf99nka9ewgiF4uRVHogvLD66/bya8TURqWMmb5b8
         HK3g==
X-Gm-Message-State: AOAM532OVH0Gkzj3kJPS0fhYjiqQkv+kuPDXxjsDpXbvGVsNuFZxEzzf
        PQHDEG16T+7pAmpmLhK/1/8=
X-Google-Smtp-Source: ABdhPJzfGdlWuTpldxnRFP/xLQ4u1aqaj7Itud+leVccJg6SM6qHcMUDfY+0Eed4Iw8uv2LwuE5m7A==
X-Received: by 2002:adf:bac8:: with SMTP id w8mr7510534wrg.68.1613510808010;
        Tue, 16 Feb 2021 13:26:48 -0800 (PST)
Received: from Ansuel-xps.localdomain (host-87-6-252-11.retail.telecomitalia.it. [87.6.252.11])
        by smtp.googlemail.com with ESMTPSA id s14sm7132182wmj.23.2021.02.16.13.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 13:26:47 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Richard Weinberger <richard@nod.at>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] Implement nvmem support for mtd
Date:   Tue, 16 Feb 2021 22:26:25 +0100
Message-Id: <20210216212638.28382-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mtd support for the nvmem api has been stalled from 2018 with a patch
half pushed hoping that a scheme is found for the mtd name later. This
patchset try to address this.

The solution is simple.
New partitions scheme should always have the partitions {} structure and 
declare subnodes as partitions is deprecated and should not be used anymore.
Fixed-partitions parser is changed to parse direct subnode as partitions
only if the appropriate compatible is used. This change make possible
the use of nvmem-partitions compatible and the entire partition node can
be parsed by the nvmem of framework.
The current code register the partition to the nvmem framework every time
but skip actually of_node parting. The new nvmem-partitions compatible is
used to enable of_node parsing on the desired partitions.

Ansuel Smith (3):
  mtd: partitions: ofpart: skip subnodes parse with compatible
  mtd: core: add nvmem-partitions compatible to parse mtd as nvmem cells
  dt-bindings: mtd: Document use of nvmem-partitions compatible

 .../mtd/partitions/nvmem-partitions.yaml      | 105 ++++++++++++++++++
 drivers/mtd/mtdcore.c                         |   3 +-
 drivers/mtd/parsers/ofpart.c                  |   5 +
 3 files changed, 112 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/partitions/nvmem-partitions.yaml

-- 
2.30.0

