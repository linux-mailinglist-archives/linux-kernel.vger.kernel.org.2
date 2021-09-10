Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20DE740650B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 03:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238892AbhIJBXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 21:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233389AbhIJBXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 21:23:07 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA94C0613BC
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 18:14:57 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id f8-20020a2585480000b02905937897e3daso347253ybn.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 18:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=85stIuvqC7qXvT5OV0bxpCSRV3islXlTG8FuUpmB6wU=;
        b=nPp1DZY5v8HPhBDJ8jyynRo0qkVY4WIpV/P2Z4KrAH+CXnr+lJO+uYbYGSMnNsuFH0
         1hCEfbFVCkaBdzRO/ZMU1H+jW59xthzaQ2XaSIT+pbM/nhPjkSiQorLtd+RxgzMYK1P2
         Ch1Dn6ZXH1PsY7OGl293RP8ACT3dlLcEOpziT0xI3N1+R8m8Ghzm722s1qxmPgZEOvjn
         iqFc3tBiKqUUw6+lEm6ZHHyUVl6Ntpp1ss1hrYBsldFVV+JhACJuz0zkNtqps5QsUVuz
         XIG9qvbJk6nar/cnBNhzNnFqgHtz18SdPSBjLZ/eYu6pdyEOrFPCja/0m4ZNsu2BKRNg
         FUWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=85stIuvqC7qXvT5OV0bxpCSRV3islXlTG8FuUpmB6wU=;
        b=j8rbiic1b0r7+gs9pZLrKsAuhDbu8mN/S0uof5WT05jQSwCAYYbqZYVx8xMnDH/P4Z
         Qp4FyTmoEgIO1QQKIgiNIsD6ifR8WPDrVuKzVxuif4YMnOuGaDb8F/lSwXQdICrBXle2
         UpxxrAQ5Ozhg/lD2P/Xjq+/e/FxTrd08giy4WBFAZdcRmtk/+H4R81kap+Ys6jcd6V5p
         rgLl04AN6vZj1SvZ5Kmfbz2bUUrvu0Qq8aFLyBT5fsWXP1/vXkigbwrifeC1OmVnBYWp
         JO4Fh0yrVPeTzyqlLyNe81NHZnVm0kyHfdwEdXwG4qz0W/SsOnsVmxlID0ro1XieyC+t
         lXGw==
X-Gm-Message-State: AOAM531LdQUAhBmTz2NvGe7p2SmXxpdqQpc2FrEWvW9fq9hva46yymg9
        CaNXiDeis/Q6xkB58Pe6VkdtTcjX82vHUfs=
X-Google-Smtp-Source: ABdhPJzz94EF6js4TQNESTU8ocFK+QyflQuccilOIE6oq/6PZh3SN0Dg+hA+CzGTYuc99t12ZwOKjZ7ruFbm42Q=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:dada:6772:417c:a317])
 (user=saravanak job=sendgmr) by 2002:a05:6902:102f:: with SMTP id
 x15mr7805359ybt.81.1631236497165; Thu, 09 Sep 2021 18:14:57 -0700 (PDT)
Date:   Thu,  9 Sep 2021 18:14:45 -0700
Message-Id: <20210910011446.3208894-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH] of: property: Disable fw_devlink DT support for X86
From:   Saravana Kannan <saravanak@google.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>
Cc:     Andre Muller <andre.muller@web.de>, kernel-team@android.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andre reported fw_devlink=on breaking OLPC XO-1.5 [1].

OLPC XO-1.5 is an X86 system that uses a mix of ACPI and OF to populate
devices. The root cause seems to be ISA devices not setting their fwnode
field. But trying to figure out how to fix that doesn't seem worth the
trouble because the OLPC devicetree is very sparse/limited and fw_devlink
only adds the links causing this issue. Considering that there aren't many
users of OF in an X86 system, simply fw_devlink DT support for X86.

[1] - https://lore.kernel.org/lkml/3c1f2473-92ad-bfc4-258e-a5a08ad73dd0@web.de/
Fixes: ea718c699055 ("Revert "Revert "driver core: Set fw_devlink=on by default""")
Signed-off-by: Saravana Kannan <saravanak@google.com>
Cc: Andre Muller <andre.muller@web.de>
---
 drivers/of/property.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 0c0dc2e369c0..3fd74bb34819 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1444,6 +1444,9 @@ static int of_fwnode_add_links(struct fwnode_handle *fwnode)
 	struct property *p;
 	struct device_node *con_np = to_of_node(fwnode);
 
+	if (IS_ENABLED(CONFIG_X86))
+		return 0;
+
 	if (!con_np)
 		return -EINVAL;
 
-- 
2.33.0.309.g3052b89438-goog

