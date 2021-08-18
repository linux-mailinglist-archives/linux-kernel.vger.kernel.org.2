Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 958C13EF8C8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 05:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237588AbhHRDjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 23:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237227AbhHRDiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 23:38:50 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DC5C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 20:38:16 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id s205-20020a252cd6000000b0059449776539so1396632ybs.22
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 20:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=BEMUdr8X5Q4aL9TA7J3U2xLBZtVMZHuyJZqksg9L6+U=;
        b=r2ib7ss7DFluFVBCuF5BLjvbhbDWTq5l01Sq9U6fA1uYR58uS2GdlH2s1USJ0itLLy
         LhtOVKy1r0bSe17mRG2AaJAzPB791fm9h6RjVsAsk1js9r3FoNJdGDd8e57gQ6sEmJmt
         zuurs+QgmXUfg6mOh2VgEW7AyFTdsM5flBkvCDoFdMH1Jf0PGzzIBLmzMPAfUr85X8LY
         yVPRCD7kU/owvuh4W/8l47WHSqkQVmTmty+YifgSE73AKuAteEgwL3alhVhX53pHYneA
         N1NldWWx9K7B4h8k/n9aAW5TUXONi1KtK40+aZaYgIZeq3JjY7IZFyTVucChKUCpaCUI
         eSoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BEMUdr8X5Q4aL9TA7J3U2xLBZtVMZHuyJZqksg9L6+U=;
        b=F/qf3HqmtHLWzvx2Vq4rLqK8JS5vYvpB3879TGfQT9Lo3W74O1T+Dr5TriRh7HdFgR
         lLxOVnbDY78aokzmkvp1AbsRGOZN7iCPaxvDYrKDHo9naFrKu0nDedgqAp6ThVyKCDjy
         P/BsHgLK4TsJR/54UiiIJQuODK1GKwQl4/6qJXxC1fELjp+SlXeL8bTfXAs0ApQd9uHz
         9ty8VTjxoZKl17qHsBQkheCH50butpvpM6vQmQQ3RnbNZR0spUfFy7XRH2SdV6xwDjaW
         LIDsBCcSbNGzkNKCYVb1Qx7qC349AR7v4bzZVc0aB8kdgEsJF/qoO8KP1T1Px5f0aYIB
         z5Zg==
X-Gm-Message-State: AOAM533eQihpHSFSqSRq1Fw/v6L0AHwtMqbzF+DYvYAkn4F/H7TofgbZ
        8jFn86IW6LdmIEvXESO/7NITGFFq4x94H8w=
X-Google-Smtp-Source: ABdhPJy5LvWk3456EERDnC1tvN03sDdUbOu+LZxfyycl1yfSMIZ6x9KrYprNC1/bZPlkGy9r+vXkKJR0ze2Tbbg=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:7750:a56d:5272:72cb])
 (user=saravanak job=sendgmr) by 2002:a25:8445:: with SMTP id
 r5mr9205574ybm.20.1629257895746; Tue, 17 Aug 2021 20:38:15 -0700 (PDT)
Date:   Tue, 17 Aug 2021 20:38:03 -0700
In-Reply-To: <20210818033804.3281057-1-saravanak@google.com>
Message-Id: <20210818033804.3281057-4-saravanak@google.com>
Mime-Version: 1.0
References: <20210818033804.3281057-1-saravanak@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [PATCH net v3 3/3] net: mdio-mux: Handle -EPROBE_DEFER correctly
From:   Saravana Kannan <saravanak@google.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jon Mason <jon.mason@broadcom.com>,
        David Daney <david.daney@cavium.com>
Cc:     Saravana Kannan <saravanak@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>, kernel-team@android.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When registering mdiobus children, if we get an -EPROBE_DEFER, we shouldn't
ignore it and continue registering the rest of the mdiobus children. This
would permanently prevent the deferring child mdiobus from working instead
of reattempting it in the future. So, if a child mdiobus needs to be
reattempted in the future, defer the entire mdio-mux initialization.

This fixes the issue where PHYs sitting under the mdio-mux aren't
initialized correctly if the PHY's interrupt controller is not yet ready
when the mdio-mux is being probed. Additional context in the link below.

Fixes: 0ca2997d1452 ("netdev/of/phy: Add MDIO bus multiplexer support.")
Link: https://lore.kernel.org/lkml/CAGETcx95kHrv8wA-O+-JtfH7H9biJEGJtijuPVN0V5dUKUAB3A@mail.gmail.com/#t
Signed-off-by: Saravana Kannan <saravanak@google.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Acked-by: Marc Zyngier <maz@kernel.org>
Tested-by: Marc Zyngier <maz@kernel.org>
Acked-by: Kevin Hilman <khilman@baylibre.com>
Tested-by: Kevin Hilman <khilman@baylibre.com>
---
 drivers/net/mdio/mdio-mux.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/mdio/mdio-mux.c b/drivers/net/mdio/mdio-mux.c
index 13035e2685c4..ebd001f0eece 100644
--- a/drivers/net/mdio/mdio-mux.c
+++ b/drivers/net/mdio/mdio-mux.c
@@ -175,11 +175,15 @@ int mdio_mux_init(struct device *dev,
 		cb->mii_bus->write = mdio_mux_write;
 		r = of_mdiobus_register(cb->mii_bus, child_bus_node);
 		if (r) {
+			mdiobus_free(cb->mii_bus);
+			if (r == -EPROBE_DEFER) {
+				ret_val = r;
+				goto err_loop;
+			}
+			devm_kfree(dev, cb);
 			dev_err(dev,
 				"Error: Failed to register MDIO bus for child %pOF\n",
 				child_bus_node);
-			mdiobus_free(cb->mii_bus);
-			devm_kfree(dev, cb);
 		} else {
 			cb->next = pb->children;
 			pb->children = cb;
-- 
2.33.0.rc1.237.g0d66db33f3-goog

