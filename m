Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDC3375539
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 15:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234454AbhEFOAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 10:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233982AbhEFOAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 10:00:13 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 049C2C061761
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 06:59:14 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id l129so4937892qke.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 06:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RM27Ns39iWEEvy6Ka61huNOh4QGP2SWbqcGCbpTFK2E=;
        b=orV9tP6GFX8bfN1m1zZurm9KIeIF3c0L6IBGjncE4W0qvmXePnVpp4klj1Wy680U0M
         g5IY71MaWr60CENceOVr7xB6R2Fwsr5fw8sezMXDSK0vaxwRU2Jl1Vrr9zvz5j8u9D2S
         QkkVg78kh3x6LlCZ7XQBx+gZNNII7N56mRgy1s5hzAxdwjSqzLNaYBrH+A2r6lv00v3K
         mblqSJZWlkffmlc1EtpuR7XDPaYc7Xn8j753AcQ970Kt1xmdbLUG0fRtq6sQ29ebB7N+
         kDArAjmc3HWf563GiqACFqDW1OptjdRhY7UDTPRG8DFyqBR73TzqZNZ5zYJjMgNDm4kT
         gaeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RM27Ns39iWEEvy6Ka61huNOh4QGP2SWbqcGCbpTFK2E=;
        b=D/fSnxeL+oecnlBiF4zpeNo7K1jG8xAnold2cH/KclRMW9rOvzXXkPueizfB+GC6m9
         bQVfv40Naq2ujpMAMuL815x1md0PTWrTvVzsbyr8EFIVGuEgZQZu28CJeRoTcl/+eD9A
         bkgEXVSlaTEsHKafOgNToCPdujXwjcGwNSgpiWTCVdgwrljDPxueh/WjZ1n98EO6j5V/
         VWFu7KQCObhsMwnawvbAlaGHgyEx/13DJyqdH0QCtOB1HRCbIuzjasWRzT93q0hbKFSt
         w2kCaSE++fBI4TOZW7hS5zyKCqyWAb+8x89WcPJqB9OpAKHkLlwFF6aHeaVIhYclf1iR
         OHVA==
X-Gm-Message-State: AOAM530QD1B4x2gPYQNIktjYZEn7xFwcjjfQy/GyYKp47cH2eH9esu3X
        plPP7o8bmP7M2+bYMJThARIY0g==
X-Google-Smtp-Source: ABdhPJz2jUu3BtYOgaDbeeBald7RHPQTOmIDFI09SkP20NDW1i/anYZTRklJDdaA7SVfuZ7e9oslYg==
X-Received: by 2002:a05:620a:1025:: with SMTP id a5mr3923714qkk.395.1620309554148;
        Thu, 06 May 2021 06:59:14 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:4c4b])
        by smtp.gmail.com with ESMTPSA id s67sm1816341qkh.59.2021.05.06.06.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 06:59:13 -0700 (PDT)
Date:   Thu, 6 May 2021 09:59:11 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, mingo@kernel.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, bsingharora@gmail.com, pbonzini@redhat.com,
        maz@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        riel@surriel.com
Subject: Re: [PATCH 1/6] delayacct: Use sched_clock()
Message-ID: <YJP2L1lUvUrur4pK@cmpxchg.org>
References: <20210505105940.190490250@infradead.org>
 <20210505111525.001031466@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210505111525.001031466@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 05, 2021 at 12:59:41PM +0200, Peter Zijlstra wrote:
> @@ -42,10 +42,9 @@ void __delayacct_tsk_init(struct task_st
>   * Finish delay accounting for a statistic using its timestamps (@start),
>   * accumalator (@total) and @count
>   */
> -static void delayacct_end(raw_spinlock_t *lock, u64 *start, u64 *total,
> -			  u32 *count)
> +static void delayacct_end(raw_spinlock_t *lock, u64 *start, u64 *total, u32 *count)
>  {
> -	s64 ns = ktime_get_ns() - *start;
> +	s64 ns = local_clock() - *start;

I don't think this is safe. These time sections that have preemption
and migration enabled and so might span multiple CPUs. local_clock()
could end up behind *start, AFAICS.
