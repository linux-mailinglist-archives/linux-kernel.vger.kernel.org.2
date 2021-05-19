Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E04C3885E7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 06:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240410AbhESERh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 00:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238882AbhESER2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 00:17:28 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19397C06175F
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 21:16:08 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id t11so6683994pjm.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 21:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D1RKoRUPuNTpnbjdR5aGjDE7LDjBJaTYkeLxTxjV2B0=;
        b=XdLYknR3fS24BTVvcLO3iqnPV+utzH9WZmcaLVtD0da3CEd5nRSGOsYgETlrU0h0be
         XTFcdN16VnEGZSiAQWx8Jvxu/bc14GkHzaqJE4Bu8qqEv0DIneoy8ewj7eTQndwMZPSc
         gMc5biLXt5doir7/csUoUlJz92NHQKPnwJRvauj5n/4ZF0VmfmQ8D3xND0+36/esjZZ6
         QxTtkq8kQ+bqIEwOhilUnMl49r1x2PXqe2KXNzy5JYhS/yzDGtCky1lMghgG9DNIt0Ow
         28n2CzKD7dRk6sQKo+KjWubnmO+eTbzcjJoPmVHTmanbu2q1OWqbL0wgMeBB9WVpOnBJ
         +lgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D1RKoRUPuNTpnbjdR5aGjDE7LDjBJaTYkeLxTxjV2B0=;
        b=YMJawdV+kcYNHB9yKgIB7VHp4WT4WA7cZm3m1rRO6AtqXtazuzC3+YbSAExNKremUq
         DrJibILhUjLU8cKScHNk083bfsTCByqFFdYP1o/44lxseQ9YEjXd/uO6o9t/X410lM49
         pmbrrdfwDH4lEbrDS6lAtLwEGZ8RB+QAcEdyUR+/MSo3XM2gA2lc4o81DQMSHyJa3vpa
         SIGsEO0399KNmQiTlvfLCtksh70vyQ8un6eDFNR/V9QUvPoFpDB1znyjgwcFVpDLp0CS
         8aw3e0ysIkqq7vyuwjC3v/+wDoa11lCwq78kBOdhSSvNnHVfSPspyk/b4HV43s3vgTkB
         tCKg==
X-Gm-Message-State: AOAM530D38x90fg/6rr+pa424ZuXQJuGw3FZVk9OV/WWdFnctF4CQVij
        0ktwatkBr74UpopTrIZ/a2mwIA==
X-Google-Smtp-Source: ABdhPJyh6+EMoF+CHQhlbWP3oQvoiUYhgaYPgM56CYEO/3syDO+eek0q9XYJLvBDwxuc46LHh4nY5A==
X-Received: by 2002:a17:902:f784:b029:ef:8e2f:430e with SMTP id q4-20020a170902f784b02900ef8e2f430emr8615252pln.28.1621397767625;
        Tue, 18 May 2021 21:16:07 -0700 (PDT)
Received: from localhost ([103.207.71.35])
        by smtp.gmail.com with ESMTPSA id np1sm3007388pjb.13.2021.05.18.21.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 21:16:07 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        James Clark <james.clark@arm.com>, Al Grant <Al.Grant@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 4/4] perf arm-spe: Remove redundant checking for "full_auxtrace"
Date:   Wed, 19 May 2021 12:15:46 +0800
Message-Id: <20210519041546.1574961-5-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210519041546.1574961-1-leo.yan@linaro.org>
References: <20210519041546.1574961-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The option "opts->full_auxtrace" is checked at the earlier place, if it
is false the function will directly bail out.  So remove the redundant
checking for "opts->full_auxtrace".

Suggested-by: James Clark <james.clark@arm.com>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/arch/arm64/util/arm-spe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
index bacdf366040d..a4420d4df503 100644
--- a/tools/perf/arch/arm64/util/arm-spe.c
+++ b/tools/perf/arch/arm64/util/arm-spe.c
@@ -116,7 +116,7 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
 		return 0;
 
 	/* We are in full trace mode but '-m,xyz' wasn't specified */
-	if (opts->full_auxtrace && !opts->auxtrace_mmap_pages) {
+	if (!opts->auxtrace_mmap_pages) {
 		if (privileged) {
 			opts->auxtrace_mmap_pages = MiB(4) / page_size;
 		} else {
-- 
2.25.1

