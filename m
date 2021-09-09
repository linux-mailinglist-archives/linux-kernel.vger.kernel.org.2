Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 880BF4046A2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 09:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbhIIIAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 04:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbhIIH75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 03:59:57 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B87FEC0613C1
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 00:58:48 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 63-20020a250d42000000b0059dc43162c9so1344602ybn.23
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 00:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=KujjUUPlr+tuE5rUahYPqg4eiHhp2n+Zb/NK/Myctvg=;
        b=F067E2gt15Rj9kESLRbDsD5mAp/sNjHr/BJ3HrwEiDLBp0ES7eEhUiV+YoKBFAMpkH
         qCMYHYJ8aMyrQLcN4/9YFaD0ls3jnm0wF71RpdN1/UKpqsxCXu4pfhGIBv2aWGeGQUnA
         6AG6RBnk0PWFyl6yUmxaL8u9kf8a6uYryUYGqggYWc0lAKidfRpdP2NMKkaqalpwYX9p
         LhllN3xj47s7ohO4xPxBZzoukwzk/eBtkXwicFzRJWlaMi6QrusLKZcq5D1v74Zkc2MJ
         l45EbMfWPcfW5xM6vTl8XZPDaebRXLGkVI5xIzdYOxiso7o/+mkeX/ZCbMOimBT0fS4C
         LgxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KujjUUPlr+tuE5rUahYPqg4eiHhp2n+Zb/NK/Myctvg=;
        b=oz+7b/D/atwcEqOJ7ToGliRW1hxNJhfkhvcOMsSihLyT087SQDHDVFtmPeYuRqcH8n
         kAXCIHCKXzPtoqoiBRoClsUG0B689Dm8/Is2YqnMru2/UfyKgjNHqcJjobDTN4eGqm02
         e9kQIEKHFD5nPRqLJUeKMck4cAYppegOxSpWyCydaaxMiPHasiK2/yzT4+uPbcbWaF5Y
         umhu1y65ILijz4s6TDCgSXq7djmFZWilWP4l4ZW7ihDGgpd8Gi6YP+XJZNafXZvcxfr8
         FUljeuDdbGiMKAu+GkUbwQQ5Py5ASeRXNDMuPmr7yNZmil2sKVm8sNMXFpAAzAx98ST8
         /9Rg==
X-Gm-Message-State: AOAM531qq5yzuF7zCh6HDQOoWpBFdqhroqg1kQrQkg58O0iOfP5jy1rj
        2x/4YUpsDL3fFAg3loS6PCAaekX/9pQa8I7bdViGohhx3BXDGpEKfjpuIDPHhZaYOFYvAgWCc5U
        KSaT80R1LGwre+UmX0E+qaemxPhwxLEKmEVdeaAIs9Yu2N8vGD23FdhX2dLN7F0oeYDi+DZ5i
X-Google-Smtp-Source: ABdhPJw07XX+MtdYPwA+Q3Ijeyxm2zgkVGU/Z4kNSvmDhdUx3R9o77fAfpodb0uH/+aZcI1Fq70B/pWpEs9P
X-Received: from uluru3.svl.corp.google.com ([2620:15c:2cd:202:f950:61f2:f1ec:ae8b])
 (user=eranian job=sendgmr) by 2002:a25:ad52:: with SMTP id
 l18mr2106490ybe.453.1631174327886; Thu, 09 Sep 2021 00:58:47 -0700 (PDT)
Date:   Thu,  9 Sep 2021 00:56:51 -0700
In-Reply-To: <20210909075700.4025355-1-eranian@google.com>
Message-Id: <20210909075700.4025355-5-eranian@google.com>
Mime-Version: 1.0
References: <20210909075700.4025355-1-eranian@google.com>
X-Mailer: git-send-email 2.33.0.153.gba50c8fa24-goog
Subject: [PATCH v1 04/13] perf/x86/amd: add branch-brs helper event for Fam19h BRS
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, acme@redhat.com, jolsa@redhat.com,
        kim.phillips@amd.com, namhyung@kernel.org, irogers@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a pseudo event called branch-brs to help use the FAM Fam19h Branch
Sampling feature (BRS). BRS samples taken branches, so it is best used when sampling
on a retired taken branch event (0xc4) which is what BRS captures.
Instead of trying to remember the event code or actual event name, users can simply do:

$ perf record -b -e cpu/branch-brs/ -c 1000037 .....

Signed-off-by: Stephane Eranian <eranian@google.com>
---
 arch/x86/events/amd/core.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 86adb0e879c6..d6d5119260a9 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -1106,8 +1106,24 @@ static struct attribute_group group_caps_amd_brs = {
 	.is_visible = amd_brs_is_visible,
 };
 
+#define AMD_FAM19H_BRS_EVENT 0xc4 /* Fam19h RETIRED_TAKEN_BRANCH_INSTRUCTIONS */
+EVENT_ATTR_STR(branch-brs, amd_branch_brs,
+	       "event=" __stringify(AMD_FAM19H_BRS_EVENT)"\n");
+
+static struct attribute *amd_brs_events_attrs[] = {
+	EVENT_PTR(amd_branch_brs),
+	NULL,
+};
+
+static struct attribute_group group_events_amd_brs = {
+	.name       = "events",
+	.attrs      = amd_brs_events_attrs,
+	.is_visible = amd_brs_is_visible,
+};
+
 static const struct attribute_group *amd_attr_update[] = {
 	&group_caps_amd_brs,
+	&group_events_amd_brs,
 	NULL,
 };
 
-- 
2.33.0.153.gba50c8fa24-goog

