Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B30AE32C11A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1838030AbhCCS7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:59:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1578517AbhCCSR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 13:17:29 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 159D5C061760
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 10:16:49 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id d11so17572353qtx.9
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 10:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=s/R9v1sh6ruIBgmGKe5l27P58TdI4+w2a/sMzI77JeA=;
        b=ikFquAQtwbFw2efhPXj5xIveufwDEC1ZgcLybD0RVJ9zDsSjuXcevPoPyQxZjEX1rA
         f0pSic7UyWV3F2Ljg1qKRwFz2xxrdkLBX+v93hLMfsdjiCBXFrBEEW9a9B857DhTOm7c
         ktpCa6P5R8GxgcWXEsnMn9IGO/2MU8Ba5ATzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=s/R9v1sh6ruIBgmGKe5l27P58TdI4+w2a/sMzI77JeA=;
        b=g7LJ+N8VZIEX8tuUZHUCwRlCMP+Mymtb46Q0SOvFyP4OnQCZeCbXHjXTyG3EC3rn3R
         jKgt7tvnjHLQWfiOwMXt5PCV05z1OScjq4GW3Y9uSlVKrx9n+yJUuzYCYzX2Imvg+ZJT
         O1b6HRG4uvOJCTXjttMK4sbUhxjdRrz6UVyoyFyzMFH+xNPLiVGHSMOgnvmUccojwend
         X7q9jQ7rX4yegsbw4rrG58gosIyOwRwxX2oNvip5EFvMKEF+wsR0qUnHZc+MPtREZgXS
         pZ1xS+RSyLE2OEuJFxlGjMG0owKhKZduga2giL0Qto94ygfXY8Fzg+4F1c8mjIaKCiL0
         W+dA==
X-Gm-Message-State: AOAM533HK63I46PpPo1a3Zi2GbPmIKyQlyKkZbqUCafkD6j5CowaaHby
        cluLijLxdnwnKt4bO5kqgmbnEykFkVZYug==
X-Google-Smtp-Source: ABdhPJy2u4clVnPo6bcuY+YzmEBgjft1TMIurCUyWc/uvZ2+Bkrol0qKFxymsBXNmQC7g2ersYC0BQ==
X-Received: by 2002:ac8:4913:: with SMTP id e19mr421939qtq.231.1614795408044;
        Wed, 03 Mar 2021 10:16:48 -0800 (PST)
Received: from macbook-air-2.local (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id 90sm15904277qtc.86.2021.03.03.10.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 10:16:47 -0800 (PST)
From:   Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date:   Wed, 3 Mar 2021 13:16:41 -0500 (EST)
To:     linux-kernel@vger.kernel.org
cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>
Subject: [perf] perf_fuzzer causes unchecked MSR access error
In-Reply-To: <32888c33-c286-c600-66cb-8b1b03beeb8b@linux.intel.com>
Message-ID: <6c1f8e-f81-a781-e594-368e7adef0c0@maine.edu>
References: <61a56699-aab4-ef6-ed8d-a22b6bf532d@maine.edu> <7170d3b-c17f-1ded-52aa-cc6d9ae999f4@maine.edu> <YCVE8q4MlbcU4fnV@hirez.programming.kicks-ass.net> <32888c33-c286-c600-66cb-8b1b03beeb8b@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

on my Haswell machine the perf_fuzzer managed to trigger this message:

[117248.075892] unchecked MSR access error: WRMSR to 0x3f1 (tried to write 0x0400000000000000) at rIP: 0xffffffff8106e4f4 (native_write_msr+0x4/0x20)
[117248.089957] Call Trace:
[117248.092685]  intel_pmu_pebs_enable_all+0x31/0x40
[117248.097737]  intel_pmu_enable_all+0xa/0x10
[117248.102210]  __perf_event_task_sched_in+0x2df/0x2f0
[117248.107511]  finish_task_switch.isra.0+0x15f/0x280
[117248.112765]  schedule_tail+0xc/0x40
[117248.116562]  ret_from_fork+0x8/0x30

that shouldn't be possible, should it?  MSR 0x3f1 is MSR_IA32_PEBS_ENABLE

this is on recent-git with the patch causing the pebs-related crash 
reverted.

Vince
