Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2633403A6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 11:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbhCRKlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 06:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbhCRKkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 06:40:49 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE6EC061762
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 03:40:49 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id v4so4940312wrp.13
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 03:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E4h/C6T84HxYsM0qAYAlk6c6TY3ISMeByeH+9EbuzfU=;
        b=KRRNlLMvzBiVLMTp4uW28iRLrI+eTs1hQfXzmzC2/MtESViCMqhjBq0SsrvYsW5I4O
         eJB+PRtNxU8nWaByICbJeuEzTmZBsoMRpgyZ5L8Q8GbRk+QlVXInAPDIImQ/qacJGwbq
         HKE4iXo6wFAav6YXwFyW1UmHhZNIrYpreymbLoxTE0pZgPyTiZqWvqB5VugcD7Cy8MBu
         iPFRfqzXkDsYbSsL6GKFiXINf2umU1CY0dMd4QrSazFCsnZ1p0LNRnsRPRL+dJcwYzSa
         jreeMZYqEOnFjB5yATGGgLCIx+SEhmS1w0XprLmL++OpkJFv8Vl1CHra0MdezCw5Q4H3
         AlOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E4h/C6T84HxYsM0qAYAlk6c6TY3ISMeByeH+9EbuzfU=;
        b=O2+6OMh81qIMy627N5tSWmV5lF7rYaV1o8DVzxjh1veYkHyVZbuRKrYvD16++IqjY8
         fCg8jJHKV27f6Z0Gv9G9Tnl+CH/koigSaJP8y+klUU7gEmj0U+FvxQ5tkEEfI+ZjB2sT
         R09+sNASD2lbjMG6eng8P5fzxJYqMm/GItlbv6BX9x3CvN3dakCU9w7WaIjPOFXeBEbv
         FqzfhNKlHE2wcX8yzlt/yCUAOb2cY4emBZO/6VQ9a0oJ5yvkElB4Kqeq5hoOoprDmnWE
         iu/Jqk6qg0DNBHSDESAWwRIUswKTrSGt3BtVixyinLL4cpWmZsmTnZH5vL+2FYiHHdHV
         DDOw==
X-Gm-Message-State: AOAM531mt4rQ3ndrGj56lh/3VMJmtDmgxl0cpcsYXyOHjPiZEUMjEJdy
        MiQzw3ppy4aKMjl/w3EaC9DZlw==
X-Google-Smtp-Source: ABdhPJzqh3WkVA8+9bX4WzO9yrw28Rt//sQJneyWO1w1Svu7x5bsUmRfIW7gjP+RbexuUKJrA7WBnA==
X-Received: by 2002:a5d:42d2:: with SMTP id t18mr8945779wrr.258.1616064047835;
        Thu, 18 Mar 2021 03:40:47 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id z1sm2426033wru.95.2021.03.18.03.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 03:40:47 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, devicetree@vger.kernel.org
Subject: [PATCH 04/10] of: base: Fix some formatting issues and provide missing descriptions
Date:   Thu, 18 Mar 2021 10:40:30 +0000
Message-Id: <20210318104036.3175910-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210318104036.3175910-1-lee.jones@linaro.org>
References: <20210318104036.3175910-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/of/base.c:315: warning: Function parameter or member 'cpun' not described in '__of_find_n_match_cpu_property'
 drivers/of/base.c:315: warning: Function parameter or member 'prop_name' not described in '__of_find_n_match_cpu_property'
 drivers/of/base.c:315: warning: Function parameter or member 'cpu' not described in '__of_find_n_match_cpu_property'
 drivers/of/base.c:315: warning: Function parameter or member 'thread' not described in '__of_find_n_match_cpu_property'
 drivers/of/base.c:315: warning: expecting prototype for property holds the physical id of the(). Prototype was for __of_find_n_match_cpu_property() instead
 drivers/of/base.c:1139: warning: Function parameter or member 'match' not described in 'of_find_matching_node_and_match'
 drivers/of/base.c:1779: warning: Function parameter or member 'np' not described in '__of_add_property'
 drivers/of/base.c:1779: warning: Function parameter or member 'prop' not described in '__of_add_property'
 drivers/of/base.c:1800: warning: Function parameter or member 'np' not described in 'of_add_property'
 drivers/of/base.c:1800: warning: Function parameter or member 'prop' not described in 'of_add_property'
 drivers/of/base.c:1849: warning: Function parameter or member 'np' not described in 'of_remove_property'
 drivers/of/base.c:1849: warning: Function parameter or member 'prop' not described in 'of_remove_property'
 drivers/of/base.c:2137: warning: Function parameter or member 'dn' not described in 'of_console_check'
 drivers/of/base.c:2137: warning: Function parameter or member 'name' not described in 'of_console_check'
 drivers/of/base.c:2137: warning: Function parameter or member 'index' not described in 'of_console_check'

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: devicetree@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/of/base.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 8a348f0d3c5e7..457d1ec27300b 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -305,7 +305,7 @@ bool __weak arch_match_cpu_phys_id(int cpu, u64 phys_id)
 	return (u32)phys_id == cpu;
 }
 
-/**
+/*
  * Checks if the given "prop_name" property holds the physical id of the
  * core/thread corresponding to the logical cpu 'cpu'. If 'thread' is not
  * NULL, local thread number within the core is returned in it.
@@ -1128,7 +1128,7 @@ EXPORT_SYMBOL(of_match_node);
  *			will; typically, you pass what the previous call
  *			returned. of_node_put() will be called on it
  *	@matches:	array of of device match structures to search in
- *	@match		Updated to point at the matches entry which matched
+ *	@match:		Updated to point at the matches entry which matched
  *
  *	Returns a node pointer with refcount incremented, use
  *	of_node_put() on it when done.
@@ -1774,6 +1774,8 @@ EXPORT_SYMBOL(of_count_phandle_with_args);
 
 /**
  * __of_add_property - Add a property to a node without lock operations
+ * @np:		Caller's Device Node
+ * @prob:	Property to add
  */
 int __of_add_property(struct device_node *np, struct property *prop)
 {
@@ -1795,6 +1797,8 @@ int __of_add_property(struct device_node *np, struct property *prop)
 
 /**
  * of_add_property - Add a property to a node
+ * @np:		Caller's Device Node
+ * @prob:	Property to add
  */
 int of_add_property(struct device_node *np, struct property *prop)
 {
@@ -1839,6 +1843,8 @@ int __of_remove_property(struct device_node *np, struct property *prop)
 
 /**
  * of_remove_property - Remove a property from a node.
+ * @np:		Caller's Device Node
+ * @prob:	Property to remove
  *
  * Note that we don't actually remove it, since we have given out
  * who-knows-how-many pointers to the data using get-property.
@@ -2125,9 +2131,9 @@ EXPORT_SYMBOL_GPL(of_alias_get_highest_id);
 
 /**
  * of_console_check() - Test and setup console for DT setup
- * @dn - Pointer to device node
- * @name - Name to use for preferred console without index. ex. "ttyS"
- * @index - Index to use for preferred console.
+ * @dn: Pointer to device node
+ * @name: Name to use for preferred console without index. ex. "ttyS"
+ * @index: Index to use for preferred console.
  *
  * Check if the given device node matches the stdout-path property in the
  * /chosen node. If it does then register it as the preferred console and return
-- 
2.27.0

