Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B88C3C3B98
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jul 2021 12:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232466AbhGKKoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jul 2021 06:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232380AbhGKKoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jul 2021 06:44:15 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90DACC0613E5
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jul 2021 03:41:28 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id d12so14947933pgd.9
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jul 2021 03:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q5Wf8ghZ23c6vSvSmNVjb2NVOeSumBPmpt+tM4X+4G0=;
        b=lyx0w/3i2J+y8CQc61EkPiIT6/dGLPzkaz7rfy+3+zdS2LKYhCN3ohFbBOQVnkr5vo
         c2QSHAkUQmYjofvTN++VJ8GVQlmbwsW/LHW82wh4QnkGR8pye+CS6TAQDUQUnd3Cwogk
         HNhZAvfFkccsVf++cXdroo8L9TMDDQzJTJjkuzpuz3Ysh+WXgzQzQ6cEsgs387G+liSe
         0YRNVEQJyrH8s6PyNWZ7gQnmGD8BwkOHe0yOdZVXvAz+26Tjns4lpRZQVkZqrmNMKMvL
         JNEzSOgyosIHx1ZjVZlafGpAY1c22KJvTAf946Df3Ic2yJcQdUgzaA1UwDVMSsHL+VyA
         5j1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q5Wf8ghZ23c6vSvSmNVjb2NVOeSumBPmpt+tM4X+4G0=;
        b=Pdn+NbPTczsDRcZ7p02DBj1dSYdY7TSFgS/XVJoj8+ZSnrRT1y3JHrljxE7SsvfWmZ
         vovZT5510OnRCoilTGWeKTPbg1IRfel3nhxZsFJKwNE2D/dnENaDmBTnejAk5PUvg/uZ
         uJxBgn5pG1Slgx2ufBiyUSuXcg0q+vnF5Ecn4UOhc6f6iybKJX9Q07QC2gDq47TG6/6a
         44F5xEO1YIAIbpwSds8yTb7d0Ahz5op2BjA2c7Md4gSQEZ9tCmL/juTMJLjzDyJ/amRg
         s7QTsTiByZKWvYo6S/Iq2jKesaKWeiLO+sB6d6QSaeKbjVhrNHEfIAs33pUz0ysy08KK
         aI5g==
X-Gm-Message-State: AOAM533shfcQ5d27CyBDAPTNuvjB9JfomcEodyZkB3RYJ8QzARrDwmve
        Y8ZLXdmN139VQk/KdnydDjuOUw==
X-Google-Smtp-Source: ABdhPJy7rSDkFVxHKzcS361rBBVWk82TUHhXPNVEgieYnRflyQ2XrW4SpdiE8S9LYx0A8Mr01spdNA==
X-Received: by 2002:a63:e211:: with SMTP id q17mr25685112pgh.363.1626000088096;
        Sun, 11 Jul 2021 03:41:28 -0700 (PDT)
Received: from localhost ([103.127.241.250])
        by smtp.gmail.com with ESMTPSA id x13sm10181726pjh.30.2021.07.11.03.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 03:41:27 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
Subject: [PATCH v4 04/11] perf/x86: Add barrier after updating bts
Date:   Sun, 11 Jul 2021 18:40:58 +0800
Message-Id: <20210711104105.505728-5-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210711104105.505728-1-leo.yan@linaro.org>
References: <20210711104105.505728-1-leo.yan@linaro.org>
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

