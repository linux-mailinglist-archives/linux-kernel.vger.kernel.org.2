Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B23B42CF73
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 02:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbhJNAOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 20:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbhJNAOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 20:14:30 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31402C061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 17:12:26 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id j193-20020a2523ca000000b005b789d71d9aso4981135ybj.21
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 17:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Rd6B9VWfRXKdtrYMluqvHZ26IrGIgC0pqkttPCxXbFc=;
        b=fvdHiDmEE7M7IASKwp/3onuFuKTKEcbN1kEqxuC4btJRo9smhk79Wo/ftr1f0z8pwn
         mQ8E4e6EW/ZF/y3jhIjpuCoP1ynMNJ4KGwdPheQ1sSY7XMYjwMSu7tHV+jZGcmWOgNDK
         CeSk/TKU+l4HlHC7OwpOYkR7nNCccS+J94SGwMPgZhrqSCwAMmwN/m0W6RlkBlJxXGVf
         RxD7/2+U2c+wuSbR6H+YmrWuvAvTNgiikSF3l0aueTYn1FQOt//BocA9hWURgmP60ia0
         PQPnSX/i6o+jKe/jlIqxO5ZHf6oqA1qxTim2Zz7vco1qufHCWPyDBLDKDuS0RaRHNCkz
         DcYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Rd6B9VWfRXKdtrYMluqvHZ26IrGIgC0pqkttPCxXbFc=;
        b=M9EcG6mm5xN3Nx0NFgfw7WKuMCm/WF/GORbGWSEUiZYWHn4C9yY1RSJbtpVwrIILRg
         ASjm+VRcvQl7d1bgVFc2BJ7gVdb/MTB4syjcty7wVa2qfZIjfS1yY5O5hFDBY2AYuCRI
         mQiFmacuxTT4znZOrFY2Ti+YbFAlRIfiI2bc14gyV5faFBZVp8rpUbI+NMwziP3UOKEd
         jSVnzZE5nUgOpx/5QnjkZanzTvOArJG0RbJebrlycr6TccNykjb2GEBUiaFs7LuK6CCH
         Ic4b97Kg+1oyhiEPcSbiXEtdKSe2ttsE6y4NzBPD7a3AL7JDAs8Z6yIu4zPWu1185Mh9
         wGHg==
X-Gm-Message-State: AOAM530I/omJIuPR8YcCoVA08nk/8R1QSfMEBI9GFOenogZkU/hgx6wh
        Dp6G0E0DOvKk63MEtb+7cybwbR0zwcI8rgAVfp3RqLyBnooLq/uiCQRFV7FsutlXdBWWlNBA0Ig
        OsKC88K8i8Y4KsEqiZr0ELWW89f03AXfHXsiiF6tha5o8hKE1iXqq2stnGwMxlS9/MHBQfdTM
X-Google-Smtp-Source: ABdhPJx3PMB6VO00byZa6EhKgjhggvbQr867ipuwcwlFWtmtBhOb/8qjR/lag8XHJ1bWv053x5eq7XQeVFUM
X-Received: from uluru3.svl.corp.google.com ([2620:15c:2cd:202:a775:8bd3:8659:5fdf])
 (user=eranian job=sendgmr) by 2002:a25:d906:: with SMTP id
 q6mr2903134ybg.129.1634170345403; Wed, 13 Oct 2021 17:12:25 -0700 (PDT)
Date:   Wed, 13 Oct 2021 17:12:14 -0700
Message-Id: <20211014001214.2680534-1-eranian@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH] perf/x86/intel: fix ICL/SPR INST_RETIRED.PREC_DIST encodings
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, kan.liang@intel.com, ak@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the encoding for INST_RETIRED.PREC_DIST as published by Intel
(download.01.org/perfmon/) for Icelake. The official encoding
is event code 0x00 umask 0x1, a change from Skylake where it was code 0xc0
umask 0x1.

With this patch applied it is possible to run:
$ perf record -a -e cpu/event=0x00,umask=0x1/pp .....

Whereas before this would fail.

