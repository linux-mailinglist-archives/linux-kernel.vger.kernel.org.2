Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 244993E0A1A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 23:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234103AbhHDVoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 17:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233725AbhHDVoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 17:44:00 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B04FBC06179B
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 14:43:46 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id f1-20020a05621400c1b029034431fe48d1so859257qvs.15
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 14:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Rynpga3J+xjZzUqZXpOXfkfOoHAVyRGf/PRkioLCwmY=;
        b=B8/MlBGQclT50fb7n0ieBcTHQoZD+gRQ/u345in6OYabDUyr30L+tBW1j2xiCfNLr7
         a1C8CtX5vMQRm7x1CDvBkHnR7zdve2JnoVx+Z7xbdcxfV8yk3pWdXvh+j8UYSWjpIiG6
         rQTgFQZx6M0HcZUL+vGBw04INfBrgmBHJ2l9jkRxNUionVIyWBvYuy2oGjIubI+Tp0Yo
         XGhjEY7KB+c3EYjb5InTMJ/2ppIb+GcWeznUvm2v3ZPxxskJbztyZsN3GfzDLyk9Mh31
         WWLv+LGc6qcqeKBXZiBeJ7l+m+i/DGhYActbYEasEVcdsi3dwW04HAEC2deDco3mysZ3
         YMOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Rynpga3J+xjZzUqZXpOXfkfOoHAVyRGf/PRkioLCwmY=;
        b=op0HboSo/6916jjSIOkiQ9N+K7ubleQdPBRGFgtP7Z8wh4sjMEN1CHZmZZPggy0LIn
         VB7+lrLCuvz5JYJA1/2HtKMmPnelif/ybgylvyqRsAXT/ApOfDd4yh3YkkUIkw6JqOuz
         a4BycusJZ5KMvC7jZPMWR2NmyWuZBhOkCIkOuVYYFBkG7qT+v8v2ZnV0VbiAoOPE5Jfi
         C1vqOXkvqGZGB3MensUn8IWe6+eeUx3EbhEn0UmrAUjHrPRgmW2Xi9hpk0mqDV6tXi5e
         uU1fyIYkN2OgIWtd/WZLkS3QcQygFrdLPHgCnEerFG1J0xrllyRetif2E7Lw34GdyW6J
         NTHQ==
X-Gm-Message-State: AOAM531yF37eBjKI+f0IyFM1f2/KjBRhjq7ajutf3ToKQwEs0FQ06AAB
        bsgWXCPohmn+BA64exhZ4XzYYmre0goU+eM=
X-Google-Smtp-Source: ABdhPJzlOYEDH8yob9gAEtyiJ+2bW8yWLnsn+Oa2Ym13tfciy/2gVuwXNkqzQileftC8X7uEAeOaOlgtP57eeUw=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:ffe5:1245:526e:3189])
 (user=saravanak job=sendgmr) by 2002:ad4:40cb:: with SMTP id
 x11mr1616861qvp.60.1628113425608; Wed, 04 Aug 2021 14:43:45 -0700 (PDT)
Date:   Wed,  4 Aug 2021 14:43:32 -0700
In-Reply-To: <20210804214333.927985-1-saravanak@google.com>
Message-Id: <20210804214333.927985-4-saravanak@google.com>
Mime-Version: 1.0
References: <20210804214333.927985-1-saravanak@google.com>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [PATCH v1 3/3] net: mdio-mux: Handle -EPROBE_DEFER correctly
From:   Saravana Kannan <saravanak@google.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
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

Link: https://lore.kernel.org/lkml/CAGETcx95kHrv8wA-O+-JtfH7H9biJEGJtijuPVN0V5dUKUAB3A@mail.gmail.com/#t
Signed-off-by: Saravana Kannan <saravanak@google.com>
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
2.32.0.554.ge1b32706d8-goog

