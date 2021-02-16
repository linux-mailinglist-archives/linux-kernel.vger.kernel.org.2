Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5647731D20C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 22:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbhBPV1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 16:27:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbhBPV1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 16:27:39 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599A7C0613D6;
        Tue, 16 Feb 2021 13:26:59 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id n8so15017337wrm.10;
        Tue, 16 Feb 2021 13:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gTKUWEdr7X7gHT2/c0rh/4HOUp41ym8Za7G+Wwf9Lwk=;
        b=H7N31piULCOG4p3kVh8VEIuac2d288j8dXkSoYRRVRXCpfTrJ8LSuVH+sv+wqjaRgm
         JKmEI0x7hme53FbBwsJ52shL93m6Ne341jtSUlUD78GDni7Yt8ZGmjJjdGzQIhSewRw/
         bG23eubM2pktJY/ePOXFOTat5SoALpSnW8rCvhfYtPUyYPZRvxDUrKl3gEoUy7bnQQWK
         GQKctLHu31M9ygX5YwaNu4I4tOnAYTdpbLFZo67bPV3HseTrTo5Lx8Afc8DsbSYqojAv
         MBHc1aWsiiXz6Uwty36AEG9Xi6AYFEJWoVeHOymKpN6LvFG6UWD1pdfH5Kk2cwOYFoV6
         Ft2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gTKUWEdr7X7gHT2/c0rh/4HOUp41ym8Za7G+Wwf9Lwk=;
        b=qPnDw1prg9+PWytMVogyAzgcH2yLGdkTMRjlLC9Abrh7RvlzZkF05XEAXqyUPN+cTT
         bepxKllGyphpW2Pj22cFCUXCWxYkBr8wUDcdzzU5BntLkw3lf9QKR8bENhbyMCUCuoUS
         NV8Pad35gkMlQMNr/tKpWADBs/4xcUNzQelH5SuzpZuBGMRAH1hBTmQqcxH8GVZ1mGiE
         UIDHMRkxfB+qkrBx0SzS6DXy/SvYh4X5Di+i8LFokJvnBiVM0tyznFJ/ytVROu7YNt8s
         NDUvQOpLM4gaL5fTdRTPOROCc0Nl8c+kl4N3hy0HoTTkDIhaGR9ajS0ocgHeUz1uH+Wd
         3nmA==
X-Gm-Message-State: AOAM5306dpCzKPwFvpCpOMEX4o2eAgdNIlSca3bQ8jkHJpUY5rKJfTzy
        A8PF7Qfyv4p6QqpBtmjo7fw=
X-Google-Smtp-Source: ABdhPJywo7VmsW32KITYWmVvyUWc2zBCwLyTACvX3mOy6RmpF6iQNI6DbIv8VsnZrxqhev97rJHmBw==
X-Received: by 2002:adf:edc8:: with SMTP id v8mr25548852wro.330.1613510817997;
        Tue, 16 Feb 2021 13:26:57 -0800 (PST)
Received: from Ansuel-xps.localdomain (host-87-6-252-11.retail.telecomitalia.it. [87.6.252.11])
        by smtp.googlemail.com with ESMTPSA id s14sm7132182wmj.23.2021.02.16.13.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 13:26:57 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Richard Weinberger <richard@nod.at>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] mtd: partitions: ofpart: skip subnodes parse with compatible
Date:   Tue, 16 Feb 2021 22:26:26 +0100
Message-Id: <20210216212638.28382-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210216212638.28382-1-ansuelsmth@gmail.com>
References: <20210216212638.28382-1-ansuelsmth@gmail.com>
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

