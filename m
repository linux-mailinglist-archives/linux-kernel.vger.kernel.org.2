Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA3A5309D13
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 15:45:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbhAaOlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 09:41:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232758AbhAaOhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 09:37:00 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD74C061573
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 06:36:19 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id m22so8853767ljj.4
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 06:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/UCJ9q9ya5x1hYaVcsdfuQylFq06C62w4UYyWc40RoM=;
        b=UUezd8qS+leTyd2V/5BGzxU5HfOl/xKtSwtRWtQusvlKpTMtLLx/+fwcp6luWesL/f
         lg+FAULF8uSLwVRMkAARJMHDTAToySHgwsiLHnOzHYaWuDorKnowye0UgsHIYaYbV4mx
         Opd7pbhz7D6Tf5ResiVaWIMLTNrJGFxq1/0iOdfaoX2gNLWcgfJAgih/4+CYPEZXhHMk
         j52k02kjILmPKzoUq13CSN6AIgz6uUVEl3aVqpzfKn/d6KKlsVX0tT+GvSNK/ofKOreZ
         /ZTjjbyyx/LpfNh6AFbLbFQQWm9fMnGOwxsA6mCU20AOGL6Unps5K+oJlwqArB44Sp6Q
         mXWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/UCJ9q9ya5x1hYaVcsdfuQylFq06C62w4UYyWc40RoM=;
        b=Hcv7dOKAtdIQ8R3cDgfnMS4ab42WAly6fKWlbSuvwYUo6LMQBxWNrP0r6QpG4o4qEO
         09RWZHICcU/sCMWUMV/02kq7gA7iGr2VTa9wAgCY2mH5lFCHHM5+NczvuHiQq1JD3T9u
         oOVLBk8HcPyztqzHCOdGxx6oVCg2y1e3a8rvs9Tbi7hGr64Hksg3XT/bMrXAcx8pfOMC
         ezkgmpCRneVDrp2D+zwT+aIVYuvJPtkmtF+bPuPFDgn5QVhNvUOVzRllORI8QA0QTaE0
         ndzF6y1OIammhHFbvYYWlqOgSuPxme8lhtY+sy4KBnyKyV98HTdbmaZr96pwuV9uY2dH
         OzOA==
X-Gm-Message-State: AOAM533XuY+rhGobGAeZPzZPkZUmNJb9AfOJhbAWFP+QsevKVDe1/oQT
        p7mzySGX7snzpFL5NS11gms=
X-Google-Smtp-Source: ABdhPJyi3UmfY3F4KBNKCMyQfShVzLkQHTV7fuufIhldBPeM4T4mgmNDf9E7qunKStFXeb6bikXXGw==
X-Received: by 2002:a2e:b17c:: with SMTP id a28mr7447111ljm.189.1612103778296;
        Sun, 31 Jan 2021 06:36:18 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-164.NA.cust.bahnhof.se. [158.174.22.164])
        by smtp.gmail.com with ESMTPSA id p3sm2681467lfu.271.2021.01.31.06.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jan 2021 06:36:17 -0800 (PST)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH] arm64: perf: Constify static attribute_group structs
Date:   Sun, 31 Jan 2021 15:36:15 +0100
Message-Id: <20210131143615.21376-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only usage of these is to put their addresses in an array of
pointers to const attribute_group structs. Make them const to allow the
compiler to put them in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 arch/arm64/kernel/perf_event.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 3605f77ad4df..59b1eed52236 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -280,7 +280,7 @@ armv8pmu_event_attr_is_visible(struct kobject *kobj,
 	return 0;
 }
 
-static struct attribute_group armv8_pmuv3_events_attr_group = {
+static const struct attribute_group armv8_pmuv3_events_attr_group = {
 	.name = "events",
 	.attrs = armv8_pmuv3_event_attrs,
 	.is_visible = armv8pmu_event_attr_is_visible,
@@ -300,7 +300,7 @@ static struct attribute *armv8_pmuv3_format_attrs[] = {
 	NULL,
 };
 
-static struct attribute_group armv8_pmuv3_format_attr_group = {
+static const struct attribute_group armv8_pmuv3_format_attr_group = {
 	.name = "format",
 	.attrs = armv8_pmuv3_format_attrs,
 };
@@ -322,7 +322,7 @@ static struct attribute *armv8_pmuv3_caps_attrs[] = {
 	NULL,
 };
 
-static struct attribute_group armv8_pmuv3_caps_attr_group = {
+static const struct attribute_group armv8_pmuv3_caps_attr_group = {
 	.name = "caps",
 	.attrs = armv8_pmuv3_caps_attrs,
 };
-- 
2.30.0

