Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1CB432D90F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 18:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbhCDRyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 12:54:55 -0500
Received: from mail.skyhub.de ([5.9.137.197]:40026 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238429AbhCDRpz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 12:45:55 -0500
Received: from zn.tnic (p200300ec2f0f5900f7833063514d8659.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:5900:f783:3063:514d:8659])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D03811EC0521;
        Thu,  4 Mar 2021 18:43:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1614879782;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TNjXE2UFHHTe6lHzK2/HNaw3+6Jea1YXLbNIAUzuqbA=;
        b=rbhCIRqj2o0KVVTF9e+ZvbcIJ5sm7/RAkWaigJF1u3fFm7pqpXPbdY6GkumJN0hUmDtVor
        d8/j0uVJ/CA3cVGVATKLbpHhMw5nnMvoT690a2khDLAb3MeorFNzug+3MDzDboZl1md+lh
        l2YfQ1dUhaBWet0H4iraIRNdT0E14j8=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v3 19/21] tools/perf: Convert to insn_decode()
Date:   Thu,  4 Mar 2021 18:42:35 +0100
Message-Id: <20210304174237.31945-20-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210304174237.31945-1-bp@alien8.de>
References: <20210304174237.31945-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Simplify code, no functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/x86/tests/insn-x86.c            |  9 ++++-----
 tools/perf/arch/x86/util/archinsn.c             |  9 +++++----
 .../intel-pt-decoder/intel-pt-insn-decoder.c    | 17 ++++++++++-------
 3 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/tools/perf/arch/x86/tests/insn-x86.c b/tools/perf/arch/x86/tests/insn-x86.c
index f782ef8c5982..049bcbc69eea 100644
--- a/tools/perf/arch/x86/tests/insn-x86.c
+++ b/tools/perf/arch/x86/tests/insn-x86.c
@@ -96,13 +96,12 @@ static int get_branch(const char *branch_str)
 static int test_data_item(struct test_data *dat, int x86_64)
 {
 	struct intel_pt_insn intel_pt_insn;
+	int op, branch, ret;
 	struct insn insn;
-	int op, branch;
 
-	insn_init(&insn, dat->data, MAX_INSN_SIZE, x86_64);
-	insn_get_length(&insn);
-
-	if (!insn_complete(&insn)) {
+	ret = insn_decode(&insn, dat->data, MAX_INSN_SIZE,
+			  x86_64 ? INSN_MODE_64 : INSN_MODE_32);
+	if (ret < 0) {
 		pr_debug("Failed to decode: %s\n", dat->asm_rep);
 		return -1;
 	}
diff --git a/tools/perf/arch/x86/util/archinsn.c b/tools/perf/arch/x86/util/archinsn.c
index 3e6791531ca5..9fb12e8e67eb 100644
--- a/tools/perf/arch/x86/util/archinsn.c
+++ b/tools/perf/arch/x86/util/archinsn.c
@@ -11,7 +11,7 @@ void arch_fetch_insn(struct perf_sample *sample,
 		     struct machine *machine)
 {
 	struct insn insn;
-	int len;
+	int len, ret;
 	bool is64bit = false;
 
 	if (!sample->ip)
@@ -19,8 +19,9 @@ void arch_fetch_insn(struct perf_sample *sample,
 	len = thread__memcpy(thread, machine, sample->insn, sample->ip, sizeof(sample->insn), &is64bit);
 	if (len <= 0)
 		return;
-	insn_init(&insn, sample->insn, len, is64bit);
-	insn_get_length(&insn);
-	if (insn_complete(&insn) && insn.length <= len)
+
+	ret = insn_decode(&insn, sample->insn, len,
+			  is64bit ? INSN_MODE_64 : INSN_MODE_32);
+	if (ret >= 0 && insn.length <= len)
 		sample->insn_len = insn.length;
 }
diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c
index 2f6cc7eea251..593f20e9774c 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-insn-decoder.c
@@ -169,11 +169,13 @@ int intel_pt_get_insn(const unsigned char *buf, size_t len, int x86_64,
 		      struct intel_pt_insn *intel_pt_insn)
 {
 	struct insn insn;
+	int ret;
 
-	insn_init(&insn, buf, len, x86_64);
-	insn_get_length(&insn);
-	if (!insn_complete(&insn) || insn.length > len)
+	ret = insn_decode(&insn, buf, len,
+			  x86_64 ? INSN_MODE_64 : INSN_MODE_32);
+	if (ret < 0 || insn.length > len)
 		return -1;
+
 	intel_pt_insn_decoder(&insn, intel_pt_insn);
 	if (insn.length < INTEL_PT_INSN_BUF_SZ)
 		memcpy(intel_pt_insn->buf, buf, insn.length);
@@ -194,12 +196,13 @@ const char *dump_insn(struct perf_insn *x, uint64_t ip __maybe_unused,
 		      u8 *inbuf, int inlen, int *lenp)
 {
 	struct insn insn;
-	int n, i;
+	int n, i, ret;
 	int left;
 
-	insn_init(&insn, inbuf, inlen, x->is64bit);
-	insn_get_length(&insn);
-	if (!insn_complete(&insn) || insn.length > inlen)
+	ret = insn_decode(&insn, inbuf, inlen,
+			  x->is64bit ? INSN_MODE_64 : INSN_MODE_32);
+
+	if (ret < 0 || insn.length > inlen)
 		return "<bad>";
 	if (lenp)
 		*lenp = insn.length;
-- 
2.29.2

