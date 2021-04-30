Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A327F36F6A8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 09:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbhD3Hro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 03:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbhD3HqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 03:46:01 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D103C061343
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 00:45:13 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id u3so25139337eja.12
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 00:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/M0m/Y8BdrRV1bnmW/B/8hRNKy6eekh8cxZ9cNaqvFk=;
        b=LoMxfuHlN/E2VET+zlRycLb0O0Ngw3+Zw25eaV88DUcnCj+r9tIsJP12h6CDxpM8m+
         yBIBxZdXbZcH2d952Dq+QjJzQENyJF5Nu0SGMB1XEIWO4onqbFP6PCiowml9HlHkYAHc
         mO8MybxYYCLzcurYnDhV33MwvuNXEPvXHOkpZoHE24jo7hXOtgIsGU8Vi6mJlQVxS8GH
         g8PVcl2/rTo0Y8O56a0wx4YYSAZCrNyPTh6h7RvZdw6JUqXXZ3O1FJfQ4BNDFpd2W4aN
         yBiGQu1MbTMsim51xscucixe5dLBH+ucqgVLLNhGGBrX8AUB611Ps8jkOKw1BJKit8nL
         Jx6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/M0m/Y8BdrRV1bnmW/B/8hRNKy6eekh8cxZ9cNaqvFk=;
        b=KMZOeiD8Yq9WLnupNgXASpgI5a39/fCexQ+cj9BL7cIc6AdocXC1sxQGkauR3G3Igu
         k2C5xXBnKX9HPJU5MQwyaGgE+Vqey735ALtdy0GbimwIY+FVJVE32xX1Hl+6U6B19iUq
         tcF5On3FO6svByncE9hJgrjCCAYnhPoLHk/PirRWR3yVtbYmgyn9n7JELNI0L/riJbON
         4YMZTCjhwo8aSu2lW/THUgf7NUwNY8LVfMVxf9czxgiEABblXLCIEMimLB4z3/Zz+3SB
         xDIvlQcXQOf62hgkcntw9wJ/ltbRw8VmnvWft0ZCiU8vLcLLq6dgIGMiiFPjH7+NtCeh
         tUlg==
X-Gm-Message-State: AOAM530HU7bo3pKq4frvJ7qMzcVbvFgLR6YuqYJsuetacNQurJhTSRbJ
        cbsyfQH11IwU8TCaYuS1PoHbVYOwDEyvDA==
X-Google-Smtp-Source: ABdhPJwY9AH0R8gPpKhh4uZkeFXHr6NNpdYoYQUsGixn27ts7NlBkyr0/2gpkQCGBm6HvIUruoUnRQ==
X-Received: by 2002:a17:906:3bc6:: with SMTP id v6mr2838360ejf.165.1619768712073;
        Fri, 30 Apr 2021 00:45:12 -0700 (PDT)
Received: from agape ([5.171.81.86])
        by smtp.gmail.com with ESMTPSA id y25sm1532955ejb.34.2021.04.30.00.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 00:45:11 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 40/43] staging: rtl8723bs: remove empty file
Date:   Fri, 30 Apr 2021 09:43:58 +0200
Message-Id: <201550b342b5578d375dfb5d98d0c65a9ee6f95e.1619768150.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619768150.git.fabioaiuto83@gmail.com>
References: <cover.1619768150.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove file left empty after function deletion.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/odm_debug.c | 9 ---------
 1 file changed, 9 deletions(-)
 delete mode 100644 drivers/staging/rtl8723bs/hal/odm_debug.c

diff --git a/drivers/staging/rtl8723bs/hal/odm_debug.c b/drivers/staging/rtl8723bs/hal/odm_debug.c
deleted file mode 100644
index 1a2e367bb306..000000000000
--- a/drivers/staging/rtl8723bs/hal/odm_debug.c
+++ /dev/null
@@ -1,9 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/******************************************************************************
- *
- * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
- *
- ******************************************************************************/
-
-#include "odm_precomp.h"
-
-- 
2.20.1

