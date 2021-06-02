Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D08FA39896A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 14:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbhFBM0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 08:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbhFBM0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 08:26:44 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E22C06175F
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 05:24:51 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id t3so2674069edc.7
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 05:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zY5RLk/fd5DiVsCKJBYSJiTcCIwghmyi0mxOi7Ll8fE=;
        b=myuHSwFtL2/YUh4FO4mQ8h7gkARescYFpoyoRFASTiAjEKgVNdg5XBrUaTCLAGRvLW
         Warw75tIjzGehaAgCugjI5o3++/Yk6C6czh1JG8AQ9AWvfBMnNF+UOi1XdwlnQK9S1EL
         myvmwLPnjeMM00iA5+HGKTp0kBxTAv3HChJb1OC5DOH2iqYS81Z3dfrZgwaLmuWC5A0x
         HceYWWZQJPqd1UybsmL43f9z0TW+5QNNHAKy9anj75+Iaaw8nzKpZ8QP9NZWGqYN1vsk
         iNVOD0s0B5zYGe57YxeE1xfCVRzU/BbOwr/KpH6m9pu/dXVfFpPLa5RS7w976zVpddsf
         wQNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zY5RLk/fd5DiVsCKJBYSJiTcCIwghmyi0mxOi7Ll8fE=;
        b=L1Ng6RETkBIDz3QC790h4N3zzUZ1hsC5OKA0Qdyg1ENuLzbsKPoGB9z3IJbdm0o1PW
         1VwMm/oFaeCsk1eGyoAXipjgLzb8DdOq+/jlIHszoU1ZQn5q+qjzr1jGtOJabiIaT5by
         3nL9dn9+TaCR8GievNMsllfKunZwsVFTQJAKZFfEG6neW7TcMaTAUsG8wNGqADQfCSFU
         aucCB1WDtnaU7mNnDjxy9aTp3efHxy5cKzIFIkNEghfCmJLe1/GqwzN0IoNX2z2dBrUO
         f0CF29aDN9FOWpiyh0cce/Va15qVVZ1TzUH2zk8sQ/ZFoM35WTc7RpoWkHFOJRWYdDGE
         5OeA==
X-Gm-Message-State: AOAM532JKUIgTpDPuzPcJ/WcGVYdlkJrOL3Z6lnUp+1e2yaj6ahmFXEv
        SKsFexr3RyyQ/tXKVoqTVTlqjw==
X-Google-Smtp-Source: ABdhPJy5ofvIiPNeXoT4V0LnHXMzOtDXc/5wn7Zw8XOphC0k6/VfbbAAL8yPnQTatcqnsiwLdFlVqg==
X-Received: by 2002:a50:a6c2:: with SMTP id f2mr31273549edc.39.1622636689739;
        Wed, 02 Jun 2021 05:24:49 -0700 (PDT)
Received: from localhost.localdomain (dh207-96-250.xnet.hr. [88.207.96.250])
        by smtp.googlemail.com with ESMTPSA id z17sm8539340ejc.69.2021.06.02.05.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 05:24:49 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        robh+dt@kernel.org, lee.jones@linaro.org, p.zabel@pengutronix.de,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     luka.perkov@sartura.hr, jmp@epiphyte.org, pmenzel@molgen.mpg.de,
        buczek@molgen.mpg.de, Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v4 3/6] dt-bindings: reset: Add Delta TN48M
Date:   Wed,  2 Jun 2021 14:24:36 +0200
Message-Id: <20210602122439.2084775-3-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602122439.2084775-1-robert.marko@sartura.hr>
References: <20210602122439.2084775-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add header for the Delta TN48M CPLD provided
resets.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 include/dt-bindings/reset/delta,tn48m-reset.h | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 include/dt-bindings/reset/delta,tn48m-reset.h

diff --git a/include/dt-bindings/reset/delta,tn48m-reset.h b/include/dt-bindings/reset/delta,tn48m-reset.h
new file mode 100644
index 000000000000..659a3f6c4d47
--- /dev/null
+++ b/include/dt-bindings/reset/delta,tn48m-reset.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Delta TN48M CPLD GPIO driver
+ *
+ * Copyright 2021 Sartura Ltd
+ *
+ * Author: Robert Marko <robert.marko@sartura.hr>
+ */
+
+#ifndef _DT_BINDINGS_RESET_TN48M_H
+#define _DT_BINDINGS_RESET_TN48M_H
+
+#define CPU_88F7040_RESET	0
+#define CPU_88F6820_RESET	1
+#define MAC_98DX3265_RESET	2
+#define PHY_88E1680_RESET	3
+#define PHY_88E1512_RESET	4
+#define POE_RESET		5
+
+#endif /* _DT_BINDINGS_RESET_TN48M_H */
-- 
2.31.1

