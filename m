Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 919D638880A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 09:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239754AbhESHVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 03:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239522AbhESHVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 03:21:14 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13333C061761
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 00:19:54 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id k15so8798068pgb.10
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 00:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VF7HOk9FnOo7p3niyuc/ZeydcOUyPtyVd5u7rDmQFT0=;
        b=EM5liwyzntU9Cj0R9VZ/vTntNwcOgx+IqSmnrR+4qu+Wk0p0ypqYuTODL2r5OW+9jq
         FiHKDrnpQ2Nv5WEbqX7D8qHVtUg7h0qQRT7ja4Or4opgEGILz6r1Ih1tSn12ORGd3tjP
         mNVBoF4yHFUcANpACuFQXyA6jafxUCIpMPrNXBr8+alRZymbhzvD9gzGswmajl7qDhwG
         dIXe5+nLkP5ej/gxj08Nnl+oEayMo/dg0ZCDrqQyTksVlb/RudCXIztuNU+SUcFe12uX
         D6dueLH6R+wV8lCI93Z0nxFTWM5UMYEdvR5NdW4bc4GdhmQqeuSmoWy75TnB25WsD+C2
         o/iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VF7HOk9FnOo7p3niyuc/ZeydcOUyPtyVd5u7rDmQFT0=;
        b=Zx2woJ/3bu3F3Std4rcWw2jiW4F4aZ1qHd0qdvoOpzpAihK1aR1AsjYu6pS+yKWFtZ
         Rpg+U17T7/mqsLAPg8NUhyXvV4u5wrpe/zYknnr7FQjq7iDU1zonh2NxsAAMlQt/PgaQ
         uweFDhdvtIE+hEpV+AjUCb+LtHdYrH1hPybxBjT1ABvy5ABWoSsBO+bsLIeyE7oPNHDg
         4jOCxpwaQhigQma92zZWoB25qHf6JP7fJIWFdmnnFxL7TJJeYPlg7ei3R5BsJ3fcOStJ
         al5wWV2Dpj3637Bvxcu1VW5Kcg4Bc/iOvCE6Ky1vGKJpH8hsfvdZ4L56gySpnLXK6vSx
         rmAw==
X-Gm-Message-State: AOAM530oWDA0ty3Y4wweFJny9hgBQxoBGwUAMoOQFhOQA/Q0Q0x1YWpa
        C7wczePAtsZHW/ncK+FrU9c1Pw==
X-Google-Smtp-Source: ABdhPJyWwwksCQZO2Hl+jN5SqYaQRszYdtaCccXCpevrwOSiRCdoiwIkINF5nLlC1dZqjTyS6nd9hQ==
X-Received: by 2002:a63:2218:: with SMTP id i24mr9373392pgi.335.1621408793596;
        Wed, 19 May 2021 00:19:53 -0700 (PDT)
Received: from localhost ([103.207.71.35])
        by smtp.gmail.com with ESMTPSA id 14sm13469638pfj.29.2021.05.19.00.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 00:19:53 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Dave Martin <Dave.Martin@arm.com>, Al Grant <Al.Grant@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v5 2/5] perf arm-spe: Convert event kernel time to counter value
Date:   Wed, 19 May 2021 15:19:36 +0800
Message-Id: <20210519071939.1598923-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210519071939.1598923-1-leo.yan@linaro.org>
References: <20210519071939.1598923-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When handle a perf event, Arm SPE decoder needs to decide if this perf
event is earlier or later than the samples from Arm SPE trace data; to
do comparision, it needs to use the same unit for the time.

This patch converts the event kernel time to arch timer's counter value,
thus it can be used to compare with counter value contained in Arm SPE
Timestamp packet.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/arm-spe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index d2ae5a5c13ee..ff8b52e6d475 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -669,7 +669,7 @@ static int arm_spe_process_event(struct perf_session *session,
 	}
 
 	if (sample->time && (sample->time != (u64) -1))
-		timestamp = sample->time;
+		timestamp = perf_time_to_tsc(sample->time, &spe->tc);
 	else
 		timestamp = 0;
 
-- 
2.25.1

