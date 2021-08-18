Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E89A43EF8C5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 05:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237493AbhHRDiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 23:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237452AbhHRDiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 23:38:50 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05FAC061292
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 20:38:13 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id v28-20020a05622a189cb029028e697f617dso299173qtc.20
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 20:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Z8jWWiX4DhgVhOx/FpYGNqyD5gAw2uVwB7qHhHnh+No=;
        b=ZpXfV/MkOoWz6e+tfXgQTfWRznzuhl5Cof4A3DqeaM8wpMxTPBFdLOCoYfuM74+oiM
         6TXqk1Td9hDqhiC4xBShscIoNou+F8eLCovLU9OtKc4xX2kHVOJ8WNMuHyJbycz0sFGG
         kgROvvGTzZxOkONoDccmGrB95osNl0TEwy5j5HcF4x3pFT7FbUjN/xMMI7qMx/dCKKDb
         rtE2xp9IFIVCMO0pmXxoWHCFBXRP0oqOc/MT0Weo2wjnixFVWLrKB09HlhnpMWG5p6Hl
         DxAtVryLE9fZvyHsyXBCIy/19KhkDAtuWF2Bpi/hxdxxbPlgHRSqlW+Us26ZJiGqHOXN
         mtwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Z8jWWiX4DhgVhOx/FpYGNqyD5gAw2uVwB7qHhHnh+No=;
        b=IWNp/HasWPSXpbuy5K3VHPFVLRwLwe/mG+qcSQjSq55cDCDmZyQvZadPngQ7BaPDNt
         LWf+VSSSGA3fGZTTSt20nZAfpepv1PtzigQCrEjO3+xEArvBitkUAo7R+nmRD0rFcbe8
         Ye2REvrjLBMP6aFoS81Y2IeRkW9cBrX0WNZVBCcWIC8cQLtIOSbQXxEgfcOcy9fkpU30
         5VpmgZyCs18k6NAv+gLHnSVPV2U+oI4MwhrXfw7NdrFbK28p+vXfj0jTWl0VEFF9loWz
         IG/RlMV7yvY90yl8GVE9049xMuZhBGSFwbXA3o+guvnb42vtdX1Saka2MEtmeWNfTHzw
         9kwQ==
X-Gm-Message-State: AOAM533LKQxBzw2t1Uh6CYdMez1QyLMRcwdhxVaJm/cYSnVC9s45GV/z
        oPyb5mL0dVlrmpU9n8lfyVoB3w6v+w19qDE=
X-Google-Smtp-Source: ABdhPJw3ByNKRDHvyWuMU52Rv67EN6GkdTZb25WMpKu9IUANHNxuCTaRkpYFIOo/BjRIkWHo7kLla9nbzH3i0PI=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:7750:a56d:5272:72cb])
 (user=saravanak job=sendgmr) by 2002:ad4:51c7:: with SMTP id
 p7mr6974858qvq.15.1629257892937; Tue, 17 Aug 2021 20:38:12 -0700 (PDT)
Date:   Tue, 17 Aug 2021 20:38:02 -0700
In-Reply-To: <20210818033804.3281057-1-saravanak@google.com>
Message-Id: <20210818033804.3281057-3-saravanak@google.com>
Mime-Version: 1.0
References: <20210818033804.3281057-1-saravanak@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [PATCH net v3 2/3] net: mdio-mux: Don't ignore memory allocation errors
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

If we are seeing memory allocation errors, don't try to continue
registering child mdiobus devices. It's unlikely they'll succeed.

Fixes: 342fa1964439 ("mdio: mux: make child bus walking more permissive and errors more verbose")
Signed-off-by: Saravana Kannan <saravanak@google.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Acked-by: Marc Zyngier <maz@kernel.org>
Tested-by: Marc Zyngier <maz@kernel.org>
Acked-by: Kevin Hilman <khilman@baylibre.com>
Tested-by: Kevin Hilman <khilman@baylibre.com>
---
 drivers/net/mdio/mdio-mux.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/net/mdio/mdio-mux.c b/drivers/net/mdio/mdio-mux.c
index 5b37284f54d6..13035e2685c4 100644
--- a/drivers/net/mdio/mdio-mux.c
+++ b/drivers/net/mdio/mdio-mux.c
@@ -82,6 +82,17 @@ static int mdio_mux_write(struct mii_bus *bus, int phy_id,
 
 static int parent_count;
 
+static void mdio_mux_uninit_children(struct mdio_mux_parent_bus *pb)
+{
+	struct mdio_mux_child_bus *cb = pb->children;
+
+	while (cb) {
+		mdiobus_unregister(cb->mii_bus);
+		mdiobus_free(cb->mii_bus);
+		cb = cb->next;
+	}
+}
+
 int mdio_mux_init(struct device *dev,
 		  struct device_node *mux_node,
 		  int (*switch_fn)(int cur, int desired, void *data),
@@ -144,7 +155,7 @@ int mdio_mux_init(struct device *dev,
 		cb = devm_kzalloc(dev, sizeof(*cb), GFP_KERNEL);
 		if (!cb) {
 			ret_val = -ENOMEM;
-			continue;
+			goto err_loop;
 		}
 		cb->bus_number = v;
 		cb->parent = pb;
@@ -152,8 +163,7 @@ int mdio_mux_init(struct device *dev,
 		cb->mii_bus = mdiobus_alloc();
 		if (!cb->mii_bus) {
 			ret_val = -ENOMEM;
-			devm_kfree(dev, cb);
-			continue;
+			goto err_loop;
 		}
 		cb->mii_bus->priv = cb;
 
@@ -181,6 +191,10 @@ int mdio_mux_init(struct device *dev,
 	}
 
 	dev_err(dev, "Error: No acceptable child buses found\n");
+
+err_loop:
+	mdio_mux_uninit_children(pb);
+	of_node_put(child_bus_node);
 err_pb_kz:
 	put_device(&parent_bus->dev);
 err_parent_bus:
@@ -192,14 +206,8 @@ EXPORT_SYMBOL_GPL(mdio_mux_init);
 void mdio_mux_uninit(void *mux_handle)
 {
 	struct mdio_mux_parent_bus *pb = mux_handle;
-	struct mdio_mux_child_bus *cb = pb->children;
-
-	while (cb) {
-		mdiobus_unregister(cb->mii_bus);
-		mdiobus_free(cb->mii_bus);
-		cb = cb->next;
-	}
 
+	mdio_mux_uninit_children(pb);
 	put_device(&pb->mii_bus->dev);
 }
 EXPORT_SYMBOL_GPL(mdio_mux_uninit);
-- 
2.33.0.rc1.237.g0d66db33f3-goog

