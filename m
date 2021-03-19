Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58DF8341469
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 05:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233733AbhCSEzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 00:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbhCSEzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 00:55:38 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0DBEC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 21:55:38 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id x27so4448129qvd.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 21:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xw5oBDDgkEWVUypIF0MB23jgpMfVpmH1wRkgF92oTgE=;
        b=QQ2d6aT8QiC77A3nriPpKEnw4dg81SUq3h3Ak7VZ650lc2p0Fjfkgk4Dcx5XC9z2G/
         +VyFNigwa7qMGY/JSvUHCPf1viSVTGu/s1JT3eBTuLaB6oaaJfKa10XeAiNp+BAGA2vP
         4gTzpfOHFO7cmxTyK5I6Wbhf6eFYJh4wpuz+McsuOkDDP9IKKiYKfU8AopWp2F+Jie7X
         M5ZCjGNJpyaBYQZO0DCCl/2SGgjoDqBZlPg9CKEAhf6VcSKvmVIyvGb2ae675TANGJum
         5lgl0yN/QL//TA00QkhlArCxHTSB4Je1wMYq9pNAxILZmfsv2RRLkdRS9cI8BGmyKjWO
         XkGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xw5oBDDgkEWVUypIF0MB23jgpMfVpmH1wRkgF92oTgE=;
        b=rjnOHMoDjvcoHB6oXt8/VvIRwT8ClKWTHgLkA++9kXmC/NZXx+nitKrxcrPD4vfJuk
         hbNwkPpj9Zfq7F22j7PMxHNXNAaxSAd/8UH95rCVCkHPFKS1e7sLdRk3Hj+C9IpfTEyj
         8IATFC57RFuazwLQVJad+3iDXm3q/52jOa3qQcklPBXcNsM31IITEZ4fGhpk3wlYKNsJ
         SqgRH4Wu+TTUirYsRUQdGthkVWlJexMl/ecfZa4nhQpMsycfvgyThUti/a4+zeUmLhGo
         AsrzzJdPzh+7gOr5NdPjdI1K1TBeygzL74SI2C7D4GvRCkSa5KuDPE/j5ML8wUC8ig45
         vn8w==
X-Gm-Message-State: AOAM532fefSDmXlKKhkcQd5JpsDyqm3RDLAArw34ZfQHiTa9C/TFOBO0
        L2JQz36S6ccr6zXLI6jjsyU=
X-Google-Smtp-Source: ABdhPJyaifoTIaq4oCpeCFbmLogAqGXOhjozP+RcCFCx1P4a9yv0aJzWDXAktfq/NgsXa0lSxvcCYA==
X-Received: by 2002:a05:6214:c27:: with SMTP id a7mr7729998qvd.54.1616129737785;
        Thu, 18 Mar 2021 21:55:37 -0700 (PDT)
Received: from localhost.localdomain ([37.19.198.87])
        by smtp.gmail.com with ESMTPSA id 85sm3673576qkf.58.2021.03.18.21.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 21:55:37 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     monstr@monstr.eu, unixbhaskar@gmail.com,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org
Subject: [PATCH] microblaze: Fix a typo
Date:   Fri, 19 Mar 2021 10:23:23 +0530
Message-Id: <20210319045323.21241-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/storign/storing/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 arch/microblaze/lib/uaccess_old.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/microblaze/lib/uaccess_old.S b/arch/microblaze/lib/uaccess_old.S
index 0e8cc2710c27..eca290090038 100644
--- a/arch/microblaze/lib/uaccess_old.S
+++ b/arch/microblaze/lib/uaccess_old.S
@@ -188,7 +188,7 @@ w2:	sw	r4, r5, r3
 	.text

 .align 4 /* Alignment is important to keep icache happy */
-page:	/* Create room on stack and save registers for storign values */
+page:	/* Create room on stack and save registers for storing values */
 	addik   r1, r1, -40
 	swi	r5, r1, 0
 	swi	r6, r1, 4
--
2.26.2

