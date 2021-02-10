Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9BE316B86
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 17:43:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233179AbhBJQnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 11:43:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232957AbhBJQir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 11:38:47 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F89C061788
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 08:36:17 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id u143so1598468pfc.7
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 08:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DHjPOaB9z0WBR9paX+T9/UPiJiQWfM7w1AksmlIdo9Y=;
        b=Xe+iIF1J2RqqvQMPg6QGaiJ+0x0WzZ5tPKHx+tq9dsjURd6cnGQCotLlHJpEmN6mMV
         qVHUcOOboYGFfuVDl86/5lnWStG+L67KwyWuJ8lkUoOhyc/5MvF71iI7UVukpDHx8gkJ
         4PqLOn7Wl+eNVLPJne8U8GfQo1Rx9KkkfB8oekzqb7wwtFcguJa7KK+t/iu4qJxOnIob
         prnEUyVDLg4f62AINDbry2FroaQykj/80Ts4B/7biiLHEcWlQ5BlfIM6RW97WAGNxfYx
         +TQn6vxoOcOERCjA7B6XxMzgW55psimnZEfoHDdXYtG7zJtVeOHJxCnYmwy3TRz/qw7s
         U02g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DHjPOaB9z0WBR9paX+T9/UPiJiQWfM7w1AksmlIdo9Y=;
        b=DQ0A2DD1N02dP6ZpJUbqh9gQUP9bMbapyWqGuE/I1so5ZatAJqqIANhk1H2St/B95k
         Ld8AzvlzmlVKxc6h3xL/rhsZJThG0Um6ioIXPk3Ts/9SvBy1scr+aBMi+CpIVlz/eyB/
         lQnN6yCSemNUtjjf7vBVULsuFNaI4kENGar2e4qUY7cq/LtbZCnMgSrOmZZsXa3fSKIL
         mIaXczup42b/Sfj24Drdw68flluEhc4C/mxg6QA4jLvNSEa733q0AKuGcnR2qQk+q0KG
         wSXT2tajDxVU2EKIkYXg6OcYpj7Jk3geMS0iZ3kzodmPV4qc6OnUP1HkyiG8HlNWaBuk
         HS/g==
X-Gm-Message-State: AOAM533u6wJ3ZRMTV4no4/lxUyIbcVjxhs+F/0RDQyjDVj9lKkFA498a
        B8a0bIOSwtdN0yV58tqBLyQIqi8W29q6Zw==
X-Google-Smtp-Source: ABdhPJyz5/IWiVKrO5/qWYpapaKEdr3aBd6RAIgVCTKfri0RIj3bR4mUK9oulzhguZfsOvMeWX0VOA==
X-Received: by 2002:a63:5525:: with SMTP id j37mr3885830pgb.191.1612974976999;
        Wed, 10 Feb 2021 08:36:16 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id bv21sm2914637pjb.15.2021.02.10.08.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 08:36:16 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] Documentation: coresight: Add PID tracing description
Date:   Wed, 10 Feb 2021 09:36:10 -0700
Message-Id: <20210210163610.2338491-3-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210210163610.2338491-1-mathieu.poirier@linaro.org>
References: <20210210163610.2338491-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leo Yan <leo.yan@linaro.org>

After support the PID tracing for the kernel in EL1 or EL2, the usage
gets more complicated.

This patch gives description for the PMU formats of contextID configs,
this can help users to understand how to control the knobs for PID
tracing when the kernel is in different ELs.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Reviewed-by: Mike Leach <mike.leach@linaro.org>
Message-Id: <20210206150833.42120-9-leo.yan@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 Documentation/trace/coresight/coresight.rst | 32 +++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/Documentation/trace/coresight/coresight.rst b/Documentation/trace/coresight/coresight.rst
index 0b73acb44efa..169749efd8d1 100644
--- a/Documentation/trace/coresight/coresight.rst
+++ b/Documentation/trace/coresight/coresight.rst
@@ -512,6 +512,38 @@ The --itrace option controls the type and frequency of synthesized events
 Note that only 64-bit programs are currently supported - further work is
 required to support instruction decode of 32-bit Arm programs.
 
+2.2) Tracing PID
+
+The kernel can be built to write the PID value into the PE ContextID registers.
+For a kernel running at EL1, the PID is stored in CONTEXTIDR_EL1.  A PE may
+implement Arm Virtualization Host Extensions (VHE), which the kernel can
+run at EL2 as a virtualisation host; in this case, the PID value is stored in
+CONTEXTIDR_EL2.
+
+perf provides PMU formats that program the ETM to insert these values into the
+trace data; the PMU formats are defined as below:
+
+  "contextid1": Available on both EL1 kernel and EL2 kernel.  When the
+                kernel is running at EL1, "contextid1" enables the PID
+                tracing; when the kernel is running at EL2, this enables
+                tracing the PID of guest applications.
+
+  "contextid2": Only usable when the kernel is running at EL2.  When
+                selected, enables PID tracing on EL2 kernel.
+
+  "contextid":  Will be an alias for the option that enables PID
+                tracing.  I.e,
+                contextid == contextid1, on EL1 kernel.
+                contextid == contextid2, on EL2 kernel.
+
+perf will always enable PID tracing at the relevant EL, this is accomplished by
+automatically enable the "contextid" config - but for EL2 it is possible to make
+specific adjustments using configs "contextid1" and "contextid2", E.g. if a user
+wants to trace PIDs for both host and guest, the two configs "contextid1" and
+"contextid2" can be set at the same time:
+
+  perf record -e cs_etm/contextid1,contextid2/u -- vm
+
 
 Generating coverage files for Feedback Directed Optimization: AutoFDO
 ---------------------------------------------------------------------
-- 
2.25.1

