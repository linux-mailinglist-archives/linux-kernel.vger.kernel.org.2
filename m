Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBC5936477A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 17:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241848AbhDSPx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 11:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241790AbhDSPxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 11:53:24 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B5C7C061761
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 08:52:54 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id f195-20020a1c1fcc0000b029012eb88126d7so8370312wmf.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 08:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mIuHild8sA8fTuyigXweKi+IzBsMRDUGQLpsgxZjzwk=;
        b=mrF01BUx/tHvbLYcuFx0zd4c0ioQVOijUzUIWXvjGfI8VFQ5v8PJRr2lQuS+6A40Yp
         LNJJb8pbbt5ZRTHLJ08qH4T3NrKev/aYEexK1V3y/NLcN63V579l4+xgpkNpZeq8RcrL
         4xbTtMChh9Gm2Wd1nT3Pq2hb41swsWFeVOgI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mIuHild8sA8fTuyigXweKi+IzBsMRDUGQLpsgxZjzwk=;
        b=aJaqYahSYVUuu32TpFxlspMILBFQZ3q/ofIiC5qyCeIJAEgr2apaXkD9UJAA+9iIst
         cahIcMj+BK/PmQ04rYP+aBbLBvxa5VBFtpcfqh1TFv8SOLmR8s/w3FNJMV9kHD0+B74l
         nG4q2kmnuk+hax7CHeYtbjyIsOZL7EPi/LxMrI41wxysTn7Ima/yLL0I9Gs3aTAmSgKw
         PmZEpebIjwHl75LhVWr1kkdXVz6kjR8MLOiIIaSvsJm6QMgVgiYFCceVh02p5sZyKZQk
         h4O1ho9s3Pw2AJFMDb89hei5XbZrKCF4hkkcFKejQ+eOQe8vAO4l3gUKkI+lu9ytSPpc
         SaSA==
X-Gm-Message-State: AOAM530yEJxHly8tFuYrCm2LIoGECXKe+yyTIUgDbS0AWPfjS1XyA9+y
        vYDCMxyfluy8qjMEkqDb/yVr+23BDVUz8pmM
X-Google-Smtp-Source: ABdhPJx7yJSHC7t3nr1OVvO7cf2dKUqLF/9Ah/DWd1GosDQDleYjjQzgT/gaQLhzCapZQ5rkkTs+0g==
X-Received: by 2002:a7b:c7c9:: with SMTP id z9mr22182692wmk.50.1618847572911;
        Mon, 19 Apr 2021 08:52:52 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:61:302:3bbb:3f8f:826f:7f55])
        by smtp.gmail.com with ESMTPSA id l9sm22868669wrz.7.2021.04.19.08.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 08:52:52 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, jackmanb@chromium.org,
        linux-kernel@vger.kernel.org, Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next v5 4/6] libbpf: Initialize the bpf_seq_printf parameters array field by field
Date:   Mon, 19 Apr 2021 17:52:41 +0200
Message-Id: <20210419155243.1632274-5-revest@chromium.org>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
In-Reply-To: <20210419155243.1632274-1-revest@chromium.org>
References: <20210419155243.1632274-1-revest@chromium.org>
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
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf_tracing.h | 40 +++++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 11 deletions(-)

diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
index f9ef37707888..1c2e91ee041d 100644
--- a/tools/lib/bpf/bpf_tracing.h
+++ b/tools/lib/bpf/bpf_tracing.h
@@ -413,20 +413,38 @@ typeof(name(0)) name(struct pt_regs *ctx)				    \
 }									    \
 static __always_inline typeof(name(0)) ____##name(struct pt_regs *ctx, ##args)
 
+#define ___bpf_fill0(arr, p, x) do {} while (0)
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
  */
-#define BPF_SEQ_PRINTF(seq, fmt, args...)				    \
-	({								    \
-		_Pragma("GCC diagnostic push")				    \
-		_Pragma("GCC diagnostic ignored \"-Wint-conversion\"")	    \
-		static const char ___fmt[] = fmt;			    \
-		unsigned long long ___param[] = { args };		    \
-		_Pragma("GCC diagnostic pop")				    \
-		int ___ret = bpf_seq_printf(seq, ___fmt, sizeof(___fmt),    \
-					    ___param, sizeof(___param));    \
-		___ret;							    \
-	})
+#define BPF_SEQ_PRINTF(seq, fmt, args...)			\
+({								\
+	static const char ___fmt[] = fmt;			\
+	unsigned long long ___param[___bpf_narg(args)];		\
+								\
+	_Pragma("GCC diagnostic push")				\
+	_Pragma("GCC diagnostic ignored \"-Wint-conversion\"")	\
+	___bpf_fill(___param, args);				\
+	_Pragma("GCC diagnostic pop")				\
+								\
+	bpf_seq_printf(seq, ___fmt, sizeof(___fmt),		\
+		       ___param, sizeof(___param));		\
+})
 
 #endif
-- 
2.31.1.368.gbe11c130af-goog

