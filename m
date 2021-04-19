Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E45736477C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 17:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241881AbhDSPxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 11:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241761AbhDSPxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 11:53:24 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD50DC06138A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 08:52:54 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id u20so13947017wmj.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 08:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=81f1son52XVDAEK91VVd7eOwFElRFc/QYfZDjUricSQ=;
        b=awcoGd5ah9jTHf9eWbR4CuUk3Cr6iesTNkFIdoOBaHT6/zQFFF6UIUGp2veeXIDwhZ
         kEr6VGsGNNu0vL3UX9kz0VVMBXUjdDD7kjZsoAifdDv+WFz0Wczzgr2lfX40LbvzTCzw
         acR4PsYi+YXN+MxPmxBhPvGPD7uAX/288oxnU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=81f1son52XVDAEK91VVd7eOwFElRFc/QYfZDjUricSQ=;
        b=aNfm3lAvE5UbTFIhqu7IdB7of/TtigvSQyM4FP+Vqd/oPJqTFw9T60IHBnaDz2R6b9
         sqgrMH1o/xR2yIa9VrlfyXLsn2AFdxpJ2+HWbhN/F7FY2WUAHTFlRTxUEPqjWqftZl2Z
         yaH6NXtr8fUaHSGCzchF+B66VDwBqGK6QH4jv8rXQ2p411gzkBtb/Z8whV2dfwvlNhNe
         n0ijdL9zyRH3dBW4VOOHqMtMPgJHq8dCNGi7BVAtsuIAyx6ZxnHrsCBHaJrEBBz19wsy
         pbk2e2uQL3FjUYEBTFXsEvGuLqtbsZpv7andkdz/liEaRn5HWo4IOcZYQZsce7Ayo+w8
         L3GQ==
X-Gm-Message-State: AOAM530USMFgcgpF7Cwx6FnLEBG5w8SgXQHmb74uvelPrs03Ml+fh3pX
        TNu5UwJbksC74KHFobUd4shVeQ==
X-Google-Smtp-Source: ABdhPJx8REppVKZkSF6SO4pLfdvDW3VBm/7/sLkBHwjOZ8CAky4sbHTnDx7kb2EEqCwzl+IBov5SDA==
X-Received: by 2002:a1c:7516:: with SMTP id o22mr21889834wmc.91.1618847573640;
        Mon, 19 Apr 2021 08:52:53 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:61:302:3bbb:3f8f:826f:7f55])
        by smtp.gmail.com with ESMTPSA id l9sm22868669wrz.7.2021.04.19.08.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 08:52:53 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, jackmanb@chromium.org,
        linux-kernel@vger.kernel.org, Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next v5 5/6] libbpf: Introduce a BPF_SNPRINTF helper macro
Date:   Mon, 19 Apr 2021 17:52:42 +0200
Message-Id: <20210419155243.1632274-6-revest@chromium.org>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
In-Reply-To: <20210419155243.1632274-1-revest@chromium.org>
References: <20210419155243.1632274-1-revest@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similarly to BPF_SEQ_PRINTF, this macro turns variadic arguments into an
array of u64, making it more natural to call the bpf_snprintf helper.

Signed-off-by: Florent Revest <revest@chromium.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf_tracing.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
index 1c2e91ee041d..8c954ebc0c7c 100644
--- a/tools/lib/bpf/bpf_tracing.h
+++ b/tools/lib/bpf/bpf_tracing.h
@@ -447,4 +447,22 @@ static __always_inline typeof(name(0)) ____##name(struct pt_regs *ctx, ##args)
 		       ___param, sizeof(___param));		\
 })
 
+/*
+ * BPF_SNPRINTF wraps the bpf_snprintf helper with variadic arguments instead of
+ * an array of u64.
+ */
+#define BPF_SNPRINTF(out, out_size, fmt, args...)		\
+({								\
+	static const char ___fmt[] = fmt;			\
+	unsigned long long ___param[___bpf_narg(args)];		\
+								\
+	_Pragma("GCC diagnostic push")				\
+	_Pragma("GCC diagnostic ignored \"-Wint-conversion\"")	\
+	___bpf_fill(___param, args);				\
+	_Pragma("GCC diagnostic pop")				\
+								\
+	bpf_snprintf(out, out_size, ___fmt,			\
+		     ___param, sizeof(___param));		\
+})
+
 #endif
-- 
2.31.1.368.gbe11c130af-goog

