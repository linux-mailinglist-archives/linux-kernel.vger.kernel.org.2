Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA399339BD9
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 05:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233053AbhCME6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 23:58:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbhCME5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 23:57:44 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88B0C061574;
        Fri, 12 Mar 2021 20:57:43 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id a11so5551961qto.2;
        Fri, 12 Mar 2021 20:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uI2/eysKRFjk3MAZeB/SnxwZYgG/IqotKv0H8VR1i0Y=;
        b=tg6943atXpiFG7TmMLifV5mM9/NmeO1mVNcDN0+SPPIXFKCZ8ygXUUZAkF/dW9gzgX
         WYtHSccaPxeC0wIJn9XBAdOR1ai6c7yoWVKJN/Fl1bJGGtbRuzZWkr0tRWW6QcEXxSRZ
         Md3FzYTc4/Qq5vdGHLXBl3CmTgEIyaiQHi/aU34qXpWZR8fFJ0Jw9+URdo9gupUjhqL7
         YNAb5D5yHDgL/IGLSJPluYFH2nVdZAPr2VVF8UniAk6OLjj7MeRs7zshgV0s9Xu/dArm
         bOrtRYjQ//BMQ2u0XpybYoJDsmtDdQCpXd0YAgqMZNfuallimrzZC/jMW+1zNzjQoSi6
         hjGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uI2/eysKRFjk3MAZeB/SnxwZYgG/IqotKv0H8VR1i0Y=;
        b=Rsx2+1mP/zsmuN5ij+x9qPfm3WigFQjaM7ZtvRSTXuJvcvA/9r9oCaZJca4fluXQiO
         jmb4lCogBmCHRoOms19V2sY1fwe365jdT+HjT9jhF3sZk2S1xVxTf0OwVkWFA3LaOJ67
         cCp2d2CB2MmU7pR09YfYxhgX/Hq2FxnLpI7O+544eL2sjzey2UrIMRAc/qiHFHwe7RH1
         r41ma5sWTbXytT9NI8uS2Vo6ORse7Ss2MQNRwlhPHSgxEwBOYONjB+RoM1fFKy65IyMW
         eP3+fvDxiM53HEJUof+vyCq43xh1iMclMKfnzAhFBZSoT9taCPzjmWOpk2SqHGuOtvHu
         FeKA==
X-Gm-Message-State: AOAM5323T9eMnzmTEVyPaB5ismv/HjmifechHn1fQUpIsBkvu71UxqaI
        dj4o8659G2m3Y73Q3s5cPUg=
X-Google-Smtp-Source: ABdhPJzBmqPGlVD24zZFlPcE2vcoZvnAef/fpbo+qvCUDIIeE47l2qOr5GnXyvdcX2kZdOX+M8iUng==
X-Received: by 2002:aed:2983:: with SMTP id o3mr12925616qtd.149.1615611463228;
        Fri, 12 Mar 2021 20:57:43 -0800 (PST)
Received: from localhost.localdomain ([37.19.198.104])
        by smtp.gmail.com with ESMTPSA id w197sm5905974qkb.89.2021.03.12.20.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 20:57:42 -0800 (PST)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     rppt@kernel.org, akpm@linux-foundation.org, unixbhaskar@gmail.com,
        deller@gmx.de, shorne@gmail.com, anshuman.khandual@arm.com,
        jrtc27@jrtc27.com, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org
Subject: [PATCH] ia64: include: asm: Minor typo fixes in the file pgtable.h
Date:   Sat, 13 Mar 2021 10:25:19 +0530
Message-Id: <20210313045519.9310-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/migraton/migration/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 arch/ia64/include/asm/pgtable.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/ia64/include/asm/pgtable.h b/arch/ia64/include/asm/pgtable.h
index 9b4efe89e62d..00a76ed7e018 100644
--- a/arch/ia64/include/asm/pgtable.h
+++ b/arch/ia64/include/asm/pgtable.h
@@ -328,7 +328,7 @@ extern void __ia64_sync_icache_dcache(pte_t pteval);
 static inline void set_pte(pte_t *ptep, pte_t pteval)
 {
 	/* page is present && page is user  && page is executable
-	 * && (page swapin or new page or page migraton
+	 * && (page swapin or new page or page migration
 	 *	|| copy_on_write with page copying.)
 	 */
 	if (pte_present_exec_user(pteval) &&
--
2.26.2

