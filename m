Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 384813DA97B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 18:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbhG2Qya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 12:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbhG2Qy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 12:54:29 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA09FC061765
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 09:54:25 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id t18so4394580qta.8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 09:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=nmN1n5c1F6qwmwJaeBZljnOrsuqT02jPRsNhxHzER/k=;
        b=OUc06M1kLDpQh7HYTyweSKDppRcsKgkEiR/4gibkr/2si/o5OT21QYcc7cLS8IYfC2
         FUGaJPTj9BM3KeUMZURQwEwCEQ/vWc7/U6SddB6tmwszhcwu4RrkEUbQMrp0lvqSt15Q
         CrMKtLHrZ0bK8+pt1Oywbeh+3EFpKwskmDf5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=nmN1n5c1F6qwmwJaeBZljnOrsuqT02jPRsNhxHzER/k=;
        b=UqaU0/t/6HaJbqZaM/eNRtXr2G6fybJXJKQ8xx9MS49acV12EnISEBP1FghDmr1dpu
         5sbgg+dvFdIuvSO/kSBDMNvgz1hS5voybSTu1Qj9RCrIYkhP4vWZCiMTMJ6mK71k3qZF
         P4uaphl+HuSw6zaalCM3S15BE5z1hlqmb7yJQ7hd22cRU2xmm8mROTlnWC7Tx6iIHJBo
         KJuZMNHyq1hI8gdOIbg8FNXcslL2UM6o3SYaemut9Rv9x+ddyy29FDvnpzsHnr9YFlqf
         LL3JdH9FBXv8iId4J1ky6rlweKxN3LsfnXifqAxXqVhlJCAmiSpFc85Hktxggph9UO7O
         0PPw==
X-Gm-Message-State: AOAM533viGgVWtJmTwh8DaGyM6em9vTiBMs7yK/YhotlgXN/IsKPULer
        s6g7aqVzHp+kz+WGaDHZyNTP2A==
X-Google-Smtp-Source: ABdhPJxnkbLYjngXhmgJYao+E+ih1NHKJS9IHWWGFhCRJ2BcE78eWyXBsRyr855cr++z8NEsHsIYqQ==
X-Received: by 2002:a05:622a:4c8:: with SMTP id q8mr5023610qtx.187.1627577665084;
        Thu, 29 Jul 2021 09:54:25 -0700 (PDT)
Received: from macbook-air.local (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id e16sm1484797qtq.35.2021.07.29.09.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 09:54:24 -0700 (PDT)
From:   Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date:   Thu, 29 Jul 2021 12:54:20 -0400 (EDT)
To:     Peter Zijlstra <peterz@infradead.org>
cc:     Vince Weaver <vincent.weaver@maine.edu>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "Liang, Kan" <kan.liang@intel.com>
Subject: Re: [perf] fuzzer triggers unchecked MSR access error: WRMSR to
 0x318
In-Reply-To: <YQJxka3dxgdIdebG@hirez.programming.kicks-ass.net>
Message-ID: <88ad522-7cd5-f636-7c1f-a5ae22a76e5f@maine.edu>
References: <37881148-a43e-5fd4-817c-a875adc7a15f@maine.edu> <YQJxka3dxgdIdebG@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jul 2021, Peter Zijlstra wrote:

> On Wed, Jul 28, 2021 at 12:49:43PM -0400, Vince Weaver wrote:
> > [32694.087403] unchecked MSR access error: WRMSR to 0x318 (tried to write 0x0000000000000000) at rIP: 0xffffffff8106f854 (native_write_msr+0x4/0x20)
> > [32694.101374] Call Trace:
> > [32694.103974]  perf_clear_dirty_counters+0x86/0x100
> 
> Hmm.. if I read this right that's MSR_ARCH_PERFMON_FIXED_CTR0 + i, given
> that FIXED_CTR0 is 0x309 that gives i == 15, which is FIXED_BTS.
> 
> I'm thinking something like this ought to cure things.

I know it sounds like the complete fix is a bit different from this, but I 
did want to report that the patch does fix the issue on my machine.

Vince Weaver
vincent.weaver@maine.edu
