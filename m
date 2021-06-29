Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 707303B703D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 11:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232941AbhF2Jqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 05:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232885AbhF2Jqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 05:46:51 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDAF2C061574
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 02:44:23 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id g21so15025177pfc.11
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 02:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dJ37PQ0DUdpFn0rnRJ0yJT5LxxB3TZY0VJaQvUIpRAc=;
        b=NLAgUarWn5AgV3j8EjWc1nVme0dHFSRQeoYdTW4OesGN8EIARL9cKJR+wmp5r37Fn2
         fRg9Xd/5/HP2HeA9vinT2g0ewkKNdMFnw8vu5qoRXrVG2+KBZKHcePlk/PTy7Wh5l1Oa
         TslX4PrI5Npy2FmW8kyi2Q+8crZglFuhIO40A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dJ37PQ0DUdpFn0rnRJ0yJT5LxxB3TZY0VJaQvUIpRAc=;
        b=Aj0ZTVyMnyWk3eKxeVBNHToulTtrSk5qiumMwjF10A2FVe36zvHpPI7hsM7f044wZ3
         QyVFnqJSIpY8ErouaFUubEy7T4zzU03mAx9EUl2bX+PzXj1b2KJXR1+A0GxcZEHTsfcQ
         A/Jha0bawihgCrnbLrmvUEO8vC+omFkzK6HjANsvQNiF/9m1+8INqsgjQaJQ2oSr3jIU
         4krDdKkOrEKM3F/rAGTZqvGC6322uJR3sAsLriHk289WU9JhCJeuqnGPY6CloiivPETI
         JE1gdVK/LNmnk5ctHJ2rvx/eX4IIs5in0nIM40pRfEARGPsG8QFmUGK83JwacqTQ9fst
         VQPg==
X-Gm-Message-State: AOAM533bxC8SyCf+V1vwG8+bcD9Vf1IEAI4UnJZFRxbOui+mds35ifoV
        bddvtuX+zzZlcRJCDA3NWht4vw==
X-Google-Smtp-Source: ABdhPJwf7am0fWVPDWZehB1xgbHGOk/B2M0vX1pYPiCsPRZk3hm0S1wfBKt2uJSRfpD/aBlbPtH27Q==
X-Received: by 2002:a65:61ad:: with SMTP id i13mr27649776pgv.345.1624959863421;
        Tue, 29 Jun 2021 02:44:23 -0700 (PDT)
Received: from fshao-glinux.tpe.corp.google.com ([2401:fa00:1:10:ebba:3e19:7691:d53e])
        by smtp.gmail.com with ESMTPSA id f15sm17891538pgg.23.2021.06.29.02.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 02:44:22 -0700 (PDT)
From:   Fei Shao <fshao@chromium.org>
To:     lee.jones@linaro.org
Cc:     Fei Shao <fshao@chromium.org>, Gene Chen <gene_chen@richtek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 1/2] mfd: mt6360: Sort regulator resources
Date:   Tue, 29 Jun 2021 17:43:38 +0800
Message-Id: <20210629094339.874120-1-fshao@chromium.org>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reorder the regulator resources.

Fixes: 4ee06e10dd26 ("mfd: mt6360: Combine mt6360 pmic/ldo resources
into mt6360 regulator resources")

Signed-off-by: Fei Shao <fshao@chromium.org>
---

 drivers/mfd/mt6360-core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/mt6360-core.c b/drivers/mfd/mt6360-core.c
index e628953548ce..6eaa6775b888 100644
--- a/drivers/mfd/mt6360-core.c
+++ b/drivers/mfd/mt6360-core.c
@@ -319,18 +319,18 @@ static const struct resource mt6360_regulator_resources[] = {
 	DEFINE_RES_IRQ_NAMED(MT6360_BUCK2_OC_EVT, "buck2_oc_evt"),
 	DEFINE_RES_IRQ_NAMED(MT6360_BUCK2_OV_EVT, "buck2_ov_evt"),
 	DEFINE_RES_IRQ_NAMED(MT6360_BUCK2_UV_EVT, "buck2_uv_evt"),
-	DEFINE_RES_IRQ_NAMED(MT6360_LDO6_OC_EVT, "ldo6_oc_evt"),
-	DEFINE_RES_IRQ_NAMED(MT6360_LDO7_OC_EVT, "ldo7_oc_evt"),
-	DEFINE_RES_IRQ_NAMED(MT6360_LDO6_PGB_EVT, "ldo6_pgb_evt"),
-	DEFINE_RES_IRQ_NAMED(MT6360_LDO7_PGB_EVT, "ldo7_pgb_evt"),
 	DEFINE_RES_IRQ_NAMED(MT6360_LDO1_OC_EVT, "ldo1_oc_evt"),
 	DEFINE_RES_IRQ_NAMED(MT6360_LDO2_OC_EVT, "ldo2_oc_evt"),
 	DEFINE_RES_IRQ_NAMED(MT6360_LDO3_OC_EVT, "ldo3_oc_evt"),
 	DEFINE_RES_IRQ_NAMED(MT6360_LDO5_OC_EVT, "ldo5_oc_evt"),
+	DEFINE_RES_IRQ_NAMED(MT6360_LDO6_OC_EVT, "ldo6_oc_evt"),
+	DEFINE_RES_IRQ_NAMED(MT6360_LDO7_OC_EVT, "ldo7_oc_evt"),
 	DEFINE_RES_IRQ_NAMED(MT6360_LDO1_PGB_EVT, "ldo1_pgb_evt"),
 	DEFINE_RES_IRQ_NAMED(MT6360_LDO2_PGB_EVT, "ldo2_pgb_evt"),
 	DEFINE_RES_IRQ_NAMED(MT6360_LDO3_PGB_EVT, "ldo3_pgb_evt"),
 	DEFINE_RES_IRQ_NAMED(MT6360_LDO5_PGB_EVT, "ldo5_pgb_evt"),
+	DEFINE_RES_IRQ_NAMED(MT6360_LDO6_PGB_EVT, "ldo6_pgb_evt"),
+	DEFINE_RES_IRQ_NAMED(MT6360_LDO7_PGB_EVT, "ldo7_pgb_evt"),
 };

 static const struct mfd_cell mt6360_devs[] = {
--
2.32.0.93.g670b81a890-goog
