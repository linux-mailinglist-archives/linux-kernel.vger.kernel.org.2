Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 713AF30508E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 05:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238398AbhA0EN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 23:13:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238243AbhA0EJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 23:09:44 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66F8C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 20:09:03 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id c13so1064985ybg.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 20:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=/NFozpI8ZbWwzRiGUBVcpbxoLur7ok4y0yyNaLYcumw=;
        b=Li+8q1/gaF5amm8CoyhzDjvW/Pl5jRGy8lpG5kJ0u6HESxuskQOSzgOi+sbdB4GwIA
         fqSyll1awe+3ZNfon1cXinDQNWFygpzRq6QmChIy4kkaUwvIXGqYhFKo//wiPe+oNBA9
         49em6YWQK2v0Bb7pZCfPzP6ZNyq5N/x+1ncL7GLYOR9MZpUsUazfvaIZxfGKC8IpTx4F
         TGjNQqyRVWO9gv5q2v44opfbfNy6dbhfpi6+AWuxeRJTZMB5dxHsJRpGj5TKU96+ffeT
         3/haVcouLdC4VU0seOF4gVXFZrz1sSjFXSSjgvEKy41x3Em1peIVKXE1fpJkpesW0Gp3
         lLAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=/NFozpI8ZbWwzRiGUBVcpbxoLur7ok4y0yyNaLYcumw=;
        b=Sz5HwqIii0FpLDqiwERJc/ewKZgWoFggT3n9An9D0WC7hJM8d81kphPb1JSKmW5vTj
         DCBcbRhtOSbLN7m5djpln69EJvVZ9IFYLAAZjwo/UQfywrmMgykcsRoOqwajyQB3f38F
         WZl8W4A9qw5BjWtCqvEgVLL2jzEmWFkQtG0IHGHkT/vgpF8JO/xHbMo47KE6SxoPjxPy
         jXE06rxijmYsJze2WmCFUR3EvieV0Lb9oexJWPyLkpLqt4rhQP0HfoLMLnte7o2WlGn4
         /Zx9Qq0nCBs5FeUxXCCmJ+FmFt7yfIfbQk3jG3UDy+DatwfMCk9A484fHAbOvjqc/8xn
         14Cg==
X-Gm-Message-State: AOAM530TZMVWZwR7nsDw8vxa+GZjHoh+rXo9jufjIvGj74ryqDOdCJ2x
        mEF8LyTpXRx6HqS124GEMDqzeZrHmdi1Aw==
X-Google-Smtp-Source: ABdhPJyrgWDt/A/kkQL9NBTPoU3UjkmaFq1Tbo0yECsvcrcuafexRiuwO9ZJfstVallP4bGH8Ka7E2FzQoqlNQ==
Sender: "davidgow via sendgmr" <davidgow@spirogrip.svl.corp.google.com>
X-Received: from spirogrip.svl.corp.google.com ([2620:15c:2cb:201:7000:2f04:a262:7158])
 (user=davidgow job=sendgmr) by 2002:a25:6ed7:: with SMTP id
 j206mr12923711ybc.312.1611720542946; Tue, 26 Jan 2021 20:09:02 -0800 (PST)
Date:   Tue, 26 Jan 2021 20:06:37 -0800
Message-Id: <20210127040636.1535722-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: [PATCH] i3c/master/mipi-i3c-hci: Specify HAS_IOMEM dependency
From:   David Gow <davidgow@google.com>
To:     Nicolas Pitre <npitre@baylibre.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
Cc:     David Gow <davidgow@google.com>, linux-i3c@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MIPI i3c HCI driver makes use of IOMEM functions like
devm_platform_ioremap_resource(), which are only available if
CONFIG_HAS_IOMEM is defined.

This causes the driver to be enabled under make ARCH=um allyesconfig,
even though it won't build.

By adding a dependency on HAS_IOMEM, the driver will not be enabled on
architectures which don't support it.

Fixes: 9ad9a52cce28 ("i3c/master: introduce the mipi-i3c-hci driver")
Signed-off-by: David Gow <davidgow@google.com>
---
 drivers/i3c/master/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i3c/master/Kconfig b/drivers/i3c/master/Kconfig
index e68f15f4b4d0..afff0e2320f7 100644
--- a/drivers/i3c/master/Kconfig
+++ b/drivers/i3c/master/Kconfig
@@ -25,6 +25,7 @@ config DW_I3C_MASTER
 config MIPI_I3C_HCI
 	tristate "MIPI I3C Host Controller Interface driver (EXPERIMENTAL)"
 	depends on I3C
+	depends on HAS_IOMEM
 	help
 	  Support for hardware following the MIPI Aliance's I3C Host Controller
 	  Interface specification.
-- 
2.30.0.280.ga3ce27912f-goog

