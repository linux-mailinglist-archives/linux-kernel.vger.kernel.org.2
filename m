Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA9E398688
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 12:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232741AbhFBKcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 06:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232532AbhFBKcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 06:32:12 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26563C061756
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 03:30:29 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id j12so1866790pgh.7
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 03:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q5Wf8ghZ23c6vSvSmNVjb2NVOeSumBPmpt+tM4X+4G0=;
        b=vtKgbR14cR7y62vFxXZgh6OuBU1qzmZhTJ2Wh0fFfsK74YBw9tRK3mWWU9u22JQPdk
         gFmXg/EUtcHHVskldrPBIeKf/U8iU1jNTaFQF4J0rz0MxbYPr42ClzwSInc8+A13AGmQ
         l5nIgiDgpl5w1iGPge+sti8zpRxzlakhwNWB16gH1UvMHwn99Bq3btm8IVTPAOdjcWgo
         fwIZ7l/mVqNg2uJhKiz92FsNiYFP9PS/yGX6jsmcqgEPRKdv3LlpmS0oLUKpvzzgnD8g
         JklAAJtSqviT30Rzlt+iqkHuPB4RQ2VVdwXS7TMNHkEaP76AMl0EXoNvd2d5E1ot8w+Z
         qunQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q5Wf8ghZ23c6vSvSmNVjb2NVOeSumBPmpt+tM4X+4G0=;
        b=GQ0vW+sC6FqvsoE5Zyuwim+8gw1XkCVIEiayYl0TyPkb01/fJfVhkqE8q5othzfGjQ
         qZ/0xdK1CiTugoPnMxN5WrM451NCBMAVFlxicd8+foQoO0UfvHI8sHNdnwWGt5JKFAY6
         1hmm29G790vjn/ibCUczqYUjJcMmZUTpRXqkr+HDzbEY5GpVN4dkfMznBNMjQB69pvvU
         TxfiJaivGfACZFThLR3e5oJ7XO9d7g+BkM6vOe8RyHouDVHph7tFSXVdDzoSNX957Z1y
         hM+vtFVYW4qt6un4wVqTDXWS69FEsnpN3kxSRqLaMFC8RpAwrhuu2D3CEBM7oJsK4yzT
         dSeg==
X-Gm-Message-State: AOAM532sb5Oz+ljx2sgV2nOb9BmFULqbNlwArLNirH67yG5GT98TrmJV
        LGY6uvPgm7b8sIa8dLylLNQjYWtWVuiOOx7Z
X-Google-Smtp-Source: ABdhPJyW5O+lp5JviQc20HzDNUJCnF1tag3CzpppyeQ7jlEx5vWwxASM3CiSXM5Fvsi9co5grxHOOA==
X-Received: by 2002:a63:a602:: with SMTP id t2mr32573804pge.320.1622629828662;
        Wed, 02 Jun 2021 03:30:28 -0700 (PDT)
Received: from localhost (ec2-18-167-84-74.ap-east-1.compute.amazonaws.com. [18.167.84.74])
        by smtp.gmail.com with ESMTPSA id u21sm15385901pfh.163.2021.06.02.03.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 03:30:28 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 4/8] perf/x86: Add barrier after updating bts
Date:   Wed,  2 Jun 2021 18:30:03 +0800
Message-Id: <20210602103007.184993-5-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210602103007.184993-1-leo.yan@linaro.org>
References: <20210602103007.184993-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add barrier wmb() to separate the AUX data store and aux_head store.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 arch/x86/events/intel/bts.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/events/intel/bts.c b/arch/x86/events/intel/bts.c
index 6320d2cfd9d3..4a015d160bc5 100644
--- a/arch/x86/events/intel/bts.c
+++ b/arch/x86/events/intel/bts.c
@@ -209,6 +209,9 @@ static void bts_update(struct bts_ctx *bts)
 	} else {
 		local_set(&buf->data_size, head);
 	}
+
+	/* The WMB separates data store and aux_head store matches. */
+	wmb();
 }
 
 static int
-- 
2.25.1

