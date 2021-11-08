Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADCEE447B3F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 08:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235879AbhKHHnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 02:43:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235686AbhKHHnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 02:43:33 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCCBEC061570
        for <linux-kernel@vger.kernel.org>; Sun,  7 Nov 2021 23:40:49 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id g25-20020a25b119000000b005c5e52a0574so281339ybj.5
        for <linux-kernel@vger.kernel.org>; Sun, 07 Nov 2021 23:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=sUtivsoVmIxGeGa4QKLNOq3mLxq5mE35JtRoIExa9WM=;
        b=fTdtn5RPYVpnCblz/8aKlnCrIz1xgQlNpTw8YAIFjrDlIQk0eIMyPo5PTlKAZ4u9EI
         i3GD/czcAEL87Fz9pnzXE/4KOqxPPku7fYwkMAzo/5yM+uTuQx/UO/l2lpJq3+AYOK9W
         DjOKMGCyXabm9WunAq1NIQgsHTTVQPoeJRB4Z2myDtmGR8/xiWdP0FDMhAgqkitvIbig
         tIy+p5yF5DqrxK5APFFpkUnDXYFaWLBK/8FogilpRMyR2NgNRc1dsL6ig1B8YcBaP1xc
         0KPovSSwcHpw4RthMt/g0E4IuD/jBMj3c9orDBYOxqE2vGIafuKRNWReXcZbun/C0wmt
         EYBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=sUtivsoVmIxGeGa4QKLNOq3mLxq5mE35JtRoIExa9WM=;
        b=kUinHy3z/w2BWJrGNvybNfNTojy+cYEkQXGPmGBQJzYY+QG1MPcVHKclhGfbIi5tr+
         p7Wdgtz3sw+0PBjwruRvXkXWyMTZ9GGjGpQ7gvEHC/y+T7LXXA5A860xTPDcZpCWVnsG
         L+JQ1OHWfe+6alA6aAkk9YfINxNrhOCLRuamaFMR4nglX8U47DfRqpByO9BhEGqlpEH2
         LDTQPjd4A2D4804T3buC/MwPQfGDIPiD/T37w0zfbr6lwb7w+tO0izkHCOA70jhaUyiV
         A4lDan2GDZUXn/kQw4c3J5FHvZ1jDKBUrth7ZdaxS/JaG+VlsSYgd+KjvM/+x9iHEtXa
         +SaQ==
X-Gm-Message-State: AOAM533P1+XDLflZr1gqydef8CKa5vRJLhyx/3tMmKehNniSTcHDcjao
        jFeKvXVajd5CQEfYhPCGLttx6RCFfzkWqqtr2QCWnErVh14R/ID89GaPTBwY39H9IpsSmHsneqW
        Lw8smDCIA0XdwdCz8DKkRtbDiI7D6XvH+7+zvfqYgRTr0X38GQYvV/QjMuHUvpyzVQGFpCLN/
X-Google-Smtp-Source: ABdhPJwte1yBki3+M1wz+zsoBwjnbnuPLF1IkjJXM7eEcDn0g6zaFAU+R/b8437vLnYiASeCha8Ztg8bWs/X
X-Received: from uluru3.svl.corp.google.com ([2620:15c:2cd:202:b53e:50ca:b5fb:c18e])
 (user=eranian job=sendgmr) by 2002:a05:6902:1081:: with SMTP id
 v1mr38616420ybu.397.1636357248950; Sun, 07 Nov 2021 23:40:48 -0800 (PST)
Date:   Sun,  7 Nov 2021 23:40:45 -0800
Message-Id: <20211108074045.3181854-1-eranian@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [PATCH] perf report: fix output of WEIGHT_STRUCT
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     acme@redhat.com, jolsa@redhat.com, ak@linux.intel.com,
        kan.liang@intel.com, irogers@google.com, namhyung@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The output of the WEIGHT_STRUCT record was not consistent among its
fields. Some are printed in decimal, other in hexdecimal. It does not
make sense to print a weight in hexadecimal.

Signed-off-by: Stephane Eranian <eranian@google.com>
---
 tools/perf/util/session.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 352f16076e01..94c056695a93 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1332,8 +1332,8 @@ static void dump_sample(struct evsel *evsel, union perf_event *event,
 	if (sample_type & PERF_SAMPLE_WEIGHT_TYPE) {
 		printf("... weight: %" PRIu64 "", sample->weight);
 			if (sample_type & PERF_SAMPLE_WEIGHT_STRUCT) {
-				printf(",0x%"PRIx16"", sample->ins_lat);
-				printf(",0x%"PRIx16"", sample->p_stage_cyc);
+				printf(", %"PRIu16"", sample->ins_lat);
+				printf(", %"PRIu16"", sample->p_stage_cyc);
 			}
 		printf("\n");
 	}
-- 
2.34.0.rc0.344.g81b53c2807-goog

