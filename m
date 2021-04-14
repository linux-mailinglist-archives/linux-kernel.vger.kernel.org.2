Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F12F35FB32
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 20:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353160AbhDNSzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 14:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348409AbhDNSyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 14:54:43 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1683BC061760
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:54:21 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id u20so6625258wmj.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xaIEhg0p0tQW9aj3I3BsxMZ2xq8px+zcdbX4G7AebBQ=;
        b=g0R+92KfHZ4/oubiZuCF64P7B7v4z0HFtlXN5l4q6DU8B7CTIXVV7QugLGXpdPWrfk
         0MahzYKLQDjTgx8p2NEya38/oxAWGM++De4uj0wfUw9Tnxc89wsf+U6Jsyf157iv1GRk
         S0Ewa1AyzYCTCl6YVjrJpv6PzfwmJDO+8WYjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xaIEhg0p0tQW9aj3I3BsxMZ2xq8px+zcdbX4G7AebBQ=;
        b=BB9N2VMWNhq8IFfAPR3oHZLN4OAM86OnSLAuC+2L3sZS81pyWPdsAvffJ7hkk8Y8Iw
         X3xouXwRcdKf3Gk+2+e0IRCOcI5CVwAW7AlOPrgPcubN2ynk2HMytjKl/o8h+kwDLRBl
         xs8G7893KrpFSsZhk/tiG9/epuKvMP5ESFZflQOwfvzNOrMd7KXDY35nJ9bXFf2K8eWM
         94MKpr7OG0ENfHhw0kiAcZfVLaQ5oGY3FBfIX0Eu+sDZlVxOhQVadbc/E8xjeIXbWVja
         BJexYEzQwhBvGoC9Gmp3QdAjcPpCgYyPsHVEhGtTv9FTOvtPpIuFN+LCwlIzga1BMWBN
         5DGQ==
X-Gm-Message-State: AOAM53157p0tBU+Ey/CU5zVacAzro7V1TY9Th5z8rYv1k5hBk8ouCCYD
        wJ1+vG8e9LH6dH0DZmtVllujWg==
X-Google-Smtp-Source: ABdhPJwaFNeD9hX3VaDQMufideEFY2UHqxxNRzq10KUP1crzIybzw5HVgaE37LYfsz8sJwVICiMW4A==
X-Received: by 2002:a7b:c5d8:: with SMTP id n24mr4315903wmk.52.1618426459835;
        Wed, 14 Apr 2021 11:54:19 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:42:204:8b2a:41bd:9d62:10d5])
        by smtp.gmail.com with ESMTPSA id f12sm253131wrr.61.2021.04.14.11.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 11:54:19 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, jackmanb@chromium.org,
        linux-kernel@vger.kernel.org, Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next v4 5/6] libbpf: Introduce a BPF_SNPRINTF helper macro
Date:   Wed, 14 Apr 2021 20:54:05 +0200
Message-Id: <20210414185406.917890-6-revest@chromium.org>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
In-Reply-To: <20210414185406.917890-1-revest@chromium.org>
References: <20210414185406.917890-1-revest@chromium.org>
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
2.31.1.295.g9ea45b61b8-goog

