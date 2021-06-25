Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 454043B3FD9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 10:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbhFYI5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 04:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbhFYI5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 04:57:34 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A4AC061760
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 01:55:14 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id y4so7486071pfi.9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 01:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/1RZJDqaTjdzLL7WiLK+w8zM8pbWvW1Qq89QoykEE80=;
        b=RghE4XWJ3SWIeZ1N3D/J/z6fTAAXxKlo6ZEFIWARx7IkB6fjWnCR7elLaPY5H0b7s2
         CUyWiC1i356R6IzN/WcA2y+XJp5JYBSh9iah5Er4VRbGecTB4SeKNHOIBrlkV/cTBI4L
         Cd7hGh1WlhgfD+UwMLSK14Eu/e30lGjCrfbl9aZM5Sj1lQ1p5rzh9TmjGXnsIBP0osnf
         CXZntTCKDIE+6e/Fmq4wylDmCrkNWNGd5N2qC+rsM8V+y/Oo9/yB7SBVYOX4glS6aFxJ
         eJLcjOmGVZ34RALSmgycb4oBu6fGRW2wdUq4LcqT0VTNCo4tSB0XLqCiu2h4eosvwaRT
         LVhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/1RZJDqaTjdzLL7WiLK+w8zM8pbWvW1Qq89QoykEE80=;
        b=pDA+Q7u5t+cIlgAptjk1aB4L37rDZrgrsouIedNmorXdNiG0UnXz1bXIfQ2h5OIAuw
         rSoyKokv7tlXFLjmsD4WVDEw0Lhqx5777VuTFELNPf+BxDbAmmUMHm95/WMVBxIBCaQJ
         1TUB+94AeAHZVNcMUiIkGOdssrKYLkTlc6SvDs8Xv/KztqYZoz11xSny9HnNAkunKdJ9
         BV57Z/+eLwRflAttmZ++VduFhPMTtmekYEup2wj7ahVpNSIPcOdDcjXfflJG9JVliQXZ
         Kr/YcVtQeJ6jZ+VjqMrwc0nW0DqXmyikk4KbXNxsPwCTM5FUMw+5WIfeRrpR0VCmQF0j
         whtg==
X-Gm-Message-State: AOAM531MessUviXqMF3kvxzB166oSi3K/3HEFwGTVLuKPKqq4kbrW2/C
        AU9VuaiBy+2WA4gWmzlMooM=
X-Google-Smtp-Source: ABdhPJyannwxf71/SxUuA49CITPyJwvoS4j45W3fee8VcXDY+xBPyI6qjXQgotApwzphJA9hixtWbw==
X-Received: by 2002:a62:1c05:0:b029:305:5230:79f7 with SMTP id c5-20020a621c050000b0290305523079f7mr9386653pfc.80.1624611313938;
        Fri, 25 Jun 2021 01:55:13 -0700 (PDT)
Received: from test-System-Product-Name.sunix.com.tw (61-220-142-250.HINET-IP.hinet.net. [61.220.142.250])
        by smtp.gmail.com with ESMTPSA id g11sm4740654pgj.3.2021.06.25.01.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 01:55:13 -0700 (PDT)
From:   Moriis Ku <saumah@gmail.com>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, jason_lee@sunix.com,
        taian.chen@sunix.com, morris_ku@sunix.com,
        Morris Ku <saumah@gmail.com>
Subject: [PATCH] SUNIX SDC PCIe multi-function card core support
Date:   Fri, 25 Jun 2021 16:55:02 +0800
Message-Id: <20210625085502.10524-1-saumah@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Morris Ku <saumah@gmail.com>

Add support for SUNIX SDC PCIe multi-function card

Cc: Jason Lee <jason_lee@sunix.com>
Cc: Taian Chen <taian.chen@sunix.com>
Cc: Morris Ku <morris_ku@sunix.com>
Signed-off-by: Morris Ku <saumah@gmail.com>
---
 sunix-sdc.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 sunix-sdc.h

diff --git a/drivers/mfd/sunix-sdc.h b/drivers/mfd/sunix-sdc.h
new file mode 100644
index 0000000..ce8f6c1
--- /dev/null
+++ b/sunix-sdc.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * SUNIX SDC PCIe multi-function card core support.
+ *
+ * Copyright (C) 2021, SUNIX Co., Ltd.
+ *
+ */
+
+#ifndef __SUNIX_SDC_H
+#define __SUNIX_SDC_H
+
+struct device;
+
+struct sunix_sdc_platform_info {
+	struct resource *b0_mem;
+	struct resource *b1_io;
+	struct resource *b2_mem;
+	int irq;
+};
+
+int sunix_sdc_probe(struct device *dev, struct sunix_sdc_platform_info *info);
+void sunix_sdc_remove(struct device *dev);
+
+#endif // __SUNIX_SDC_H
-- 
2.20.1

