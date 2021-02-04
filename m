Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8695C30F1CF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 12:18:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235695AbhBDLOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 06:14:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235730AbhBDLM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 06:12:27 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4106C0611BC
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 03:10:26 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id l12so2765481wmq.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 03:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3IEsVjEj58gpnbEtzruF6QIgBE7zuGLR+EproOK/53M=;
        b=pwnuFV934+1NBMnFc5tehmnUsznGHtEqWZhqeblMxHAXEAiQO6GdBjD9HxbnteJQcr
         685CCA/s/RxaZFiIYu0DrIFt0EcTLzuxK77dJBvb+mRTMK3sUOvkv9but9M6CN43Z2J1
         I7oJqVe5vMwwwgDcI5hJhNzeX6RutJNg35WaQCJ9FcrtDIAUFz3JXOjcPProru5uu5UK
         0zOkNV8vIv+vwRwAD//KlfbPZStVsvZTPQNg5fIw5RhfnWevY5A4EH/gLo7FTAROjK+4
         9ff74FS33cbCNPcvFgudhYPqg/Pq5qkF0Xg1xI2vN8P+tsvv96rzaDvzdNQsrA/CTTqj
         CwSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3IEsVjEj58gpnbEtzruF6QIgBE7zuGLR+EproOK/53M=;
        b=TGlVj3YiVXK5qk4zrA4FFto+9i+45RTNV0iPmMHCKmNxkhDVUT3CDKP2jBYXty+/zA
         romLUPfQjBxDpP83+UXeyv86WmnIGrHl73jZYrZYYBqG6KzoDqge28eCsr1YEUxkTQjI
         T/f8GatLSn2bap/q4wIykVHwxeL2aZfnglaFUedo55kUrhxEUAfwerIUFUAysLFap1mo
         26d+CeRSU/Of35ojCpVBHo8vUcd9P45E3z8wtZnWarKBkSl7dUaBg3rTHYNMjiXA1Qca
         L1ig3D0NEOGrS3As7JW4rH/v2sIkscELa4iOUjYyYIJkY9ChOcFFKRe/FJ/RxRSi6ymz
         gVbg==
X-Gm-Message-State: AOAM530RJybMpTaLCcj/xi04LUsfs2jt3UoTnB59TkRz5jWGdxKo7NLW
        QxPxHgWUKPtU+z4d/SNkQeIWnw==
X-Google-Smtp-Source: ABdhPJwzTr8uy4M0IvB8VO2hwiH8qyYaC4erJaP/nR/itMDq7tvkpIn8Do6atM7jT0LKBKilP1cAUQ==
X-Received: by 2002:a1c:f70f:: with SMTP id v15mr6821758wmh.38.1612437024780;
        Thu, 04 Feb 2021 03:10:24 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id y18sm7696218wrt.19.2021.02.04.03.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 03:10:24 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Breno=20Leit=C3=A3o?= <leitao@debian.org>,
        Nayna Jain <nayna@linux.ibm.com>,
        Paulo Flabiano Smorigo <pfsmorigo@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Kent Yoder <yoder1@us.ibm.com>, linux-crypto@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 18/20] crypto: nx: nx_debugfs: Header comments should not be kernel-doc
Date:   Thu,  4 Feb 2021 11:09:58 +0000
Message-Id: <20210204111000.2800436-19-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210204111000.2800436-1-lee.jones@linaro.org>
References: <20210204111000.2800436-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/crypto/nx/nx_debugfs.c:34: warning: Function parameter or member 'drv' not described in 'nx_debugfs_init'
 drivers/crypto/nx/nx_debugfs.c:34: warning: expecting prototype for Nest Accelerators driver(). Prototype was for nx_debugfs_init() instead

Cc: "Breno Leitão" <leitao@debian.org>
Cc: Nayna Jain <nayna@linux.ibm.com>
Cc: Paulo Flabiano Smorigo <pfsmorigo@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Kent Yoder <yoder1@us.ibm.com>
Cc: linux-crypto@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/crypto/nx/nx_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/nx/nx_debugfs.c b/drivers/crypto/nx/nx_debugfs.c
index 1975bcbee9974..ee7cd88bb10a7 100644
--- a/drivers/crypto/nx/nx_debugfs.c
+++ b/drivers/crypto/nx/nx_debugfs.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/**
+/*
  * debugfs routines supporting the Power 7+ Nest Accelerators driver
  *
  * Copyright (C) 2011-2012 International Business Machines Inc.
-- 
2.25.1

