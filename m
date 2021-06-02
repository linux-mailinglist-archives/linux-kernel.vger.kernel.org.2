Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91C4F3989CA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 14:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbhFBMlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 08:41:52 -0400
Received: from mail-pg1-f171.google.com ([209.85.215.171]:39483 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbhFBMlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 08:41:50 -0400
Received: by mail-pg1-f171.google.com with SMTP id v14so2118908pgi.6
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 05:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tkfGbFk7RbowFQb2pdJ2DiNSH2Hl1PMpHr94hmyAtqs=;
        b=lxTZN5WbWFKLKZay+tdzygwECcBcBFtb83iQAMQ8lte/ef8eggQE+S6BXoanfnJ/4I
         dEl0mlNV6UDIdqkQHC32HZwJ89hL6aWyh2WgB3pOoIe9D/z8kfIjRpvSZIH8pmiPlNGS
         IpFZWdj+7gWvUjS9SyFwBbBo8H1aSB76NwmjvgtpvFHQToHJ+Kuddzdd+0tm+VMTcgg5
         7H7ew14q/bvkc2Lod182B23azGQ9B9P9FlPuvJk8Dzix8zksKnZ+vJGK2e0WeuzXv25I
         UkIy8wL7PVXNQ9j6HkPq9Undf92t2TZKM4M2WVAfzXaMeScb3NFjSK/mH/UmRz9bdIUs
         v5tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tkfGbFk7RbowFQb2pdJ2DiNSH2Hl1PMpHr94hmyAtqs=;
        b=bPgh+YmCWblq1OTROI1DJWWUJ5Fe0PTFz05nYIOBLvqkffQ5IMgSpkFzxmYWIlvier
         jCAbOZKKvdLr8RisyogoHIZ9TI2A/f9Ed3eczfM1GuIlECvL20DQCm5ca2FczKZOP0S6
         7tHRiMo4hBso+Ebmm0QEyNGCSKTY9ApddumTnHfvon051SLzL+aYdJ3I4o/Pg40y01bS
         ZY53GoZ4EXSJZXnZ1wSe20vGGFIZNQcMqJJK+ZRy04XvVY6XETMu3yHEBPyZ7vpV7N20
         zlvO9CbV2X+6PZ0ChuWwu1Mjb+lHucFjrcncc3z+1Y/ly6Fc5mpQZjYKp/gIKERlX7nN
         Y8kA==
X-Gm-Message-State: AOAM533iWe3hVLeEFJRHJWLPlm1BVTbtgZnOZvMBGTvCFzrioLMR9zSD
        z8Duks4vkRMvjiFY/zznIZYRow==
X-Google-Smtp-Source: ABdhPJwZLYHDPPn1a+5bpf3u9GEz+y0iz9ZUQ2qJzz1MLRRwbyl6UAlRYCEn1EZr8YCrCxvzgqY3OA==
X-Received: by 2002:a63:5c5d:: with SMTP id n29mr33235732pgm.131.1622637534524;
        Wed, 02 Jun 2021 05:38:54 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (ec2-18-167-84-74.ap-east-1.compute.amazonaws.com. [18.167.84.74])
        by smtp.gmail.com with ESMTPSA id m2sm17340941pgu.85.2021.06.02.05.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 05:38:53 -0700 (PDT)
Date:   Wed, 2 Jun 2021 20:38:47 +0800
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
Message-ID: <20210602123847.GE10272@leoy-ThinkPad-X240s>
References: <20210602103007.184993-1-leo.yan@linaro.org>
 <20210602103007.184993-9-leo.yan@linaro.org>
 <c321e998-6fd2-86e9-7876-7250a9b23c25@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c321e998-6fd2-86e9-7876-7250a9b23c25@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrain,

On Wed, Jun 02, 2021 at 02:18:47PM +0300, Adrian Hunter wrote:
> On 2/06/21 1:30 pm, Leo Yan wrote:
> > Since the 64-bit atomicity is not promised in 32-bit perf, directly
> > report the error and bail out for this case.
> > 
> > Now only applies on x86_64 and Arm64 platforms.
> > 
> > Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
> 
> Maybe we can do better for the compat case.
> 
> We can assume the upper 32-bits change very seldom,
> and always increase. So for the 'read' case:
> 
> 	u64 first, second, last;
> 	u64 mask = (u64)((u32)-1) << 32;
> 
> 	do {
> 		first = READ_ONCE(pc->aux_head);
> 		rmb();
> 		second = READ_ONCE(pc->aux_head);
> 		rmb();
> 		last = READ_ONCE(pc->aux_head);
> 	} while ((first & mask) != (last & mask));
> 	return second;
> 
> For the write case, we can cause a fatal error only if the new
> tail has non-zero upper 32-bits.  That gives up to 4GiB of data
> before aborting:
> 
> 	if (tail & mask)
> 		return -1;
> 	smp_mb();
> 	WRITE_ONCE(pc->aux_tail, tail);

Seems to me, it's pointless to only support aux_head for 64-bit and
support aux_tail for 32-bit.  I understand this can be helpful for the
snapshot mode which only uses aux_head, but it still fails to support
the normal case for AUX ring buffer using 64-bit head/tail.

Thanks,
Leo
