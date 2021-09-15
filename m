Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4203A40BE78
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 05:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236258AbhIODwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 23:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbhIODwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 23:52:40 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B30C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 20:51:22 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id w19so1393304pfn.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 20:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=572jzkGxeL6YfJP3ZwAjXGhaawSUrfiEVlgivE5LFtc=;
        b=Qc1YKpfBh+BXdNeqFWOt9SMUtxZO32kP42rboAkSjl99bKxGkrwXTiWlTW2QF9VKNV
         eHWcBDFqviXzU6Ysxqj5Kd9wBxwE+gR39muUsdlccQ7f8k/IBYaj+lUvQnH+pjJsIHNL
         bDJQnijNX1yETGxIl22sGgFIBIYFlAG3ZDhjaNevHYgz5K7GGznNG3MePLno2L18F3tL
         MM/1OCijAmh7DiKVDjlkETdjwREs+Z9lxAKrO1q0ZRqhIJcJvz/31cITusOFaO88rOPR
         TjtIYSF5jgRxWerpVXe+3M/4p7Wt/pWdKR6ySLX+hwEw4keASVkLgovzlwWQrgONme69
         elUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=572jzkGxeL6YfJP3ZwAjXGhaawSUrfiEVlgivE5LFtc=;
        b=4Qk7LbCNDfKUCmDcPQ0makV9nTG/gg/4Z9gvTcDS//kJ1YqHWeHnL4xv8/n/kydh55
         KCjGflvFiwNdltEFiPc9rMKc0j14lZOX0/vmcKVcBdpocpa44CgFH10fqgfvspfQvyqw
         5ZEpJGDeys+6PC4RAUfiyVEqgHCJNVjp22M9LUuk+SWwaemwvJu4I3oNTPgc3cnvzf4x
         HoHrB61fwdgmBI5Eo5gTYLLP/6MQsGX1ZzE9HwnHqGskzDsZs6u9sszTm9oX/h1kmPqL
         tGwVOLzXrYuHcV4LU36bp4iruY0smUffNlFbfwoyNQyuB2k8EYStQdyG+0UnUl+k6gHf
         WKsw==
X-Gm-Message-State: AOAM532XSZMYUnXqPLFjo7x6uC77iLIvMx2PknWbj66qpLhqyHXKI2s+
        91paalcoofXsz4I5wuQnyQ==
X-Google-Smtp-Source: ABdhPJwS9T+vc3XhGASS4drRS336qlUtgAJ4PtZWtSSh4cQIzXsfF6HxEHPBJOPK4lqmgQx9cSjACA==
X-Received: by 2002:a05:6a00:1147:b029:3e0:8c37:938e with SMTP id b7-20020a056a001147b02903e08c37938emr8101968pfm.65.1631677882118;
        Tue, 14 Sep 2021 20:51:22 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id x13sm8602357pfp.133.2021.09.14.20.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 20:51:21 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Julien Thierry <jthierry@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wang Qing <wangqing@vivo.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Santosh Sivaraj <santosh@fossix.org>
Subject: [PATCH 0/5] watchdog_hld cleanup and async model for arm64
Date:   Wed, 15 Sep 2021 11:50:58 +0800
Message-Id: <20210915035103.15586-1-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hard lockup detector is helpful to diagnose unpaired irq enable/disable.
Sumit has tried with a series, and the last one is V5 [1].
Since it lasts a long time without any update, I takes a retry, which
addresses the delay intialization of watchdog_hld.

There is an obstacle to integrate arm64 hw perf event into watchdog_hld.
When lockup_detector_init()->watchdog_nmi_probe(), on arm64, PMU is not
ready until device_initcall(armv8_pmu_driver_init).  And it is deeply
integrated with the driver model and cpuhp. Hence it is hard to push
the initialization of armv8_pmu_driver_init() before smp_init().

But it is easy to take an opposite approach by enabling watchdog_hld to
get the capability of PMU async. The async model is achieved by
introducing an extra parameter notifier of watchdog_nmi_probe().

In this series, [1-2/5] are trivial cleanup. [3-5/5] is for this async
model.
    
[1]: http://lore.kernel.org/linux-arm-kernel/1610712101-14929-1-git-send-email-sumit.garg@linaro.org

Cc: Sumit Garg <sumit.garg@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Julien Thierry <jthierry@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Sami Tolvanen <samitolvanen@google.com>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Wang Qing <wangqing@vivo.com>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: Santosh Sivaraj <santosh@fossix.org>
To: linux-arm-kernel@lists.infradead.org
To: linux-kernel@vger.kernel.org


Pingfan Liu (5):
  kernel/watchdog: remove useless WATCHDOG_DEFAULT
  kernel/watchdog_hld: clarify the condition in
    hardlockup_detector_event_create()
  kernel/watchdog: adapt the watchdog_hld interface for async model
  kernel/watchdog_hld: simplify the detecting of hld watchdog
  arm64/watchdog_hld: enable hard lockup on arm64 platform

 arch/arm64/Kconfig                  |  3 ++
 arch/arm64/include/asm/perf_event.h |  5 ++
 arch/arm64/kernel/Makefile          |  1 +
 arch/arm64/kernel/perf_event.c      | 14 ++++-
 arch/arm64/kernel/watchdog_hld.c    | 83 +++++++++++++++++++++++++++++
 drivers/perf/arm_pmu.c              |  5 ++
 include/linux/nmi.h                 | 20 ++++---
 kernel/watchdog.c                   | 69 ++++++++++++++++++------
 kernel/watchdog_hld.c               | 26 +++------
 9 files changed, 181 insertions(+), 45 deletions(-)
 create mode 100644 arch/arm64/kernel/watchdog_hld.c

-- 
2.31.1

