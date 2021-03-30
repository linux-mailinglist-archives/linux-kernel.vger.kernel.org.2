Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 701FB34EE58
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 18:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232666AbhC3Qqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 12:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232478AbhC3QpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 12:45:23 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 905B5C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 09:45:23 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 12so8739338wmf.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 09:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1QfXEB5kFgNhtvAawkchbYfU2dqIbxSq+0NLPKycdLE=;
        b=Km2nqKbehUueIf1qOZdqaGyhq9/jlKDKl6lKk0dd/AFCDf7ys/Ek9/zWJ624l7jLps
         BRfSFi0V/7NfElKayWoTklcJIH5vqttyGPvtCyRFxCFVyBL2ShtIyndxGW5PhdUiWA7P
         bAdauz4rz0nF4R+jysCJCmaH9zepD+U/rAQvki7QQC2L/7r5QRH8a8vjse9xhlxHdDwf
         ifxKQGiV4345s/uBSl3GjpDnqAOYjQ6FcCemazae/D9716ByrvQ8r2tsC6F+vcBllB0t
         PSnBLsTNJPP4perVx9PEvc5tsgLc/Kla50ckP+YYavpjqYJXIBVjxwwe62FLv1FWZdmr
         AsPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1QfXEB5kFgNhtvAawkchbYfU2dqIbxSq+0NLPKycdLE=;
        b=E1D7XyFPnj3jGDOBNGIgakItlkR5tbz9X7RRLQIu1QwDUchbFWCftFzfpR39FXex2N
         UtVGCK8cumky2o9gzJF9B+VqdkXC925s69aYh7b7IiZ7YpO6s/Nxkc7OIvqep09eypVW
         gRf/CdXYWLP+7f41tFMP5xD8v/c7L24iVMfpBvoZtd7zlOMmryshHJG625cVfbTG4zRF
         tnjgmY0NMjYvzf2Gjg9d5N0i0sBb/sEMtQW+9L3PiX34K7is/ykqcfxAgSiy7CYigMBG
         wQ3ok/C8fWXiTrLMhLGwN5o/znU4M//6Ek2n0wuOVK3iDh1v1PK0IEo8IUt8suDVwlyw
         58Ng==
X-Gm-Message-State: AOAM530kRnwKenyEz/7X0XirQffhbtrySnwktF/rxyne/YybklySvfc1
        gkSf1bjAcM/UvYp7DPVAokKU7Q==
X-Google-Smtp-Source: ABdhPJyRPMzS604bTe1KyMncc7Ngaaaxrvl9ySWMgEqMoqMJBoASJWIx/0v8/t5Wu5IEE8L6L7VwkQ==
X-Received: by 2002:a1c:1b96:: with SMTP id b144mr4807155wmb.131.1617122722344;
        Tue, 30 Mar 2021 09:45:22 -0700 (PDT)
Received: from dell.default ([91.110.221.217])
        by smtp.gmail.com with ESMTPSA id a15sm25660805wrr.53.2021.03.30.09.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 09:45:21 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Tyler Hicks <code@tyhicks.com>,
        "Michael A. Halcrow" <mahalcro@us.ibm.com>,
        ecryptfs@vger.kernel.org
Subject: [PATCH 21/31] fs: ecryptfs: dentry: File headers are not good candidates for kernel-doc
Date:   Tue, 30 Mar 2021 17:44:48 +0100
Message-Id: <20210330164458.1625478-22-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210330164458.1625478-1-lee.jones@linaro.org>
References: <20210330164458.1625478-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 fs/ecryptfs/dentry.c:19: warning: Incorrect use of kernel-doc format:  * ecryptfs_d_revalidate - revalidate an ecryptfs dentry
 fs/ecryptfs/dentry.c:32: warning: Function parameter or member 'dentry' not described in 'ecryptfs_d_revalidate'
 fs/ecryptfs/dentry.c:32: warning: Function parameter or member 'flags' not described in 'ecryptfs_d_revalidate'
 fs/ecryptfs/dentry.c:32: warning: expecting prototype for eCryptfs(). Prototype was for ecryptfs_d_revalidate() instead

Cc: Tyler Hicks <code@tyhicks.com>
Cc: "Michael A. Halcrow" <mahalcro@us.ibm.com>
Cc: ecryptfs@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 fs/ecryptfs/dentry.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ecryptfs/dentry.c b/fs/ecryptfs/dentry.c
index 44606f079efb0..acaa0825e9bbe 100644
--- a/fs/ecryptfs/dentry.c
+++ b/fs/ecryptfs/dentry.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/**
+/*
  * eCryptfs: Linux filesystem encryption layer
  *
  * Copyright (C) 1997-2003 Erez Zadok
-- 
2.27.0

