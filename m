Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBDFD315182
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 15:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbhBIOZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 09:25:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbhBIOY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 09:24:59 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DFC8C06178A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 06:24:17 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id v14so6480240wro.7
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 06:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eQeLU31ef47viRxJ/MC8VCOG0n3wDTVZ859Id6VOzf0=;
        b=vKlRIaIqFNihmUDRVjhW/1tv/8nuKp2WibgJVIBrSOS26wXmuPrRKByZ5XHuqfhplB
         RRmqy6QTzL0WJsgLQyrao5ntq2BJt0tuyYxfT8Fimh6VLHAKXaW3zZcydzfv1jtNZPeC
         6rnoUqGiY6Dyf7Qx/qEBOkZDhA4+gh2e1kAyA8fIIprsQRD1ih0QHSlTP3sFOEcV2YI9
         LJ028UzHos6OIyIUnGFEWl5AlkvRDqZHgrYozYWLIU6w/OTT2jQemaeFVEapTxy82BPz
         KQRdVE2J7rJfCjiliSVjdnmNofzF5fc9r5w1lSoHnV12NmD7f4awachW4C/xhdE+jn2i
         8CIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eQeLU31ef47viRxJ/MC8VCOG0n3wDTVZ859Id6VOzf0=;
        b=uPUf6V8k7VLEeiNxxy/nY3HDgkWm8lOIi09otEoj6mgsFsVrk8jUXHKa70DaoF5Vdx
         IOPOlIW6YIcxPeuIzMDugfRJmQcw1rL4nkFCacMFateo/XTCajYNwkv4JDMyXawX9HPK
         rzHLnedBQxnf+u6RQouJEPObHRTtqdTS/Mtzi1w8xrbo5VnZyYF7Iy2p/WjcBNFtjRBB
         CXXlwI5beS9saCxpCquYf5YGr4iGIkH0ZIE9P30xbLdkGhn+o9vP8FPjMGFzciwV+pj3
         wUwo6g/VaNCqbhhGwK5xJKZ+5djia8gKSgAL0CSbra4UVzRZYn9FpBdQFFcuXp5vIDqQ
         nayg==
X-Gm-Message-State: AOAM532nBSLrqPBlaWcCXCqg9AFo/NN6pSdKyPBas3NmZ9NoqWpkAKE3
        ef+06tv99jbQB7hhMGrCFu3RJRTDMH63RQ==
X-Google-Smtp-Source: ABdhPJwUC45k1V/bVJws3QQirQ/TyTfmMBrmtO4nCoh85QFEZaWSsSzWEH9ThvccG1oBnlbd7RXqPg==
X-Received: by 2002:a5d:460e:: with SMTP id t14mr26534825wrq.68.1612880656154;
        Tue, 09 Feb 2021 06:24:16 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id r13sm5423108wmh.9.2021.02.09.06.24.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Feb 2021 06:24:15 -0800 (PST)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     akpm@linux-foundation.org, linux-mm@kvack.org
Cc:     rdunlap@infradead.org, pdaly@codeaurora.org,
        georgi.djakov@linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] mm: cma: Print region name on failure
Date:   Tue,  9 Feb 2021 16:24:14 +0200
Message-Id: <20210209142414.12768-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Daly <pdaly@codeaurora.org>

Print the name of the CMA region for convenience. This is useful
information to have when cma_alloc() fails.

Signed-off-by: Patrick Daly <pdaly@codeaurora.org>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
v2:
 * Print the "count" variable, as it was originally in the code. (Randy)
 * Fix spelling s/convienience/convenience/ in the commit text (Randy)

v1: https://lore.kernel.org/r/20210208115200.20286-1-georgi.djakov@linaro.org/

 mm/cma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/cma.c b/mm/cma.c
index 23d4a97c834a..54eee2119822 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -500,8 +500,8 @@ struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
 	}
 
 	if (ret && !no_warn) {
-		pr_err("%s: alloc failed, req-size: %zu pages, ret: %d\n",
-			__func__, count, ret);
+		pr_err("%s: %s: alloc failed, req-size: %zu pages, ret: %d\n",
+		       __func__, cma->name, count, ret);
 		cma_debug_show_areas(cma);
 	}
 
