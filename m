Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDE7346F76
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 03:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234898AbhCXCXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 22:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234868AbhCXCXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 22:23:09 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D97CC061763
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 19:23:09 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id v4so22826344wrp.13
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 19:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DgtEXfyMpibQZBxsBxLO280xYt78RavkJ5Ge5XcGw9g=;
        b=DscXYx0tfZXiOeAHsK/pTwSM+SMtDANBrbjqJPErgjYsQ+sP4l8uLkh9IGZuavw/gd
         LCS8Rsz5fGmAROBo0/iCVX98MCeHCGxIqDJ21IV3zlWw2+U9omSI9cJN+efFxyeX2mub
         NCWzKJlkVM20no0pAaK98AeHCQ3O50wc7y1F0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DgtEXfyMpibQZBxsBxLO280xYt78RavkJ5Ge5XcGw9g=;
        b=R1uxPEYIgo221NhqtAnaovrDE9S5dciIUpV84xmzWMgRZi3osLWooDllbfPaMm2XmN
         pTDbmDHBZUGmZS9WsVrt4F2k4epO/kNQEq1vZxZIoq2ZJAxmoFGo66rHWiqwGjK9twPx
         BG6GSS9TVu4meR7ECif+WaL1NrhQEbJCir6P1wt9RuKy1xb5NpBvKtxrhFv8FiEtMnhr
         SYBAxZozVnPzQ/S+aFTbQy40LlFb+VnfMhgrksaIDQva1aS1QwJlPyYkaFv0DqgrhPJM
         1EZYBDsOEHoVBcyE8P8HHJcYpGJg4qN2gd90ywj7Lr5gyp4oAcj6e5uvH/DhhMFgkRXd
         c9ig==
X-Gm-Message-State: AOAM530dgPFq6i61hkukdvS5RYyIIF4EssYW3cEQ9t72q+1P6RN950Z6
        BWpfpolqAqIxoactPEYb54IMhQ==
X-Google-Smtp-Source: ABdhPJwkb1tlYfhhVEKp79x3joMPVioewfkCUofJzn9HUWLvuz4nYbB9fVeprXyTg5kNE0836MGC8A==
X-Received: by 2002:adf:e38f:: with SMTP id e15mr785656wrm.321.1616552588336;
        Tue, 23 Mar 2021 19:23:08 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:42:204:ccba:9601:929c:dbcb])
        by smtp.gmail.com with ESMTPSA id n9sm74219wrx.46.2021.03.23.19.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 19:23:07 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, jackmanb@chromium.org,
        linux-kernel@vger.kernel.org, Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next v2 4/6] libbpf: Initialize the bpf_seq_printf parameters array field by field
Date:   Wed, 24 Mar 2021 03:22:09 +0100
Message-Id: <20210324022211.1718762-5-revest@chromium.org>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
In-Reply-To: <20210324022211.1718762-1-revest@chromium.org>
References: <20210324022211.1718762-1-revest@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When initializing the __param array with a one liner, if all args are
const, the initial array value will be placed in the rodata section but
because libbpf does not support relocation in the rodata section, any
pointer in this array will stay NULL.

Fixes: c09add2fbc5a ("tools/libbpf: Add bpf_iter support")
Signed-off-by: Florent Revest <revest@chromium.org>
---
 tools/lib/bpf/bpf_tracing.h | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
index f9ef37707888..d9a4c3f77ff4 100644
--- a/tools/lib/bpf/bpf_tracing.h
+++ b/tools/lib/bpf/bpf_tracing.h
@@ -413,6 +413,22 @@ typeof(name(0)) name(struct pt_regs *ctx)				    \
 }									    \
 static __always_inline typeof(name(0)) ____##name(struct pt_regs *ctx, ##args)
 
+#define ___bpf_fill0(arr, p, x)
+#define ___bpf_fill1(arr, p, x) arr[p] = x
+#define ___bpf_fill2(arr, p, x, args...) arr[p] = x; ___bpf_fill1(arr, p + 1, args)
+#define ___bpf_fill3(arr, p, x, args...) arr[p] = x; ___bpf_fill2(arr, p + 1, args)
+#define ___bpf_fill4(arr, p, x, args...) arr[p] = x; ___bpf_fill3(arr, p + 1, args)
+#define ___bpf_fill5(arr, p, x, args...) arr[p] = x; ___bpf_fill4(arr, p + 1, args)
+#define ___bpf_fill6(arr, p, x, args...) arr[p] = x; ___bpf_fill5(arr, p + 1, args)
+#define ___bpf_fill7(arr, p, x, args...) arr[p] = x; ___bpf_fill6(arr, p + 1, args)
+#define ___bpf_fill8(arr, p, x, args...) arr[p] = x; ___bpf_fill7(arr, p + 1, args)
+#define ___bpf_fill9(arr, p, x, args...) arr[p] = x; ___bpf_fill8(arr, p + 1, args)
+#define ___bpf_fill10(arr, p, x, args...) arr[p] = x; ___bpf_fill9(arr, p + 1, args)
+#define ___bpf_fill11(arr, p, x, args...) arr[p] = x; ___bpf_fill10(arr, p + 1, args)
+#define ___bpf_fill12(arr, p, x, args...) arr[p] = x; ___bpf_fill11(arr, p + 1, args)
+#define ___bpf_fill(arr, args...) \
+	___bpf_apply(___bpf_fill, ___bpf_narg(args))(arr, 0, args)
+
 /*
  * BPF_SEQ_PRINTF to wrap bpf_seq_printf to-be-printed values
  * in a structure.
@@ -421,12 +437,14 @@ static __always_inline typeof(name(0)) ____##name(struct pt_regs *ctx, ##args)
 	({								    \
 		_Pragma("GCC diagnostic push")				    \
 		_Pragma("GCC diagnostic ignored \"-Wint-conversion\"")	    \
+		unsigned long long ___param[___bpf_narg(args)];		    \
 		static const char ___fmt[] = fmt;			    \
-		unsigned long long ___param[] = { args };		    \
+		int __ret;						    \
+		___bpf_fill(___param, args);				    \
 		_Pragma("GCC diagnostic pop")				    \
-		int ___ret = bpf_seq_printf(seq, ___fmt, sizeof(___fmt),    \
-					    ___param, sizeof(___param));    \
-		___ret;							    \
+		__ret = bpf_seq_printf(seq, ___fmt, sizeof(___fmt),	    \
+				       ___param, sizeof(___param));	    \
+		__ret;							    \
 	})
 
 #endif
-- 
2.31.0.291.g576ba9dcdaf-goog

