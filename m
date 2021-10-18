Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C761432377
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 18:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbhJRQIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 12:08:17 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:55226
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229634AbhJRQIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 12:08:15 -0400
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E910A4001A
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 16:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1634573160;
        bh=UwuVR/x7VT/cOQTFcqIu0KjQRbfwdcmSL/xYEKrPIRE=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=oNLLaoyFkg/uxBxbAlTY9JTnr5BH4rPJIkiPiOGwQ9w2Mj5k5AiBoXEQTMEwHfjAX
         x9PURYbg8m2N+Rtukubnt0sUMwHTEI7MUzwvTfX0hNBq4OVKNNec8rAdFhRuUPqMXF
         AypWzIlyg+OMFKHqvATAQ4wfFXqRZUQe7uGvMb6Mfx8elUk3SmgojsDkiYX+XjHllz
         u0U8yCjVpUkmGy6KQpJHkOLupjSqRR/Tvr7YFVtEHHGXDbgy/OZbH9Hq5qLWuSIqa/
         /gEKtcIvP/2Jd+umObUIEiNcadMbWy6ZFqzeJNGOg00QrfhtC2sQOuaXV0lcbYCAP0
         PleBhauNvHv8g==
Received: by mail-pg1-f200.google.com with SMTP id n9-20020a63e049000000b002951886c1c5so10150647pgj.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 09:05:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UwuVR/x7VT/cOQTFcqIu0KjQRbfwdcmSL/xYEKrPIRE=;
        b=FKy4KtC8nBL8sU14mhrUXeQsllU74DdL1qBJjrb1BdCIXD4STse+OUhILRtcM4EYoI
         wrms3hnthZ0I5BBNH0ZhREPKMhRMgrTzwD0xzaDzEHayO4XcYb88opnlDAcPTFmb0TJL
         1fDB6IVpoeOQLhB5S5BF/rHExDUMIFTJ6iDTjZUVUKbBRejDEEvUbslEMiaJOcY9/2RA
         HS8IKFTW3fu0Dc73GllSKGJMbMwrUx6Tbpg0f9FNVfwn9jtbil/c4KPgg68R8iFEZwKF
         Olkj/Ba2tYAo4Ai5Ts1+LFqhQQoi/3Kg2UUMjPl9auLjyHC78NIv64CpYOiBcv+uGqy4
         cPYQ==
X-Gm-Message-State: AOAM5337N0JZljq4CkL2yah3BQhUNg6jUhIoj45pwHebvZCyjZRbG5gc
        /3LYK/4B2V5aNa9+TQo6kWM06acsfGR+A0lwgPAEpE8QzHqLEZ6iQRcEvd2q2LNhO6MDxjbnFqv
        DtFV3qowz7i1pNVIB1NpiPsbVroktpKQzALwVaV8fHA==
X-Received: by 2002:a63:f356:: with SMTP id t22mr24443623pgj.18.1634573158433;
        Mon, 18 Oct 2021 09:05:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyTWyH9GbLkYIHLYPV5b2YP7Ek0Zcm/M4vmWJOVn1YIdz3V4X13i+DMfc/AS49ZtXTFcacYmQ==
X-Received: by 2002:a63:f356:: with SMTP id t22mr24443603pgj.18.1634573158224;
        Mon, 18 Oct 2021 09:05:58 -0700 (PDT)
Received: from localhost.localdomain ([69.163.84.166])
        by smtp.gmail.com with ESMTPSA id u74sm13131500pfc.87.2021.10.18.09.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 09:05:57 -0700 (PDT)
From:   Tim Gardner <tim.gardner@canonical.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     tim.gardner@canonical.com, Roy Pledge <Roy.Pledge@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH][linux-next] soc: fsl: dpio: Unsigned compared against 0 in qbman_swp_set_irq_coalescing()
Date:   Mon, 18 Oct 2021 10:05:41 -0600
Message-Id: <20211018160541.13512-1-tim.gardner@canonical.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Coverity complains of unsigned compare against 0. There are 2 cases in
this function:

1821        itp = (irq_holdoff * 1000) / p->desc->qman_256_cycles_per_ns;

CID 121131 (#1 of 1): Unsigned compared against 0 (NO_EFFECT)
unsigned_compare: This less-than-zero comparison of an unsigned value is never true. itp < 0U.
1822        if (itp < 0 || itp > 4096) {
1823                max_holdoff = (p->desc->qman_256_cycles_per_ns * 4096) / 1000;
1824                pr_err("irq_holdoff must be between 0..%dus\n", max_holdoff);
1825                return -EINVAL;
1826        }
1827
    	unsigned_compare: This less-than-zero comparison of an unsigned value is never true. irq_threshold < 0U.
1828        if (irq_threshold >= p->dqrr.dqrr_size || irq_threshold < 0) {
1829                pr_err("irq_threshold must be between 0..%d\n",
1830                       p->dqrr.dqrr_size - 1);
1831                return -EINVAL;
1832        }

Fix this by checking for 0. Also fix a minor comment typo.

Fixes ed1d2143fee53755ec601eb4d48a337a93933f71 ("soc: fsl: dpio: add support for
irq coalescing per software portal")

Cc: Roy Pledge <Roy.Pledge@nxp.com>
Cc: Li Yang <leoyang.li@nxp.com>
Cc: linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Tim Gardner <tim.gardner@canonical.com>
---

I'm not 100% sure this is the right way to fix the warning, but according to the
pr_err() comments these values should never be 0.

---
 drivers/soc/fsl/dpio/qbman-portal.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/fsl/dpio/qbman-portal.c b/drivers/soc/fsl/dpio/qbman-portal.c
index d3c58df6240d..b768a14bb271 100644
--- a/drivers/soc/fsl/dpio/qbman-portal.c
+++ b/drivers/soc/fsl/dpio/qbman-portal.c
@@ -1816,16 +1816,16 @@ int qbman_swp_set_irq_coalescing(struct qbman_swp *p, u32 irq_threshold,
 	u32 itp, max_holdoff;
 
 	/* Convert irq_holdoff value from usecs to 256 QBMAN clock cycles
-	 * increments. This depends to the QBMAN internal frequency.
+	 * increments. This depends on the QBMAN internal frequency.
 	 */
 	itp = (irq_holdoff * 1000) / p->desc->qman_256_cycles_per_ns;
-	if (itp < 0 || itp > 4096) {
+	if (!itp || itp > 4096) {
 		max_holdoff = (p->desc->qman_256_cycles_per_ns * 4096) / 1000;
 		pr_err("irq_holdoff must be between 0..%dus\n", max_holdoff);
 		return -EINVAL;
 	}
 
-	if (irq_threshold >= p->dqrr.dqrr_size || irq_threshold < 0) {
+	if (irq_threshold >= p->dqrr.dqrr_size || !irq_threshold) {
 		pr_err("irq_threshold must be between 0..%d\n",
 		       p->dqrr.dqrr_size - 1);
 		return -EINVAL;
-- 
2.33.1

