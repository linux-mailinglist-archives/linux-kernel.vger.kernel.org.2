Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87C95316132
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 09:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbhBJIiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 03:38:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhBJIeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 03:34:23 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC79C061756
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 00:33:42 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id c11so786932pfp.10
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 00:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P6rhtAYLG1gXFZ7PB3kRYPBv2eeanr9xcLohT1MKoRA=;
        b=nLi0BNZHUIwV7EH2fFrhCOdJ0Khtw7wT0xW3ApR2VdHxJz5ox3LnVTwlaMnnO8GMFN
         aLtaojOaGWGOTzSY30dFI/Y3a0zYh5kaZoCYlwRgh4yqjlLJ2EanHvKviiFqxEluQ5EG
         NTV7Etj3q9eroJLBcHhlIyyDFfekx4gx8TgTOZx6fqPfOpHMGZYvz+tB+M+cNhg/8VZg
         XPbbXbovLj27HMUBaFtlROk0Z+gtVyoTtmMGlotBMIILtkA/Ehw74/+Y2EsCVr/Rgehz
         o8dMMBtTg86Dc1O4lYWmZPSTgwLGDbw1cAasWdF2Ft9EOeIQ9ainoavGMk9+B6j5CDiY
         +E9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=P6rhtAYLG1gXFZ7PB3kRYPBv2eeanr9xcLohT1MKoRA=;
        b=fLKe4zkzbzos4XaJt+uYk6ZC/DqmuWbk1tYteGO7wO6ynoHKnko3AqTa67Dc79FrcK
         C+mDMgZdgjPd5uy4Nr1nW6GfmAhqPeqzuelhw1T7EO68kNESgeAX2C0Lg5Q4w1+irYpr
         REreZw4tAMCLfCFO/VfCXscYPiPe6+8F66Egvfo8k4Y3J5JDNk9cdI3bmJ42u8I70VJE
         E0I5BtDa8nXcijR2gfigUF8lcghYCIWQufOFJ9Yhlk9pNA3fD281YEecMXFbda6TpGfO
         VF2iow2k8dGYhCH3QvYEgzIzYmh1g26FHVaAoi85CmAz8VkkzE88bIJLIqpIIFJqoOik
         9Vmw==
X-Gm-Message-State: AOAM532ZmHShAfqS3mbnjUtNznzeco1CNAj4VtyYWBYWv5CbHMyeigjt
        1hKl908eVgPAFc4oI8A5vZs=
X-Google-Smtp-Source: ABdhPJz+aDJEgZcIzu5LSXudex+R5PmvLroa/1AvW2IDqsDThy8GDFVD0qGJfTM8bRbD16Jc9u07oQ==
X-Received: by 2002:a05:6a00:14c8:b029:1bb:8436:497c with SMTP id w8-20020a056a0014c8b02901bb8436497cmr1996645pfu.68.1612946021635;
        Wed, 10 Feb 2021 00:33:41 -0800 (PST)
Received: from balhae.roam.corp.google.com ([114.129.115.223])
        by smtp.gmail.com with ESMTPSA id l21sm1401341pjy.31.2021.02.10.00.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 00:33:40 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH v3 2/3] perf core: Add PERF_COUNT_SW_CGROUP_SWITCHES event
Date:   Wed, 10 Feb 2021 17:33:26 +0900
Message-Id: <20210210083327.22726-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
In-Reply-To: <20210210083327.22726-1-namhyung@kernel.org>
References: <20210210083327.22726-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a new software event to count context switches
involving cgroup switches.  So it's counted only if cgroups of
previous and next tasks are different.  Note that it only checks the
cgroups in the perf_event subsystem.  For cgroup v2, it shouldn't
matter anyway.

One can argue that we can do this by using existing sched_switch event
with eBPF.  But some systems might not have eBPF for some reason so
I'd like to add this as a simple way.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 include/linux/perf_event.h      | 7 +++++++
 include/uapi/linux/perf_event.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 2a1be6026a2f..270dbe2ae0b2 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1214,6 +1214,13 @@ static inline void perf_event_task_sched_out(struct task_struct *prev,
 	if (__perf_sw_enabled(PERF_COUNT_SW_CONTEXT_SWITCHES))
 		__perf_sw_event_sched(PERF_COUNT_SW_CONTEXT_SWITCHES, 1, 0);
 
+#ifdef CONFIG_CGROUP_PERF
+	if (__perf_sw_enabled(PERF_COUNT_SW_CGROUP_SWITCHES) &&
+	    perf_cgroup_from_task(prev, NULL) !=
+	    perf_cgroup_from_task(next, NULL))
+		__perf_sw_event_sched(PERF_COUNT_SW_CGROUP_SWITCHES, 1, 0);
+#endif
+
 	if (static_branch_unlikely(&perf_sched_events))
 		__perf_event_task_sched_out(prev, next);
 }
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 7d292de51410..78445919a752 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -112,6 +112,7 @@ enum perf_sw_ids {
 	PERF_COUNT_SW_EMULATION_FAULTS		= 8,
 	PERF_COUNT_SW_DUMMY			= 9,
 	PERF_COUNT_SW_BPF_OUTPUT		= 10,
+	PERF_COUNT_SW_CGROUP_SWITCHES		= 11,
 
 	PERF_COUNT_SW_MAX,			/* non-ABI */
 };
-- 
2.30.0.478.g8a0d178c01-goog

