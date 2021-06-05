Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88F3F39CB6D
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 00:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbhFEWSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 18:18:12 -0400
Received: from mail-lj1-f172.google.com ([209.85.208.172]:43782 "EHLO
        mail-lj1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbhFEWSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 18:18:11 -0400
Received: by mail-lj1-f172.google.com with SMTP id w15so16481015ljo.10
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jun 2021 15:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DSNtbl7+m8u1jF6spZR7rMM0J4kDmSlqDiqsN9hvk0I=;
        b=HTYJzRm5lzImi1pUOx0Eml6+cHg9Dy2+ZaWqoBxBSxzgvFwPHQnQdOshvF7f3cdjzW
         A+JREf3m58pe/oeXY2/ugj6mpNDaYnp2NOzbmSlZknI4mv8kjud3tWxuANo358Qfeq/6
         E2cZB94Xdg+8koTCgq/zMf09RW9t4m6d9R/FIzGQ1eS5NkOq2wt+dMlr9Rwkxm3z06SW
         rV/mYIf6LYPsy7TPYKCmEx8TlgsssOeaxO69aRL2b7nuzsr+yN4ZdJbxWI1QycdUQUcG
         Wix7nZ4gfCwpyyGw9pmPdeQrvdbTPp4fHxDFJ2B+y/7UQbmfcuyWZpkQtrIlNlPGd/+h
         wkmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DSNtbl7+m8u1jF6spZR7rMM0J4kDmSlqDiqsN9hvk0I=;
        b=FthFqyG9hl3V3e3l3OOosv+XfuepyOl2hyKF14RXAq8HFbu3BgW6gNZbJGhHBPCmCy
         TV55wsPF9UJ+mBAqYxhe0zrFRp0yv/XW1W9nB7GZHs9NV/BrITlcOnDbjx+QOwkhcJEK
         iGnlyR4YznOo37u2NDqqvbg3b7OyhBBMnxABnTNSWQdDxMgb+7LhXGBAxnrHRo2Ob6EY
         zXu5td6J+85tOab8wPN8m/l4ZziFm8pIAP7z6VW1YCAF/RLf4ZgRZsI19oCOM9kSXzg8
         9z4nu7EETvbUY2hLnDiatosxKv4/UzYpWvDD8FVGWvr3CtepuGU6CwozCaZ1B0AylYrm
         Qfdw==
X-Gm-Message-State: AOAM533aecV06yV9lBEx8VcAe6Fzzn2e0uDBEfLVqA3CyzNm/WCV++Sb
        NaYcVA9ipqLMMmR6Ff6LfTmIfO0P/tB8Sw==
X-Google-Smtp-Source: ABdhPJzQ6upeQvGZ6QWD+jxYyfCteIEOQZkOSLTdSDIEMrGKac4CJznw/4GT4ZGK26tDHFWqAIcNGw==
X-Received: by 2002:a2e:889a:: with SMTP id k26mr8734454lji.438.1622931321802;
        Sat, 05 Jun 2021 15:15:21 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-228-193.NA.cust.bahnhof.se. [98.128.228.193])
        by smtp.gmail.com with ESMTPSA id a20sm1183920ljk.29.2021.06.05.15.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jun 2021 15:15:21 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH] perf/hisi: Constify static attribute_group structs
Date:   Sun,  6 Jun 2021 00:15:14 +0200
Message-Id: <20210605221514.73449-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are only put in an array of pointers to const attribute_group
structs. Make them const like the other static attribute_group structs
to allow the compiler to put them in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/perf/hisilicon/hisi_uncore_pa_pmu.c   | 2 +-
 drivers/perf/hisilicon/hisi_uncore_sllc_pmu.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/hisilicon/hisi_uncore_pa_pmu.c b/drivers/perf/hisilicon/hisi_uncore_pa_pmu.c
index e1f71eab5640..83264ec0a957 100644
--- a/drivers/perf/hisilicon/hisi_uncore_pa_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_pa_pmu.c
@@ -333,7 +333,7 @@ static struct attribute *hisi_pa_pmu_identifier_attrs[] = {
 	NULL
 };
 
-static struct attribute_group hisi_pa_pmu_identifier_group = {
+static const struct attribute_group hisi_pa_pmu_identifier_group = {
 	.attrs = hisi_pa_pmu_identifier_attrs,
 };
 
diff --git a/drivers/perf/hisilicon/hisi_uncore_sllc_pmu.c b/drivers/perf/hisilicon/hisi_uncore_sllc_pmu.c
index 08e028d9a406..6aedc303ff56 100644
--- a/drivers/perf/hisilicon/hisi_uncore_sllc_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_sllc_pmu.c
@@ -366,7 +366,7 @@ static struct attribute *hisi_sllc_pmu_identifier_attrs[] = {
 	NULL
 };
 
-static struct attribute_group hisi_sllc_pmu_identifier_group = {
+static const struct attribute_group hisi_sllc_pmu_identifier_group = {
 	.attrs = hisi_sllc_pmu_identifier_attrs,
 };
 
-- 
2.31.1

