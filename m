Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 681E7325719
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 20:54:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234775AbhBYTw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 14:52:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235114AbhBYTmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 14:42:45 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C72CC061794;
        Thu, 25 Feb 2021 11:42:05 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id r3so6395740wro.9;
        Thu, 25 Feb 2021 11:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=saCL0zfJzepVD1gxLoKMRQsDgM3GHTKoi14Ll4BsQeg=;
        b=JryEvbV1GQsxgCKnjJBw5scuebx3A+/9G9SK/FrVWiCCojT6WRO9jElDYXYapQCsC2
         Ewaqogw1CWS8NOtyA/q3bGrLGXXu8HSP3gWDzcgCDZtVY+eZfzC25akHws0xRLhbJSgG
         1ehhUuCzvmGsa6elJpp/fby7EEhzK5VoM358JOZXeg/gVA9C+L6p2I4Jyk7F4bU5qzmn
         iPw0KcO6ro4efc65qjBmhHs4ZBwCAO9jp/ql9au+M4XT0vzqjH70dr+AlwrJNBW1b/qP
         DWOhIFgCiKhnt1xm0+cjBBC8Evns+DT5zzwvOFgcmZs64+8Igby6uvWlNiaZWZhOTHhk
         ba9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=saCL0zfJzepVD1gxLoKMRQsDgM3GHTKoi14Ll4BsQeg=;
        b=QI/TF6oFkGhUdQ4cNsIJNPn2D7UQR2wF9nWPsN+7BgvAvnAvV7Cem7G3rfRp+vnIep
         nTLdoe5wQJf04vIUZ6vX1Kt/TcO3yLm3AHJqJ3lpdC/HSO6t/HqLrZmLPZWvKFU9RdkS
         NsNoTI3IqKPb9EQmvrwmTbiX+7hjCnLjaKYbJJH+14FebZtI0EBcXI+qZXITTHYurawq
         3L7W3YdOG7jumg6/RBZk9qEqQwHIPH81TKU33sJqspYzJoiyenz3RJCVF/407jUzBIpx
         VguXu0EEsgKO7x06P/A6Q5WlAm9tVgXRzZXFbTYCCXTjfzAq68ZFukVgJFcQLlWpjyIn
         hCnw==
X-Gm-Message-State: AOAM530bGENH16Me39EtvG038K3rksJNgYRrR3L5pM3lV4fXWeneovbh
        SfaSqWjDEGU1VXIG9g+PuxI=
X-Google-Smtp-Source: ABdhPJwWjm9e7eKn0TIyQV98i8yiAEUSMvJWWTiiUM4DI6+uDhxL/7wpeSPqfszRt5SqZjOkV3445g==
X-Received: by 2002:a5d:6ccb:: with SMTP id c11mr1407903wrc.122.1614282123818;
        Thu, 25 Feb 2021 11:42:03 -0800 (PST)
Received: from skynet.lan (170.red-88-1-105.dynamicip.rima-tde.net. [88.1.105.170])
        by smtp.gmail.com with ESMTPSA id a198sm890603wmd.11.2021.02.25.11.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 11:42:03 -0800 (PST)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     jonas.gorski@gmail.com,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maxime Ripard <maxime@cerno.tech>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>, Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] mips: bmips: add BCM63268 timer clock definitions
Date:   Thu, 25 Feb 2021 20:41:58 +0100
Message-Id: <20210225194201.17001-2-noltari@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210225194201.17001-1-noltari@gmail.com>
References: <20210225194201.17001-1-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing timer clock definitions for BCM63268.

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 include/dt-bindings/clock/bcm63268-clock.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/dt-bindings/clock/bcm63268-clock.h b/include/dt-bindings/clock/bcm63268-clock.h
index da23e691d359..dea8adc8510e 100644
--- a/include/dt-bindings/clock/bcm63268-clock.h
+++ b/include/dt-bindings/clock/bcm63268-clock.h
@@ -27,4 +27,17 @@
 #define BCM63268_CLK_TBUS	27
 #define BCM63268_CLK_ROBOSW250	31
 
+#define BCM63268_TCLK_EPHY1		0
+#define BCM63268_TCLK_EPHY2		1
+#define BCM63268_TCLK_EPHY3		2
+#define BCM63268_TCLK_GPHY1		3
+#define BCM63268_TCLK_DSL		4
+#define BCM63268_TCLK_WAKEON_EPHY	6
+#define BCM63268_TCLK_WAKEON_DSL	7
+#define BCM63268_TCLK_FAP1		11
+#define BCM63268_TCLK_FAP2		15
+#define BCM63268_TCLK_UTO_50		16
+#define BCM63268_TCLK_UTO_EXTIN		17
+#define BCM63268_TCLK_USB_REF		18
+
 #endif /* __DT_BINDINGS_CLOCK_BCM63268_H */
-- 
2.20.1

