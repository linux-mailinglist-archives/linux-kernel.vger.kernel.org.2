Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FED536F809
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 11:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbhD3Jll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 05:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbhD3Jlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 05:41:40 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA65DC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 02:40:52 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id l2so17520420wrm.9
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 02:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YqQG962SVshTpUZ/kMVkNgzpW3WoV/92m2+7KXBNH9c=;
        b=AEtcRz0RDsyeMsLBUBexlQbdrAnECa4f55Fa94keCVL5fKNm04JEvT9RHAYyHrGzRY
         e6WQcXzYqxNMaHD9w+jEUQWWTCcvhVs1caZX2M606yYsCXc0CplA/Hey0sq3gdnfn4SH
         QhrgGZjDXZpMTxiABhGbQE0AIqRWIB6hSFZ6Nxm8R6LjWGg2R4IBHhFEXEGfqpcLvMiD
         6bb47iEL4I7NcWGWGtBJJvPYtxOHS7yoLzkHmExZKYxEcU8fQJ1WGrOQ2u1DfmKpqX/3
         mOUGJImBPxFWzBirnKHvoHDVnVd7UxOBREsX3uckooimWXseQTMzZiBBIvsM+WFLPB47
         Q0KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YqQG962SVshTpUZ/kMVkNgzpW3WoV/92m2+7KXBNH9c=;
        b=d4xR8q/+88K7262PaYhZs4mfOpsJgVoSrJIyO6TsrP0CVn3I8V3ByAX6nlyC327Ix/
         19cqjjezrDHf+hLVRrW0bRNfUxDcqQv7xfXPtw31Q2csA1K73/V+TsIX75ippefitvaD
         Vv8swexhgjlhB21QyE/j3jUHmLp6Afe8PJbvtvq0KtaDz4M36lbdaWHbkNewYtSKp1R2
         XkwSb5VtTwHBo4TdtS4en5PW0MIaFe7+Kf3app5EUNETJ80BPGroEz5hcyhjxgZ0FG6k
         TQ1BaKNWHaJKmaj+rYdWtAYWAmaXUeVexDFYj27fEBbQ0RwxdSvvMbAsoLcOyfa1rr3U
         v+BA==
X-Gm-Message-State: AOAM531kM6ZI96jbRMOmhWfatV5eA19rINpUXA2/7ywsoirqmRgrembZ
        fjtI7NuvfLVL8X3S3ZT3xKazEw==
X-Google-Smtp-Source: ABdhPJyHqFEzYqJ50DfsORmI7X28WiffJ+Gm2QHn4Shm/FiW0pB0M6PKStog6LTbyos2KW+HQt8KXA==
X-Received: by 2002:a5d:4a02:: with SMTP id m2mr5455386wrq.188.1619775651600;
        Fri, 30 Apr 2021 02:40:51 -0700 (PDT)
Received: from google.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id a2sm1711504wrt.82.2021.04.30.02.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 02:40:51 -0700 (PDT)
Date:   Fri, 30 Apr 2021 09:40:48 +0000
From:   Quentin Perret <qperret@google.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Android Kernel Team <kernel-team@android.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Patrick Bellasi <patrick.bellasi@matbug.net>
Subject: Re: [PATCH v2] sched: Fix out-of-bound access in uclamp
Message-ID: <YIvQoG52Vk96DJQ/@google.com>
References: <20210429152656.4118460-1-qperret@google.com>
 <CAKfTPtAfgVnMYkY_M+SDmNQDb_EsxSctQw-fkt2WJhczZakOjQ@mail.gmail.com>
 <YIu/EjZ8QsEl9sum@google.com>
 <CAKfTPtDOuB0UzZM5OtNzCUABftz_A40Z4W1z9OAORzFitfPDEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtDOuB0UzZM5OtNzCUABftz_A40Z4W1z9OAORzFitfPDEQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 30 Apr 2021 at 10:49:50 (+0200), Vincent Guittot wrote:
> 20 buckets is probably not the best example because of the rounding of
> the division. With 16 buckets, each bucket should be exactly 64 steps
> large except the last one which will have 65 steps because of the
> value 1024. With your change, buckets will be 65 large and the last
> one will be only 49 large

OK, so what do you think of this?

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c5fb230dc604..dceeb5821797 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -920,14 +920,14 @@ static struct uclamp_se uclamp_default[UCLAMP_CNT];
  */
 DEFINE_STATIC_KEY_FALSE(sched_uclamp_used);

-#define UCLAMP_BUCKET_DELTA (SCHED_CAPACITY_SCALE / UCLAMP_BUCKETS + 1)
+#define UCLAMP_BUCKET_DELTA DIV_ROUND_CLOSEST(SCHED_CAPACITY_SCALE, UCLAMP_BUCKETS)

 #define for_each_clamp_id(clamp_id) \
        for ((clamp_id) = 0; (clamp_id) < UCLAMP_CNT; (clamp_id)++)

 static inline unsigned int uclamp_bucket_id(unsigned int clamp_value)
 {
-       return clamp_value / UCLAMP_BUCKET_DELTA;
+       return min(clamp_value / UCLAMP_BUCKET_DELTA, UCLAMP_BUCKETS - 1);
 }

 static inline unsigned int uclamp_none(enum uclamp_id clamp_id)
