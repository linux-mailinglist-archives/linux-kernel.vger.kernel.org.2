Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 774963D6B32
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 02:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234515AbhG0ABI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 20:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234493AbhG0AA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 20:00:59 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92DE8C061757
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 17:41:27 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id k1so13654474plt.12
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 17:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NNVYuLLan0DbWKz2ujfAadJo7MF6NbWDZ6vQQn1FVnQ=;
        b=hFZXRcvm6o1J85FJHveCFIdnAk3b2RIiMKV2HjJwXO/DrxU7MzkvC7sI451v2Lv8kf
         rDno1AGGeN+6y4K7Kw1zdmjHAnyCvWukMgI5b8qSnGVLRqjlfbr6GGj3Wynqr/uQcvU7
         Iq4JN/PrTbQ05lb43LHOsMHT8fFp4XUS9l5xA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NNVYuLLan0DbWKz2ujfAadJo7MF6NbWDZ6vQQn1FVnQ=;
        b=MS5zcpj6N7Nsq1fKLxx9BCgXrk+oEpXx8PDcxLrDRWJtuFcif/aqR3CHHK2jpu/i2N
         Z2GL+xiUOx9zcWhuek0GSNxdOUX4h1zuAA6M0dvaphe3fJX9NeadokazVm+HQb+fDYXz
         G6t5HLKjtqgprSyidGATJLEv29lZsAYPS+2f8Mn0Fg7SHACjdAWRlluZ/q2F0x3DOVqX
         ILT2pDb+on7SPEcMsucYNf1DJ7d/s4TRDxCHAz776yr9L/j00W/ppl87CnILMX6//WXh
         e3DPfrZYC3oD5bOLhVBcEf3pdr/+xMlaGr+yiJNwOXPpG0Zp2lSi74O6BLp6dhzPt3n7
         OdGA==
X-Gm-Message-State: AOAM533SSVV3rgGJR07kMMoER8oQN3CVG7oIH0SNMJ23+Wn8JrkLCbW9
        6BGNh/g7GkChpzN2ulA/l3Hh3A==
X-Google-Smtp-Source: ABdhPJxutSwl+RD+8PC6SoWHzxCN84aCgaJ9K1NMr2MPxgJnx4/GFQQ4lr7E4AuBHxrcwJI6c3A6ag==
X-Received: by 2002:a17:90a:ce03:: with SMTP id f3mr8599750pju.30.1627346487176;
        Mon, 26 Jul 2021 17:41:27 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:9c3d:270c:6be9:9c33])
        by smtp.gmail.com with UTF8SMTPSA id x14sm1283854pfq.143.2021.07.26.17.41.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jul 2021 17:41:26 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>
Cc:     Bastien Nocera <hadess@hadess.net>,
        Peter Chen <peter.chen@kernel.org>, devicetree@vger.kernel.org,
        Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-usb@vger.kernel.org,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v15 2/6] of/platform: Add stubs for of_platform_device_create/destroy()
Date:   Mon, 26 Jul 2021 17:41:14 -0700
Message-Id: <20210726174048.v15.2.I08fd2e1c775af04f663730e9fb4d00e6bbb38541@changeid>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
In-Reply-To: <20210727004118.2583774-1-mka@chromium.org>
References: <20210727004118.2583774-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Code for platform_device_create() and of_platform_device_destroy() is
only generated if CONFIG_OF_ADDRESS=y. Add stubs to avoid unresolved
symbols when CONFIG_OF_ADDRESS is not set.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Acked-by: Rob Herring <robh@kernel.org>
---

Changes in v15:
- none

Changes in v14:
- none

Changes in v13:
- none

Changes in v12:
- none

Changes in v11:
- none

Changes in v10:
- none

Changes in v9:
- added Rob's 'Acked-by' tag

Changes in v8:
- fixed C&P error in commit message

Changes in v7:
- none

Changes in v6:
- patch added to the series

 include/linux/of_platform.h | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/include/linux/of_platform.h b/include/linux/of_platform.h
index 84a966623e78..d15b6cd5e1c3 100644
--- a/include/linux/of_platform.h
+++ b/include/linux/of_platform.h
@@ -61,16 +61,18 @@ static inline struct platform_device *of_find_device_by_node(struct device_node
 }
 #endif
 
+extern int of_platform_bus_probe(struct device_node *root,
+				 const struct of_device_id *matches,
+				 struct device *parent);
+
+#ifdef CONFIG_OF_ADDRESS
 /* Platform devices and busses creation */
 extern struct platform_device *of_platform_device_create(struct device_node *np,
 						   const char *bus_id,
 						   struct device *parent);
 
 extern int of_platform_device_destroy(struct device *dev, void *data);
-extern int of_platform_bus_probe(struct device_node *root,
-				 const struct of_device_id *matches,
-				 struct device *parent);
-#ifdef CONFIG_OF_ADDRESS
+
 extern int of_platform_populate(struct device_node *root,
 				const struct of_device_id *matches,
 				const struct of_dev_auxdata *lookup,
@@ -84,6 +86,18 @@ extern int devm_of_platform_populate(struct device *dev);
 
 extern void devm_of_platform_depopulate(struct device *dev);
 #else
+/* Platform devices and busses creation */
+static inline struct platform_device *of_platform_device_create(struct device_node *np,
+								const char *bus_id,
+								struct device *parent)
+{
+	return NULL;
+}
+static inline int of_platform_device_destroy(struct device *dev, void *data)
+{
+	return -ENODEV;
+}
+
 static inline int of_platform_populate(struct device_node *root,
 					const struct of_device_id *matches,
 					const struct of_dev_auxdata *lookup,
-- 
2.32.0.432.gabb21c7263-goog

