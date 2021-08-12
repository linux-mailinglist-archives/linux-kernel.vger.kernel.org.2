Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3B93EAC03
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 22:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238027AbhHLUmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 16:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237930AbhHLUm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 16:42:27 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0EC2C061756
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 13:42:01 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d9so6377034qty.12
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 13:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yXImnqZERav+3w/cyHb8wggYxQXzQW+9n8PpB8P0B2M=;
        b=usm5jESwVuEx39403DEzOX/iOpRPGkXcTdPc6I/xDG/6cl72ZcYCdVnAoCHJUeyZ9/
         KD5H3a0mCF5PjztxPo+5cr6SHbpbiJPCCEptDNN/2/bkj/O5kkopxXhmWAyjqLumLWO7
         aBfLXfcVC3Iv2KZtneyMTow7xHrRF7uuAUkxYwj6T5rTu4p3JBhjzsxPogYFZYD2KIkp
         h7VKKq6nD43UXSmTVJfcHKt2LDJqfSIFIWtIoVqIyOtOYWweeB75a+LG0eSsvl4JqSgi
         dBx1CjNXqcBlGLgxRS/cObY47JiCHWKWbyaSmXh0DoktqUH1u8G0p1YV0EV9yIgXAMpE
         L9Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yXImnqZERav+3w/cyHb8wggYxQXzQW+9n8PpB8P0B2M=;
        b=sE4QJpYudbFoTxBVSJb2DupYewDjLIcEuWc4et0+ekoeC48pqQW/NiHCYZKZlaXMKg
         gLKwCENj7qMwnJkbarrniWXd+Uq/OzAW6+DJv+Gm2krVLoLCLFLdvJhH9nr5QQU2ciu2
         dYD2BS/4a7HixY4q4tgRJyjzIET9PaQ4m+EbxZVXsT2v8i5Uqswe4Z0PjlieYPvqfB8B
         ySLnYnyyDcjKdHLjFzfJbYP9h4KUc30jdLPfxRM+mZ3qj+ymmA7HCgLVO4JD9HYl54sG
         uAXQpl/nf+A6F79LBQnSfvSdIIEmZknBFLW4Bp/DiLDr4/bKA9RB7DfmDjbFfjlXJnYO
         Oh3w==
X-Gm-Message-State: AOAM533cck1RrDS9ULgLD0iSH0gcnQj9g4r0C38bSxG8M0YgYJCzLb9H
        jp14TY/BDgC/7nA/gRVUoEQ=
X-Google-Smtp-Source: ABdhPJy2RX7/mb2/P2Gi72QdHX2DsNgx/ybOEpWl/TEzJP8z0OZU2joHZRJ1zmu0jAe+6w9/N6s6dg==
X-Received: by 2002:a05:622a:2c8:: with SMTP id a8mr5634300qtx.137.1628800921025;
        Thu, 12 Aug 2021 13:42:01 -0700 (PDT)
Received: from master-laptop.sparksnet ([2601:153:980:85b1:e89f:d077:9161:1bd7])
        by smtp.gmail.com with ESMTPSA id m16sm1940361qki.19.2021.08.12.13.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 13:42:00 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     Peter Geis <pgwipeout@gmail.com>, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/8] phy: phy-rockchip-inno-usb2: support standalone phy nodes
Date:   Thu, 12 Aug 2021 16:41:12 -0400
Message-Id: <20210812204116.2303617-5-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210812204116.2303617-1-pgwipeout@gmail.com>
References: <20210812204116.2303617-1-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

New Rockchip devices have the usb2 phy devices as standalone nodes
instead of children of the grf node.
Allow the driver to find the grf node from a phandle.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
index 5d2916143df7..84a0c1d697da 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
@@ -1081,12 +1081,19 @@ static int rockchip_usb2phy_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	if (!dev->parent || !dev->parent->of_node)
-		return -EINVAL;
+	if (!dev->parent || !dev->parent->of_node) {
+		rphy->grf = syscon_regmap_lookup_by_phandle(np, "rockchip,usbgrf");
+		if (IS_ERR(rphy->grf)) {
+			dev_err(dev, "failed to locate usbgrf\n");
+			return PTR_ERR(rphy->grf);
+		}
+	}
 
-	rphy->grf = syscon_node_to_regmap(dev->parent->of_node);
-	if (IS_ERR(rphy->grf))
-		return PTR_ERR(rphy->grf);
+	else {
+		rphy->grf = syscon_node_to_regmap(dev->parent->of_node);
+			if (IS_ERR(rphy->grf))
+				return PTR_ERR(rphy->grf);
+	}
 
 	if (of_device_is_compatible(np, "rockchip,rv1108-usb2phy")) {
 		rphy->usbgrf =
-- 
2.25.1

