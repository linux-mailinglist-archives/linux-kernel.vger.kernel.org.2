Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4D84335CA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 14:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235615AbhJSMWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 08:22:06 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:47324
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230513AbhJSMWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 08:22:04 -0400
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1CD493FFF4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 12:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1634645991;
        bh=S5hSs0IsYHo4czoU+ZSwS65AB7r69uVnogvCkeb+UaY=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=goFZpP5KNea5gq70vpwYi8/RGdpk30/9m03MJcs5zm142C/kW5F7riQDAM0m2fcrr
         L9pb3H2KCGutPAH5Gu5tT7L3rIjxHzDx0KXcoXlnA6vcykDZzgzb4GCWzKeDHo/qoU
         4y70BI2Pkf5XfEtPSGYZvRoFyG6SvmInXKtW6PCVWizh+Hr4lanB0T6ssuhQob8M0I
         GvWbvBzAm+WqB4UH2Py81kZn6wcSkKKNgxGoqwRIyEb5sNSoxRKVKwPNPbXoIoDR4E
         B6nZByLsDTEr9aiBcfNgVQ4AFaKGm08YSLHY0ADzrKva20d9I/pT40dfmNoFoGee/k
         RDpF6wWU7IBvA==
Received: by mail-pl1-f200.google.com with SMTP id u1-20020a170903124100b0013fd0e97269so1211618plh.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 05:19:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S5hSs0IsYHo4czoU+ZSwS65AB7r69uVnogvCkeb+UaY=;
        b=dWlf5E48IJbCHUGmKH/ojiXqU3/GKHcCRBrBZIfSdAjLZBHGxEPjoS1cMtfcmll063
         M0tJ+RMXDVc7qJaVHu0lzC6zuBJeTdrfNiQCyyDBQU81eSNO7309ZAHTDrPJVJtXRl7b
         3kRGZN/FFM1Qy576Q4Fc3wlGXtCRdQwuXGG3EajGiDP3BMnUxys1r/Y4WQECb09ND1eO
         fv+nm5T/TBQTDKQhKIITfPibiP5OvapbfPbaAkq1skUeW6uQJ8RF/1a6ca/cXrppfX5O
         mOf3D3J0Huj3gmSZXGUgT2NG44B4Bg/HjiCFEKP1k/x0dZPNHhHHqP4f0TpxG1qK+lJF
         ymkA==
X-Gm-Message-State: AOAM531xPnXebACMTMV6p69cMwH6sIg/PSljadcYvPqnhujxVGDF9LQ0
        ssZHqTqbJ65ZMDyW8FXpBg2XHTI4F1dOwBu8ePrPNt8SdLX2tElpgz3MyUn+M0NJ5JI4O1oFag9
        P+YuzmLURA5PGTRmmlT0ndUIpHS3T3MG5HMJpM4WOiw==
X-Received: by 2002:a63:1a1b:: with SMTP id a27mr28220394pga.220.1634645989569;
        Tue, 19 Oct 2021 05:19:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwbyPSE4NlHm4yFcKK7AkscCZM/c58AVrYx67InnYieO9ip6aITa2c/Inpm/1ZU1/nozfudIA==
X-Received: by 2002:a63:1a1b:: with SMTP id a27mr28220375pga.220.1634645989228;
        Tue, 19 Oct 2021 05:19:49 -0700 (PDT)
Received: from localhost.localdomain ([69.163.84.166])
        by smtp.gmail.com with ESMTPSA id d71sm12152571pga.67.2021.10.19.05.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 05:19:48 -0700 (PDT)
From:   Tim Gardner <tim.gardner@canonical.com>
To:     netdev@vger.kernel.org
Cc:     Tim Gardner <tim.gardner@canonical.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Roy Pledge <Roy.Pledge@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2][net-next] soc: fsl: dpio: Unsigned compared against 0 in qbman_swp_set_irq_coalescing()
Date:   Tue, 19 Oct 2021 06:19:25 -0600
Message-Id: <20211019121925.8910-1-tim.gardner@canonical.com>
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

Fix this by removing the comparisons altogether as they are incorrect. Zero is
a possible value in either case. Also fix a minor comment typo and update the
2 pr_err() calls to use %u formatting as well as be more precise regarding
the exact error.

Fixes: ed1d2143fee5 ("soc: fsl: dpio: add support for irq coalescing per software portal")
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: Roy Pledge <Roy.Pledge@nxp.com>
Cc: Li Yang <leoyang.li@nxp.com>
Cc: linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: netdev@vger.kernel.org
Signed-off-by: Tim Gardner <tim.gardner@canonical.com>
---

v1 - check itp and irq_threshold for 0.
v2 - drop the checks for comparison to 0. Update pr_err() calls with precise language
     about the error.

---
 drivers/soc/fsl/dpio/qbman-portal.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/fsl/dpio/qbman-portal.c b/drivers/soc/fsl/dpio/qbman-portal.c
index d3c58df6240d..3474bf5f88d5 100644
--- a/drivers/soc/fsl/dpio/qbman-portal.c
+++ b/drivers/soc/fsl/dpio/qbman-portal.c
@@ -1816,18 +1816,17 @@ int qbman_swp_set_irq_coalescing(struct qbman_swp *p, u32 irq_threshold,
 	u32 itp, max_holdoff;
 
 	/* Convert irq_holdoff value from usecs to 256 QBMAN clock cycles
-	 * increments. This depends to the QBMAN internal frequency.
+	 * increments. This depends on the QBMAN internal frequency.
 	 */
 	itp = (irq_holdoff * 1000) / p->desc->qman_256_cycles_per_ns;
-	if (itp < 0 || itp > 4096) {
+	if (itp > 4096) {
 		max_holdoff = (p->desc->qman_256_cycles_per_ns * 4096) / 1000;
-		pr_err("irq_holdoff must be between 0..%dus\n", max_holdoff);
+		pr_err("irq_holdoff must be <= %uus\n", max_holdoff);
 		return -EINVAL;
 	}
 
-	if (irq_threshold >= p->dqrr.dqrr_size || irq_threshold < 0) {
-		pr_err("irq_threshold must be between 0..%d\n",
-		       p->dqrr.dqrr_size - 1);
+	if (irq_threshold >= p->dqrr.dqrr_size) {
+		pr_err("irq_threshold must be < %u\n", p->dqrr.dqrr_size - 1);
 		return -EINVAL;
 	}
 
-- 
2.33.1

