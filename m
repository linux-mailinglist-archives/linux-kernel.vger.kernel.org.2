Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7C6F34D3C0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 17:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbhC2PZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 11:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbhC2PY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 11:24:56 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C63C061756
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 08:24:55 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id k8so13288745wrc.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 08:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3BjDQPO5XvHFzQtUgs6LH7ol2ep0u1eLVhg0ffmIyak=;
        b=oOA2R79rA1kOLLACi+uWoT+fQBLKYXGZc3JRMCJkJIP+tQHPQf0Qv5T+wRAhD4wamX
         bolMpKpTK2jgcViUCM0vz6FDnYp1kWJmsJNqEiTthgO2l+tlsOPxFqr9RJ3Ue67w9BwH
         wQVhxCCHBQU2R99CB2vnICWngOIOXSy10rFWu/bYAs7yAWvtMvAmg3lnqxchKO7yAxyJ
         XYONtOBI4jev+qzBFXMdEFmacG8AZLnlrQssdnYWJqgGmO1VuF+ob8dXOQOg0ZGXjpO5
         Rh0sN8Bkv1z9INJlB6zQK0GzjwJTIOp6irVE2OBCnhZ2rnes/P0LakuAzulBNs7MoB93
         PzDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3BjDQPO5XvHFzQtUgs6LH7ol2ep0u1eLVhg0ffmIyak=;
        b=nJqeGImLipvgdr9ljLs31w8Fi4+zyxMZgIOx2Mtswfj5xKXX8eqKOsxOZ0unIubPyT
         3MIi+CKvR2V24qRbQ+jmxvLKFnL18BQ9ucpJERvxLpuI7pJZsnFpWSf39mxI5vwxaQIm
         EDaUM8ouHknT3Gow4S2n9i7GP+kvwh7rk11Y6gRR+y3K85e2gDR1d9zdFDwArP76ylCh
         /n/ooTeLDGXmBWzFuBGyIdGug7LtF5se4bqVZQlnACQ0h1grkF4vzC00eHQn2MXMVSxf
         mqjO/eyP81mZzDzuFcWVgzBMKPALposciNy4uNbyC6aAxnNopE7QZXYsXw7iy59TUHNn
         Eorg==
X-Gm-Message-State: AOAM5336NkyQM/mawmuowl+uLq1yBee1eSrFL3VX150mi4aU4IbOFosA
        qu9nZsLSn9fgfwNnvWdVpT+dipuNMujpqw==
X-Google-Smtp-Source: ABdhPJxG/lWwyYQ0I+O9vaojjU0Bfa+lMEtHEufpl02r0vgN1yoOZORNV84msnRBsvubCP+4jmcu5Q==
X-Received: by 2002:a5d:6587:: with SMTP id q7mr28738296wru.282.1617031494626;
        Mon, 29 Mar 2021 08:24:54 -0700 (PDT)
Received: from dell.default ([91.110.221.217])
        by smtp.gmail.com with ESMTPSA id p17sm23744377wmd.42.2021.03.29.08.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 08:24:54 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, devicetree@vger.kernel.org
Subject: [PATCH 1/1] of: base: Fix spelling issue with function param 'prop'
Date:   Mon, 29 Mar 2021 16:24:35 +0100
Message-Id: <20210329152435.900225-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/of/base.c:1781: warning: Function parameter or member 'prop' not described in '__of_add_property'
 drivers/of/base.c:1781: warning: Excess function parameter 'prob' description in '__of_add_property'
 drivers/of/base.c:1804: warning: Function parameter or member 'prop' not described in 'of_add_property'
 drivers/of/base.c:1804: warning: Excess function parameter 'prob' description in 'of_add_property'
 drivers/of/base.c:1855: warning: Function parameter or member 'prop' not described in 'of_remove_property'
 drivers/of/base.c:1855: warning: Excess function parameter 'prob' description in 'of_remove_property'

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: devicetree@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/of/base.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 457d1ec27300b..aaf52eaa8b8c7 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1775,7 +1775,7 @@ EXPORT_SYMBOL(of_count_phandle_with_args);
 /**
  * __of_add_property - Add a property to a node without lock operations
  * @np:		Caller's Device Node
- * @prob:	Property to add
+ * @prop:	Property to add
  */
 int __of_add_property(struct device_node *np, struct property *prop)
 {
@@ -1798,7 +1798,7 @@ int __of_add_property(struct device_node *np, struct property *prop)
 /**
  * of_add_property - Add a property to a node
  * @np:		Caller's Device Node
- * @prob:	Property to add
+ * @prop:	Property to add
  */
 int of_add_property(struct device_node *np, struct property *prop)
 {
@@ -1844,7 +1844,7 @@ int __of_remove_property(struct device_node *np, struct property *prop)
 /**
  * of_remove_property - Remove a property from a node.
  * @np:		Caller's Device Node
- * @prob:	Property to remove
+ * @prop:	Property to remove
  *
  * Note that we don't actually remove it, since we have given out
  * who-knows-how-many pointers to the data using get-property.
-- 
2.27.0

