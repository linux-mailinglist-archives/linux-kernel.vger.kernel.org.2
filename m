Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D95373FEAED
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 11:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244937AbhIBJDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 05:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244583AbhIBJDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 05:03:32 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80DC6C061757
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 02:02:34 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id f2so2254622ljn.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 02:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qZWfMSX8wMAWulFpFk0yumlnd8aLSAYEODrPThO+hW0=;
        b=ctOuK49ceAh0izIbXBGFKtYK3umKm395+zOvmxODultMDVBXDumAtSV4us9u/GtX8f
         zANgiH/F6HpXzEI54iHJz4+6o81Tqbowx0vFtPdwIbsbxurzrmN98UtGkPvwzBJ5FZ6c
         D4bf4vWVBQ0627tlmzlA58vLbGHFkFaive6GSlEgpviV1Z7EV5KUA0E34ApzxZ2rFbVN
         caeS38SXdDtGfXwxIjgy3R05Puo8i+PM065QlF082mTQuOCrfs5HhJFBaaY3jX6WR8lP
         +qKhF7Xonfed3APeeUfUusSkR3Wq/1kpbkEshbAlBfoqg9ZfG0wUSp06dXM/RyrlO1wt
         jQuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qZWfMSX8wMAWulFpFk0yumlnd8aLSAYEODrPThO+hW0=;
        b=Kwrm6nbZU3rsZk+rOkOYtybfuU0FsRhyqL+gmauMpxPgFZHshNHyCsYryOEwRF5dzH
         EAIPW94i927HgAh0jAcN1oYbrmbKFVuEr+CIKbBP2eZrNYmjkDbBtzr0AneiFUZgPteq
         64J/q/Sd7sgM+Jz9x+0M6LdOz8IUG3qY26NhUbTWMG2TjqnTb+W8SvLpiWojNGl8ILZY
         CyvCZjT8xM92zmjEdfOqm09Q3/+TpbmkBFeKPn+xjEthhJP6LtQwdf4QizJ5cukXFsaM
         RgVsvNdcQtWsAMZukYJ4s4XES8MOEYW3QVAju35O0nk1M5M1CjHSvTQvoEdFpC4Hslin
         XRTA==
X-Gm-Message-State: AOAM531pC7SUGow644yFmeO6/Apg4FciN/6k1wBVNF5fQTr0Se1G4GOX
        QlxYo6hpSmJdRZC5K4hBdly3ug==
X-Google-Smtp-Source: ABdhPJxC9FL/CE2Uc0dvquHeUzF6/9Ta3W9YEHISvKYopat1t+96pMvVAuHGdEZ6lz4F1h2PDEdjFw==
X-Received: by 2002:a2e:86ce:: with SMTP id n14mr1588757ljj.421.1630573352628;
        Thu, 02 Sep 2021 02:02:32 -0700 (PDT)
Received: from localhost.localdomain (h-155-4-129-146.NA.cust.bahnhof.se. [155.4.129.146])
        by smtp.gmail.com with ESMTPSA id t12sm137590lfg.151.2021.09.02.02.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 02:02:31 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Saravana Kannan <saravanak@google.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] of: property: fw_devlink: Fixup behaviour when 'node_not_dev' is set
Date:   Thu,  2 Sep 2021 11:02:21 +0200
Message-Id: <20210902090221.820254-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the struct supplier_bindings the member 'node_not_dev' is described as
"The consumer node containing the property is never a device.", but that is
inconsistent with the behaviour of the code in of_link_property(), as it
calls of_get_compat_node() that starts parsing for a compatible property
from the node it gets passed to it. The proper behaviour is to start at the
node's parent, so let's do that.

While at it, let's take the opportunity to update the description of the
'node_not_dev' flag, as to clarify its purpose.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/of/property.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 6c028632f425..a94d007be416 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1075,6 +1075,17 @@ static struct device_node *of_get_compat_node(struct device_node *np)
 	return np;
 }
 
+static struct device_node *of_get_compat_node_parent(struct device_node *np)
+{
+	struct device_node *parent, *node;
+
+	parent = of_get_parent(np);
+	node = of_get_compat_node(parent);
+	of_node_put(parent);
+
+	return node;
+}
+
 /**
  * of_link_to_phandle - Add fwnode link to supplier from supplier phandle
  * @con_np: consumer device tree node
@@ -1249,7 +1260,9 @@ static struct device_node *parse_##fname(struct device_node *np,	     \
  * @parse_prop.index: For properties holding a list of phandles, this is the
  *		      index into the list
  * @optional: Describes whether a supplier is mandatory or not
- * @node_not_dev: The consumer node containing the property is never a device.
+ * @node_not_dev: The consumer node containing the property is never converted
+ *		  to a struct device. Instead, parse ancestor nodes for the
+ *		  compatible property to find a node corresponding to a device.
  *
  * Returns:
  * parse_prop() return values are
@@ -1416,7 +1429,7 @@ static int of_link_property(struct device_node *con_np, const char *prop_name)
 			struct device_node *con_dev_np;
 
 			con_dev_np = s->node_not_dev
-					? of_get_compat_node(con_np)
+					? of_get_compat_node_parent(con_np)
 					: of_node_get(con_np);
 			matched = true;
 			i++;
-- 
2.25.1

