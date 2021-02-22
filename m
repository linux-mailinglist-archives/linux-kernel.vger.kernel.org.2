Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64AC53213E7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 11:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbhBVKNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 05:13:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbhBVKLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 05:11:49 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 988DAC061786
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 02:11:07 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id u14so18430785wri.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 02:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oQGkJKwIhTep5KxrrDjW1tyasGFy3d4f3QEyNCd7LoY=;
        b=K+QVZP9/fmCDLj6lnZJKnGJ1bXZt+Xc+P0L6G6feyUtjNe97UwdthGIygtVabCNlTN
         TqEfqATua1Zvybr5iM4e4xgsvgiTa5IhUU7FcVeslrs2ILlD9dxEi+fL3RviBLd0Khcs
         UehINTLRWpCp6D/JfgcXSAIiBVygvxwALounhKXthnqHc6+W8P1JNil5QeG8/qc31AZB
         gN9fkONpbAkb5bC/R6bPqx8xRWy6iNghjJCiOsYMYkv9kGXlwbDSgNMkd2G7QJVk8SSP
         lDOa5qPlr9bqcjACp/3rDHe66Wjw4Ut5bJlQ+l/XI0qSvhls7XgS3eE/O5xhjJD/tvbZ
         pIZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oQGkJKwIhTep5KxrrDjW1tyasGFy3d4f3QEyNCd7LoY=;
        b=bZ9fRFh0qH3x9fuZgGgTj7UaJqK2AeWxvKcwnnDSSmEJ3uzjeczSfCrF6RRNdsS1K5
         bapDwEl6yIhC2FPjZosGemqSv3vWi616Xf4XXz+h2hNIgNTAUjGHVLUDGtypzy5CNHDJ
         pQuLY47BeX1h8ykgK5QwmvSX1fGLNkaA+NoJQvb9O3Q6QlEEijcqXnkVLtZIua1XOPEa
         fqgV+h4tK2SR+58dkSkUey27N92SmIRrJqUlaTUcl9vC/pSq5nvDZPhKiMpY08xy6JmI
         FVXdE/FxlzVmYVnmRtRBXH3JhOEG9RwRDQ/uYVH7FbhapVxLtQj5evhQ6epWYCmKE7tu
         Fdnw==
X-Gm-Message-State: AOAM533/ON4qpEkOeBAS8ObKl6NuEnX50dowTlZahhb0G2cwnKz3tJD3
        8C1tpVOlzmSZ4BCVLJFsdG/NFj4SgK4NCQ==
X-Google-Smtp-Source: ABdhPJw3Cs+vDRP8+RZGEJSF47YQ7DY8eIeZtWMSzJ+SuM4TCJmCLMBikNsugasE+jolVF9IfeD82Q==
X-Received: by 2002:a5d:4ecf:: with SMTP id s15mr18222134wrv.71.1613988666266;
        Mon, 22 Feb 2021 02:11:06 -0800 (PST)
Received: from google.com (230.69.233.35.bc.googleusercontent.com. [35.233.69.230])
        by smtp.gmail.com with ESMTPSA id r18sm122177wro.7.2021.02.22.02.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 02:11:05 -0800 (PST)
Date:   Mon, 22 Feb 2021 10:11:03 +0000
From:   Quentin Perret <qperret@google.com>
To:     vincent.donnefort@arm.com
Cc:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org,
        patrick.bellasi@matbug.net, valentin.schneider@arm.com
Subject: Re: [PATCH] sched/fair: Fix task utilization accountability in
 cpu_util_next()
Message-ID: <YDODN1rnTqfTQOug@google.com>
References: <20210222095401.37158-1-vincent.donnefort@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210222095401.37158-1-vincent.donnefort@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Vincent,

On Monday 22 Feb 2021 at 09:54:01 (+0000), vincent.donnefort@arm.com wrote:
> From: Vincent Donnefort <vincent.donnefort@arm.com>
> 
> Currently, cpu_util_next() estimates the CPU utilization as follows:
> 
>   max(cpu_util + task_util,
>       cpu_util_est + task_util_est)

s/task_util_est/_task_util_est

This is an important difference.

> 
> This is an issue when making a comparison between CPUs, as the task
> contribution can be either:
> 
>   (1) task_util_est, on a mostly idle CPU, where cpu_util is close to 0
>       and task_util_est > cpu_util.
>   (2) task_util, on a mostly busy CPU, where cpu_util > task_util_est.

I don't understand how this is an issue, this is by design with util-est
no?

Note that cpu_util_next() tries to accurately predict what cpu_util(@cpu)
will be once @p is enqueued on @dst_cpu. There should be no policy
decision here, we just reproduce the enqueue aggreagation -- see
util_est_enqueue() and cpu_util().

Could you please give an example where you think cpu_util_next()
computes the wrong value?

Thanks,
Quentin
