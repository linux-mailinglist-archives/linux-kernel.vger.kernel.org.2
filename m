Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72E113A758F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 06:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbhFOEG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 00:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhFOEG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 00:06:56 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E651DC061574
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 21:04:52 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id s14so12237043pfd.9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 21:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wGn0kL3dEWXjw2oVxcLhrhQZH20+XB/vV2y7WkNfavs=;
        b=edDcKr9WMz5VlR41gbBV+LoX3mwd6mMpqKqRYgA6t6bknRlBw43ElYus4gYM3bzzwq
         5KifXwUjx6E47dNmyhf5XY4Da56f9Tb3k2VnHFcj1UILx50rhkeNp4N1IqqcdyBvYRWv
         mv0N3is51Q1YsMLsChuaHXsWi6pyKvDrCd5MB3Sc91p2JZxKSJ2MEoCM0vWjIkUPeQG4
         Mkmi4ab7NJYqTnXD5kY0klE4HXh65jO8s3Et04knYn+Y+10CmolGZsGPA67nV0IBlebB
         tTLYHhe2WcSTrMi5ybGfOWWtaCX/15n11USGwx/jH0vwNM7r+cDKZ4lPGBx+v11dAyja
         jBVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wGn0kL3dEWXjw2oVxcLhrhQZH20+XB/vV2y7WkNfavs=;
        b=BqMqMC5JfaVzMJ6WeCWyzS5fKfTc6hva3AUs7JqWGLW7NlMjR9kWR0VtW5efAsu45r
         4TR0jgPkntMEiNGSODPzW6ldewVECLuGW7BiNzyN2ZG5Oi8Vfm5mfE0ijJ/CAIcS/NOa
         BsZD5xeVlFqJB4L/BoOzjztp8bCDHTdVJvxNENo+pFuUfmin313gpTr5LFUXo6P8Weti
         bLt8CI4zK5D9Vmt/WJLVvd1+r2XukQIGh/h3wUnvc/jjPUkZr0/t2DlGOhNbB6mTuepl
         cVnn5qnXilciOAyXA9YbL3nemFYi42Qp0wtegRieEiF7s6HMEkf0Vawuvq1A8zZjd6/o
         QNag==
X-Gm-Message-State: AOAM532nCG/n2D+2P+sDUMAz3VdtVj6/9S8Y9MvIRJl2Ra22Y+UffCmW
        rNDbDPrE2A1zwonc4KicCgUxLA==
X-Google-Smtp-Source: ABdhPJzOVhVQhui6DOUpaTJG4IjWv4QHCqBTkO+GpKDFfKVqoZfEB+7qcKr4ImMDok+dGxq5RsCmHA==
X-Received: by 2002:a62:1681:0:b029:2f0:b913:8726 with SMTP id 123-20020a6216810000b02902f0b9138726mr1094753pfw.0.1623729892265;
        Mon, 14 Jun 2021 21:04:52 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (ec2-18-167-84-74.ap-east-1.compute.amazonaws.com. [18.167.84.74])
        by smtp.gmail.com with ESMTPSA id z7sm14282621pgr.28.2021.06.14.21.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 21:04:51 -0700 (PDT)
Date:   Tue, 15 Jun 2021 12:04:47 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Yang Jihong <yangjihong1@huawei.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] perf annotate: Add itrace options support
Message-ID: <20210615040447.GB9844@leoy-ThinkPad-X240s>
References: <20210615024036.181427-1-yangjihong1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210615024036.181427-1-yangjihong1@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jihong,

Loop in Adrain to be aware this AUX trace change.

On Tue, Jun 15, 2021 at 10:40:36AM +0800, Yang Jihong wrote:
> The "auxtrace_info" and "auxtrace" functions are not set in "tool" member of
> "annotate". As a result, perf annotate does not support parsing itrace data.
> 
> Before:
> 
>   # perf record -e arm_spe_0/branch_filter=1/ -a sleep 1
>   [ perf record: Woken up 9 times to write data ]
>   [ perf record: Captured and wrote 20.874 MB perf.data ]
>   # perf annotate --stdio
>   Error:
>   The perf.data data has no samples!
> 
> Solution:
> 1.Add itrace options in help,
> 2.Set hook functions of "auxtrace_info" and "auxtrace" in perf_tool.
> 
> After:
> 
>   # perf record --all-user -e arm_spe_0/branch_filter=1/ ls
>   Couldn't synthesize bpf events.
>   perf.data
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 0.010 MB perf.data ]
>   # perf annotate --stdio

>    Percent |      Source code & Disassembly of libc-2.28.so for branch-miss (1 samples, percent: local period)
>   ------------------------------------------------------------------------------------------------------------
>            :
>            :
>            :
>            :           Disassembly of section .text:
>            :
>            :           0000000000066180 <__getdelim@@GLIBC_2.17>:
>       0.00 :   66180:  stp     x29, x30, [sp, #-96]!
>       0.00 :   66184:  cmp     x0, #0x0
>       0.00 :   66188:  ccmp    x1, #0x0, #0x4, ne  // ne = any
>       0.00 :   6618c:  mov     x29, sp
>       0.00 :   66190:  stp     x24, x25, [sp, #56]
>       0.00 :   66194:  stp     x26, x27, [sp, #72]
>       0.00 :   66198:  str     x28, [sp, #88]
>       0.00 :   6619c:  b.eq    66450 <__getdelim@@GLIBC_2.17+0x2d0>  // b.none
>       0.00 :   661a0:  stp     x22, x23, [x29, #40]

[...]

Nitpick: the above example is not typical for annotation, since it
doesn't show any C source code with samples.  At my side, I tested this
patch and confirmed the patch works well with below commands:

  # gcc -ggdb -O0 -o task_migration task_migration.c
  # perf record -e cs_etm/@tmc_etr0/u --per-thread ./task_migration
  # perf annotate --itrace=i1000 --stdio

The complete annotation result can be reviewed at [1].

Thus for this patch:

Tested-by: Leo Yan <leo.yan@linaro.org>

[1] https://paste.ubuntu.com/p/pHz74MYRPJ/

[...]
