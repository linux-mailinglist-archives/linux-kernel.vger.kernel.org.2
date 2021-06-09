Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20FF33A12B7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 13:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239101AbhFIL33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 07:29:29 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:41953 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238767AbhFIL31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 07:29:27 -0400
Received: by mail-wr1-f51.google.com with SMTP id o3so6689359wri.8;
        Wed, 09 Jun 2021 04:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fyQgGAadeLU91exjwkDmQ8sdlZgvYCMWXa8NU62n5iI=;
        b=NK+vK4BR3jmSACfDfe0iYHhFtmMKHkGY2F5qiufSN4ghQa7WkcBzLsaNzNOQdskCNa
         GuUIorD2Bl+sQ83zoRNIhjOH11rpgydeHGu+7aqXfnSj3lfBaCGAYsCWFzIgTm7QWxQr
         /aZZlp9J4oYWHBA3OUR2u7IBMAyK3ob/FYJDsxhxmYsunBaR8ZduCbY9YTV9EtkKgN55
         4s+fPj89Dr5Vv8exRVkAAmxN6u8pKdITu4P4qv2sVgMYi5acQ70vc+epvzggYoPE4Dcw
         raRICuOWmXrakTH2gBvZKgYqgx3ZEC0yB7zuVa+bl4qGTkJZe/xzMetdSZlXUjblYBh9
         nPZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fyQgGAadeLU91exjwkDmQ8sdlZgvYCMWXa8NU62n5iI=;
        b=ZQLxfdi26OEwIq2Bvw759b+BPu8YzkUdz5xwKFChRcwUGIJr3Qr7lcriZ3kKuxvtac
         zL6scCozYt2cjjO2z/f2wvc7+xBanWIsvrcMe9WNAnL1T7DoM5Ue+LZp152FXnKq86fS
         fvc/Hnq18Xh+BTawqTGezjIAeapCXl/MsqwBpKUm+wvFGauBI7+/OSSFFkCq8GF6PiiL
         UkidQCHc0gHShVxEvJlHbcGjUZAlcfD4YtRBrXBkoD++0AW0MkwWcGAaR9Eo9zOVLeH0
         2DNJPuEfSEp1Zr+8hVtDcdXQS4JITDqATOu2D27PtDhwU9ed7jMmldxMyJ6njS4K4U1n
         qhcg==
X-Gm-Message-State: AOAM533A7ujgnXlPCm/WO1y4/54N6ID3InpWVHNSVhg9oFkKl8sTvn1Q
        QKEpvCkVjpHpik5scC9rMuY=
X-Google-Smtp-Source: ABdhPJzs3k40HZp8LCZEVWARS5VOnX/evYwWBaJOtEB4h5MiyWChb+mTZ8lXMnQ7zTgav4qJvZJtiQ==
X-Received: by 2002:a05:6000:2c4:: with SMTP id o4mr27863535wry.267.1623237991819;
        Wed, 09 Jun 2021 04:26:31 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id f12sm9123422wru.81.2021.06.09.04.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 04:26:30 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] reset: Add compile-test stubs
Date:   Wed,  9 Jun 2021 13:28:06 +0200
Message-Id: <20210609112806.3565057-3-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210609112806.3565057-1-thierry.reding@gmail.com>
References: <20210609112806.3565057-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Add stubs for the reset controller registration functions to allow
building reset controller provider drivers with the COMPILE_TEST
Kconfig option enabled.

Reported-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Suggested-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 include/linux/reset-controller.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/include/linux/reset-controller.h b/include/linux/reset-controller.h
index ec35814e0bbb..0fa4f60e1186 100644
--- a/include/linux/reset-controller.h
+++ b/include/linux/reset-controller.h
@@ -79,6 +79,7 @@ struct reset_controller_dev {
 	unsigned int nr_resets;
 };
 
+#if IS_ENABLED(CONFIG_RESET_CONTROLLER)
 int reset_controller_register(struct reset_controller_dev *rcdev);
 void reset_controller_unregister(struct reset_controller_dev *rcdev);
 
@@ -88,5 +89,26 @@ int devm_reset_controller_register(struct device *dev,
 
 void reset_controller_add_lookup(struct reset_control_lookup *lookup,
 				 unsigned int num_entries);
+#else
+static inline int reset_controller_register(struct reset_controller_dev *rcdev)
+{
+	return 0;
+}
+
+static inline void reset_controller_unregister(struct reset_controller_dev *rcdev)
+{
+}
+
+static inline int devm_reset_controller_register(struct device *dev,
+						 struct reset_controller_dev *rcdev)
+{
+	return 0;
+}
+
+static inline void reset_controller_add_lookup(struct reset_control_lookup *lookup,
+					       unsigned int num_entries)
+{
+}
+#endif
 
 #endif
-- 
2.31.1

