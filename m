Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8293536C518
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 13:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235831AbhD0La4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 07:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235426AbhD0Lav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 07:30:51 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A67BFC061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 04:30:06 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id k14so9180844wrv.5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 04:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4t3fwu407mErMmjxG6jssxxaD8OTJLeJVELqfTsXsW4=;
        b=X5gtZi3PonClOX9mpJRZO2m9QL6bXITgK2KAn4xLSC32/vbkx9DhT2H+eq4jjq8ybG
         eOqlhyuqN/sFkTtls21q6EcLYufp95g1dVJqcAcx5AbicTZjfyB/hk92gffzULZEHLjU
         c7+7LHRFl4Ra8g5XnPLtHQoBMs2W6XGuIWyz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4t3fwu407mErMmjxG6jssxxaD8OTJLeJVELqfTsXsW4=;
        b=EdTJhY8xChX9rW7oPEQBgg+j4Yyx7YyPRX4sOBUGGwaOm3EDFNe39GNbvejmpQxh5l
         FQUc0/hflQKacd9XIoFzvhMSHXy20ExULfMa6V6IM9Qq+dtbIW60vE/5uyAl09osg+Oe
         CCl/oLOR72raqqEkJkjtYZLwW2dTHHsZzNeVj0XvGH0wBcE9YjLgc5M4thubCxMqsAoj
         gCjwOz6eOEsJ5idyqHILuZekFojBD6Nz8/7Yr+TY6DywJ4DILMHYqK7JAqVRVD+ihIO1
         uKECp/49qM9K65poD/Vj9QS8ZmenGqZcQRggZnRz29Xqp90Fk/DPTV+PhWteApb6XY2S
         8oDA==
X-Gm-Message-State: AOAM531GPVSkUfrCRYYGHCNhH307u1312OGbRISb88py10e0tfgqxdFs
        fGp0wiU6PzZKvOYr91B2r8HmCw==
X-Google-Smtp-Source: ABdhPJzljCvKmxwUWLOFfiuC7lqbL3FbUzmKBuU2Je2HB9tXIPa/wjpsFO96TOH0sWRkUqwqiv7kJw==
X-Received: by 2002:a05:6000:110d:: with SMTP id z13mr13163489wrw.92.1619523005399;
        Tue, 27 Apr 2021 04:30:05 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:61:302:28bf:825e:e514:98a1])
        by smtp.gmail.com with ESMTPSA id b12sm4320984wrn.18.2021.04.27.04.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 04:30:04 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kpsingh@kernel.org, jackmanb@google.com, linux@rasmusvillemoes.dk,
        linux-kernel@vger.kernel.org, Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next] bpf: Lock bpf_trace_printk's tmp buf before it is written to
Date:   Tue, 27 Apr 2021 13:29:58 +0200
Message-Id: <20210427112958.773132-1-revest@chromium.org>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bpf_trace_printk uses a shared static buffer to hold strings before they
are printed. A recent refactoring moved the locking of that buffer after
it gets filled by mistake.

Fixes: d9c9e4db186a ("bpf: Factorize bpf_trace_printk and bpf_seq_printf")
Reported-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Signed-off-by: Florent Revest <revest@chromium.org>
---
 kernel/trace/bpf_trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 2a8bcdc927c7..0e67d12a8f40 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -391,13 +391,13 @@ BPF_CALL_5(bpf_trace_printk, char *, fmt, u32, fmt_size, u64, arg1,
 	if (ret < 0)
 		return ret;
 
+	raw_spin_lock_irqsave(&trace_printk_lock, flags);
 	ret = snprintf(buf, sizeof(buf), fmt, BPF_CAST_FMT_ARG(0, args, mod),
 		BPF_CAST_FMT_ARG(1, args, mod), BPF_CAST_FMT_ARG(2, args, mod));
 	/* snprintf() will not append null for zero-length strings */
 	if (ret == 0)
 		buf[0] = '\0';
 
-	raw_spin_lock_irqsave(&trace_printk_lock, flags);
 	trace_bpf_trace_printk(buf);
 	raw_spin_unlock_irqrestore(&trace_printk_lock, flags);
 
-- 
2.31.1.498.g6c1eba8ee3d-goog

