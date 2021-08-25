Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D84F93F70A3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 09:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238793AbhHYHrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 03:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238651AbhHYHrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 03:47:16 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469E3C0613C1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 00:46:31 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id d6so35648496edt.7
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 00:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7D1/WS0zTlYHIFesaw9k9oY822cAZCcAzswuvk/STN8=;
        b=Fn5OTYgKC1XDw0fsZCNL5rK8nh3Yw6q69Py4rAti5bRuYxtnF+M7ZWk75l25Rq+Uea
         4qw9w1qItY3JzNN9LgaucWg5NR4YlSM4yHAP6HWraNA3H0nY3AWIQaT/hc2bn9qM0uBc
         domES/aD32d842L/fI5nO6pRBe8ZZ5xKYz1/RL/xqs3c61Q1jLCr2PoFl2HuTO+aJCYs
         0gKDDxxl5hQp1bLHn5we/hoL/hu8TNf2iMCCuDKd64HZaKHonkoCmKO+94+/DBll+DdY
         BpF9vucnALM2gghb0Xu0pt2Bt/sbxCOi+xHFDNlOhckzQPlD/Bl16X0Lyr/NsjbMItCm
         KStA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=7D1/WS0zTlYHIFesaw9k9oY822cAZCcAzswuvk/STN8=;
        b=RMKKwdi2dsS/cTvvUYpvkLkoegPkm1LwgXET1RD2Wo/VNKNTlexTaPHaXcxArkKLYU
         lI8jVbdx+VVnYNi9G5OP0/CfBAHnF+pD/XbvxoO+iYh4/NtdoxTSbv47J03eiw/UFLY5
         YszdRje/nVHpOUEhvwNvovm1qxs1Zgti4Esu2qlBGEWS6C5TL9ua8Qp0fJv3GBop8lA1
         31PJ6MJwOknLM+BnO5WtYreONwWY01KGDXMFkQavrCB3g9IXclWcdhcpGlkMolNdFSFr
         Sz8VXcZZhebbBgQtMr059ykZCRMGE5mLRMY1wSQo+0s1GF8Frqq2V6MoZYnZHnNL7Fe6
         wBvQ==
X-Gm-Message-State: AOAM532kgd+ClasdU7GAllvEUooAAhjI2+g3H08gwpp952DEg2j5zM9z
        PKHnfgQU8MYMVNavVLYJ7j/K55CPfeXcqdJD
X-Google-Smtp-Source: ABdhPJyG/jvLMmIrbWGFryX+KzJyGx1fCLqz+gM1ewCG9/7rjU6A1V6bNX+Pwdr1vKLcAGaLTQU9dA==
X-Received: by 2002:aa7:cb0f:: with SMTP id s15mr47452079edt.190.1629877589680;
        Wed, 25 Aug 2021 00:46:29 -0700 (PDT)
Received: from localhost ([2a02:768:2307:40d6::e05])
        by smtp.gmail.com with ESMTPSA id p8sm6664854ejo.2.2021.08.25.00.46.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Aug 2021 00:46:29 -0700 (PDT)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Mike Looijmans <mike.looijmans@topic.nl>
Cc:     Daniel Palmer <daniel@0x0f.com>, Hao Fang <fanghao11@huawei.com>,
        Joel Stanley <joel@jms.id.au>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Max Merchel <Max.Merchel@tq-group.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH] dt-bindings: Add vendor prefix for Topic Embedded Systems
Date:   Wed, 25 Aug 2021 09:46:28 +0200
Message-Id: <b6e42012977876c421672a84bdb7636be819d664.1629877585.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vendor prefix for Topic Embedded Systems (http://topic.nl).

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 07fb0d25fc15..d3d7e109f1bd 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1165,6 +1165,8 @@ patternProperties:
     description: Tecon Microprocessor Technologies, LLC.
   "^topeet,.*":
     description: Topeet
+  "^topic,.*":
+    description: Topic Embedded Systems
   "^toppoly,.*":
     description: TPO (deprecated, use tpo)
     deprecated: true
-- 
2.33.0

