Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5916338B07
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 12:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233912AbhCLLIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 06:08:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233762AbhCLLIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 06:08:05 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3BEC061761
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 03:08:04 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id o14so768528wrm.11
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 03:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bB37NURGh8EFIJQIa++3BQSCU0th5hoxHg0xcGpcKp8=;
        b=tmsGKcKgEnsj0KhVWe2+k8A1ABsaHdyGtihJMLmEKBibW/MwchKqZMucJ2Bf+JeJ3H
         emjiTOGPn2KKQHgYfwXPrPP0h4r5bpWUTcm/MqMz4umjl7cmtNMU6tLxJZMB1CfwtwoY
         RzOMlRnrDNriNMrFjVPrsEFYifdnuqjZ1LW0RJ+P+DSIZiMBtarte05Al7uuVAYGJdgo
         wah2axV51h3tdIaVigzP4kWCabECr2Ev2XhZtcdQ0cUo1UTJxkj1tXXeKzohVxF3Pio6
         5XXUaA2g5cFG7/OXLNewYIBG9BAb7ce+/laDOYDRarSDwxv+UpsTlj5RXLqk5LaC/+YN
         vegA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bB37NURGh8EFIJQIa++3BQSCU0th5hoxHg0xcGpcKp8=;
        b=FOTRHTOg0+k0gR77A/ZRBc1tKzGDPqiGt8bUrI3/4I0ndJQxKYOzow3zOV8keLu4W/
         XSrG8svBwotKwy4vOQ4z5+fufcXctXduPM/mRU5oa24n9pHJ0Npo5S0jo/1rPykBsw+p
         3C8cBMOxc7r2kAU44iyui0KeCWUFnHzvGB+W8/hcypHuLdecAgdHQRqPhyz1mQBMaxMh
         w3JfEJ9JwNtIPJsFvBc0MBwpX8dgC4Mp3WxikR6PypwrsJPt4tuChHTa6nk+NioDWwSs
         DKMqlckZzI+4bvFgukvvHAqjiSHPwkfW6wk+KS74RR0Rai6Brk3oZgdOmzFZY8GfpY8M
         3Csw==
X-Gm-Message-State: AOAM531dj/tYdjoQX2sgw8jggkZIhICiYrD829C/HgeqReq2FWKbbC1H
        YGkiM9bNKx8HU8b3PE7Cr1ggxA==
X-Google-Smtp-Source: ABdhPJxdZXEXsyo56YWGdpLI+TV2w0Bi6ry8On8Jgv+w757A5JzCjLQDf2n33EIQZ7P2cWgMcG9uAA==
X-Received: by 2002:adf:e68e:: with SMTP id r14mr13195066wrm.273.1615547283597;
        Fri, 12 Mar 2021 03:08:03 -0800 (PST)
Received: from dell.default ([91.110.221.204])
        by smtp.gmail.com with ESMTPSA id f126sm1813003wmf.17.2021.03.12.03.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 03:08:03 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org
Subject: [PATCH 02/10] of: dynamic: Fix incorrect parameter name and demote kernel-doc abuse
Date:   Fri, 12 Mar 2021 11:07:50 +0000
Message-Id: <20210312110758.2220959-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210312110758.2220959-1-lee.jones@linaro.org>
References: <20210312110758.2220959-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/of/dynamic.c:234: warning: Function parameter or member 'np' not described in 'of_attach_node'
 drivers/of/dynamic.c:286: warning: Function parameter or member 'np' not described in 'of_detach_node'
 drivers/of/dynamic.c:326: warning: Function parameter or member 'kobj' not described in 'of_node_release'
 drivers/of/dynamic.c:326: warning: Excess function parameter 'kref' description in 'of_node_release'

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: devicetree@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/of/dynamic.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index 9a824decf61f1..93b35f3c92c18 100644
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -227,7 +227,7 @@ static void __of_attach_node(struct device_node *np)
 	of_node_clear_flag(np, OF_DETACHED);
 }
 
-/**
+/*
  * of_attach_node() - Plug a device node into the tree and global list.
  */
 int of_attach_node(struct device_node *np)
@@ -279,7 +279,7 @@ void __of_detach_node(struct device_node *np)
 	__of_phandle_cache_inv_entry(np->phandle);
 }
 
-/**
+/*
  * of_detach_node() - "Unplug" a node from the device tree.
  */
 int of_detach_node(struct device_node *np)
@@ -318,7 +318,7 @@ static void property_list_free(struct property *prop_list)
 
 /**
  * of_node_release() - release a dynamically allocated node
- * @kref: kref element of the node to be released
+ * @kobj: kernel object of the node to be released
  *
  * In of_node_put() this function is passed to kref_put() as the destructor.
  */
-- 
2.27.0

