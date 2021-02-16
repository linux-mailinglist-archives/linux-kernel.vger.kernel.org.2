Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9D6B31D149
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 20:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbhBPT5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 14:57:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbhBPT5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 14:57:13 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DDC2C06174A;
        Tue, 16 Feb 2021 11:56:33 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id y26so18474637eju.13;
        Tue, 16 Feb 2021 11:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gTKUWEdr7X7gHT2/c0rh/4HOUp41ym8Za7G+Wwf9Lwk=;
        b=jzGuKPTMZQWNehBBdJksfFwA4UOge6d9q760lIxNyncm7nBdfugSgxT1Keg1HPzAGd
         JLTkJogzs3pxn3/srZQRlM9pKm51nUl1kC4rxUo5QDMbTY5n3zVLepdEOytL2FUre2Oq
         ojgUAT6EOzqAFDUj3t+wJcw536Kuqg0NisJaSSSsLq+H/LMKkUpR3X5NmJ79Gh5VCXx2
         000XzNjAt7yUQ+q/cwGySF6KRhgbUZyPDQ7tGfPHLfnWkpnVsWwlossT9gjdsMktQD3H
         SCL5QVA+TqcmyT8SzfQ+cd8c1ANJv/41oqptoBynUPMcsX1gzKIyiRrs0LS0IbH24o2P
         uUNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gTKUWEdr7X7gHT2/c0rh/4HOUp41ym8Za7G+Wwf9Lwk=;
        b=mXMR7k9eado5d2jpC4N4vyDHSQZ6LMjB5OxUCTNaDEZPK+OWAy9BCb10O4K0pl8rtE
         CHJ2oywoFyuu4aiObY03zq2UxgJlwNX8uNw60b6RTKEqBrx/y+EsQmAG5X4z3bWUX3cp
         ACkU2QnEh5kx4ljeMVb3KsuBgEiyPmq1bBrT4uSWHGTRjiDqcMjPT1X6uDWM+CidKRul
         QcRXP34txZ6/zTlE7A20GyzlSSQqJh7iLN/uQcKk2dw9301yP68qwQZHJtvVkwArEQGQ
         ZO0NftVkQCfhS21Lq3LZQstET8GkiGJwfIoi4d37bzSJt6NY09QbzwGQf8xPr1q6fdRr
         tLcQ==
X-Gm-Message-State: AOAM533rqNR4EjR6Rq/pmpk1ORVJk5q3g0lji4DCA61+/NnLI0g16rTF
        bxeS/3RPsIwQ2SpkvlQORMM=
X-Google-Smtp-Source: ABdhPJzK70XRIZgLLT7o/B2o/FVR+4gONsXyljCh7z9pr7UcUcn/7nBvSDLpE9BN9tCvYHYZsl0Ihg==
X-Received: by 2002:a17:906:c1c1:: with SMTP id bw1mr22551444ejb.86.1613505391883;
        Tue, 16 Feb 2021 11:56:31 -0800 (PST)
Received: from Ansuel-xps.localdomain (host-87-6-252-11.retail.telecomitalia.it. [87.6.252.11])
        by smtp.googlemail.com with ESMTPSA id rh22sm963332ejb.105.2021.02.16.11.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 11:56:31 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Richard Weinberger <richard@nod.at>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] mtd: partitions: ofpart: skip subnodes parse with compatible
Date:   Tue, 16 Feb 2021 20:56:09 +0100
Message-Id: <20210216195618.27959-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210216195618.27959-1-ansuelsmth@gmail.com>
References: <20210216195618.27959-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a partitions structure is not used, parse direct subnodes as
fixed-partitions only if a compatible is not found or is of type
fixed-partition. A parser can be used directly on the subnode and
subnodes should not be parsed as fixed-partitions by default.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/mtd/parsers/ofpart.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mtd/parsers/ofpart.c b/drivers/mtd/parsers/ofpart.c
index daf507c123e6..4b363dd0311c 100644
--- a/drivers/mtd/parsers/ofpart.c
+++ b/drivers/mtd/parsers/ofpart.c
@@ -50,6 +50,11 @@ static int parse_fixed_partitions(struct mtd_info *master,
 			 master->name, mtd_node);
 		ofpart_node = mtd_node;
 		dedicated = false;
+
+		/* Skip parsing direct subnodes if a compatible is found and is not fixed-partitions */
+		if (node_has_compatible(ofpart_node) &&
+		    !of_device_is_compatible(ofpart_node, "fixed-partitions"))
+			return 0;
 	} else if (!of_device_is_compatible(ofpart_node, "fixed-partitions")) {
 		/* The 'partitions' subnode might be used by another parser */
 		return 0;
-- 
2.30.0

