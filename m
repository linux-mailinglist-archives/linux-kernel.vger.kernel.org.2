Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4784539DFFD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 17:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbhFGPMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 11:12:08 -0400
Received: from mail-pf1-f176.google.com ([209.85.210.176]:38497 "EHLO
        mail-pf1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbhFGPMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 11:12:05 -0400
Received: by mail-pf1-f176.google.com with SMTP id z26so13291291pfj.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 08:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CyhSA0HZXSwzbxjylXSnlqEooN36dMYeyMrQufwloxc=;
        b=Qt1UPicDa+UU2VmOY0pJBQ259OpaqgZjE30H32TDyaaWKun4/1AbDZWdhroZZRbKtz
         vu1OWUPEuVphQY7wDVdqQ2FMKBq0HWmYsISn4BlbZYvtvpb7ZtqqvRew0THvyugcxuOD
         0ZvzOzbIRSx3asMgBJlrQlmOy7Q93+cqRhqN8apFl/d39bo/rvyQWiVRzJR5YGV22zSN
         E7H+b1dYWEpUwhX+2S/6c2RGKCwJ6T7gsuuqL1W9QRc7XtHco9hXcO8XJ2h639FDP9vu
         Fnbsy2MKdEGfHq9tGsMIMT+SfjxS940KnLev9WoELaKQwsyKvIhPtOav3wmfwmoGJ936
         Y7ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CyhSA0HZXSwzbxjylXSnlqEooN36dMYeyMrQufwloxc=;
        b=uB9hwP6jIc3IApfbJPiGg8T13xjxLIgbTzC1Sp58/UUd9hnhEap2VftQHmkis6Wh4u
         g7st/W8uIgMZkG8oM9zgkXJCS46wW1QBY7X/rY1cEvMihuz7GqiwV9UeZzTXt3AXiZyN
         CUqWnoFGY3Ze7x7eDFPcSpxOOdkx+7NCCLzB3wkku2VqBdX7U2A72NzxgdbetXh+Wtsi
         Zx/YymHWhvF+XwYsRIRNq+4Tgd8kfVQ5ZUDqGq8UvSuZbbd+lU0OhLTVfV4w/bYIt2zO
         BWC1VKOcg6iblxWiMxDg7YXvKdMEO0hP8EqrCP4EbxiSSuFX2RQxJws+vDfTZW/9d+TU
         jfWg==
X-Gm-Message-State: AOAM533LWK9C53FwP5oB9STPXehcZNaw+Cd4LyhApR5L536uN1mNZLeA
        lbjvDyIoZEc+t4JHaiPxVvXy89NP10pe8MeEtsk=
X-Google-Smtp-Source: ABdhPJxOJVs7oeh8RVkMB2oNzC96Z1htkLVbcTpKTHChVCIqHYTE0GAU1CZ61m6jdGE8/kcmtk/YiA==
X-Received: by 2002:aa7:8d82:0:b029:2ec:a73b:aff9 with SMTP id i2-20020aa78d820000b02902eca73baff9mr11722166pfr.51.1623078554412;
        Mon, 07 Jun 2021 08:09:14 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (ec2-18-167-84-74.ap-east-1.compute.amazonaws.com. [18.167.84.74])
        by smtp.gmail.com with ESMTPSA id n6sm9071583pgm.79.2021.06.07.08.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 08:09:13 -0700 (PDT)
Date:   Mon, 7 Jun 2021 23:09:03 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
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
        Andi Kleen <ak@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 8/8] perf record: Directly bail out for compat case
Message-ID: <20210607150903.GC1071897@leoy-ThinkPad-X240s>
References: <20210602103007.184993-1-leo.yan@linaro.org>
 <20210602103007.184993-9-leo.yan@linaro.org>
 <c321e998-6fd2-86e9-7876-7250a9b23c25@intel.com>
 <20210602123847.GE10272@leoy-ThinkPad-X240s>
 <96e5fac6-17a2-ea03-9b15-338b84321ecf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96e5fac6-17a2-ea03-9b15-338b84321ecf@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07, 2021 at 01:23:43PM +0300, Adrian Hunter wrote:
