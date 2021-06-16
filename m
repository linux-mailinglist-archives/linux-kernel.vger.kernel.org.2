Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8190F3AA3E8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 21:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbhFPTKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 15:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232353AbhFPTKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 15:10:31 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23CF6C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 12:08:25 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id l15so1076280lje.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 12:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XwPUFmwMt+6ig9pUm7xR69UTaqxBREF6Kd62jKc8yaI=;
        b=BQ/amQy84n8KucLrbcdyONyn+4G87+J4dUfVzAJ6jeeaJgjg4ZS+ZqfenzMUM30yyf
         UW0UHQ7kUanjquaLOkRatvcA80WtEgRgEUhyfDOq/i2mA9wtTNFn0ygei5CZFmrbIFZn
         jhbkXZ0npg6uSRCMVSGmKXla4WTOoFIH8UhKrirZ8O4zHGgmKE1ofJ731vCH3quovrQv
         3zhV1MExunmSNNf+3jZVbNb7azAGfZqdd6epMgZkhsbLpAaOJP2g9UqB5REApYokuqJS
         CivELkyiZp+od2aVig+dWQG5DDdiunOcwLfPr4F2qpEdMLp7V+d7qvaodUC3+o8dbVIy
         LGaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XwPUFmwMt+6ig9pUm7xR69UTaqxBREF6Kd62jKc8yaI=;
        b=BB/n/IdiyAzPAkPLf9oOsmmq7NvbydZh00vXx/tiGZci/7lP/hgqicbQ9HGwYEiFHa
         icq4nhB167YB/DBRqF8J6+MCOM5G2Z07Q3I+w9MBKPSu/UbVLLXaFx0sATIHjMR83ISS
         YIZb0+EH9jqvXpyUMcY5TcFDgV4BQv5PQXUn7L8N1GYtqWkl1RAqrN4rn78nyRHa8sua
         zaj/34qJ6uV6xZDxXmqDl1hA2Y8/jM+RSb/6pKi41EL2JPomJN7t/hOHG5EOY3CW45Wg
         P7a2djJ6Dz4enIx+2LAm6P+lUsw92tkSicYiPMWTWwbJx/nZqi1sm5xciUEBuBPt1EjA
         l/1g==
X-Gm-Message-State: AOAM531f6NDZK2nos4ejrL0D/OzVamEYwLMA/3r0xBa+bIoMp+dw/iht
        JX8e0HnNH6nPlHH6V3M6ldORJBPRs69wlQ==
X-Google-Smtp-Source: ABdhPJwym4wWzJVyfPCnct1qQl1FU7ernZ+6b1Nh1rWn8VG2YsSMO14y5o9x58hC3nYas6XlXAUJVg==
X-Received: by 2002:a2e:a583:: with SMTP id m3mr1161671ljp.305.1623870502441;
        Wed, 16 Jun 2021 12:08:22 -0700 (PDT)
Received: from gilgamesh.lab.semihalf.net ([83.142.187.85])
        by smtp.gmail.com with ESMTPSA id h22sm406939ljl.126.2021.06.16.12.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 12:08:21 -0700 (PDT)
From:   Marcin Wojtas <mw@semihalf.com>
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux@armlinux.org.uk,
        jaz@semihalf.com, gjb@semihalf.com, upstream@semihalf.com,
        Samer.El-Haj-Mahmoud@arm.com, jon@solid-run.com, tn@semihalf.com,
        rjw@rjwysocki.net, lenb@kernel.org, Marcin Wojtas <mw@semihalf.com>
Subject: [net-next: PATCH v2 2/7] net: mdiobus: Introduce fwnode_mdbiobus_register()
Date:   Wed, 16 Jun 2021 21:07:54 +0200
Message-Id: <20210616190759.2832033-3-mw@semihalf.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210616190759.2832033-1-mw@semihalf.com>
References: <20210616190759.2832033-1-mw@semihalf.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces a new helper function that
wraps acpi_/of_ mdiobus_register() and allows its
usage via common fwnode_ interface.

Fall back to raw mdiobus_register() in case CONFIG_FWNODE_MDIO
is not enabled, in order to satisfy compatibility
in all future user drivers.

Signed-off-by: Marcin Wojtas <mw@semihalf.com>
---
 include/linux/fwnode_mdio.h    | 12 +++++++++++
 drivers/net/mdio/fwnode_mdio.c | 22 ++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/include/linux/fwnode_mdio.h b/include/linux/fwnode_mdio.h
index faf603c48c86..13d4ae8fee0a 100644
--- a/include/linux/fwnode_mdio.h
+++ b/include/linux/fwnode_mdio.h
@@ -16,6 +16,7 @@ int fwnode_mdiobus_phy_device_register(struct mii_bus *mdio,
 int fwnode_mdiobus_register_phy(struct mii_bus *bus,
 				struct fwnode_handle *child, u32 addr);
 
+int fwnode_mdiobus_register(struct mii_bus *bus, struct fwnode_handle *fwnode);
 #else /* CONFIG_FWNODE_MDIO */
 int fwnode_mdiobus_phy_device_register(struct mii_bus *mdio,
 				       struct phy_device *phy,
@@ -30,6 +31,17 @@ static inline int fwnode_mdiobus_register_phy(struct mii_bus *bus,
 {
 	return -EINVAL;
 }
+
+static inline int fwnode_mdiobus_register(struct mii_bus *bus,
+					  struct fwnode_handle *fwnode)
+{
+	/*
+	 * Fall back to mdiobus_register() function to register a bus.
+	 * This way, we don't have to keep compat bits around in drivers.
+	 */
+
+	return mdiobus_register(mdio);
+}
 #endif
 
 #endif /* __LINUX_FWNODE_MDIO_H */
diff --git a/drivers/net/mdio/fwnode_mdio.c b/drivers/net/mdio/fwnode_mdio.c
index e96766da8de4..b6576af89fa1 100644
--- a/drivers/net/mdio/fwnode_mdio.c
+++ b/drivers/net/mdio/fwnode_mdio.c
@@ -7,8 +7,10 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/acpi_mdio.h>
 #include <linux/fwnode_mdio.h>
 #include <linux/of.h>
+#include <linux/of_mdio.h>
 #include <linux/phy.h>
 
 MODULE_AUTHOR("Calvin Johnson <calvin.johnson@oss.nxp.com>");
@@ -142,3 +144,23 @@ int fwnode_mdiobus_register_phy(struct mii_bus *bus,
 	return 0;
 }
 EXPORT_SYMBOL(fwnode_mdiobus_register_phy);
+
+/**
+ * fwnode_mdiobus_register - bring up all the PHYs on a given MDIO bus and
+ *	attach them to it.
+ * @bus: Target MDIO bus.
+ * @fwnode: Pointer to fwnode of the MDIO controller.
+ *
+ * Return values are determined accordingly to acpi_/of_ mdiobus_register()
+ * operation.
+ */
+int fwnode_mdiobus_register(struct mii_bus *bus, struct fwnode_handle *fwnode)
+{
+	if (is_acpi_node(fwnode))
+		return acpi_mdiobus_register(bus, fwnode);
+	else if (is_of_node(fwnode))
+		return of_mdiobus_register(bus, to_of_node(fwnode));
+	else
+		return -EINVAL;
+}
+EXPORT_SYMBOL(fwnode_mdiobus_register);
-- 
2.29.0

