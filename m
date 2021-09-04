Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80949400C76
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 20:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237354AbhIDSEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 14:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232946AbhIDSEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 14:04:41 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C150EC061575
        for <linux-kernel@vger.kernel.org>; Sat,  4 Sep 2021 11:03:39 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id q26so2447616wrc.7
        for <linux-kernel@vger.kernel.org>; Sat, 04 Sep 2021 11:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0mT68BaDD/bwPLmIZxYJDhXjyMEnqUzQlAwGpSfapeY=;
        b=cPCJSfGNGRHiFXqqT1P/j1Kg7soePnwBDCFUVVkeuuU2G/A2MgB5KCiTtpRkvqMPPS
         LU/SdCM/uXSZvd8585h9vfHqTmuc7rnLTUDY1b8yDxRQSm79ah6wKEhL1NTL50d/KNob
         INC/Ad/qPPsDpjxwi1J9XYJdrF1phdiYFytsuDrLqXGk86gblX/1OqfEw4Jt1b22ihMG
         6o8quHxA70CNNjm9WCuhm8CwS+9SeFmyE8v2kv5iUCiRm0cfSdiuiwa27qUqqyb17ex7
         qOKdAGg+wkN+HZnqD1drSrLAzY5+loQ+MZ7tEfJJ517OMpaXA8hpCanTmoD8GqbMvbYH
         VGZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0mT68BaDD/bwPLmIZxYJDhXjyMEnqUzQlAwGpSfapeY=;
        b=CyYOQDOrFRAZgbmt36L37nuBglrySlU59K5Qtkr3EbqhxORxAvJYEX6o0Yu7c/vh7/
         9H9aj2heN5YXPAMy3AV07orgjh0s2nPsrUBQv7+6sSCFl/y71LbI5rQ7QL5pqa9iGYCK
         d3fjk4Hhej5MEXfCNnZ2fO9ugx2P9LsK0Fpy6EqSD+WxAUtp8OYakIFYyUh+ufe1BdFW
         qTZF8olnfC8U4Oxah3LtUvaRf58YFP4eKpHCKmP82Lq7xCSBTR/0+ulK3OUzhE3ruLKQ
         Ynf4dt0U4zeC2MFaClDwYc//AAGGfsGh4HnpDdbhnZVCtysKrzJuHgQM1QWkf4sCiy/e
         q/Uw==
X-Gm-Message-State: AOAM532o4s5Kec5GHGCG/tpDsLwvUbjm8RJvxMWU22EUh+uAf6Y9ptVQ
        YHll9BWnk8epnhXFu2Wu9Ws=
X-Google-Smtp-Source: ABdhPJw+XkC1lgWUsr46LiCi/e+yySY04IZGbDYW+ILT8DflYf63eucAMsyq2KlGr7Qk6icv+zt5MA==
X-Received: by 2002:adf:b741:: with SMTP id n1mr5073658wre.354.1630778618379;
        Sat, 04 Sep 2021 11:03:38 -0700 (PDT)
Received: from localhost.localdomain ([2001:8f8:1127:62fc:cf28:f9:da98:9620])
        by smtp.gmail.com with ESMTPSA id r25sm2761370wra.12.2021.09.04.11.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Sep 2021 11:03:38 -0700 (PDT)
From:   Carles Pey <carles.pey@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Carles Pey <carles.pey@gmail.com>
Subject: [PATCH 1/1] ftrace: add unit test for removing trace function
Date:   Sat,  4 Sep 2021 22:02:48 +0400
Message-Id: <20210904180248.1886220-2-carles.pey@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210904180248.1886220-1-carles.pey@gmail.com>
References: <20210904180248.1886220-1-carles.pey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---
 kernel/trace/trace_selftest.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/kernel/trace/trace_selftest.c b/kernel/trace/trace_selftest.c
index adf7ef194005..875b4f1a0476 100644
--- a/kernel/trace/trace_selftest.c
+++ b/kernel/trace/trace_selftest.c
@@ -287,6 +287,40 @@ static int trace_selftest_ops(struct trace_array *tr, int cnt)
 	if (trace_selftest_test_probe3_cnt != 4)
 		goto out_free;
 
+	/* Remove trace function from probe 3 */
+	func1_name = "!" __stringify(DYN_FTRACE_TEST_NAME);
+	len1 = strlen(func1_name);
+
+	ftrace_set_filter(&test_probe3, func1_name, len1, 0);
+
+	DYN_FTRACE_TEST_NAME();
+
+	print_counts();
+
+	if (trace_selftest_test_probe1_cnt != 3)
+		goto out_free;
+	if (trace_selftest_test_probe2_cnt != 2)
+		goto out_free;
+	if (trace_selftest_test_probe3_cnt != 4)
+		goto out_free;
+	if (cnt > 1) {
+		if (trace_selftest_test_global_cnt == 0)
+			goto out_free;
+	}
+	if (trace_selftest_test_dyn_cnt == 0)
+		goto out_free;
+
+	DYN_FTRACE_TEST_NAME2();
+
+	print_counts();
+
+	if (trace_selftest_test_probe1_cnt != 3)
+		goto out_free;
+	if (trace_selftest_test_probe2_cnt != 3)
+		goto out_free;
+	if (trace_selftest_test_probe3_cnt != 5)
+		goto out_free;
+
 	ret = 0;
  out_free:
 	unregister_ftrace_function(dyn_ops);
-- 
2.26.3

