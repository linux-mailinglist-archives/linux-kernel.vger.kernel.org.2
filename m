Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B84C4100F0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 23:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243273AbhIQVz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 17:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbhIQVzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 17:55:21 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40764C061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 14:53:59 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id i13so11780774ilm.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 14:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fWR0esOBVBV64rKinxIgFxJ4wKagR9YhECkqxWxa0Tw=;
        b=grs8gzHe5cek7z8ddLzkbZFT7aCOxQJODThfS5zh/JoI7HS4l1kwTTu7rDiPM2U1HS
         50yJla7O7avcIoYd7ryDuwWFWQotD8dMUhzDqWtwm0za2axPDLgCp3WOYQ7XsTUahFBA
         PmCw/f4CquFNZn9tPYHg/W1yqtFj2NG6e7mNM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fWR0esOBVBV64rKinxIgFxJ4wKagR9YhECkqxWxa0Tw=;
        b=ZkXm/QD8WPtDl9GPewahzdFJ1hP+6lczoF0XC4kazQeYtuOYnAI+qftPe15B+4a3fK
         xcp/I8NLqoutLCNIqVUn3mt7g6KzuXZkevLFpLDamhOENKR+ytNxcJWr0w3P4m9vE0oi
         SfmiQK92DouhwHVYMYmElPERDOeCqRKBHwYRwp7ro7BF83+eIjy7uWtBi37nJkfT6ObA
         dchSKBc5rAGe1xyzZnMajyFfp21/j03e07Kf4W5SqHg2o+RhYDVmlmljNU9cZroaoygt
         3egmA2/YVikm8EE5awIl1Csf85eTNLh69VVFT2RqgIYA6oox7YMAsoZVchEjohu2CaxN
         npBg==
X-Gm-Message-State: AOAM531x36WP1gLz/FLpazskos9L0AnH0ItEBXXizHM+BBRW6oSK592k
        9bK6hKiKwCsASng5brRREaH9sxD1flyLWA==
X-Google-Smtp-Source: ABdhPJy2rJ1ey28tHL7q/gFDZW67ncHgR3kfTnhfa8+NV1dCDCgJWrmoAMq2uukUi+T5BT3LGK0oQg==
X-Received: by 2002:a92:cd09:: with SMTP id z9mr9916764iln.50.1631915638652;
        Fri, 17 Sep 2021 14:53:58 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id b3sm4390167ile.37.2021.09.17.14.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 14:53:58 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     davem@davemloft.net, kuba@kernel.org, shuah@kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: net: af_unix: Fix makefile to use TEST_GEN_PROGS
Date:   Fri, 17 Sep 2021 15:53:56 -0600
Message-Id: <20210917215356.33791-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Makefile uses TEST_PROGS instead of TEST_GEN_PROGS to define
executables. TEST_PROGS is for shell scripts that need to be
installed and run by the common lib.mk framework. The common
framework doesn't touch TEST_PROGS when it does build and clean.

As a result "make kselftest-clean" and "make clean" fail to remove
executables. Run and install work because the common framework runs
and installs TEST_PROGS. Build works because the Makefile defines
"all" rule which is unnecessary if TEST_GEN_PROGS is used.

Use TEST_GEN_PROGS so the common framework can handle build/run/
install/clean properly.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/net/af_unix/Makefile | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/af_unix/Makefile b/tools/testing/selftests/net/af_unix/Makefile
index cfc7f4f97fd1..df341648f818 100644
--- a/tools/testing/selftests/net/af_unix/Makefile
+++ b/tools/testing/selftests/net/af_unix/Makefile
@@ -1,5 +1,2 @@
-##TEST_GEN_FILES := test_unix_oob
-TEST_PROGS := test_unix_oob
+TEST_GEN_PROGS := test_unix_oob
 include ../../lib.mk
-
-all: $(TEST_PROGS)
-- 
2.30.2

