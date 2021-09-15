Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE90540C176
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 10:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237315AbhIOINt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 04:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237075AbhIOINV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 04:13:21 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7589AC0613E5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 01:12:00 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id b8-20020a0562141148b02902f1474ce8b7so2626740qvt.20
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 01:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=RwmF1eG4qjehbM/6vPHudaKlp5QMZAj0EjDeZYR+hmQ=;
        b=lisrCW1FhYgFf8tDVaJoILHzDIzWOAS5LqcKP0JGtTYPEKmraA3n3o4QQJNAhwl4/4
         TKKR9DPQyLJ+kZ+nQVA5aF0oHoCDT1mORXCa+VYPIIXBaK53fZDs3wSXIpuCpM4HtEHd
         b/iAKZelL/EgjCvxZmEGTurk1lK6922v21LbUJ7JxgYlexfobGlx8iZtIOyAVx9pyLqc
         QoK/xekl9Y57N7unuQldMOQfk+G87n32xwKcmHW32zh2RgOIGp313Kq5TsYpXT1+rwvt
         2+9hEwDzGoaW2+9sGVLIWufrkLfBncwA57Rvmmv5Nfz9ops1bM9sDFOdfaWw3keCzCk/
         ZRgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RwmF1eG4qjehbM/6vPHudaKlp5QMZAj0EjDeZYR+hmQ=;
        b=fHRSukvqqLvdlmLQORw2yXC+0dvu/NRnAp/pCM/f64lurmw9NwwFP1wIXp5aCqwmG1
         avM6ADmDXbXYH3ZxXcjfwWywTc0C8VCCsVMw3l/H/TN8hdym4EGpMjvXrqkBRGnvxBnL
         RZwPIB6IgBaLhqEnHRxxY7r/m3NxbaajOWxOmD8jWIqxP4QVlDHBgDJk6zzNR9TG7mys
         qIS6inAUx07Db9I55U6X6avp0XLw6oSdzL4b7VIf0PAh80Afhhu3TQ1x/BP9LHGwU8+6
         dbM8RbTwyQpQe/xBKeNXj1oyHh9NgkHCEU2PHr9Pcn+MzWwibrrhNX1KZWtjlyE9FD8F
         d65w==
X-Gm-Message-State: AOAM531rVHCltjKQiImMmfGkEa3ZIt2VYAYWmlNmuNNEFVjSf35GjH1d
        SaIb5RvCRgn68fJyXNZ/tEhVYkNr2enVuKc=
X-Google-Smtp-Source: ABdhPJzcVHO3Ms5A0jhHL8HrSgC/BPW06xlc2sD9lu2NhNaF2NYgAvjFpvJKh45oFc+yH+l3aOMriFQ5YfmnYCc=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:16d1:ab0e:fc4a:b9b1])
 (user=saravanak job=sendgmr) by 2002:a0c:d6cd:: with SMTP id
 l13mr9444170qvi.24.1631693519655; Wed, 15 Sep 2021 01:11:59 -0700 (PDT)
Date:   Wed, 15 Sep 2021 01:11:38 -0700
In-Reply-To: <20210915081139.480263-1-saravanak@google.com>
Message-Id: <20210915081139.480263-7-saravanak@google.com>
Mime-Version: 1.0
References: <20210915081139.480263-1-saravanak@google.com>
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH v2 6/6] net: mdiobus: Set FWNODE_FLAG_NEEDS_CHILD_BOUND_ON_ADD
 for mdiobus parents
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Len Brown <lenb@kernel.org>,
        Saravana Kannan <saravanak@google.com>
Cc:     John Stultz <john.stultz@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Vladimir Oltean <olteanv@gmail.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are many instances of PHYs that depend on a switch to supply a
resource (Eg: interrupts). Switches also expects the PHYs to be probed
by their specific drivers as soon as they are added. If that doesn't
happen, then the switch would force the use of generic PHY drivers for
the PHY even if the PHY might have specific driver available.

fw_devlink=on by design can cause delayed probes of PHY. To avoid, this
we need to set the FWNODE_FLAG_NEEDS_CHILD_BOUND_ON_ADD for the switch's
fwnode before the PHYs are added. The most generic way to do this is to
set this flag for the parent of MDIO busses which is typically the
switch.

For more context:
https://lore.kernel.org/lkml/YTll0i6Rz3WAAYzs@lunn.ch/#t

Suggested-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/net/phy/mdio_bus.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index 53f034fc2ef7..ee8313a4ac71 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -525,6 +525,10 @@ int __mdiobus_register(struct mii_bus *bus, struct module *owner)
 	    NULL == bus->read || NULL == bus->write)
 		return -EINVAL;
 
+	if (bus->parent && bus->parent->of_node)
+		bus->parent->of_node->fwnode.flags |=
+					FWNODE_FLAG_NEEDS_CHILD_BOUND_ON_ADD;
+
 	BUG_ON(bus->state != MDIOBUS_ALLOCATED &&
 	       bus->state != MDIOBUS_UNREGISTERED);
 
-- 
2.33.0.309.g3052b89438-goog

