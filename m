Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA30439293E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 10:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235250AbhE0ILI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 04:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235224AbhE0ILH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 04:11:07 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E2AC061574;
        Thu, 27 May 2021 01:09:35 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id y202so3049346pfc.6;
        Thu, 27 May 2021 01:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=4JOQDMQ5MrNkV0pXoypIfdZ9ej9lE8plMzguR7gL1n0=;
        b=fCVBdkC/hlcE+GNGGkR4uOqOIWj+8rVSVLTJgXTJHV2qwZ+yRIIrDzXGNX/E+oBTQ/
         QeGlHmeDSKFWi5mnNbzEJl9rIr1U3S8c3FWe+hGd96xHAtjoUPf5wBxNhhHDMSH93O5Z
         d4rB9fENuiiQA1KU04B3OstTXyFhqxdEEIQXJUiVfa/XBWw7vS1//Kv/dy8gXwu48vPo
         z77LhvU7RauAsplBcKfGFF5R0+R+0seL7mL+TOS1HfhWrVkLuk9r9URSLQbNbuh97o1g
         VrRyjz24EOsP4tI99J9YS5jpICtPmunCiRpVZPVL/eOKIwvOxUEMZFjcT4sOdKuTCegb
         BiZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4JOQDMQ5MrNkV0pXoypIfdZ9ej9lE8plMzguR7gL1n0=;
        b=r9SV5KyJiLk8TSdOP3X+uU/NxXDDdfoZgoILWFEY6Y8ktk26G5OmrPStDlm6XwwIbh
         FdxaTwUcYVRD8Zyxp6ticmBwKqQxs57jNXy4pLB1kep6IiFC/lWM1yZ4MphRpKAw9yYz
         4+tBJ8RngxKpmLkOGGp/F39TWW1dJghgimzUtjhY2XfYZ+ddRN4mZqVq81jQJR8d5liX
         55n+kI8Zz7jeuZCYbTO3xp9KGiqS6Ja6O5r2lmHWUFZHV8Lvnop4XI2aHMhsKPOBnKcL
         ifl4tpU3YYkgz1/O8TyfX5i3Rkxs+1TywF2iRg2Qh9xfDChJw0a2lG/6Ms8XgQvOdfJT
         hpyw==
X-Gm-Message-State: AOAM530e6Zw68bS7fVyLEzEEpEM5vQEgUhc3DSUJ4q1zs/nkwnF0GTpC
        7GvGh2RW01zCbvTn9VkV+PbUNgJLngUCBQ==
X-Google-Smtp-Source: ABdhPJyyFBddDD6f9J6DOv05HPPCjTNyeinjIAfFGt00voOAkCON8yupnyGP28ikePP0g4BCsNB3hg==
X-Received: by 2002:aa7:9438:0:b029:2df:258e:7f10 with SMTP id y24-20020aa794380000b02902df258e7f10mr2162599pfo.79.1622102975009;
        Thu, 27 May 2021 01:09:35 -0700 (PDT)
Received: from lenovo.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id t141sm1267362pfc.3.2021.05.27.01.09.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 May 2021 01:09:34 -0700 (PDT)
From:   Orson Zhai <orsonzhai@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Saravana Kannan <saravanak@google.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orson.zhai@unisoc.com>
Subject: [PATCH] of: property: Add fw_devlink support for pwms
Date:   Thu, 27 May 2021 16:09:10 +0800
Message-Id: <1622102950-31688-1-git-send-email-orsonzhai@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Orson Zhai <orson.zhai@unisoc.com>

pwms is often required by backlight in embedded devices. Add device link
support for pwms as well.

Signed-off-by: Orson Zhai <orson.zhai@unisoc.com>
---
 drivers/of/property.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 6c02863..93be977 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1287,6 +1287,7 @@ DEFINE_SIMPLE_PROP(pinctrl6, "pinctrl-6", NULL)
 DEFINE_SIMPLE_PROP(pinctrl7, "pinctrl-7", NULL)
 DEFINE_SIMPLE_PROP(pinctrl8, "pinctrl-8", NULL)
 DEFINE_SIMPLE_PROP(remote_endpoint, "remote-endpoint", NULL)
+DEFINE_SIMPLE_PROP(pwms, "pwms", NULL)
 DEFINE_SUFFIX_PROP(regulators, "-supply", NULL)
 DEFINE_SUFFIX_PROP(gpio, "-gpio", "#gpio-cells")
 
@@ -1371,6 +1372,7 @@ static const struct supplier_bindings of_supplier_bindings[] = {
 	{ .parse_prop = parse_pinctrl7, },
 	{ .parse_prop = parse_pinctrl8, },
 	{ .parse_prop = parse_remote_endpoint, .node_not_dev = true, },
+	{ .parse_prop = parse_pwms, },
 	{ .parse_prop = parse_gpio_compat, },
 	{ .parse_prop = parse_interrupts, },
 	{ .parse_prop = parse_regulators, },
-- 
2.7.4

