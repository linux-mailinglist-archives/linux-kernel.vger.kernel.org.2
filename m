Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86E15311FE3
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 21:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbhBFURu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 15:17:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbhBFURt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 15:17:49 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4891CC06174A
        for <linux-kernel@vger.kernel.org>; Sat,  6 Feb 2021 12:17:07 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id 7so12204290wrz.0
        for <linux-kernel@vger.kernel.org>; Sat, 06 Feb 2021 12:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S7bAkgjej0tXs3CFsUSAY/E5YDxWGktGInnREXcyLhc=;
        b=JRm9VyOW91wbTaaDNqzXD9xGVo0wvRAxVi8/RRYuEX3Nocr0wsPcJopHJXtk9NbDDB
         TofS/oZQjeQVTeVlzhJHgBldlOhHBcut88aBQZV+Q6xyZPnEj6Kicz95RVFpC55qUp63
         N5ba4Fk9fiGn4tUeThIcZwC+nKqK7zU2jM7LaaUWQYhkLjUwBkYESiNMvoe1KFcaC7FZ
         eYg3bCi9r56+97gSOOR/zPXuKUIqfOyVUuX1p5r7PcwWoE36TLMx6xAd4ZtiOaHs9AGw
         2YbpRq4q7ACWFj7zNT2T78zfOlOdIhiwAZwKr4SeKh2Sq9iF2rQvgHNWZkdVq6AbmJvU
         Wtew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S7bAkgjej0tXs3CFsUSAY/E5YDxWGktGInnREXcyLhc=;
        b=XpFIbe4W+prOGC3Xj1MRIHv/i4RNj08rEXXcKXPTRqE9br3JBYAkhXWs3THxt1Z1ds
         KXiHSTeBYATCHbeqyDoJ5Pw2eURLnzeKMHxhRE9qZ4L8diatLEAQIvuRQiKURcVU2EO7
         lhaGFCBbkT5oYZuaRVUfnxPw16QiS+pIUQ+2TXwtQ3vxRfk6tJSpuqswO8OQy6Z5fURq
         ZPdbx9cOPyCgMYe1EQ09Cl87q8A8Ls5HVRNDYOc8ULKkG3dCzxg3Fv4hfqXLiw5BstoB
         y65oY/3gS5rIK9XO7o0zbQG/SXdu3GKFTkyzq+eOZux6RCVZB0Afju+iBRGqLI8ssZZb
         34Wg==
X-Gm-Message-State: AOAM532B3JGC2VlhKgb7yCM0KVEbk2mCBqJbS2ShikMZUnjEAEHVKm7S
        iEn4Rj/8FJr+833F6W0rr4nTGw==
X-Google-Smtp-Source: ABdhPJyZu2Gh+51it6XpHqPJjr1b4rWpLSzmf/OsxKoOwn0n0qoHik71EjbvpbjRL76h9bawGGZ+Wg==
X-Received: by 2002:adf:dd92:: with SMTP id x18mr11902843wrl.4.1612642626070;
        Sat, 06 Feb 2021 12:17:06 -0800 (PST)
Received: from localhost.localdomain (2.0.5.1.1.6.3.8.5.c.c.3.f.b.d.3.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16:0:3dbf:3cc5:8361:1502])
        by smtp.gmail.com with ESMTPSA id d13sm17054668wrx.93.2021.02.06.12.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Feb 2021 12:17:05 -0800 (PST)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        alexander.sverdlin@nokia.com, f.fainelli@gmail.com, andrew@lunn.ch,
        davem@davemloft.net, chris.packham@alliedtelesis.co.nz
Subject: [PATCH] staging: octeon: remove braces from single-line block
Date:   Sat,  6 Feb 2021 20:17:01 +0000
Message-Id: <20210206201701.5273-1-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This removes the braces from the if statement that checks the
physical node return value in cvm_oct_phy_setup_device, as this
block contains only one statement. Fixes a style warning.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/octeon/ethernet-mdio.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/octeon/ethernet-mdio.c b/drivers/staging/octeon/ethernet-mdio.c
index 0bf545849b11..b0fd083a5bf2 100644
--- a/drivers/staging/octeon/ethernet-mdio.c
+++ b/drivers/staging/octeon/ethernet-mdio.c
@@ -146,9 +146,8 @@ int cvm_oct_phy_setup_device(struct net_device *dev)
 		goto no_phy;
 
 	phy_node = of_parse_phandle(priv->of_node, "phy-handle", 0);
-	if (!phy_node && of_phy_is_fixed_link(priv->of_node)) {
+	if (!phy_node && of_phy_is_fixed_link(priv->of_node))
 		phy_node = of_node_get(priv->of_node);
-	}
 	if (!phy_node)
 		goto no_phy;
 
-- 
2.29.2