To avoid problems with tools which may use the old code, we maintain the old
encoding for Icelake.

Signed-off-by: Stephane Eranian <eranian@google.com>
---
 arch/x86/events/intel/core.c | 5 +++--
 arch/x86/events/intel/ds.c   | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 9a044438072b..bc3f97f83401 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -243,7 +243,8 @@ static struct extra_reg intel_skl_extra_regs[] __read_mostly = {
 
 static struct event_constraint intel_icl_event_constraints[] = {
 	FIXED_EVENT_CONSTRAINT(0x00c0, 0),	/* INST_RETIRED.ANY */
-	FIXED_EVENT_CONSTRAINT(0x01c0, 0),	/* INST_RETIRED.PREC_DIST */
+	FIXED_EVENT_CONSTRAINT(0x01c0, 0),	/* old INST_RETIRED.PREC_DIST */
+	FIXED_EVENT_CONSTRAINT(0x0100, 0),	/* INST_RETIRED.PREC_DIST */
 	FIXED_EVENT_CONSTRAINT(0x003c, 1),	/* CPU_CLK_UNHALTED.CORE */
 	FIXED_EVENT_CONSTRAINT(0x0300, 2),	/* CPU_CLK_UNHALTED.REF */
 	FIXED_EVENT_CONSTRAINT(0x0400, 3),	/* SLOTS */
@@ -288,7 +289,7 @@ static struct extra_reg intel_spr_extra_regs[] __read_mostly = {
 
 static struct event_constraint intel_spr_event_constraints[] = {
 	FIXED_EVENT_CONSTRAINT(0x00c0, 0),	/* INST_RETIRED.ANY */
-	FIXED_EVENT_CONSTRAINT(0x01c0, 0),	/* INST_RETIRED.PREC_DIST */
+	FIXED_EVENT_CONSTRAINT(0x0100, 0),	/* INST_RETIRED.PREC_DIST */
 	FIXED_EVENT_CONSTRAINT(0x003c, 1),	/* CPU_CLK_UNHALTED.CORE */
 	FIXED_EVENT_CONSTRAINT(0x0300, 2),	/* CPU_CLK_UNHALTED.REF */
 	FIXED_EVENT_CONSTRAINT(0x0400, 3),	/* SLOTS */
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 8647713276a7..4dbb55a43dad 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -923,7 +923,8 @@ struct event_constraint intel_skl_pebs_event_constraints[] = {
 };
 
 struct event_constraint intel_icl_pebs_event_constraints[] = {
-	INTEL_FLAGS_UEVENT_CONSTRAINT(0x1c0, 0x100000000ULL),	/* INST_RETIRED.PREC_DIST */
+	INTEL_FLAGS_UEVENT_CONSTRAINT(0x01c0, 0x100000000ULL),	/* old INST_RETIRED.PREC_DIST */
+	INTEL_FLAGS_UEVENT_CONSTRAINT(0x0100, 0x100000000ULL),	/* INST_RETIRED.PREC_DIST */
 	INTEL_FLAGS_UEVENT_CONSTRAINT(0x0400, 0x800000000ULL),	/* SLOTS */
 
 	INTEL_PLD_CONSTRAINT(0x1cd, 0xff),			/* MEM_TRANS_RETIRED.LOAD_LATENCY */
@@ -943,7 +944,7 @@ struct event_constraint intel_icl_pebs_event_constraints[] = {
 };
 
 struct event_constraint intel_spr_pebs_event_constraints[] = {
-	INTEL_FLAGS_UEVENT_CONSTRAINT(0x1c0, 0x100000000ULL),
+	INTEL_FLAGS_UEVENT_CONSTRAINT(0x100, 0x100000000ULL),	/* INST_RETIRED.PREC_DIST */
 	INTEL_FLAGS_UEVENT_CONSTRAINT(0x0400, 0x800000000ULL),
 
 	INTEL_FLAGS_EVENT_CONSTRAINT(0xc0, 0xfe),
-- 
2.33.0.1079.g6e70778dc9-goog

