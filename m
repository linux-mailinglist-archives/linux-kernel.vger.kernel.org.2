Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2B83A9304
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 08:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbhFPGuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 02:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbhFPGuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 02:50:21 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 822BEC06175F
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 23:48:15 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id s17-20020a17090a8811b029016e89654f93so3380622pjn.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 23:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pGeux1k9JWdeLuVQiCjnsXhyQPPrJGOsEZqXQl3yO0U=;
        b=C5NAcwkC7mA1qeppXu2tkTAkN7Jy2MTgN4kTAeYpf+aPPjiofwWPc/Zen9dH10DK9V
         6jXvGF/h1ZATOw9SeR1C7Tx2GNtiD1WXbuLL0OmjuErWPNdPy1V4lUzHlOm44m45mxhl
         KIOXN8nSFwgX4g6ztaeKjzyvLd5+qN0qZ00DSYdmWjSz01xXoRMwnQm0dEXk8RG+nJhu
         ikNPloTrQEgHmsd0HVbuetcSPjbihvHfewN5fDSOrtd0H5lo0o3Ng2oAMv3ekAyGprDv
         4EEZ4SXI/07UVoQ/B+WJu+EawA/rY0eOg30vHev6mco1uKydZbGOCjfDjoQYRHtLgWkm
         zQmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pGeux1k9JWdeLuVQiCjnsXhyQPPrJGOsEZqXQl3yO0U=;
        b=Ioz5x1S5eAC+CLycbCC9F6kjsrW4gDKccvaQOfmDGMnorQzRVX7os1AqS3t7f5+ive
         m0TLuoSEaQsCyhN6Uou5BZivnzhk1FucV7nKC9BhPOtoNGSzwS6zGpAJg1UXI1j32I/w
         OfqnWH6BJBSz/S7OPPwbfD5EJ+wHikJ1YsjbiNx4kkI4xq9CrsdPNKQo3id4wcLJHBGE
         HJAkVWyqxYrAIFRmEZwT95DxntHOamhKjuUT4o4FJ19Zh03r32PPspFFstQDfLtlENnq
         G5IOS5bkL8SDSZqGHTOyVaJrMMSTL1zMuGtcBQf/PszYhbfQMbVBHHczz62/dPOmqjgh
         PjqA==
X-Gm-Message-State: AOAM530aLyaexEaW57urD1RUsOisKJtLgoB2SkZS55QdegyEtVf2BQPH
        Lw0n363iPu/z5JA/Jqcb7Q5dJw==
X-Google-Smtp-Source: ABdhPJxyy8SzyZMJWv8Peo5J64qiBMxpXojyyPNFDjOw/oZUudqWKkHh3X4bGVEIbT9V/VeVa7bnoQ==
X-Received: by 2002:a17:903:3053:b029:110:d36:af61 with SMTP id u19-20020a1709033053b02901100d36af61mr7798331pla.5.1623826095004;
        Tue, 15 Jun 2021 23:48:15 -0700 (PDT)
Received: from localhost ([136.185.134.182])
        by smtp.gmail.com with ESMTPSA id x36sm1096314pfu.39.2021.06.15.23.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 23:48:14 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org, Qian Cai <quic_qiancai@quicinc.com>,
        linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH V2 0/3] cpufreq: cppc: Add support for frequency invariance
Date:   Wed, 16 Jun 2021 12:18:06 +0530
Message-Id: <cover.1623825725.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Changes since V1:

- Few of the patches migrating users to ->exit() callback are posted separately.

- The CPPC patch was completely reverted and so the support for FIE is again
  added here from scratch.

- The start_cpu() and stop_cpu() interface is reworked a little so stop_cpu() is
  only ever called for a CPU if start_cpu() was called for it earlier.

- A new patch to implement RCU locking in arch_topology core to avoid some
  races.

- Some cleanup and very clear/separate paths for FIE in cppc driver now.


-------------------------8<-------------------------

CPPC cpufreq driver is used for ARM servers and this patch series tries to
provide counter-based frequency invariance support for them in the absence for
architecture specific counters (like AMUs).

This was reverted earlier for the 5.13 kernel after Qian Cai reported kernel
oops during suspend/resume.

This is based of pm/linux-next + a cleanup patchset:

https://lore.kernel.org/linux-pm/cover.1623825358.git.viresh.kumar@linaro.org/

All the patches are pushed here together for people to run.

https://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git/log/?h=cpufreq/cppc

This is tested on my Hikey platform (without the actual read/write to
performance counters), with this script for over an hour:

while true; do
    for i in `seq 1 7`;
    do
        echo 0 > /sys/devices/system/cpu/cpu$i/online;
    done;

    for i in `seq 1 7`;
    do
        echo 1 > /sys/devices/system/cpu/cpu$i/online;
    done;
done


Vincent will be giving this patchset a try on ThunderX2.

Meanwhile it is up for review. Ideally I would like to get this merged for 5.14,
but lets see how it goes.

Thanks.

--
Viresh

Viresh Kumar (3):
  cpufreq: Add start_cpu() and stop_cpu() callbacks
  arch_topology: Avoid use-after-free for scale_freq_data
  cpufreq: CPPC: Add support for frequency invariance

 Documentation/cpu-freq/cpu-drivers.rst |   7 +-
 drivers/base/arch_topology.c           |  27 ++-
 drivers/cpufreq/Kconfig.arm            |  10 ++
 drivers/cpufreq/cppc_cpufreq.c         | 232 +++++++++++++++++++++++--
 drivers/cpufreq/cpufreq.c              |  19 +-
 include/linux/arch_topology.h          |   1 +
 include/linux/cpufreq.h                |   5 +-
 kernel/sched/core.c                    |   1 +
 8 files changed, 272 insertions(+), 30 deletions(-)

-- 
2.31.1.272.g89b43f80a514

