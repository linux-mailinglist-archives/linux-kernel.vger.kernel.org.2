Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6A224160C7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 16:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241646AbhIWOLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 10:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241645AbhIWOLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 10:11:51 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00D5C061756
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 07:10:19 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id r2so6436917pgl.10
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 07:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bs8p7jBvxim/Kr15A2OV4dN2/Mya/1qDXohd6hFoZU8=;
        b=hhQZH3A2YahkZIGyCB11t8MDcxyoHxC3hwtw1e3SDnawMLSo1u+fV76diWFr7dR2VY
         1RyitLX3DOn+Jy51CbVQeMMVa+DudjAxej6/vunZFV1qoxt9ppaoB7ZfORi73SKec2oI
         g+29SO6QIvw1XXIlr9O2UBjUXifiEO0ciK1i8qCisIDgcWDC0GOiy130wL213Y+EvftL
         74fySXt/IwXr/hkkfn7Tg2s+EK4bl2C7goHXDZja13BV4bXIrOGSZqEz/0gKZ36M3L7F
         OA6x1ULdK3uArS/OjrOs+nnUM8rVmmoRYXQlS6Dm18a98t9Ab2PC9UGRXHhITcHOD0nx
         4yiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bs8p7jBvxim/Kr15A2OV4dN2/Mya/1qDXohd6hFoZU8=;
        b=jIA6Of71kNmnAfacF+iEckyQ+e9KHPcUMyzJwznoo4cFtnx5MzYaXNr3PXqgpPsFDk
         nLcYagpIPxcsLfIZqC79YILcEVVJ2tK50KDbpKCReBn/3960ABLwbjfJdK2SPna/QH71
         w4Xd9HPidtEn9YlmuauMLNPXp52bQod7u1Zgp/zlk26+2VO6Np4m63Fo0Xf1NdEwwjhy
         Jc9O69+dVit6gHYGsC0sFjm2/uVk3hn+2WgtvZRC+GGSDkBZEt0JbzbLoyEtUCI+laFE
         Jw1rRyWNIzjbz8y56+uAwV7bO0rtzBfro+Do5rYjzoU33DpZghKHQ8cZHGFFTZsaLsIG
         bivw==
X-Gm-Message-State: AOAM533nCK+pPLpKAGgcJR3DuC/k9PndSSZJS0OYeJFlyVPM4WlkC3c0
        KfGX1ujqPk3qDVzfyLHhFg==
X-Google-Smtp-Source: ABdhPJwTWlyXVR1PJUb+0Q0cITf1GXZ/W7/ofK4VM3wAjnkormgd23RTaJ/t4CCcN+48liNtzjCifw==
X-Received: by 2002:a63:b252:: with SMTP id t18mr4415027pgo.14.1632406219483;
        Thu, 23 Sep 2021 07:10:19 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id j6sm5800766pfn.107.2021.09.23.07.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 07:10:18 -0700 (PDT)
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
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wang Qing <wangqing@vivo.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Santosh Sivaraj <santosh@fossix.org>
Subject: [PATCHv2 0/4] watchdog_hld cleanup and async model for arm64
Date:   Thu, 23 Sep 2021 22:09:47 +0800
Message-Id: <20210923140951.35902-1-kernelfans@gmail.com>
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
( To: Sumit, I think the main body of [4/4] is contributed from you,so I
keep you as the author, please let me know if you dislike it and my
modification.)

There is an obstacle to integrate arm64 hw perf event into watchdog_hld.
When lockup_detector_init()->watchdog_nmi_probe(), on arm64, PMU is not
ready until device_initcall(armv8_pmu_driver_init).  And it is deeply
integrated with the driver model and cpuhp. Hence it is hard to push
the initialization of armv8_pmu_driver_init() before smp_init().

But it is easy to take an opposite approach by enabling watchdog_hld to
get the capability of PMU async. 
The async model is achieved by expanding watchdog_nmi_probe() with
-EBUSY, and a re-initializing work_struct which waits on a
wait_queue_head.

In this series, [1-2/4] are trivial cleanup. [3-4/4] is for this async
model.


v1 > v2:
    uplift the async model from hard lockup layer to watchdog layter.
The benefit is simpler code, the drawback is re-initialize means wasted
alloc/free.
    
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

*** BLURB HERE ***

Pingfan Liu (3):
  kernel/watchdog: trival cleanups
  kernel/watchdog_hld: clarify the condition in
    hardlockup_detector_event_create()
  kernel/watchdog: adapt the watchdog_hld interface for async model

Sumit Garg (1):
  arm64: Enable perf events based hard lockup detector

 arch/arm64/Kconfig               |  2 ++
 arch/arm64/kernel/Makefile       |  1 +
 arch/arm64/kernel/perf_event.c   | 11 +++++++--
 arch/arm64/kernel/watchdog_hld.c | 36 +++++++++++++++++++++++++++
 drivers/perf/arm_pmu.c           |  5 ++++
 include/linux/nmi.h              |  5 +++-
 include/linux/perf/arm_pmu.h     |  2 ++
 kernel/watchdog.c                | 42 +++++++++++++++++++++++++++-----
 kernel/watchdog_hld.c            |  5 +++-
 9 files changed, 99 insertions(+), 10 deletions(-)
 create mode 100644 arch/arm64/kernel/watchdog_hld.c

-- 
2.31.1

