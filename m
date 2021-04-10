Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFCA35AAF5
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 07:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233707AbhDJFCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 01:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbhDJFCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 01:02:13 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B52DC061762
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 22:01:58 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id l1so3705350plg.12
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 22:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gk/+cUxEFhkA5Sr23xDJi6lyVwLgABo9cNglBLLd61g=;
        b=MHzX+bH5wAfGsTIjjMgZ8+J+KG3d/2OycnIBTrqE+sj5TI+m4n+qeglu+BSY7rzm3T
         wSJav4Gf2niOUp07dCN9UESr6hR3WpXQKkkNC60faX4rS7I5gkWj++iprL/Da9rxq4L0
         p4fRX6PTRW8N3HZz/MdHzaZlBO1Lg4r+b2+AFjukrfmXuJJ+3mOPgBi8hh6lSr9nRiU2
         hen5YX24paXB7psi3qAo+H4VpW4CJsbPujw3EoKMAByFRKiaKsKxP7eBTCJImdmdEyBm
         kS655LqURaDNKL+WsSrKgJ4vgofVtftfQklTVSH8Xu0L9CEpznSlhuYqFRp2hWay8Dvi
         L9Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gk/+cUxEFhkA5Sr23xDJi6lyVwLgABo9cNglBLLd61g=;
        b=T5vPOD/k70m0l86aglwzjDJz7rEyXiAAXhlUlwzi8b/SSn1sERQjZwDP2ZmpcSqbXD
         W5ULooHCaIN4p6Xtnxt7N1RUVeQdjjPc3XFRLZJYCQkpYJ8sPFJDQE5o2Sk223bGxYaJ
         JB74U7gVCJ9zYkMVgTCzhJ85KUgGkjhbfJHoSHXJuAlfJNmlgj1WvPpGRSVoEhd1yp/S
         Y6V73uz1D54driczf9DbwuZUphVctj4LRyf0S7AH/B7wZu520PsLaeVbxd7dYvHXZui0
         lRAGTUJUDq6v+mXBkx/x4jS+YNdiGJ7gcoX0NRw2S6WWP4sK9idur624KbfQ8XWIXBWX
         g4gg==
X-Gm-Message-State: AOAM531cVIgHrVYZuX5ZJv6ENfR+hU00u3p4r/IxzxOnsuXY5N7rwCDH
        gS1YvsiojHBo5jEZoSe+ZE5YGw==
X-Google-Smtp-Source: ABdhPJyPq0oOx2MfQ6NZ/w5udW4Rm+IrpgcyDCfR8yJ1J6lY1i5dHLanogygyBkXcCFG/6Pj5C0hyg==
X-Received: by 2002:a17:90b:1e0b:: with SMTP id pg11mr17539430pjb.146.1618030917907;
        Fri, 09 Apr 2021 22:01:57 -0700 (PDT)
Received: from localhost ([116.206.101.232])
        by smtp.gmail.com with ESMTPSA id u18sm3607677pfm.4.2021.04.09.22.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 22:01:57 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Al Grant <Al.Grant@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        James Clark <James.Clark@arm.com>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 1/6] perf arm-spe: Remove unused enum value ARM_SPE_PER_CPU_MMAPS
Date:   Sat, 10 Apr 2021 13:00:41 +0800
Message-Id: <20210410050046.5394-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210410050046.5394-1-leo.yan@linaro.org>
References: <20210410050046.5394-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The enum value 'ARM_SPE_PER_CPU_MMAPS' is never used so remove it.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/arm-spe.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/util/arm-spe.h b/tools/perf/util/arm-spe.h
index 98d3235781c3..105ce0ea0a01 100644
--- a/tools/perf/util/arm-spe.h
+++ b/tools/perf/util/arm-spe.h
@@ -11,7 +11,6 @@
 
 enum {
 	ARM_SPE_PMU_TYPE,
-	ARM_SPE_PER_CPU_MMAPS,
 	ARM_SPE_AUXTRACE_PRIV_MAX,
 };
 
-- 
2.25.1

