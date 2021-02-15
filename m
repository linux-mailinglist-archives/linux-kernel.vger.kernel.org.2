Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC42A31B725
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 11:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbhBOK1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 05:27:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbhBOK0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 05:26:24 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03DCC0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 02:25:42 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id k22so3475179pll.6
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 02:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=5QNtL/QJMKYTcCcpXwyC4qEWlr5o4t0EK/CSxuKil3o=;
        b=allR8ueCxcSNegm7Gn+qidsAEGcOtrJyQt+4UYvGX55E6Xdi1PWKtgJcjns6mIMFqR
         FL8o3w5LK1D6vX57fAJ164giA8Jkq6WIa++GPhHIOcuqZ/fMpbKpRxUXxxYHsSTotRrS
         5YHSHWxwTKxpthKx63PjOtskQzyi9cjZXst1cmyVTFbdkB86aoQCTn4GQNJLurSqkXiQ
         UHQvoy0xCSArkj2zu08KUPxBr3l3/7AAxgvG3Vak52x01AHBnqK6nX0UVLiVfpLDXfPn
         99FvvM0xs4IUx+EmpvtS26qkjwuFsY7UZFURCnARkRFc/MblHTLBjanbKj+5ThpYMKMI
         ZtgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5QNtL/QJMKYTcCcpXwyC4qEWlr5o4t0EK/CSxuKil3o=;
        b=UbV9REcyftA5jloqrGDD9sf/4+jPYyxMGvucPBxNMRxKFqHR216fDCSdtl582CKA//
         DygJ21ULy81tuZg62LyXjS9M5oTULA0DsW5m7RiJf4m7m53Wf7bQaMNHc9fd98OCzLr5
         kMH5qBDzw+vyf7t0ltRZHGRyhZAwkerRTweb/sba4oO7wwihLr2lTzmpCT5N/n4Q/KMJ
         u0QNYwc64cXhiId3k2pd3Ttc928FgC62e+t2chwqnJBFFoPLNjXnHZr59AdVS4DZrgJX
         taSuRwbIKAhi7RbGV2ukzFextSq6PvrFxrXZM0bzBjkQxmzu+2xz/D/Mx583TTZdAjRc
         E+JA==
X-Gm-Message-State: AOAM530/h5efVtAutRM4UJekJ5Zw6n0a/ATBAMPCMueOptxcyywLYFlX
        RDocyGE47Dw7ja1T47m+G6+MhQ==
X-Google-Smtp-Source: ABdhPJy+60W6ok2/zY3nob6ijfUXD2FXktLLBG1JJc7q8yF1H0737pObi07IBdmUDDckhLzZCXafzQ==
X-Received: by 2002:a17:90a:4306:: with SMTP id q6mr15201645pjg.138.1613384742448;
        Mon, 15 Feb 2021 02:25:42 -0800 (PST)
Received: from prasanth.timesys.com ([59.97.51.145])
        by smtp.gmail.com with ESMTPSA id g3sm18402396pfq.42.2021.02.15.02.25.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Feb 2021 02:25:42 -0800 (PST)
From:   prasanth.r@timesys.com
To:     michal.lkml@markovi.net, masahiroy@kernel.org
Cc:     linux-kernel@vger.kernel.org, Prasanth R <prasanth.r@timesys.com>
Subject: [PATCH] kbuild: use shorthand operator for compiler
Date:   Mon, 15 Feb 2021 15:55:36 +0530
Message-Id: <1613384736-31129-1-git-send-email-prasanth.r@timesys.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Prasanth R <prasanth.r@timesys.com>

Despite making the gcc as default let the user fix the
HOST values or we need to point the /usr/bin/gcc

Signed-off-by: Prasanth R <prasanth.r@timesys.com>
---
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index de1acae..46301a6 100644
--- a/Makefile
+++ b/Makefile
@@ -410,8 +410,8 @@ ifneq ($(LLVM),)
 HOSTCC	= clang
 HOSTCXX	= clang++
 else
-HOSTCC	= gcc
-HOSTCXX	= g++
+HOSTCC	?= gcc
+HOSTCXX	?= g++
 endif
 
 export KBUILD_USERCFLAGS := -Wall -Wmissing-prototypes -Wstrict-prototypes \
-- 
2.7.4

