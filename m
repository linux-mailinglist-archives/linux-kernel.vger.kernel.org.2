Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1F733BABC6
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jul 2021 09:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbhGDHUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jul 2021 03:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbhGDHUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jul 2021 03:20:06 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA80C061762
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jul 2021 00:17:31 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d12so13567306pfj.2
        for <linux-kernel@vger.kernel.org>; Sun, 04 Jul 2021 00:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kCQzQNUYho/r8d2unDfjM9CEfsvPEczKr8vsttMJnd8=;
        b=pGJGBIEcKP1v98r9fkfW8D3gn5kEVOQ2tcNe7vRZ9woJExO1ntTVeLbMgMtMwJ1UYg
         CZcI1vzj+wtUb8hHrRiEko7miZUZ4Hv3O5iCFse4PI6SKhVNasQ772ZJKMcgUSp5HFho
         1WuvnbPOS0pqZ4VpvHcChWEZPKNGxYsjIhbK4z1uho/+T3OKZMmuV0t3MqQ1zhJ5Fe4L
         WRlYFSFx2psp9RZIkPWM957bfv2tQASWkYo3PFNYkVYK1AouAEHx2swR7X4paGZbWEGZ
         wr8j1xjQoKMA+TkSyc+DfS4cI30Szw2nUfVC7EnoQLFpqvZKIovexoBgd+obHTjzgCJN
         YjPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kCQzQNUYho/r8d2unDfjM9CEfsvPEczKr8vsttMJnd8=;
        b=Ywsc/qGL9TeRg9ctYi8VZXTzYL50fyugEHryy5fHBBo7E0Ewg+9KMONS0N9VsKqioz
         y3W1F0DhFI4YiM5sEKQhmMNgOo4Y5usYKsSewnTiSIMrP/AjcEzcJPa/qnOr8EzABaD3
         qssU1+eaAv7U+OJ+xDYrm0BTfXUBrB+m6unOrfybUyhIQMJ9zNQC5RwjHXNcRtTrkIpB
         ySNiekkfTexQi1yrgEW/VXBeQpOgeq7PQ9NVlM86QBWC4fmGm34mskwvSD52M/X+2JXN
         MzidoRJpmzDIaJUs8vvUnfjbE0xUGERKH0sb4W27pju6VjeeDEr6WA+m2jJqv+b0QTwT
         lAnA==
X-Gm-Message-State: AOAM532aDssM5ZX22mA04oano1DWuRvyE80II0LSTwL5ZF9+Q8lbrA7y
        sJoIFh8LPeDUGipvaxoHXuK//g==
X-Google-Smtp-Source: ABdhPJy/0lUUGEPuTONMJGU3vs7xq5nWAKNr4/oXiN3xxNG/2XrE5GcCMZpOwGHpAVm/Oh7WcB7i1g==
X-Received: by 2002:a05:6a00:13a7:b029:309:bfd1:a3f5 with SMTP id t39-20020a056a0013a7b0290309bfd1a3f5mr8464357pfg.66.1625383051124;
        Sun, 04 Jul 2021 00:17:31 -0700 (PDT)
Received: from localhost ([103.207.71.35])
        by smtp.gmail.com with ESMTPSA id m24sm3092470pgd.60.2021.07.04.00.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jul 2021 00:17:30 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 08/10] perf auxtrace: Use WRITE_ONCE() for updating aux_tail
Date:   Sun,  4 Jul 2021 15:16:42 +0800
Message-Id: <20210704071644.107397-9-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210704071644.107397-1-leo.yan@linaro.org>
References: <20210704071644.107397-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use WRITE_ONCE() for updating aux_tail, so can avoid unexpected memory
behaviour.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/perf/util/auxtrace.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index 1a2f42980e3f..d68a5e80b217 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -456,7 +456,7 @@ static inline void auxtrace_mmap__write_tail(struct auxtrace_mmap *mm, u64 tail)
 
 	/* Ensure all reads are done before we write the tail out */
 	smp_mb();
-	pc->aux_tail = tail;
+	WRITE_ONCE(pc->aux_tail, tail);
 }
 
 int auxtrace_mmap__mmap(struct auxtrace_mmap *mm,
-- 
2.25.1

