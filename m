Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE2D3F4BBF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 15:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237266AbhHWNbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 09:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232437AbhHWNbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 09:31:33 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4477BC061757
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 06:30:51 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id 18so15374866pfh.9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 06:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ODvhxN1h3My2xCRqsnXsIvfrBdID67wSeUzABvdfpFo=;
        b=a/blRocIIPrF8HfVAmCgyWq+DBw/kFO4f+9Nd8uiohRuZT0fcEMf9kmuzDV+UqrAoq
         KTO+wZRUBhKwMmLXQAk6k2NQuYtU+pI5gBih7ZEQ3rnb08klATCmDzhWqmy+Wy3luL6p
         CDMyZOkv1UJbjjUKEEj0KDtGUGt4Tu15/uyWHMAG4HjA0BaWYM0k/4W4ZWUWgmh3QASp
         fpN1MlYvts4SAKII+JaCwwzfHVQ/pTobrMTrYoUmqf+edIxG3DqKT/hs+qmvc0jmCyAR
         YZkku6YWdlGkxLIDQrcWJniZUoyDfai4M0Qb1OJTrcO/JG/A1QtuJie5B411EBCe6iPc
         kMjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ODvhxN1h3My2xCRqsnXsIvfrBdID67wSeUzABvdfpFo=;
        b=mDS4LtoXwK/F0VjLzHQacn2fwlDQA07AXlcp/27/svBvOUUeeqFkbdEZUV4yYdkYyj
         CwMOLLa0b3hjUS4yQ+TMJc7i06Zv9NNQaqUntebd7YJaRIbVpdSb2Qph3AxCNbr5cMsv
         ubIXkswlfySGRLYQKMdEXQYX+we93+sBHo0rXI5um1PLU1imgWl0/S6co6TExSVDkx65
         uOTsRl8JXtrvS/43BJ7bPkT3CDbbjzzraaklbzONDnccl7wb0Og6DXEGaHi8D+N0CsQZ
         nogYi8NBO2Bww0Q8t/GoOPBbu7o6kRbD68ATZ2keZWLsZzraahjVVjo4YwY8DCIrJQm4
         bGPQ==
X-Gm-Message-State: AOAM532Fa6f6p5S1aI4MZ5njKV8avVN0o/+8AGjYm86TgrN6rpQiOIY3
        ADY+mA8bauxpTJiK18rl5pgMQQ==
X-Google-Smtp-Source: ABdhPJxcASJr92dk3H/AjBdcjDuti6sHoXFIlCkLb6s+6JYIuxaiRk33gcCJWiSR/lm/rhOdkTLkbQ==
X-Received: by 2002:aa7:8713:0:b0:3e0:4537:a1d4 with SMTP id b19-20020aa78713000000b003e04537a1d4mr34204009pfo.1.1629725450565;
        Mon, 23 Aug 2021 06:30:50 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([202.155.204.36])
        by smtp.gmail.com with ESMTPSA id w82sm16319595pff.112.2021.08.23.06.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 06:30:49 -0700 (PDT)
Date:   Mon, 23 Aug 2021 21:30:43 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Li Huafei <lihuafei1@huawei.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        John Garry <john.garry@huawei.com>, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/3] perf auxtrace arm: Support
 compat_auxtrace_mmap__{read_head|write_tail}
Message-ID: <20210823133043.GF100516@leoy-ThinkPad-X240s>
References: <20210809112727.596876-1-leo.yan@linaro.org>
 <20210809112727.596876-4-leo.yan@linaro.org>
 <6ce4057a-57cf-501d-6449-2069cd00ba57@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ce4057a-57cf-501d-6449-2069cd00ba57@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On Mon, Aug 23, 2021 at 01:23:42PM +0100, James Clark wrote:
> 
> 
> On 09/08/2021 12:27, Leo Yan wrote:
> > When the tool runs with compat mode on Arm platform, the kernel is in
> > 64-bit mode and user space is in 32-bit mode; the user space can use
> > instructions "ldrd" and "strd" for 64-bit value atomicity.
> > 
> > This patch adds compat_auxtrace_mmap__{read_head|write_tail} for arm
> > building, it uses "ldrd" and "strd" instructions to ensure accessing
> > atomicity for aux head and tail.  The file arch/arm/util/auxtrace.c is
> > built for arm and arm64 building, these two functions are not needed for
> > arm64, so check the compiler macro "__arm__" to only include them for
> > arm building.
> > 
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  tools/perf/arch/arm/util/auxtrace.c | 32 +++++++++++++++++++++++++++++
> >  1 file changed, 32 insertions(+)
> > 
> > diff --git a/tools/perf/arch/arm/util/auxtrace.c b/tools/perf/arch/arm/util/auxtrace.c
> > index b187bddbd01a..c7c7ec0812d5 100644
> > --- a/tools/perf/arch/arm/util/auxtrace.c
> > +++ b/tools/perf/arch/arm/util/auxtrace.c
> > @@ -107,3 +107,35 @@ struct auxtrace_record
> >  	*err = 0;
> >  	return NULL;
> >  }
> > +
> > +#if defined(__arm__)
> > +u64 compat_auxtrace_mmap__read_head(struct auxtrace_mmap *mm)
> > +{
> > +	struct perf_event_mmap_page *pc = mm->userpg;
> > +	u64 result;
> > +
> > +	__asm__ __volatile__(
> > +"	ldrd    %0, %H0, [%1]"
> > +	: "=&r" (result)
> > +	: "r" (&pc->aux_head), "Qo" (pc->aux_head)
> > +	);
> > +
> > +	return result;
> > +}
> 
> Hi Leo,
> 
> I see that this is a duplicate of the atomic read in arch/arm/include/asm/atomic.h

Exactly.

> For x86, it's possible to include tools/include/asm/atomic.h, but that doesn't
> include arch/arm/include/asm/atomic.h and there are some other #ifdefs that might
> make it not so easy for Arm. Just wondering if you considered trying to include the
> existing one? Or decided that it was easier to duplicate it?

Good finding!

With you reminding, I recognized that the atomic operations for
arm/arm64 should be improved for user space program.  So far, perf tool
simply uses the compiler's atomic implementations (from
asm-generic/atomic-gcc.h) for arm/arm64; but for a more reliable
implementation, I think we should improve the user space program with
architecture's atomic instructions.

So I think your question should be converted to: should we export the
arm/arm64 atomicity operations to user space program?  Seems to me this
is a challenge work, we need at least to finish below items:

- Support arm64 atomic operations and reuse kernel's
  arch/arm/include/asm/atomic.h;
- Support arm atomic operation and reuse kernel's
  arch/arm/include/asm/atomic.h;
- For aarch32 building, we need to use configurations to distinguish
  different cases, like LPAE, Armv7, and ARMv6 variants (so far I have
  no idea how to use a graceful way to distinguish these different
  building in perf tool).

I am not sure if there have any existed ongoing effort for this part,
if anyone is working on this (or before have started related work),
then definitely we should look into how we can reuse the arch's
atomic headers.

Otherwise, I prefer to firstly merge this patch with dozen lines of
duplicate code; afterwards, we can send a separate patch set to
support arm/arm64 atomic operations in user space.

If any Arm/Arm64 maintainers could shed some light for this part work,
I think it would be very helpful.

> Other than that, I have tested that the change works with a 32bit build with snapshot
> and normal mode.
> 
> Reviewed by: James Clark <james.clark@arm.com>
> Tested by: James Clark <james.clark@arm.com>

Thanks for test and review!

Leo
