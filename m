Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7C2233E78D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 04:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbhCQDPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 23:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhCQDPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 23:15:14 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E82C06174A;
        Tue, 16 Mar 2021 20:15:04 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id b130so37541651qkc.10;
        Tue, 16 Mar 2021 20:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5tCsYycXFkNFDZJyu+i0pU21odI0Rq9q/SDWK96iIm4=;
        b=N6L/S8i/tVNsoQg4qZRcBxdRE98/MuD/d3IUyMIPvlad+dPI6utKtgQ9Se1rNTY2OH
         EWmSjpKGrshyHrzdGIUH+VbTcN/Iz3qNkp20tV/RYKkBZgP8oSRsxWzRgcLiddvdU4Tn
         fZyxvFfkv3GBLNkC8wAwxVN/4k7zIt4hCF0Ib6H/0oMaYBm/8miZ1lzcvP3BU4kKmFbn
         D0hKh1krRS8Pa2faTTYQTOVesQa7mrLIEh1XM8RtE9cNFVXq8OHnYpT5ReZvLdACXQr/
         lsAT4fGf8q7uUHME8ZYtiXjyNbDQbXLqJ1yilleSLX/+WckIdYaWNQBXKcJ/gYl+f1xK
         5lEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5tCsYycXFkNFDZJyu+i0pU21odI0Rq9q/SDWK96iIm4=;
        b=GrJOtJ012yIvfkaBmfOdIGaBOAqAAckTpCjqcwYbNsXU8ZJBzjPr3GOJL6gDGcZJ81
         G9htGaCTzhHljems0dT5cX1QHYyaH6MqEOuHRLjzA8NXeeCKIe2EJlKUS7+kwKEfUDgn
         e8e/pts837zY1FUp11gkng3O7znF7hT66q5G4Qr/XE+AEACwXeWUluvWfz6ZTfXEcrpN
         TCev7Svnvz8MHtS/DAx2awAij1FhNQiBs5LnOC60dCt36MSfrAC7J5TqJzWQbWQ6lu4G
         3yJCSGAr3mzbnPPyG7C2cd9ZOkPSy6TE8SVdjs56vNLlzSAWl2GcRVDFP/PYBJrZpvOD
         JDcQ==
X-Gm-Message-State: AOAM532z3i1Ma5c8Jvf7pS/3qjteeAolOvoHekH0wSdEH5GA7AYV8z1R
        DQv3Mw1Ie8t7uAnuvzhOEaw=
X-Google-Smtp-Source: ABdhPJwg7K/wWWKF2tiK2VXKOLxIix4kFOd+GxbIEK5rFildmUOffPH5dhTNDxbLAFKWvc6EjE0TBA==
X-Received: by 2002:a05:620a:13ac:: with SMTP id m12mr2486413qki.458.1615950904159;
        Tue, 16 Mar 2021 20:15:04 -0700 (PDT)
Received: from localhost.localdomain ([37.19.198.5])
        by smtp.gmail.com with ESMTPSA id z11sm17201538qkg.52.2021.03.16.20.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 20:15:03 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     unixbhaskar@gmail.com, mpe@ellerman.id.au, huawei@kernel.org,
        schnelle@linux.ibm.com, nicoleotsuka@gmail.com,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org
Subject: [PATCH] ia64: hp: common: A typo fix in the file sba_iommu.c
Date:   Wed, 17 Mar 2021 08:44:20 +0530
Message-Id: <20210317031420.3136958-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



s/minium/minimum/


Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 arch/ia64/hp/common/sba_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/ia64/hp/common/sba_iommu.c b/arch/ia64/hp/common/sba_iommu.c
index 9148ddbf02e5..3dcb8c35faad 100644
--- a/arch/ia64/hp/common/sba_iommu.c
+++ b/arch/ia64/hp/common/sba_iommu.c
@@ -828,7 +828,7 @@ mark_clean (void *addr, size_t size)
  * corresponding IO TLB entry. The PCOM (Purge Command Register)
  * is to purge stale entries in the IO TLB when unmapping entries.
  *
- * The PCOM register supports purging of multiple pages, with a minium
+ * The PCOM register supports purging of multiple pages, with a minimum
  * of 1 page and a maximum of 2GB. Hardware requires the address be
  * aligned to the size of the range being purged. The size of the range
  * must be a power of 2. The "Cool perf optimization" in the
--
2.30.2

