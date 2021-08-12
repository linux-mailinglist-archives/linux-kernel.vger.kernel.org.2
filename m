Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3193EADC6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 02:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233865AbhHLX6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 19:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbhHLX6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 19:58:07 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05BCBC061756
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 16:57:41 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id a8so12606434pjk.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 16:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OnDcmEJajWUtEFaGEvj/D4Fwljwck+hH395Nlc7cE9Q=;
        b=SW3HXY/HQ7tbvrZRhnmZnGP9oiDqGO0ip2XW70FltQCFxJc/aMlRrMCWPkSZUzXpUj
         bj+DI0rpRVMsXiwG7baS5PP+NJ62KyCJX+tJqW7sPbPkbhZqm+lC64pKHYulY/Ae7Ynd
         ZtezRsN5GcWfRoKp4vuMqLIIX0QdCURXHIJZ85iSCNqNC5CbuMD+5NVme/B49xWIDhgR
         v3IT74lOdzn4ZGxhCoYXGUDvTTdiEHKbSB96nr4rk7n3kgOP4xpiacriUiVN7mttP9zE
         isf9wb14F7d5vWFEQqR3cVJjSlup68L10XYOEf4DJ4RaEN1b9V4IG9R1OCLRs6eRfUUn
         kFBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=OnDcmEJajWUtEFaGEvj/D4Fwljwck+hH395Nlc7cE9Q=;
        b=n8TaEhSmXv5ioxXJucjOVogOfYTj5XmDkLXRP9bLI2jWlQVj7SoQ1GjkbudBdnFXFx
         31OS+yi4dwoB+NQw+AF6jGv5VSbg08ial74V4o33O368hLD5nPHF5SkjtpLDdkPJa2b3
         Avbs9giy9lXkc+hGqbCESHrXvdsaW1InpZ/r0fRuIBMgnMZjSWjqu3+HKsEVWNzvvU9+
         FZdXss9UqqjLhVVhXouXPCsLuxq/uLIenHda369ftFdV2MxgfI0EAeJNBqLS5T6y5Nb0
         2Z4DrVgMsULLnnylcSzRtiqaf+RQJxkOWaCNm0rIG9+5QTzmVVOX376mViQN4dyNPXmE
         Wstw==
X-Gm-Message-State: AOAM533YxkeB/R93GRDPGHRAKQSIlAxGRFmuRgCMuuZ7BzkG2IfZPETd
        anVBYQPrOXWl4owYspDjwsY=
X-Google-Smtp-Source: ABdhPJxKjQ3N8G7TAQrlJRUDiTAvOEWivKMLjnAXnl8nke/NUe7LH1eiJ7IPuFD2RKHl5Rpl3j0I1g==
X-Received: by 2002:a05:6a00:2346:b029:3c6:9ff4:c5e6 with SMTP id j6-20020a056a002346b02903c69ff4c5e6mr6473733pfj.23.1628812661474;
        Thu, 12 Aug 2021 16:57:41 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4800:e240:d849:7fc0:9a49:373e])
        by smtp.gmail.com with ESMTPSA id v3sm286041pfn.28.2021.08.12.16.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 16:57:40 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Alexei Budankov <abudankov@huawei.com>,
        James Clark <James.Clark@arm.com>,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf test: Do not compare overheads in the zstd comp test
Date:   Thu, 12 Aug 2021 16:57:38 -0700
Message-Id: <20210812235738.1684583-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The overhead can vary on each run so it'd make the test failed
sometimes.  Also order of hist entry can change.

Use perf report -F option to omit the overhead field and sort the
result alphabetically.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/record+zstd_comp_decomp.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/shell/record+zstd_comp_decomp.sh b/tools/perf/tests/shell/record+zstd_comp_decomp.sh
index 045723b3d992..8a168cf8bacc 100755
--- a/tools/perf/tests/shell/record+zstd_comp_decomp.sh
+++ b/tools/perf/tests/shell/record+zstd_comp_decomp.sh
@@ -25,8 +25,8 @@ check_compressed_stats() {
 
 check_compressed_output() {
 	$perf_tool inject -i $trace_file -o $trace_file.decomp &&
-	$perf_tool report -i $trace_file --stdio | head -n -3 > $trace_file.comp.output &&
-	$perf_tool report -i $trace_file.decomp --stdio | head -n -3 > $trace_file.decomp.output &&
+	$perf_tool report -i $trace_file --stdio -F comm,dso,sym | head -n -3 > $trace_file.comp.output &&
+	$perf_tool report -i $trace_file.decomp --stdio -F comm,dso,sym | head -n -3 > $trace_file.decomp.output &&
 	diff $trace_file.comp.output $trace_file.decomp.output
 }
 
-- 
2.33.0.rc1.237.g0d66db33f3-goog

