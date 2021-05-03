Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3FA3722C8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 23:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbhECWAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 18:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbhECWAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 18:00:11 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5CAFC061573
        for <linux-kernel@vger.kernel.org>; Mon,  3 May 2021 14:59:17 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id d29so4013655pgd.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 14:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C70V1ep2OC0kZd3ksfbxSiRkqnQcxIJ5Zt5dguO6jEA=;
        b=ddABHDYPpcDSWspsVe5JjaRfWW2WGzybj41mDN4dyyhwjLnvgl8JpgEMRrm0zl8014
         sghhgQqUZi2bnSITlK49Sqef/89J5Z0uzWa29w7OYowYEtVZghumEDiQhCbYWYhRuDeL
         8Ga3xvrQTHc+QoTZKO6w2zXurJ7km4LRNn3M8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C70V1ep2OC0kZd3ksfbxSiRkqnQcxIJ5Zt5dguO6jEA=;
        b=jpyzstltEgO46WCYk0rkGIXmRStdmfwOEc+uq4uRypIt8zttlgMEmtcJ2DQvdk5exA
         gCq92Tcu2Cjb+5hASmkQtgBzZUzdO67HMgD9vqrOLin5pY7Xx76anwq1/0RNjP2suuSr
         X31gjoYTK40xqlT/m6NU4IR94+U4nHoVdy4KSd7MUAJ6+DdyVfT/k9wxFywCMvha8+C7
         DhHl7Xm2KYy9s5WwcnoiyyOojAao0eVkaCKcw6c+3gVkkVMRVqMv93XnPEzDQQP81PDB
         Spx08KPgYaWi9i6pklnGxjX9O2aBUquLMg10QfkfF+NgCK0asMyn4ZUGhdzFqXSXvVEb
         HlAA==
X-Gm-Message-State: AOAM533MtF4KxsbMo/sSDiYnDzeDbb67HmeUcviQ7562Hub3z2WuFNMV
        bwDGqOBpZrn/PfA0DDAdwEO7KA==
X-Google-Smtp-Source: ABdhPJxCffXNMJSO10RrlyG4KuAU0sSx6Cz3Lg0v+K+XZhSsqwIjdP9TiZSAgQzu7azyCwAucvUELg==
X-Received: by 2002:a17:90b:3684:: with SMTP id mj4mr958049pjb.50.1620079157449;
        Mon, 03 May 2021 14:59:17 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:a592:ac50:b17b:5c43])
        by smtp.gmail.com with ESMTPSA id w1sm639186pgp.31.2021.05.03.14.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 14:59:16 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Sam Ravnborg <sam@ravnborg.org>, Wolfram Sang <wsa@kernel.org>
Cc:     Lyude Paul <lyude@redhat.com>, Steev Klimaszewski <steev@kali.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>,
        Linus W <linus.walleij@linaro.org>, robdclark@chromium.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thierry Reding <treding@nvidia.com>, linux-i2c@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/5] i2c: i2c-core-of: Fix corner case of finding adapter by node
Date:   Mon,  3 May 2021 14:58:40 -0700
Message-Id: <20210503145750.v6.1.Ib7e3a4af2f3e2cb3bd8e4adbac3bcfc966f27791@changeid>
X-Mailer: git-send-email 2.31.1.527.g47e6f16901-goog
In-Reply-To: <20210503215844.2996320-1-dianders@chromium.org>
References: <20210503215844.2996320-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The of_find_i2c_adapter_by_node() could end up failing to find an
adapter in certain conditions. Specifically it's possible that
of_dev_or_parent_node_match() could end up finding an I2C client in
the list and cause bus_find_device() to stop early even though an I2C
adapter was present later in the list.

Let's move the i2c_verify_adapter() into the predicate function to
prevent this. Now we'll properly skip over the I2C client and be able
to find the I2C adapter.

This issue has always been a potential problem if a single device tree
node could represent both an I2C client and an adapter. I believe this
is a sane thing to do if, for instance, an I2C-connected DP bridge
chip is present. The bridge chip is an I2C client but it can also
provide an I2C adapter (DDC tunneled over AUX channel). We don't want
to have to create a sub-node just so a panel can link to it with the
"ddc-i2c-bus" property.

I believe that this problem got worse, however, with commit
e814e688413a ("i2c: of: Try to find an I2C adapter matching the
parent"). Starting at that commit it would be even easier to
accidentally miss finding the adapter.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
Later patches in this series won't work right without this one, but
they won't crash. If we can't find the i2c bus we'll just fall back to
the hardcoded panel modes which, at least today, all panels have.

I'll also note that part of me wonders if we should actually fix this
further to run two passes through everything: first look to see if we
find an exact match and only look at the parent pointer if there is no
match. I don't currently have a need for that and it's a slightly
bigger change, but it seems conceivable that it could affect someone?

(no changes since v1)

 drivers/i2c/i2c-core-of.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/i2c-core-of.c b/drivers/i2c/i2c-core-of.c
index 3ed74aa4b44b..de0bf5fce3a2 100644
--- a/drivers/i2c/i2c-core-of.c
+++ b/drivers/i2c/i2c-core-of.c
@@ -124,6 +124,14 @@ static int of_dev_or_parent_node_match(struct device *dev, const void *data)
 	return 0;
 }
 
+static int of_i2c_adapter_match(struct device *dev, const void *data)
+{
+	if (!of_dev_or_parent_node_match(dev, data))
+		return 0;
+
+	return !!i2c_verify_adapter(dev);
+}
+
 /* must call put_device() when done with returned i2c_client device */
 struct i2c_client *of_find_i2c_device_by_node(struct device_node *node)
 {
@@ -146,18 +154,13 @@ EXPORT_SYMBOL(of_find_i2c_device_by_node);
 struct i2c_adapter *of_find_i2c_adapter_by_node(struct device_node *node)
 {
 	struct device *dev;
-	struct i2c_adapter *adapter;
 
 	dev = bus_find_device(&i2c_bus_type, NULL, node,
-			      of_dev_or_parent_node_match);
+			      of_i2c_adapter_match);
 	if (!dev)
 		return NULL;
 
-	adapter = i2c_verify_adapter(dev);
-	if (!adapter)
-		put_device(dev);
-
-	return adapter;
+	return to_i2c_adapter(dev);
 }
 EXPORT_SYMBOL(of_find_i2c_adapter_by_node);
 
-- 
2.31.1.527.g47e6f16901-goog

