Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36F54338B14
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 12:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233992AbhCLLI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 06:08:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233814AbhCLLII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 06:08:08 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63040C061763
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 03:08:08 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id v15so4574930wrx.4
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 03:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0k9bZZ6oep6a8gAswjqXP9lEO++F0b2FjoK2nqaF0JQ=;
        b=mlx3SwYKgets0dI286MU1qf+QdAehdwSkI3REXJk6LdrlclARx4DshlQpHLevNaVKQ
         DOJrVrL4VYk4KkaILsN+AyiW31ulsdIi8GhWDtybTbOLuzarGIYTljhGIr8E6Gny4sc7
         NDxWEevHpSVpiwQQgM+51Nok6G8YL1NV2lhdFMO5BDXUMrGL9/EE14RTUnGeOVK35Cpk
         KUgxOQ9vkP3p6/hF4gETlmO8Q1YVnwDARTAlEs36AGI0/u7ym+9hP6Wt8z7ievurh2gP
         ZGqMYpB5ahjbN5MMHasdSCji/yrMG3Ppqgs0VSJe5kEeyQ7I0M1uDq3ZGUUPvDlYgqhr
         YFMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0k9bZZ6oep6a8gAswjqXP9lEO++F0b2FjoK2nqaF0JQ=;
        b=DyYBYLqVtufenKamGFe6lBp81jeH4LyNIAJYSH4ob0l3Z3BLHIF0zbMr+8BkztZ+yZ
         uCzv+ybvh/Q6sQtllkQLOmkJ5kfdy3zHEu3Pz+2MQDuDgCtbc8XQR3p/NH6J1yrLbIjC
         HzGY4ubDPqkmBjVzw2i/0llL2yskZ2Z5NUU1HqN7lODfklgnqe7cuyf6tzL3a75v7JXU
         f1J1AdSOGPcehCx1QffLLby/9T+Ft7ETXVBtGkyOuQ8aayYHtZl6CeC55a5fDr2c1ANv
         FOg+NJo2Vba4Xgq4G2kxeBOzl/uq7tNn65q3hgRYzKxTDTc3EqNxUdhzTBDJ60m8tT1M
         Yi1A==
X-Gm-Message-State: AOAM530jTQ+cKbOAVzRV9mMd+NwvtnS6bYsAokyRAbeUlZBIkpDKsVvk
        B51VSpJ+cP6cAOwmH9Yf9Ldsnw==
X-Google-Smtp-Source: ABdhPJzmmAGscwRgfqeXsshThlq74TTYYKWUNa7WJfQttZu4ydNHIHY/6lBL2MqTWT7SMaShhY+LEA==
X-Received: by 2002:a5d:67cf:: with SMTP id n15mr13267191wrw.95.1615547287168;
        Fri, 12 Mar 2021 03:08:07 -0800 (PST)
Received: from dell.default ([91.110.221.204])
        by smtp.gmail.com with ESMTPSA id f126sm1813003wmf.17.2021.03.12.03.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 03:08:06 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org
Subject: [PATCH 06/10] of: address: Demote non-conformant kernel-doc header
Date:   Fri, 12 Mar 2021 11:07:54 +0000
Message-Id: <20210312110758.2220959-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210312110758.2220959-1-lee.jones@linaro.org>
References: <20210312110758.2220959-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/of/address.c:868: warning: Function parameter or member 'dev' not described in 'of_address_to_resource'
 drivers/of/address.c:868: warning: Function parameter or member 'index' not described in 'of_address_to_resource'
 drivers/of/address.c:868: warning: Function parameter or member 'r' not described in 'of_address_to_resource'

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: devicetree@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/of/address.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index 73ddf2540f3fe..9350697ae5aad 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -855,7 +855,7 @@ static int __of_address_to_resource(struct device_node *dev,
 	return 0;
 }
 
-/**
+/*
  * of_address_to_resource - Translate device tree address and return as resource
  *
  * Note that if your address is a PIO address, the conversion will fail if
-- 
2.27.0

