Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A77F7360C0C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 16:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233282AbhDOOma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 10:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbhDOOm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 10:42:29 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09CD6C061574
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 07:42:06 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id w6so1664706pfc.8
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 07:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hatUuIhFi7CMwOdtJnGcgxnJeKk201WCNig0Migkokc=;
        b=WWvQUtlCtm3XADW/zB82p0+6Hb5UM6F14J4u3VKgtfXypsgmQ9OUwXGOUQklu3RSqZ
         +R6Yu1xwTw+VRqAt1W9KDznQETO7wmMLiN5E3jC8sRmIqBYebwSFH5P7e4mln4VQ9cqT
         vyOLwyPpClX8h+xkfB+LMtuM170wDldyjrIs9mRugpcXU/Hh4BcY6TgQI7ES9THgOEaD
         vkedDhegu0iRrjDHjc7N93ZiGPFl1yQ8yVrspF3kbMTc3KdV+PxKJ7tuR4BE5HMaHz7F
         nxwpwufQqt2cyGBLOYZtD+E5k3hXj91R2eheqFLaUE193ta3anEpLwwx4G5K5xF6niky
         zVwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hatUuIhFi7CMwOdtJnGcgxnJeKk201WCNig0Migkokc=;
        b=SRCgGURwSHYaoqA5E26Qem+apCQgbTgRfx2c5nE8BCZtuQwzO+VENMK9pgof90z22a
         Yot1l1fBxx0n5/gzqkUERdD1qK92iu9ThkhPJPPbNL+pzQyZa672jaWzFzsO9ScFLlpM
         8hI8cRhrflLyLJKWECTCazCsNS7DvxoAeRYNwngnqX5DwKKYJHePvbVgVhmzUSUuX5TY
         xFx7IcD52jGSooX56JCeuAeN9Dq7dpp+GEQpjZoSRbQl12jiOSWrOEetLRLgQnJUKDaj
         YAU9dnrGrmgB2r/43et77L7Q6ucXozoLeRLcdtQpG8aL+PoXPI7cfnj4NQ7qxp/r0BBQ
         bPIw==
X-Gm-Message-State: AOAM533WzdkN0vf/G0uubnQA0CbELvUvzbuxEdH9YF9DxZot7lKJd9oh
        UDO0ktGAob+xISBHTpLYTajW7A==
X-Google-Smtp-Source: ABdhPJzOVlfOiUa73d5LlzAx57mYNgnY2nwgWDcJlPxpK8barrG8CUwSkXJPPE6FSKXQTMAjqBm4Vg==
X-Received: by 2002:aa7:86c9:0:b029:245:1c62:3499 with SMTP id h9-20020aa786c90000b02902451c623499mr3489516pfo.74.1618497725486;
        Thu, 15 Apr 2021 07:42:05 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([116.206.101.232])
        by smtp.gmail.com with ESMTPSA id t10sm2719605pjy.16.2021.04.15.07.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 07:42:04 -0700 (PDT)
Date:   Thu, 15 Apr 2021 22:41:58 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
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
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/6] perf arm-spe: Remove unused enum value
 ARM_SPE_PER_CPU_MMAPS
Message-ID: <20210415144158.GD1011890@leoy-ThinkPad-X240s>
References: <20210412091006.468557-1-leo.yan@linaro.org>
 <20210412091006.468557-2-leo.yan@linaro.org>
 <882e13d1-c793-88c6-0b1e-629462fb99ac@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <882e13d1-c793-88c6-0b1e-629462fb99ac@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On Thu, Apr 15, 2021 at 05:13:36PM +0300, James Clark wrote:
> On 12/04/2021 12:10, Leo Yan wrote:
> > The enum value 'ARM_SPE_PER_CPU_MMAPS' is never used so remove it.
> 
> Hi Leo,
> 
> I think this causes an error when attempting to open a newly recorded file
> with an old version of perf. The value ARM_SPE_AUXTRACE_PRIV_MAX is used here:
> 
> 	size_t min_sz = sizeof(u64) * ARM_SPE_AUXTRACE_PRIV_MAX;
> 	struct perf_record_time_conv *tc = &session->time_conv;
> 	struct arm_spe *spe;
> 	int err;
> 
> 	if (auxtrace_info->header.size < sizeof(struct perf_record_auxtrace_info) +
> 					min_sz)
> 		return -EINVAL;
> 
> And removing ARM_SPE_PER_CPU_MMAPS changes the value of ARM_SPE_AUXTRACE_PRIV_MAX.
> 
> At least I think that's what's causing the problem. I get this error:
> 
> 	./perf report -i per-thread-spe-time.data
> 	0x1c0 [0x18]: failed to process type: 70 [Invalid argument]
> 	Error:
> 	failed to process sample
> 	# To display the perf.data header info, please use --header/--header-only options.
> 	#

Yes, when working on this patch I had concern as well.

I carefully thought that the perf tool should be backwards-compatible,
but there have no requirement for forwards-compatibility.  This is the
main reason why I kept this patch.

If you or anyone could confirm the forwards-compatibility is required,
it's quite fine for me to drop this patch.

Thanks a lot for the reviewing and testing!
Leo
