Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99C8532BEA6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574435AbhCCRdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:33:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349655AbhCCN5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 08:57:03 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23C3C061A27
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 05:55:10 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id u14so23789489wri.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 05:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ty0BzBDNPFd+4Q3CQdXodQA+pq5y755+2zWo49k15dc=;
        b=vPU2cpPrXqRPQjdvIZ5y1sDo76JnkGXxuh3u21DG73cAmeDzm2Iqk+DajmBGMambD4
         larStOihTuOwXTxzhjpNkeEZOfylXyxk1rc1djLp2tBV0fSCsGpsBJhzhx7vaQXQQY0o
         +texv1rR+Dyeg+KR64oU8fCZfU2rwqyRWQ1CbGN4LctCb9A700AMVH2tQ2fzRVbCPqXp
         XFiCbKye6XzgQRiCHG+V2g4zTk72wxJdLhFK3L3EX80XtfuYdR8bwOOx1JWOqAAAJHeG
         q8Ge9XpOU0HUSmy8un+qpD0oN+F7fOHBCuUZ8S8X9ElUoqTJrXJFXjnDEqCKQdOzmErY
         Di0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ty0BzBDNPFd+4Q3CQdXodQA+pq5y755+2zWo49k15dc=;
        b=OZawQUczm7g3/npjHf5IAWg+23dlBKTnAhrfUEfisTMCUd2hC83IjjrHlbl6PT/0Iq
         cqmKZ7hmdIpCOWxDvVu/n2OtchcgdSwYYAWFP4LlCTmXIkdB8t05xJnxGbH0C4qb8tng
         NmqGmNfuPMoVkm0MyYMTOIAS60StHo0zpl0LHJFT9dKSamC6QQUcaXOSHgHiP4+jlb9D
         phefWiOsQxrCKkUBuRlXIRHNvsxvfsdJ5WOevHRrknftIicTFh+lvRChELlC4l6jzbph
         okNl9FcpA01GMlE6r4uZNXlW2NUh/1HkaZk5YUN0aABj7y6AnbLgbrdMPKQ/gFCrDTTN
         KUrQ==
X-Gm-Message-State: AOAM5324vB5BjYGXIjoKsEGs30WL68csnx6PwTwPJ0os4w+jNOmmjSmc
        p10BBLpdNsTG6NdURY1R+ELOSg==
X-Google-Smtp-Source: ABdhPJwi5nmL+zXteQsjQGsjHpIU26byW+qlik7BOIakozNfL2yoCTXbIq3y9fVry18+g8PqUY+bwQ==
X-Received: by 2002:adf:ec46:: with SMTP id w6mr21988503wrn.213.1614779709687;
        Wed, 03 Mar 2021 05:55:09 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
        by smtp.gmail.com with ESMTPSA id u4sm25329574wrm.24.2021.03.03.05.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 05:55:08 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
        by zen.linaroharston (Postfix) with ESMTP id D32EE1FF91;
        Wed,  3 Mar 2021 13:55:00 +0000 (GMT)
From:   =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     maxim.uvarov@linaro.org, joakim.bech@linaro.org,
        ilias.apalodimas@linaro.org, arnd@linaro.org,
        ruchika.gupta@linaro.org, tomas.winkler@intel.com,
        yang.huang@intel.com, bing.zhu@intel.com,
        Matti.Moell@opensynergy.com, hmo@opensynergy.com,
        linux-mmc@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-nvme@vger.kernel.org,
        =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH  5/5] tools/rpmb: simple test sequence
Date:   Wed,  3 Mar 2021 13:55:00 +0000
Message-Id: <20210303135500.24673-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210303135500.24673-1-alex.bennee@linaro.org>
References: <20210303135500.24673-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A simple test script to exercise the rpmb interface.

Signed-off-by: Alex BennÃ©e <alex.bennee@linaro.org>
---
 tools/rpmb/key     |  1 +
 tools/rpmb/test.sh | 13 +++++++++++++
 2 files changed, 14 insertions(+)
 create mode 100644 tools/rpmb/key
 create mode 100755 tools/rpmb/test.sh

diff --git a/tools/rpmb/key b/tools/rpmb/key
new file mode 100644
index 000000000000..2b6bd3bc3fe6
--- /dev/null
+++ b/tools/rpmb/key
@@ -0,0 +1 @@
+˜ƒÆÐh«#×¢ö‹pRTà¿®åô\r|OŠ	¯mo«
\ No newline at end of file
diff --git a/tools/rpmb/test.sh b/tools/rpmb/test.sh
new file mode 100755
index 000000000000..ae5ce49a412f
--- /dev/null
+++ b/tools/rpmb/test.sh
@@ -0,0 +1,13 @@
+#!/bin/sh -e
+echo "get info"
+./rpmb -v get-info /dev/rpmb0
+echo "program key"
+./rpmb -v program-key /dev/rpmb0 key
+echo "get write counter"
+./rpmb -v write-counter /dev/rpmb0
+echo "generating data"
+dd if=/dev/urandom of=data.in count=1 bs=256
+echo "write data"
+./rpmb -v write-blocks /dev/rpmb0 0 1 data.in
+echo "read data back"
+./rpmb -v read-blocks /dev/rpmb0 0 1 data.out
-- 
2.20.1

