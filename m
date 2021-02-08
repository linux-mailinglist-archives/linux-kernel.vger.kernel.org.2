Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41DF53131EA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 13:14:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbhBHMNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 07:13:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233449AbhBHLwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 06:52:44 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0D5C06178B
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 03:52:04 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id r21so475443wrr.9
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 03:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P8sbwZJksTHY0g7J4gwBmmOhoWBgz9PyjuC/t9xFYc4=;
        b=og8oHOy20CdNUnjmh4a5BFlhL/JHUeymZ5PBKhTZik+VO6CHT9e4mzp6yRIxNsehQi
         lLgV4cA6iFbCSbj7MWBsHZb7U5E+7zrVNvU5G+vTy01ehcqCOlRCJLgTt4Rakjr3BQyw
         cClxPHXYeybfWlhEO5T7kBUyQz2FECUYiP6HniQrwSCOxHsgz/zwHMWtLwTyS5YvRZSG
         3fYc5hhoMYi/dyx32MIWyX/0QSgUbqsR3m0NQPjhYDkk4q36DIR5OpO2vBy6LuPyzeTh
         UitCbPqf8+JO3n/9/nigR47F77IFqqSVupxZEqR24a3CejkjYVWST919IEjUvYod9dcW
         2ScQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P8sbwZJksTHY0g7J4gwBmmOhoWBgz9PyjuC/t9xFYc4=;
        b=HAdGCDOrtzAufNWWnpOwe4TnK1TP+0iGw5sxRbm9CzJnccN4FLmqGW/m04NTMWSR1R
         /+/mxK5aqQePPUocYO93FQbDFEw9EBMdWuAfftxW8CVHO1hDnF2aSvkccY9s2N9B83LJ
         zKS5+neDWDcaSdAJvt3oD+0iwfdfTYlbb7/zEHeNIN2b62RGurtgFm4F5AcUwlLKYKAW
         57yAUBDBkjaVj+AWW4iLe93+9/JcxRI8vTqNYM5t+TTxITKuEQkTLjQrZMaa6ppawk2Q
         Zb9cIkkF81dAUncynRhrgVs+/TA3E9aVsI5aD69nj279BMn8ZTm9mmUOW/xgrAMgV36I
         Rh9Q==
X-Gm-Message-State: AOAM531aPuvW2FG3sFW7hBKecut+JlmfjrZcX+Cp+LhgYlMnf86PqQHs
        eEd8CRtTCDaIOKX3EoVnTZME+7WJ126Q5g==
X-Google-Smtp-Source: ABdhPJzbVPAxOaCpXmvkC8F2ttifA1FDEkebSqYL4jke6VNrz9r29Gom+z/dOybf4mUE2YoHLnkVmg==
X-Received: by 2002:a5d:50d2:: with SMTP id f18mr20356764wrt.338.1612785123105;
        Mon, 08 Feb 2021 03:52:03 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id f7sm27980549wre.78.2021.02.08.03.52.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Feb 2021 03:52:02 -0800 (PST)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     akpm@linux-foundation.org, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, pdaly@codeaurora.org,
        georgi.djakov@linaro.org
Subject: [PATCH] mm: cma: Print region name on failure
Date:   Mon,  8 Feb 2021 13:52:00 +0200
Message-Id: <20210208115200.20286-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Daly <pdaly@codeaurora.org>

Print the name of the cma region for convienience. This is useful
information to have when cma_alloc() fails.

Signed-off-by: Patrick Daly <pdaly@codeaurora.org>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 mm/cma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/cma.c b/mm/cma.c
index 23d4a97c834a..9ca6eaa0e52e 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -500,8 +500,8 @@ struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
 	}
 
 	if (ret && !no_warn) {
-		pr_err("%s: alloc failed, req-size: %zu pages, ret: %d\n",
-			__func__, count, ret);
+		pr_err("%s: %s: alloc failed, req-size: %zu pages, ret: %d\n",
+		       __func__, cma->name, cma->count, ret);
 		cma_debug_show_areas(cma);
 	}
 
