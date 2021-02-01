Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C172530AF01
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 19:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232753AbhBASUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 13:20:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232305AbhBASPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 13:15:34 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02AEC061225
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 10:14:23 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id m12so76295pjs.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 10:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ud8fSYQS4d3P26sJXvIE1jVhQWMgH/q2+4y/hg0WOzE=;
        b=Bq142QzhKaao2VxJy5mJjbxcbYKOYG5x7RP7xQ/EzMs+IrSq4M4BKdnRAfy7zVyQX7
         YhdJbF2EX6Z9GrI6l8RN9S2y/ZjZAcK4XcMIopxQwEehv66fWF6XkWVvCNJvU6RE15x3
         Cv0tQJouHYxfo3TCIA+d1p4ecdlKCRKNYsRMhf9j1tvthHv40Au3FEw+W3fggZG5v+ly
         VuPhpCfLXhrMofcHTNjeVVIPHzyvWzmK0IeAxMKvpKLjme6Gtgk8/i+7vEuWQwZ0NgRF
         fAjHoltk0zn8SEDGxWppuL29JeOsR0VSDQ9UUl6hHh5ZuNCG14huFoCXoy+LApJrWWaV
         Xlog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ud8fSYQS4d3P26sJXvIE1jVhQWMgH/q2+4y/hg0WOzE=;
        b=XkB9DM4zioY37Cb1DNBsp+SP09QUwVIdlfQkENUcx/zOhyupBTqigwQgdeQ9C/An79
         zW4Buv+DOyeUMALiO2PGDsEIpJzeB5DNxDNwila0ghFH+Ix9TeMKMxgG9AaT6hET3IhY
         odOkPIVdJps0g6W9L4scbpz33PrRz7fxveZowE4g/xUkSxTh9LWSBXvIZIuzBHXre6Ut
         1w0IBDcWvZI6yjjrionkSDojZVkWNBpI6lswNb/yr4nSOBPmVSnRzT1hLS4MdJlpMeMs
         Cmb+bwjr4F5fnJQxY/ElQyI5akf1Vp6vVAxVD57ENEdor4uq7//C3z9RwqZBlZ/BQ3jD
         sw7Q==
X-Gm-Message-State: AOAM533dHmGiiirSgxqi7lJsTGRV+e1u+kc7AhG/zpLt4qdqhTxmVcIE
        3OntRNiK3iPRtZ1w+AdadhrZbA==
X-Google-Smtp-Source: ABdhPJwuhnxfgWa+/10wsinybLQICKg8hNRPHx1P5G+mblYZOUxwiPeN6OAd49yfOTnD4wB1ai1N7g==
X-Received: by 2002:a17:90a:4890:: with SMTP id b16mr171042pjh.36.1612203263428;
        Mon, 01 Feb 2021 10:14:23 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id e12sm75784pjj.23.2021.02.01.10.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 10:14:22 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 28/31] dts: bindings: coresight: ETM system register access only units
Date:   Mon,  1 Feb 2021 11:13:48 -0700
Message-Id: <20210201181351.1475223-29-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210201181351.1475223-1-mathieu.poirier@linaro.org>
References: <20210201181351.1475223-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

Document the bindings for ETMs with system register accesses.

Cc: devicetree@vger.kernel.org
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Link: https://lore.kernel.org/r/20210110224850.1880240-27-suzuki.poulose@arm.com
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 Documentation/devicetree/bindings/arm/coresight.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/coresight.txt b/Documentation/devicetree/bindings/arm/coresight.txt
index d711676b4a51..7f9c1ca87487 100644
--- a/Documentation/devicetree/bindings/arm/coresight.txt
+++ b/Documentation/devicetree/bindings/arm/coresight.txt
@@ -34,9 +34,12 @@ its hardware characteristcs.
 					Program Flow Trace Macrocell:
 			"arm,coresight-etm3x", "arm,primecell";
 
-		- Embedded Trace Macrocell (version 4.x):
+		- Embedded Trace Macrocell (version 4.x), with memory mapped access.
 			"arm,coresight-etm4x", "arm,primecell";
 
+		- Embedded Trace Macrocell (version 4.x), with system register access only.
+			"arm,coresight-etm4x-sysreg";
+
 		- Coresight programmable Replicator :
 			"arm,coresight-dynamic-replicator", "arm,primecell";
 
-- 
2.25.1