> On 2/06/21 3:38 pm, Leo Yan wrote:
> > Hi Adrain,
> > 
> > On Wed, Jun 02, 2021 at 02:18:47PM +0300, Adrian Hunter wrote:
> >> On 2/06/21 1:30 pm, Leo Yan wrote:
> >>> Since the 64-bit atomicity is not promised in 32-bit perf, directly
> >>> report the error and bail out for this case.
> >>>
> >>> Now only applies on x86_64 and Arm64 platforms.
> >>>
> >>> Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
> >>
> >> Maybe we can do better for the compat case.
> >>
> >> We can assume the upper 32-bits change very seldom,
> >> and always increase. So for the 'read' case:
> >>
> >> 	u64 first, second, last;
> >> 	u64 mask = (u64)((u32)-1) << 32;
> >>
> >> 	do {
> >> 		first = READ_ONCE(pc->aux_head);
> >> 		rmb();
> >> 		second = READ_ONCE(pc->aux_head);
> >> 		rmb();
> >> 		last = READ_ONCE(pc->aux_head);
> >> 	} while ((first & mask) != (last & mask));
> >> 	return second;
> >>
> >> For the write case, we can cause a fatal error only if the new
> >> tail has non-zero upper 32-bits.  That gives up to 4GiB of data
> >> before aborting:
> >>
> >> 	if (tail & mask)
> >> 		return -1;
> >> 	smp_mb();
> >> 	WRITE_ONCE(pc->aux_tail, tail);
> > 
> > Seems to me, it's pointless to only support aux_head for 64-bit and
> > support aux_tail for 32-bit.  I understand this can be helpful for the
> > snapshot mode which only uses aux_head, but it still fails to support
> > the normal case for AUX ring buffer using 64-bit head/tail.
> 
> I am not sure why you say it is pointless.  'perf record' would still be
> able to capture up to 4GiB of data. Do you mean you usually capture more
> than 4GiB of data?

Okay, understand.  We can support 32-bit perf for compat mode when the
trace data is less than 4GiB.

> I was thinking we would separate out the compat case:
> 
> #if BITS_PER_LONG == 32
> 	if (kernel_is_64_bit)
> 		return compat_auxtrace_mmap__[read_head/write_tail]()
> #endif
> 
> So the non-compat cases would not be affected.

Because I don't want to introduce the complexity for read/write head
and tail, and we also need to handle the same issue for the perf ring
buffer.  So how about below change?

The main idea for below change is it allows the perf to run normally
on the compat mode and exitly if detects the buffer head is close to
the low 32-bit's overflow: when detect the low 32-bit value is bigger
than 0xf0000000 (so we have 256MiB margin to the overflow), it reports
error and exit.

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 1b4091a3b508..2a9965bfeab4 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -1693,6 +1693,14 @@ static int __auxtrace_mmap__read(struct mmap *map,
 	pr_debug3("auxtrace idx %d old %#"PRIx64" head %#"PRIx64" diff %#"PRIx64"\n",
 		  mm->idx, old, head, head - old);
 
+#ifdef BITS_PER_LONG == 32
+	if (kernel_is_64bit() && head >= 0xf0000000) {
+		pr_err("32-bit perf cannot read 64-bit value atomically;\n");
+		pr_err("exit to avoid the 4GB (32-bit) AUX buffer overflow on compat mode.\n");
+		return -ENOMEM;
+	}
+#endif
+
 	if (mm->mask) {
 		head_off = head & mm->mask;
 		old_off = old & mm->mask;
diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index 9130f6fad8d5..823b69895b85 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -405,3 +405,20 @@ int perf_env__numa_node(struct perf_env *env, int cpu)
 
 	return cpu >= 0 && cpu < env->nr_numa_map ? env->numa_map[cpu] : -1;
 }
+
+int perf_kernel_is_64bit(void)
+{
+	struct utsname uts;
+	int ret;
+
+	ret = uname(&uts);
+	if (ret < 0)
+		return 0;
+
+	if (!strncmp(uts.machine, "x86_64", 6) ||
+	    !strncmp(uts.machine, "aarch64", 7) ||
+	    !strncmp(uts.machine, "arm64", 5))
+		return 1;
+
+	return 0;
+}
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index ca249bf5e984..c6c034fc08f6 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -147,4 +147,6 @@ void perf_env__insert_btf(struct perf_env *env, struct btf_node *btf_node);
 struct btf_node *perf_env__find_btf(struct perf_env *env, __u32 btf_id);
 
 int perf_env__numa_node(struct perf_env *env, int cpu);
+
+int perf_kernel_is_64bit(void);
 #endif /* __PERF_ENV_H */
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index ab7108d22428..f1d3725d599a 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -323,6 +323,14 @@ int perf_mmap__push(struct mmap *md, void *to,
 	if (rc < 0)
 		return (rc == -EAGAIN) ? 1 : -1;
 
+#ifdef BITS_PER_LONG == 32
+	if (kernel_is_64bit() && head >= 0xf0000000) {
+		pr_err("32-bit perf cannot read 64-bit value atomically;\n");
+		pr_err("exit to avoid the 4GB (32-bit) buffer overflow on compat mode.\n");
+		return -ENOMEM;
+	}
+#endif
+
 	size = md->core.end - md->core.start;
 
 	if ((md->core.start & md->core.mask) + size != (md->core.end & md->core.mask)) {

Thanks,
Leo
