Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95C56344064
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 13:04:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbhCVMEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 08:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhCVMDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 08:03:30 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7428C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 05:03:28 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id f12so12056972qtq.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 05:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tQK01wmcF8jPX8e5PCzrQrsEyQrec41JbEyt6M3+vg4=;
        b=D9avA8ij3mUbrTDCl8zy8/B34jsX+dh/SBXjQpM8bcCjfgHFhtuZ/mfmv664IH7SiW
         CmkBTti9xjZ4kQBCO3j3rDxxXAWonh+RG/VT/e1G7lxpTwE8aQDbwIuVOZyfsjxgqOfM
         j/kCyzbAFkhvM+7dhB6kZSyGPaHSDgcHW9ET36f1DJds5aTti+gUS6SjaG81n/ZyskDH
         Rr3H9IT7Lm7Ya9SiCx8GifpD6GbWdjVFmD2gbyND0veMTG3Gt5aa3KAo5iqxL8oe7NXB
         IiFwXXQcHCfv24l8ARlDC3nqRSkA9uGCO2BorvSWZ3nrwWuAxIi0AjRAhIBnd+oyyn3P
         etEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tQK01wmcF8jPX8e5PCzrQrsEyQrec41JbEyt6M3+vg4=;
        b=flP9Uj8gLm+d4tuagZA0vlNyu/dZUFKStoh78MpSRnMRoXLau/v/cFJmej++c+eDss
         IWcyS+dYuKngLr2hsiBZp931+/yPHX/KjrnW7wzG4VjPNum1ix4a7ktZIGygZ/l3mWc1
         z1Dts/V1Uz7/yia6+oyK4dJBpniXs/L1R8GUKzNKo2QS/F/6+0XqJAyErJGzCcxUqTti
         gG+E3FTBcfmtSMJGStAcPlTZdKMT8+L1t6zp0glBmPQIj0bHg3PTir52+tM5e96ZZLjc
         nqhhFjfhqzO3k7gY3zXg8ltDXv/xTWwg6sJ1KeNKUArXNu7EOX28Mx9cCak6CkeaP4v2
         NzrA==
X-Gm-Message-State: AOAM532+o6ORyiEqplbR3gSojLn4QvEYJkdceXh/IG8qe+8u0C96dGYW
        CxpY0O7UlxfL7ZQpnuMENlFgGcO2CvJjudWY
X-Google-Smtp-Source: ABdhPJxDCg1+OAL3V5EU4KW1n/507Ijkz7OJJQy43gygVfsFk84CIg2ZOhnfD7K8Mj7dJSOzoADL0Q==
X-Received: by 2002:a05:622a:4d0:: with SMTP id q16mr9121780qtx.303.1616414608119;
        Mon, 22 Mar 2021 05:03:28 -0700 (PDT)
Received: from localhost.localdomain ([143.244.44.200])
        by smtp.gmail.com with ESMTPSA id z7sm10556601qkf.136.2021.03.22.05.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 05:03:27 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        christophe.leroy@csgroup.eu, rppt@kernel.org, npiggin@gmail.com,
        akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] powerpc/8xx: Fix a typo
Date:   Mon, 22 Mar 2021 17:33:14 +0530
Message-Id: <20210322120314.2085782-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/poiners/pointers/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 arch/powerpc/kernel/head_8xx.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 46dff3f9c31f..8a85a984609a 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -819,7 +819,7 @@ EXPORT_SYMBOL(empty_zero_page)
 swapper_pg_dir:
 	.space	PGD_TABLE_SIZE

-/* Room for two PTE table poiners, usually the kernel and current user
+/* Room for two PTE table pointers, usually the kernel and current user
  * pointer to their respective root page table (pgdir).
  */
 	.globl	abatron_pteptrs
--
2.31.0

