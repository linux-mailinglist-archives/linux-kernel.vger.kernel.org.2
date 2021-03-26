Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7B234A7F2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 14:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbhCZNSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 09:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbhCZNSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 09:18:03 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B423DC0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 06:18:02 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id a11so4180642qto.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 06:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VTh2sVwKnK+836HUYOaQhn/MuNdJEG4q3XTzh/7CGZg=;
        b=nQjyzhQKk6YeS2kjxFr6qkz4WGXuau+DuAh7aiyUidUeFwlKevG8WUXPHcfBDacGyE
         /Tteb+c4TQtDj2bVNYEfUV2cFbMFRDg740Rt7wFLPa2Gyd+PUlMZ9iFbqc68pqCi1xtR
         Mi+k0NHljyA0WiA5DX9gbkezWennIT0XTnlBUK0pPZtZ8zvL9XdDZO7azRP4kRoVUFGP
         zyah3Xgc9YKRzvXIsEQQsvpVpd6TcsoQljNKTm+UYTwyMoK8F683agdKJA7/D6+CbPzF
         wCQ5Cup3NIIDSo+pAajLquxY38kHRXCeGbz+OLaF1KhneQ3IyjU4VXh5l8cq6vlEekT4
         bsLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VTh2sVwKnK+836HUYOaQhn/MuNdJEG4q3XTzh/7CGZg=;
        b=Z7pwxEUlj9EMI5KnaRWiX6xMh4PEAhlO+JDRdD2BEDDvgxGllSD6fePvdO/yP4ESZi
         R10PRiUBOVtjGzwIx5UC4KiISAGW3aYj8sA2lWsD62aLHdq7oiZVfSNBL/WaYO9YQ3yL
         AVMofBQ0fB+SJ/FFswLI3OS801WaAcKN8NJ9ZogrYDwx96rqOCwE2IPgHOxwDZiEmYl9
         vw6MrokHH/S+pCAvNoL4gfRHCa4q3bgaXDKhsWsyzEltP9g4tKTCxoukuJPwrxGZYcyy
         czmGFIrYTBhpUShLfJHc7mmI/U944tl900x10h4LlNZlMQ7MX+uIFWwOB9MCFfmtH+LL
         /Ylg==
X-Gm-Message-State: AOAM532qtEYoYHE2sVzgAcLr+ShOB6h8jQn2QgD53Ahf9HE6IN0qEZtG
        jI7Na+rc4wWMIVtjlK6DQAM=
X-Google-Smtp-Source: ABdhPJxIv5wIrWCN+qw4Z0zcXzSNXGa3FjZ+mZsXpEhiVDENqafvjlMVaiiHxgUwHBGJnJMFquzSjg==
X-Received: by 2002:aed:2803:: with SMTP id r3mr12568461qtd.142.1616764681884;
        Fri, 26 Mar 2021 06:18:01 -0700 (PDT)
Received: from localhost.localdomain ([156.146.55.149])
        by smtp.gmail.com with ESMTPSA id a187sm6600199qkd.69.2021.03.26.06.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 06:18:01 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     akpm@linux-foundation.org, sjhuang@iluvatar.ai,
        unixbhaskar@gmail.com, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org
Subject: [PATCH] lib/genalloc.c: Fix a typo
Date:   Fri, 26 Mar 2021 18:45:30 +0530
Message-Id: <20210326131530.30481-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/macthing/matching/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 lib/genalloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/genalloc.c b/lib/genalloc.c
index 5dcf9cdcbc46..8273760884a7 100644
--- a/lib/genalloc.c
+++ b/lib/genalloc.c
@@ -735,7 +735,7 @@ EXPORT_SYMBOL(gen_pool_first_fit_order_align);

 /**
  * gen_pool_best_fit - find the best fitting region of memory
- * macthing the size requirement (no alignment constraint)
+ * matching the size requirement (no alignment constraint)
  * @map: The address to base the search on
  * @size: The bitmap size in bits
  * @start: The bitnumber to start searching at
--
2.26.2

