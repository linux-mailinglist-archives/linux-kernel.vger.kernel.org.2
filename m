Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01AC433B2AE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 13:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbhCOM0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 08:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbhCOM0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 08:26:11 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F3AC061574;
        Mon, 15 Mar 2021 05:26:10 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id j4-20020a05600c4104b029010c62bc1e20so19345199wmi.3;
        Mon, 15 Mar 2021 05:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P/qICzhc57N6m96z6GfH+yTgyYloqlB4y8MgkxTfk9w=;
        b=YWQtxQ2dZCQg66yskornnbemBod3qjUwaNziHKnTJt4lxBUnRYkIhgoPsHTCiQ5LCX
         9CIvOz6x08M7PHIEIdcv6Zj+S9TcyRJdF64cqhR4yEGeU/DkjvdCrm6NUxGswd24KJr7
         bzTTagFqqRb7AQZzUfrZTID1YRx9ynZ6AXsH3mFukICh2TdVl/RA8IY1gNIa4NLd4VZm
         wFGns6x4DtKc/aD443tG359vQIaVTRIPr7bBi3mfS+bkfvDpIcBaCKdDuvInQgNt4ASQ
         5EXr55u3ca+rv33T6vl9cqglDrHiga6QdcnCxBbrYa4zsY36LKnxuq/SzGXmSagaHSTT
         67YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P/qICzhc57N6m96z6GfH+yTgyYloqlB4y8MgkxTfk9w=;
        b=hY9kUJ3pl+HmOIKtM3AyprIwHecoHT+B3HGMMIK0MpcomEmY053mZkVZ0T5tcMULCY
         Iaios7lOXiGXFplrNqfxccfV56R8sDKEq6ur+rRZdAGPtouFelaoBfLFbbfqE+AC2BKS
         T/OgViH/7TrGquwt1wZrAYthlELYvY3yC49GYivOiWuhE8ajLHWUyA5Ok+lnSocKp1Hk
         4HvDN3CL8gqty6tC1sayrY3V4bT1fMlgTUx8MswrGtM79B9+sab25IwV4KAa8ussAeeW
         7NQlRP0G37R/Jl2ynwOXI9s7MvFLHFK6xkBJ6f3kGfARoSn5gOyXJXkt7y5zZ+JjG/au
         FSAg==
X-Gm-Message-State: AOAM531DFdYr4uBiZfrIsoqqCXYD45wF5HdEtfaldbaPtGEca99qBvK1
        t80AA//7TU7ROY343vpIxu0=
X-Google-Smtp-Source: ABdhPJwiatuxx1JWKA1EloLmwLDzAzTBmYRty3vDBpn644Q59UB2LmsDT8pJhSMPVdwvNj3piQymQQ==
X-Received: by 2002:a1c:4145:: with SMTP id o66mr21197086wma.68.1615811169135;
        Mon, 15 Mar 2021 05:26:09 -0700 (PDT)
Received: from skynet.lan ([80.31.204.166])
        by smtp.gmail.com with ESMTPSA id o7sm18317851wrs.16.2021.03.15.05.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 05:26:08 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     jonas.gorski@gmail.com,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Maxime Ripard <maxime@cerno.tech>,
        =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>, Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>
Subject: [PATCH v2 2/4] dt-bindings: reset: add BCM63268 timer reset definitions
Date:   Mon, 15 Mar 2021 13:26:03 +0100
Message-Id: <20210315122605.28437-3-noltari@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210315122605.28437-1-noltari@gmail.com>
References: <20210315122605.28437-1-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing timer reset definitions for BCM63268.

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 v2: change commit title, as suggested by Stephen Boyd

 include/dt-bindings/reset/bcm63268-reset.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/dt-bindings/reset/bcm63268-reset.h b/include/dt-bindings/reset/bcm63268-reset.h
index 6a6403a4c2d5..d87a7882782a 100644
--- a/include/dt-bindings/reset/bcm63268-reset.h
+++ b/include/dt-bindings/reset/bcm63268-reset.h
@@ -23,4 +23,8 @@
 #define BCM63268_RST_PCIE_HARD	17
 #define BCM63268_RST_GPHY	18
 
+#define BCM63268_TRST_SW	29
+#define BCM63268_TRST_HW	30
+#define BCM63268_TRST_POR	31
+
 #endif /* __DT_BINDINGS_RESET_BCM63268_H */
-- 
2.20.1

