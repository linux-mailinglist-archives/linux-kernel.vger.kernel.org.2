Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9EB392D5B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 13:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234562AbhE0MAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 08:00:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38897 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234447AbhE0MAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 08:00:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622116737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wjPIN2JnhuUc4ncCd4AUurBqU2Abl/WhHOre8Sqosdk=;
        b=dVr33mHxAo5UQXE1gIwvwiNgTEqgCokvy2SDWpPyGbgCZlawzdowRsxe4PEvzQ47yjapbn
        7xDr9rPO73ND2AjO3qQOrPmm+o8ECeWvSjmGQXhdDD6hkBV4KyjQcQL/97fSukxIbLpvO7
        o6Hox7t26B31jPqHGIV3upnAjJ/95W0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-iK5Gz3YfOCC7-xWjiOXLMA-1; Thu, 27 May 2021 07:58:56 -0400
X-MC-Unique: iK5Gz3YfOCC7-xWjiOXLMA-1
Received: by mail-ed1-f72.google.com with SMTP id b8-20020a05640202c8b029038f1782a77eso180282edx.15
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 04:58:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wjPIN2JnhuUc4ncCd4AUurBqU2Abl/WhHOre8Sqosdk=;
        b=jWzd5L3Di+7DXfjKHNQ9lAvZ2NOSH6G3+E0V8TjBJxKdI0a/BPuXMmO/MC0kYGbeRq
         aWLd76ZKvZkoGLL9//gLcMZ/Pad6KbmaUi8FQDa3jlI4waMnVDsa6xI41RurmLHZkfuQ
         hHdviekpB8sbxh3QzQdJZ+vIcRxVOoKPWDvb6mMzN20Pc1cxYiOH63r95K41lwLYSH7F
         v9cUfHd0yr73RV514Bq+IzSAalsbgW6ThhlqaJgdzH40QKU8QuQCOeTgh52XeXcQA/zf
         FEANwPl0WfskWcFn0RL/vPck6LOe/b0tSa7Z/h6ujHIr26CUZrCseYyWwB5l5nzxKs2b
         YY4A==
X-Gm-Message-State: AOAM533KFY+3Xq9rsDxA1ziNLQSLPkkvl4EXxVI9cyMklvnNm5tEpEpU
        l4V46NLixnnCJ2+EGtkOnlC3LDlbYZfPfIbbfkRtLOF1uF6xWH96GRMfjQ/l+s7YJRqCCiRMKOB
        ZY8tEu2fvs6PaCK+YLzWnpzcX
X-Received: by 2002:a17:906:40cf:: with SMTP id a15mr3413628ejk.181.1622116734868;
        Thu, 27 May 2021 04:58:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyI4hefZVEXGQJKCWltH1Y1Bc9bZRIv+jfizbEcnuKXGxBcsLjympjaoZ9j+8ttg8WO7W2pJg==
X-Received: by 2002:a17:906:40cf:: with SMTP id a15mr3413610ejk.181.1622116734710;
        Thu, 27 May 2021 04:58:54 -0700 (PDT)
Received: from localhost.localdomain ([151.29.18.58])
        by smtp.gmail.com with ESMTPSA id v16sm890216ejr.65.2021.05.27.04.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 04:58:54 -0700 (PDT)
Date:   Thu, 27 May 2021 13:58:52 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Phil Auld <pauld@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Kate Carcia <kcarcia@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Clark Willaims <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH V3 4/9] tracing/hwlat: Implement the per-cpu mode
Message-ID: <YK+JfHHNbvV7odqX@localhost.localdomain>
References: <cover.1621024265.git.bristot@redhat.com>
 <187db3f9eed1603c858a1f7669d0140dfb753bfd.1621024265.git.bristot@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <187db3f9eed1603c858a1f7669d0140dfb753bfd.1621024265.git.bristot@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 14/05/21 22:51, Daniel Bristot de Oliveira wrote:

[...]

> +/**
> + * start_per_cpu_kthread - Kick off the hardware latency sampling/detector kthreads
> + *
> + * This starts the kernel threads that will sit on potentially all cpus and
> + * sample the CPU timestamp counter (TSC or similar) and look for potential
> + * hardware latencies.
> + */
> +static int start_per_cpu_kthreads(struct trace_array *tr)
> +{
> +	struct cpumask *current_mask = &save_cpumask;
> +	struct cpumask *this_cpumask;
> +	struct task_struct *kthread;
> +	char comm[24];
> +	int cpu;
> +
> +	if (!alloc_cpumask_var(&this_cpumask, GFP_KERNEL))
> +		return -ENOMEM;

Is this_cpumask actually used anywhere?

Thanks,
Juri

