Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6D9D346F75
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 03:24:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234891AbhCXCX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 22:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234872AbhCXCXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 22:23:10 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57267C061763
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 19:23:10 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id x16so22822220wrn.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 19:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KDHxUtIcFm0Nl4J4yzuUnsR5DF+QeQCxjIidtyz941k=;
        b=HB1WPusWmPQPSKrW+hmhdPfvtn7c4Jg67typcZqsVOdZSfSrIHmcLIG/OLP2BIBC3G
         C9hqv/zyY4tvi5dqS0Gw8og4JlVYUwUi0XBSSqP3sfpWz/NlK1kAsBC1BnDU8pySSOaj
         hnIm4AvTZnYk9SLo77LBItHNsQePKf3klAoT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KDHxUtIcFm0Nl4J4yzuUnsR5DF+QeQCxjIidtyz941k=;
        b=MSM+VYSEL0u5eeuURIeZZgwEH7yivw4bYJaVYVVuiSZOpBsWJvaaGzMnvCwvbxbgp+
         NLmarWJimEqzdUnxvi50OlD91drgx+kTcDpM2D2ZiIX2ht20noFyFTrf5+NBf2w9MOTx
         sG94X0ZyCqLRYHQfOiGB4msS8AFBAa/beXXSKxpl0YBu6ugA5g2V31H+/YJ98dPvJkYc
         wA3/CRGrWfLnCIV+onuzDK+kHiPnnvYVo4rMp0iQ3EmMFO0OK+sgH6tALde22TVw5aQ1
         bM3mDaLknhLsRcaamLfhCVq+eRSr5DT56YMmj0Q6N4glNqZYIWnKN911UtRb8yt1pSb5
         MsuQ==
X-Gm-Message-State: AOAM532w0JeVkGB03R37pshVE6mTMTww6uw5HEiVcouD/jeXhC1gd2K4
        MQ4fpvJtw408dablJoFRHYeEPQ==
X-Google-Smtp-Source: ABdhPJx2yfABFEcLE1oTBlY+Bk7ub/lScxnpgaM/HehkLjIgieqx3dpfSCAaT66j3fbHhm36smOoDQ==
X-Received: by 2002:a5d:560e:: with SMTP id l14mr868446wrv.10.1616552589107;
        Tue, 23 Mar 2021 19:23:09 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:42:204:ccba:9601:929c:dbcb])
        by smtp.gmail.com with ESMTPSA id n9sm74219wrx.46.2021.03.23.19.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 19:23:08 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, jackmanb@chromium.org,
        linux-kernel@vger.kernel.org, Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next v2 5/6] libbpf: Introduce a BPF_SNPRINTF helper macro
Date:   Wed, 24 Mar 2021 03:22:10 +0100
Message-Id: <20210324022211.1718762-6-revest@chromium.org>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
In-Reply-To: <20210324022211.1718762-1-revest@chromium.org>
References: <20210324022211.1718762-1-revest@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similarly to BPF_SEQ_PRINTF, this macro turns variadic arguments into an
array of u64, making it more natural to call the bpf_snprintf helper.

Signed-off-by: Florent Revest <revest@chromium.org>
---
 tools/lib/bpf/bpf_tracing.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
index d9a4c3f77ff4..e5c6ede6060b 100644
--- a/tools/lib/bpf/bpf_tracing.h
+++ b/tools/lib/bpf/bpf_tracing.h
@@ -447,4 +447,22 @@ static __always_inline typeof(name(0)) ____##name(struct pt_regs *ctx, ##args)
 		__ret;							    \
 	})
 
+/*
+ * BPF_SNPRINTF wraps the bpf_snprintf helper with variadic arguments instead of
+ * an array of u64.
+ */
+#define BPF_SNPRINTF(out, out_size, fmt, args...)			    \
+	({								    \
+		_Pragma("GCC diagnostic push")				    \
+		_Pragma("GCC diagnostic ignored \"-Wint-conversion\"")	    \
+		unsigned long long ___param[___bpf_narg(args)];		    \
+		static const char ___fmt[] = fmt;			    \
+		int __ret;						    \
+		___bpf_fill(___param, args);				    \
+		_Pragma("GCC diagnostic pop")				    \
+		__ret = bpf_snprintf(out, out_size, ___fmt,		    \
+				     ___param, sizeof(___param));	    \
+		__ret;							    \
+	})
+
 #endif
-- 
2.31.0.291.g576ba9dcdaf-goog

