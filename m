Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF54E31453E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 02:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbhBIBFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 20:05:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbhBIBFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 20:05:23 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D90C06178B
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 17:04:42 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id u17so2248894ybi.10
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 17:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=+ejAYf6RFze/7mcFs9laQRj3JeOW5TThaToa2ePllHE=;
        b=uQGyN9/uid6kEc344dGUHhufvU0FWp5osHTigoBHyDdlIS+lEBdRvBqA/Wi+Qh3J99
         0rdO4rRhdmz0LHEaus2oo3yrxPRMaq8q4W5sFb20ajRSOmS0Fg7l04MCIgBbbX2CztqN
         GYuIUPpmg8plcfSJ48KTZTzwq9Tl85LJpYoJdmuRXy0ZvTKFFSQBudtoF2YkRpbotgTG
         fQwTaTPosMEWYTf9A0ahy0bKg5KawUoodNeO9AJJlRZO48zwP84phpyvtf7XHFfQCSbH
         X8MVLQX6AVY/5a+Jfz0JINKFMb43lLP1Jgr/zXKeWFn1Y3bxQPdXtzydEgRaL0kcIaBt
         OV8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=+ejAYf6RFze/7mcFs9laQRj3JeOW5TThaToa2ePllHE=;
        b=p+NKUkKSTHDcm1Ik0qH5Lq7A7JjDRcC3kTNqHQE9ysKZ4kKkYQ7DGpPR1p44y4UaNI
         ohEDfV8/QHmTac+BeUoegMmE8x4Y71+Ql6duymKTFM02CJJOzBAt9IEYfyB61Z/uuWDp
         GCQWIG4OxdEg7jxHS//ZlKl8XHAkqD7z9up0uJhPcNSz/K4U5mYp1AoY2wq0rXVg+aBY
         U4mt151G9koi1ln6/Ycs3Izu9zIrtqzoH1i0ukKeRXWW/cFCl8Uv87kBHsiTb/Pbbpey
         9ds0H8j5prT9rOOfdbMQOUMxfptijnQPd4pwetoYnagmLOo0hP+cP9RUM4hSWO2CBYyl
         ymIQ==
X-Gm-Message-State: AOAM530seVHAni3RkZXdNe8eEbvE0zqSxUmuv/rxSGyyOcB34dqFilqh
        l8FCra9FSWZJJ0IFW6mZj7yvxO1FCdWdqTE=
X-Google-Smtp-Source: ABdhPJxC1JuXNwRRIWi0N8wFznbmeW788ZV3yjK+VcE9zY/ARsRMO1bJrgMpvf7GgY9Q/BjPTM7IPCLBjGFnJx4=
Sender: "saravanak via sendgmr" <saravanak@saravanak.san.corp.google.com>
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:d2a:da02:d812:71f7])
 (user=saravanak job=sendgmr) by 2002:a05:6902:1025:: with SMTP id
 x5mr28936258ybt.493.1612832682139; Mon, 08 Feb 2021 17:04:42 -0800 (PST)
Date:   Mon,  8 Feb 2021 17:04:38 -0800
Message-Id: <20210209010439.3529036-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH] of: property: Fix fw_devlink handling of interrupts/interrupts-extended
From:   Saravana Kannan <saravanak@google.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Saravana Kannan <saravanak@google.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <treding@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        kernel-team@android.com, Rob Herring <robh@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 4104ca776ba3 ("of: property: Add fw_devlink support for interrupts")
was not taking interrupt-map into account. Fix that.

Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Fixes: 4104ca776ba3 ("of: property: Add fw_devlink support for interrupts")
Signed-off-by: Saravana Kannan <saravanak@google.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
Greg,

This needs to go into driver-core as the "Fixes" commit is only in
driver-core if I'm not mistaken.

-Saravana

 drivers/of/property.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 962109082df1..79b68519fe30 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1248,8 +1248,6 @@ DEFINE_SIMPLE_PROP(dmas, "dmas", "#dma-cells")
 DEFINE_SIMPLE_PROP(power_domains, "power-domains", "#power-domain-cells")
 DEFINE_SIMPLE_PROP(hwlocks, "hwlocks", "#hwlock-cells")
 DEFINE_SIMPLE_PROP(extcon, "extcon", NULL)
-DEFINE_SIMPLE_PROP(interrupts_extended, "interrupts-extended",
-					"#interrupt-cells")
 DEFINE_SIMPLE_PROP(nvmem_cells, "nvmem-cells", NULL)
 DEFINE_SIMPLE_PROP(phys, "phys", "#phy-cells")
 DEFINE_SIMPLE_PROP(wakeup_parent, "wakeup-parent", NULL)
@@ -1300,10 +1298,13 @@ static struct device_node *parse_gpio_compat(struct device_node *np,
 static struct device_node *parse_interrupts(struct device_node *np,
 					    const char *prop_name, int index)
 {
-	if (strcmp(prop_name, "interrupts") || index)
+	struct of_phandle_args sup_args;
+
+	if (strcmp(prop_name, "interrupts") &&
+	    strcmp(prop_name, "interrupts-extended"))
 		return NULL;
 
-	return of_irq_find_parent(np);
+	return of_irq_parse_one(np, index, &sup_args) ? NULL : sup_args.np;
 }
 
 static const struct supplier_bindings of_supplier_bindings[] = {
@@ -1318,7 +1319,6 @@ static const struct supplier_bindings of_supplier_bindings[] = {
 	{ .parse_prop = parse_power_domains, },
 	{ .parse_prop = parse_hwlocks, },
 	{ .parse_prop = parse_extcon, },
-	{ .parse_prop = parse_interrupts_extended, },
 	{ .parse_prop = parse_nvmem_cells, },
 	{ .parse_prop = parse_phys, },
 	{ .parse_prop = parse_wakeup_parent, },
-- 
2.30.0.478.g8a0d178c01-goog

