Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 526CC3BABC2
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jul 2021 09:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbhGDHT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jul 2021 03:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbhGDHTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jul 2021 03:19:53 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD87C061765
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jul 2021 00:17:18 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id h6so7230744plf.11
        for <linux-kernel@vger.kernel.org>; Sun, 04 Jul 2021 00:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q5Wf8ghZ23c6vSvSmNVjb2NVOeSumBPmpt+tM4X+4G0=;
        b=sPPIAp6bykeHv8kNEiNQSCH3ZxxoXifu1yRZOpcwWPNEr0fyMcMBODJMeCbSdX3rQR
         wjMbs3m5gsKDPv5lyx/QgE5e2gxb+9Dzh2piLOFCcTLAPDOMc6lo3y1SidC97ncjri4o
         39iHTnXCslYQiJVFWKaSbc0leC98lBqCqkszir2CJHxzKPpOCX7EAm3Xo99jF5HyZGBZ
         95CLan0JYfl6yZNUYfl8UaQgFQxYilZgLOZNB4SjbzRYJ5Nt5jcJiXgb1jZLKZDRsk80
         iatwVhlW8M9/y6n7k8g5bLXC+MUMOGRCNBcy+fsRX4q+lU/H4Zb9fWXiW5tIloDKZd2U
         Pi6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q5Wf8ghZ23c6vSvSmNVjb2NVOeSumBPmpt+tM4X+4G0=;
        b=IL/BPfUnhvO6iObUP1torL4XZF3eeV3ouupkrbJK/Ai6BkKYrR0s6TqWIknNDhDH6V
         YUfBcgu8+AJo+Q1v9K0NtsABv8lonuIQq0gLA+N5ZdyCTir+kMOhUosGdpgIH70y4hhY
         HUgn/2fHv8A76QSBGVxVG7bQGEQQQ62Tgaw1rRoXrSGhOAJLWbaOX7CArWm5kZW3sqmz
         /ciCpznxGaT7sfbeHnrti6cpu79EAFDI3lki2sstnU2Sg4q+QzsJgAea6lhjhvCrv6tr
         cfnV7vn2l0pLptfuSL8MihdWWyxAEHGkQHBjZqDJWhBLn+nfPqX+jZc9f+kCAGDwwYws
         lpeA==
X-Gm-Message-State: AOAM531RBE3TPZvRin/FirLk7v03JphCrPsRJKoDt6737tV+o5aGCgV2
        d2SXVA20/4vP5PhIBsN25oPrJw==
X-Google-Smtp-Source: ABdhPJzUFCWdKrT5LqvA16eca5FTWrFAEQFxu73CU4ERAiEVgUNZaIdSuqJv3g3yMzx1OBcIywsEvg==
X-Received: by 2002:a17:90b:1284:: with SMTP id fw4mr8381195pjb.74.1625383038146;
        Sun, 04 Jul 2021 00:17:18 -0700 (PDT)
Received: from localhost ([103.207.71.35])
        by smtp.gmail.com with ESMTPSA id z7sm8588734pfn.36.2021.07.04.00.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jul 2021 00:17:17 -0700 (PDT)
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
Subject: [PATCH v3 04/10] perf/x86: Add barrier after updating bts
Date:   Sun,  4 Jul 2021 15:16:38 +0800
Message-Id: <20210704071644.107397-5-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210704071644.107397-1-leo.yan@linaro.org>
References: <20210704071644.107397-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add barrier wmb() to separate the AUX data store and aux_head store.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 arch/x86/events/intel/bts.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/events/intel/bts.c b/arch/x86/events/intel/bts.c
index 6320d2cfd9d3..4a015d160bc5 100644
--- a/arch/x86/events/intel/bts.c
+++ b/arch/x86/events/intel/bts.c
@@ -209,6 +209,9 @@ static void bts_update(struct bts_ctx *bts)
 	} else {
 		local_set(&buf->data_size, head);
 	}
+
+	/* The WMB separates data store and aux_head store matches. */
+	wmb();
 }
 
 static int
-- 
2.25.1

