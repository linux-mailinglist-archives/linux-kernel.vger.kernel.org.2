Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C10DD362B86
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 00:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235776AbhDPWmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 18:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235235AbhDPWll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 18:41:41 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13B2C061763
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 15:41:16 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id e2so10425594plh.8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 15:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G1oK3A+M8fg+nmJCwN6uSqjhfKVKHBhUTiK9rrQlAS4=;
        b=bCeuEmR3HjXaHM41yzCpBTsW5gkiZWfz+buTmvLCoA3npH8nKGoWLVRFtmpaCOeNJv
         BMKH1h0fbC4DBaiaaLumGYJPd1GONx5InTjlGMDSJPKVKkmdgRdG0VztUjk+WywnCBvC
         OorkdjY52CQ8xbqIbH26D7ORN0pySvgdVIsRI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G1oK3A+M8fg+nmJCwN6uSqjhfKVKHBhUTiK9rrQlAS4=;
        b=B3G0NViNpG7weQwvQ8tQtvhK4Oko4hpUH2vUEVOorpAGkTkPtCX3+xmS2FJnZNgyql
         tTxp9E6HMPYjL4zWDKtDBiqaZrWuJQY9N7yNFj6eLJWlRz2KofxjQUrbpl17lK3mbHbk
         bNtNYJ4n91j0JdYy3U4/aDHvOa94t4ev9MvkYHnNBEBAmACUyaOAL7HKleZOKSmMkERi
         m4IYqqio9XX0p61nqkcj2qeOLEn7AP9CJT0HjqSB3QY5iuPPHReAkRLFwX/FBC91UEBL
         z6pnsFZkYlNNuh7PTaPCxhg9/PJDSrVArv8pRJ2LnO4N87Gqv7w5wMrfRFCoQ7gleEoU
         V25w==
X-Gm-Message-State: AOAM532zuaHJ71nXj4sBHknRGAPN/DjCEYMKflj/WLyvKQjuA+L87h/C
        ul6AKOaXf4lcmZxT2fK4K4DRAw==
X-Google-Smtp-Source: ABdhPJy6EH6g0mXqfXc8j8Oj2eoiQmlxQ4rGLqmYwpa2F46snG4cU2uBdupfef6ToF02aiZj4Q8Osg==
X-Received: by 2002:a17:902:c40c:b029:ea:af9e:b123 with SMTP id k12-20020a170902c40cb02900eaaf9eb123mr11667608plk.30.1618612876151;
        Fri, 16 Apr 2021 15:41:16 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:dc8a:c9d0:aa5b:5386])
        by smtp.gmail.com with ESMTPSA id r6sm5633659pgp.64.2021.04.16.15.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 15:41:15 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Sam Ravnborg <sam@ravnborg.org>, Wolfram Sang <wsa@kernel.org>
Cc:     Stephen Boyd <swboyd@chromium.org>, robdclark@chromium.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>,
        Steev Klimaszewski <steev@kali.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, Linus W <linus.walleij@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 21/27] i2c: i2c-core-of: Fix corner case of finding adapter by node
Date:   Fri, 16 Apr 2021 15:39:44 -0700
Message-Id: <20210416153909.v4.21.Ib7e3a4af2f3e2cb3bd8e4adbac3bcfc966f27791@changeid>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
In-Reply-To: <20210416223950.3586967-1-dianders@chromium.org>
References: <20210416223950.3586967-1-dianders@chromium.org>
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
---
This commit is sorta just jammed into the middle of my series. It has
no dependencies on the earlier patches in the series and I think it
can land independently in the i2c tree. Later patches in the series
won't work right without this one, but they won't crash. If we can't
find the i2c bus we'll just fall back to the hardcoded panel modes
which, at least today, all panels have.

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
2.31.1.368.gbe11c130af-goog

