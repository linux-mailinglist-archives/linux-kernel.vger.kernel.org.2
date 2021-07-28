Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2303D9391
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 18:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbhG1Qtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 12:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbhG1Qtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 12:49:50 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A47C061757
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 09:49:48 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id t68so2847612qkf.8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 09:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google;
        h=from:date:to:cc:subject:message-id:mime-version;
        bh=nJXlLpkTlQG+j2g9fJu+5AVUSl9pOmwqtryvrpLl9zY=;
        b=SOta93O7KDpbZ3/CfSY3Gv+++hKDiwL0eTalIh/EVOWVeYaMLHjpCpVRsTgbMUBAvT
         MPJLDPNwinLSvJFNEhKj/4Wc3hAZqcHlU/QDG2y0cHnsDGtmBmVFmIvRQ1CRut6Dsme3
         kgWHYqXrnLAAhNdVQZIQ7CMwPYvDQWXdvYc3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:mime-version;
        bh=nJXlLpkTlQG+j2g9fJu+5AVUSl9pOmwqtryvrpLl9zY=;
        b=IpUTboNiWBMjDgnv6MreAPTonjozKORoNw75FVhv7zDHmENxO2j1bKYZhlIuLmTau6
         wIppMIyq11mJZaPgz3sn9gTiVqLZRDRwNk2xtrx/M7bzoP50b/EqUdAr487RbTYuWMqD
         k17+pv3xowcq/DDrNnd0l3qz6b5D1w6xC7eHran8YnEWISIO3HEihpRToPyl4qfSvnAa
         h0LAg3yB3sMpp90i7dH0S6osrBxqXxEZXsuFAYl3UBScKZY+IT1Aprqatmrf/A2HVUCI
         GMA1mXFr5C5YHXDKYNRQKCrIlQ29l73oh5mxb/ECmFw1+ywF8PCjJwp06fsXrWq1mYio
         LCrg==
X-Gm-Message-State: AOAM530/7fhVpFTjOW0NlgZ2w82jP/HDvqWrasrs1Fo68yBgMgRW4b0k
        ucbhX3N4vKXWXU87D29GLtBhfGGfivdE6g==
X-Google-Smtp-Source: ABdhPJznoC6po0xd33YGlKPu+hTq1bF0rajM+XbF2VTq87GhRpdDzXEcsJsILoUwXhMSGbGwis6PGg==
X-Received: by 2002:a37:a04a:: with SMTP id j71mr587084qke.424.1627490987778;
        Wed, 28 Jul 2021 09:49:47 -0700 (PDT)
Received: from macbook-air-3.local (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id a127sm268955qkc.121.2021.07.28.09.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 09:49:47 -0700 (PDT)
From:   Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date:   Wed, 28 Jul 2021 12:49:43 -0400 (EDT)
To:     linux-kernel@vger.kernel.org
cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [perf] fuzzer triggers unchecked MSR access error: WRMSR to 0x318
Message-ID: <37881148-a43e-5fd4-817c-a875adc7a15f@maine.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

ther perf_fuzzer on current linux-git on a Haswell system triggers the 
following.

I've truncated the call chain, as it goes on for quite a while, let me 
know if you want/need more information.

Vince

[32694.087403] unchecked MSR access error: WRMSR to 0x318 (tried to write 0x0000000000000000) at rIP: 0xffffffff8106f854 (native_write_msr+0x4/0x20)
[32694.101374] Call Trace:
[32694.103974]  perf_clear_dirty_counters+0x86/0x100
[32694.109027]  switch_mm_irqs_off+0x1d0/0x430
[32694.113498]  __schedule+0x29f/0x1490
[32694.117300]  ? cr4_update_irqsoff+0x2a/0x30
[32694.121762]  ? switch_mm_irqs_off+0x1ba/0x430
[32694.126418]  ? rcu_eqs_exit.constprop.0+0x2e/0x60
[32694.131515]  ? cpuidle_enter_state+0xb7/0x350
[32694.136152]  schedule_idle+0x26/0x40
[32694.139974]  do_idle+0x16e/0x280
[32694.143421]  cpu_startup_entry+0x19/0x20
[32694.147643]  secondary_startup_64_no_verify+0xb0/0xbb
[32694.973583] Call Trace:
[32694.976215]  perf_clear_dirty_counters+0x86/0x100
[32694.981290]  switch_mm_irqs_off+0x1d0/0x430
[32694.985797]  __schedule+0x29f/0x1490
[32694.989664]  ? cr4_update_irqsoff+0x2a/0x30
[32694.994134]  ? switch_mm_irqs_off+0x1ba/0x430
[32694.998789]  ? rcu_eqs_exit.constprop.0+0x2e/0x60
[32695.003831]  ? cpuidle_enter_state+0xb7/0x350
[32695.008521]  schedule_idle+0x26/0x40
[32695.012362]  do_idle+0x16e/0x280
[32695.015838]  cpu_startup_entry+0x19/0x20
[32695.020041]  secondary_startup_64_no_verify+0xb0/0xbb
[32695.126530] Call Trace:
[32695.129184]  perf_clear_dirty_counters+0x86/0x100
[32695.134268]  switch_mm_irqs_off+0x1d0/0x430
[32695.138757]  __schedule+0x29f/0x1490
[32695.142577]  ? tick_nohz_get_sleep_length+0x6b/0xa0
[32695.147806]  ? rcu_eqs_exit.constprop.0+0x2e/0x60
[32695.152806]  ? cpuidle_enter_state+0xb7/0x350
[32695.157500]  schedule_idle+0x26/0x40
[32695.161342]  do_idle+0x16e/0x280
[32695.164798]  cpu_startup_entry+0x19/0x20
[32695.169010]  secondary_startup_64_no_verify+0xb0/0xbb

