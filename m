Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51F7741BF87
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 09:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244512AbhI2HGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 03:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244488AbhI2HGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 03:06:14 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB8CC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 00:04:34 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id j6-20020a05620a288600b0045e5d85ca17so7743799qkp.16
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 00:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=485aqyMaDhgNS2O/IDjEvg+jxK02XiMi7beDqYxp0oU=;
        b=pn51I8FoCpp0r1PED2fZr8xnbRt/fFAtSye7wwHS3v5i7peflI0195y+mVTHkFdmsB
         xWM1nb/BQrYjDfZtCi1N79y0Ov8BNZsLNkLTCxd0q8qUr+HLUnGb4iKYmCZgmsZVpy9f
         3Ab9kA3sTdmkF/RT516ifCN162EU88z1b5BxNP/wsRKvOYBYAhgXebURobTSNG3mFggG
         T3mfnkBSQMb9SBBsCcsnHkqjNP+vvmc665nRH3Vs7/rWZm9zi2Cksri2yDHW/gK/edoL
         KnozByn9nPtxgxgS2du9I31tptg0QWOAnr7ji5UwKsgw9/6GPHrSlxotgZEXvQh20Vbv
         IaYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=485aqyMaDhgNS2O/IDjEvg+jxK02XiMi7beDqYxp0oU=;
        b=OAjm7XVrhklUvHrUKsAZ3uTauKiM6PiTTpeaOjPVD1p+9FcVBEIu4ikgPGoprpcPPo
         w2cUS3PPxMIvBnt0865URqdiJQiEO+h5ci3EHAL1eFilK1Pavao6KW6mGO5R8QGrD+J/
         n95jbZ+gwpTeSilblYa5RzHzNMEDFBOT3jjqW0po0phCyyEOKvSQVSWiGtJDowkdAxem
         4+o0kIbKFEdi1CknrB5POV7veyG023eVmnYiS1bi036GQpQ69MMRNvR0Mnx5bY2kOr4F
         nbZxSQQ471eJsX3Xfj+OJvaxv4NuM4qChJKL+c6hzMZiegKcAO/YCoqocaq2V0jG9xXD
         /vHA==
X-Gm-Message-State: AOAM533X2+VP1HdeLtiyW2eiBzx9Lgm/3cytcISY/Ceql6wHWCqqkAdh
        yvYWbPGNhTLNt47dADT66IwvaW4RIcsq
X-Google-Smtp-Source: ABdhPJz2Q+RMRv8+ZBVLFet3MQ700VtyYjtKz5H2PNxHN4Iu/cz1l5TyAVcm2tlliSB/aDALbhTqgbx4QCnX
X-Received: from nandos.syd.corp.google.com ([2401:fa00:9:14:846e:ae82:9f80:179b])
 (user=amistry job=sendgmr) by 2002:a05:6214:17d1:: with SMTP id
 cu17mr10202777qvb.14.1632899073573; Wed, 29 Sep 2021 00:04:33 -0700 (PDT)
Date:   Wed, 29 Sep 2021 17:04:21 +1000
Message-Id: <20210929170405.1.I078b98ee7727f9ae9d6df8262bad7e325e40faf0@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
Subject: [PATCH] perf/x86: Reset destroy callback on event init failure
From:   Anand K Mistry <amistry@google.com>
To:     linux-perf-users@vger.kernel.org
Cc:     Anand K Mistry <amistry@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

perf_init_event tries multiple init callbacks and does not reset the
event state between tries. When x86_pmu_event_init runs, it
unconditionally sets the destroy callback to hw_perf_event_destroy. On
the next init attempt after x86_pmu_event_init, in perf_try_init_event,
if the pmu's capabilities includes PERF_PMU_CAP_NO_EXCLUDE, the destroy
callback will be run. However, if the next init didn't set the destroy
callback, hw_perf_event_destroy will be run (since the callback wasn't
reset).

Looking at other pmu init functions, the common pattern is to only set
the destroy callback on a successful init. Resetting the callback on
failure tries to replicate that pattern.

This was discovered after commit f11dd0d80555 ("perf/x86/amd/ibs: Extend
PERF_PMU_CAP_NO_EXCLUDE to IBS Op") when the second (and only second)
run of the perf tool after a reboot results in 0 samples being
generated. The extra run of hw_perf_event_destroy results in
active_events having an extra decrement on each perf run. The second run
has active_events == 0 and every subsequent run has active_events < 0.
When active_events == 0, the NMI handler will early-out and not record
any samples.

Signed-off-by: Anand K Mistry <amistry@google.com>
---

 arch/x86/events/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index e6db1a1f22d7..1f5d96ba4866 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2284,6 +2284,7 @@ static int x86_pmu_event_init(struct perf_event *event)
 	if (err) {
 		if (event->destroy)
 			event->destroy(event);
+		event->destroy = NULL;
 	}
 
 	if (READ_ONCE(x86_pmu.attr_rdpmc) &&
-- 
2.33.0.800.g4c38ced690-goog

