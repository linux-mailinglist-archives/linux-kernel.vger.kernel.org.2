Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 114BF43E196
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 15:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbhJ1NGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 09:06:53 -0400
Received: from mail-oo1-f46.google.com ([209.85.161.46]:38742 "EHLO
        mail-oo1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbhJ1NGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 09:06:52 -0400
Received: by mail-oo1-f46.google.com with SMTP id z11-20020a4a870b000000b002b883011c77so2101146ooh.5;
        Thu, 28 Oct 2021 06:04:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rh04sCxAXful7mJSlNTH3IS6uJ0MONEanjW5tEUQbgo=;
        b=b8bJtIpdlmuDlQuH7lgYngXg1G3ArcS7FOWJo4hhIiuhAuyWEiV/zRmUBhZ8qHDIt5
         kRq4mDTqXX+1T+KjBThz8ABB8ryZIsbYLa97k8f47AQNd55xOmkPRMntHdo1hDN7y+s1
         cDcx+U5A1rJu1RUUb2djLkcjGBBiLUDWyaInStTpz/Zr+qfkDfbjL2xeHhnMadNrMO6P
         a6pqi2LVHe2qZ2Yn+60t0ckBNgyzc82cflQojxLCSZQ6dmOZ0U/7He4cNMkwyqP4HVpB
         TRzHqIa7OxUswaSeBxhsUUw0jb8MQk1WCSQQdiRzx4sTFYvtWgEW//8MHvG8o3BqDK1m
         GWvg==
X-Gm-Message-State: AOAM533xXHhS8vkWeYtqZVvw+//oh+aDY7tRZP5oaOZOmpOTo1+KNF8G
        qp0Vb2gYKvJgh9oKf3I94ECu3KpUfg==
X-Google-Smtp-Source: ABdhPJyororwU0p9VmFHSj4JVyIQzHMKAXP25T49oVvAqHkP8Ovdbc8zDQ+t2U488A9WNSdKjxlxwQ==
X-Received: by 2002:a4a:ea2e:: with SMTP id y14mr2909498ood.26.1635426265232;
        Thu, 28 Oct 2021 06:04:25 -0700 (PDT)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id bl35sm1113106oib.50.2021.10.28.06.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 06:04:24 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Frank Rowand <frowand.list@gmail.com>
Subject: [PATCH v2] of/unittest: Disable new dtc node_name_vs_property_name and interrupt_map warnings
Date:   Thu, 28 Oct 2021 08:04:23 -0500
Message-Id: <20211028130423.4025578-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The unittest dtbs have various intentional errors which cause warnings.
With the latest dtc sync to v1.6.1-19-g0a3a9d3449c8, we need to disable
some new checks: node_name_vs_property_name and interrupt_map warnings.
These warnings are also generated for static_base_1.dtb, so add
DTC_FLAGS for it.

Note that the interrupt_map warnings only appear once interrupt_provider
warning is re-enabled globally.

drivers/of/unittest-data/tests-interrupts.dtsi:32.26-35.6: Warning (interrupt_map): /testcase-data/interrupts/intmap1: Missing '#address-cells' in interrupt-map provider

Fixes: e76187b9792e ("scripts/dtc: Update to upstream version v1.6.1-19-g0a3a9d3449c8")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Frank Rowand <frowand.list@gmail.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/of/unittest-data/Makefile | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/of/unittest-data/Makefile b/drivers/of/unittest-data/Makefile
index a5d2d9254b2c..fbded24c608c 100644
--- a/drivers/of/unittest-data/Makefile
+++ b/drivers/of/unittest-data/Makefile
@@ -37,7 +37,9 @@ DTC_FLAGS_overlay_base += -@
 DTC_FLAGS_testcases += -@
 
 # suppress warnings about intentional errors
-DTC_FLAGS_testcases += -Wno-interrupts_property
+DTC_FLAGS_testcases += -Wno-interrupts_property \
+	-Wno-node_name_vs_property_name \
+	-Wno-interrupt_map
 
 # Apply overlays statically with fdtoverlay.  This is a build time test that
 # the overlays can be applied successfully by fdtoverlay.  This does not
@@ -82,6 +84,10 @@ apply_static_overlay_1 := overlay_0.dtbo \
 
 apply_static_overlay_2 := overlay.dtbo
 
+DTC_FLAGS_static_base_1 += -Wno-interrupts_property \
+	-Wno-node_name_vs_property_name \
+	-Wno-interrupt_map
+
 static_test_1-dtbs := static_base_1.dtb $(apply_static_overlay_1)
 static_test_2-dtbs := static_base_2.dtb $(apply_static_overlay_2)
 
-- 
2.32.0

