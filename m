Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DDB832C3C1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbhCCX7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 18:59:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233992AbhCCTgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 14:36:25 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CECD9C061756
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 11:28:51 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id b18so18495560wrn.6
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 11:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AEc7PHeM5cn89gKxBHioKyI8+eQFhoyAQ6NhxnhGjo4=;
        b=LY7Rxw9ok3ztMBE3u+8eyRBeGcl+vohkFpg//XteLBxer29nquhO4a40ukpMmMZsgz
         E/fVpjMIJnlJhwEJ5M6+/adrhEhhRO2J2ObZBDBjZZkokX7eOsmpXFR6iM+SvrcZtFM9
         S1Z2eJmfZ2JxSt+2TxQ6pOdk4bvenjTQhUMT2hbf+aglPNtP3lMeAP7mTkQ3+tVS3yep
         j1GJhurU3onl2o7eywL4B3hpZt5Ie7bNPw/WRV56RPbUoYKrsSBk+jhgTSnFWS/1bayZ
         kfKeWoJf7fqhYffMPy3Ndz4uMngdC/zpghsaUpNJheR+qndZq7DqUjsEXLdo34xlb77r
         gzNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AEc7PHeM5cn89gKxBHioKyI8+eQFhoyAQ6NhxnhGjo4=;
        b=TrRrUR3GKzuP2JtaKz2XXmE14Czi7drAaMN49usa5SlCurzrqOOJjpFhZGCYX+JqgX
         GTlDKoRtPE5FDhOY1v3WX8HQp4KP4PsdVL7g8V4mcDBGyCiUQhO45p+7xX/pHMm3xnbb
         JOmVQJBB/LmxPN1LSsg8WRtue6Q1dNnwiu3t6WeutrJggN+lC7PbzShu5FBtXMLxilkU
         2vRyd3jdUmY3xqMslHZm/0KdnlewrLMbJtuY+uNKr2fUm4bccIjEKXASdoIgNvGRdzph
         tCU1vTNBifCKyD7dsAszNIluYmf0dyLqte0uereY4KLcLmsbT8a0Aamb3pUgVYt8IEm9
         0Ywg==
X-Gm-Message-State: AOAM530vJOXapVJJcTF0D/3nsM90TbbwfgMo20k5OowS9kuooP5nzXz+
        b/j/MgPQV7bB9VdMWFvsBXiCEnwd9zizVohRDyXrMA==
X-Google-Smtp-Source: ABdhPJy3NfXRHidsUEjI1siEpcCBdV3b78e0hEP61m0XI8rM6jiD+bctdUf5Uabs0FytoF/74p2BFuk7vUhYtSv3YO8=
X-Received: by 2002:adf:ec46:: with SMTP id w6mr162222wrn.213.1614799730502;
 Wed, 03 Mar 2021 11:28:50 -0800 (PST)
MIME-Version: 1.0
References: <61a56699-aab4-ef6-ed8d-a22b6bf532d@maine.edu> <7170d3b-c17f-1ded-52aa-cc6d9ae999f4@maine.edu>
 <YCVE8q4MlbcU4fnV@hirez.programming.kicks-ass.net> <32888c33-c286-c600-66cb-8b1b03beeb8b@linux.intel.com>
 <6c1f8e-f81-a781-e594-368e7adef0c0@maine.edu>
In-Reply-To: <6c1f8e-f81-a781-e594-368e7adef0c0@maine.edu>
From:   Stephane Eranian <eranian@google.com>
Date:   Wed, 3 Mar 2021 11:28:39 -0800
Message-ID: <CABPqkBRp17EMqgoO3LTC-hTkpbv2njFO-Kkf-RifrSksdGfEaA@mail.gmail.com>
Subject: Re: [perf] perf_fuzzer causes unchecked MSR access error
To:     Vince Weaver <vincent.weaver@maine.edu>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "Liang, Kan" <kan.liang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 3, 2021 at 10:16 AM Vince Weaver <vincent.weaver@maine.edu> wrote:
>
> Hello
>
> on my Haswell machine the perf_fuzzer managed to trigger this message:
>
> [117248.075892] unchecked MSR access error: WRMSR to 0x3f1 (tried to write 0x0400000000000000) at rIP: 0xffffffff8106e4f4 (native_write_msr+0x4/0x20)
> [117248.089957] Call Trace:
> [117248.092685]  intel_pmu_pebs_enable_all+0x31/0x40
> [117248.097737]  intel_pmu_enable_all+0xa/0x10
> [117248.102210]  __perf_event_task_sched_in+0x2df/0x2f0
> [117248.107511]  finish_task_switch.isra.0+0x15f/0x280
> [117248.112765]  schedule_tail+0xc/0x40
> [117248.116562]  ret_from_fork+0x8/0x30
>
> that shouldn't be possible, should it?  MSR 0x3f1 is MSR_IA32_PEBS_ENABLE
>
Not possible, bit 58 is not defined in PEBS_ENABLE, AFAIK.

>
> this is on recent-git with the patch causing the pebs-related crash
> reverted.
>
> Vince
