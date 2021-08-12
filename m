Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5BD73EAC02
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 22:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238015AbhHLUme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 16:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237894AbhHLUm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 16:42:26 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E91C8C0617AD
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 13:42:00 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id t66so8327132qkb.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 13:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ggW256M3SIcZiGvGqGuspKz5dguh2TkojKgtWRP6iJo=;
        b=t1W1hIvV0te5vPrxMds68WtR52qT21pqllsiWQ4EdrsevpXRuUZnxXIl5qHRbeUKud
         9PN6GoVqsYPuDsx7pi32SNuSqOfURq9S31XUJV/AlJd0iywelRrQmbl/OkkSbSIU9aj1
         Mtb23C5te0dfzD8gkBPfn7Zn7O1BmMZZ2Vj2ptM9z69YebxBooi4wimZ4liyXX2ddbch
         OrYgutQBIxSZfehRX8I8oI6UUch0Re8p5DMgGbrbTH6AehG0dHunC65FbcJV2TSgrxQc
         RbHAseLHF2JwHcI2FEDLV18o9MijWzchENcsVLda2q16CcVzVCETsEAeHlmbl+LQ+vxn
         Es2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ggW256M3SIcZiGvGqGuspKz5dguh2TkojKgtWRP6iJo=;
        b=gmMFLbJTZfNVZxwa5eRdWqdKfuOHMutyz5ALJGAyMO0M0lpXXPYZXYw0vFWkB4SGWB
         ToVFTtqBbFQOkPmJWfUUt8DYnMrffZElMGO/4XuHLm7+3UlTSbRiJQQoDJ1y/p1TF6O8
         ip6fMcDZbarYzmLqK/1FnTcJdmtT+yqCHEgztTV/YfQmWVQ6AM2PXxzyBMwN6XXF2kWS
         2jtQYErZ20zDLQuL7jvtPMO8LBC3LBRExqBjFfr1MkMf2enLODkfBaxDL5SSkqnvw/j7
         aKEtMd6MBeG+i1NCK0mmpl/YyVG2w5KFocNAkXANw2YgbTEuKNbZxhmd6OvRwqBiiv3b
         ZbZQ==
X-Gm-Message-State: AOAM531+ZZ04wR1Sa/I3QrJjemyL8HliQ9Kib0pZ8IOUtXqpjn+m8Wuc
        GWItLONH6QjesKW2fhMunmc=
X-Google-Smtp-Source: ABdhPJwz50s1sUzGtczLj6lnVE9J9Egy2qsDbNPpOk2wPPVMdrvu2dFxJKuLLxvmd8wuc8hmQwDo8Q==
X-Received: by 2002:a37:9643:: with SMTP id y64mr6224821qkd.213.1628800920037;
        Thu, 12 Aug 2021 13:42:00 -0700 (PDT)
Received: from master-laptop.sparksnet ([2601:153:980:85b1:e89f:d077:9161:1bd7])
        by smtp.gmail.com with ESMTPSA id m16sm1940361qki.19.2021.08.12.13.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 13:41:59 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     Peter Geis <pgwipeout@gmail.com>, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/8] phy: phy-rockchip-inno-usb2: support #address_cells = 2
Date:   Thu, 12 Aug 2021 16:41:11 -0400
Message-Id: <20210812204116.2303617-4-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210812204116.2303617-1-pgwipeout@gmail.com>
References: <20210812204116.2303617-1-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

New Rockchip devices have the usb phy nodes as standalone devices.
These nodes have register nodes with #address_cells = 2, but only use 32
bit addresses.

Adjust the driver to check if the returned address is "0", and adjust
the index in that case.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
index beacac1dd253..5d2916143df7 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
@@ -1098,12 +1098,21 @@ static int rockchip_usb2phy_probe(struct platform_device *pdev)
 		rphy->usbgrf = NULL;
 	}
 
-	if (of_property_read_u32(np, "reg", &reg)) {
+	if (of_property_read_u32_index(np, "reg", 0, &reg)) {
 		dev_err(dev, "the reg property is not assigned in %pOFn node\n",
 			np);
 		return -EINVAL;
 	}
 
+	/* support address_cells=2 */
+	if (reg == 0) {
+		if (of_property_read_u32_index(np, "reg", 1, &reg)) {
+			dev_err(dev, "the reg property is not assigned in %pOFn node\n",
+				np);
+			return -EINVAL;
+		}
+	}
+
 	rphy->dev = dev;
 	phy_cfgs = match->data;
 	rphy->chg_state = USB_CHG_STATE_UNDEFINED;
-- 
2.25.1

