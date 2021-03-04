Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75A0532CAD1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 04:30:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232395AbhCDD3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 22:29:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232357AbhCDD2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 22:28:54 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A671C061574
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 19:28:08 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id n10so17954275pgl.10
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 19:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e3xu91cRIV/SXfMyzyfPmU5Jq21le4tYtNrxuGRlo1c=;
        b=BCLF6YU2zW5PPWyFmF0GQDr6gns9w0aOJf7Xoua98gHCgVFIvHrI0u3EPCqZaQX+qx
         rzxjIwNB9PpSnMbpdBLDl6QOhwp3TCzIzJKnJeL1mdx3i5MgtWph0mkQR4d0SzFd9RIH
         TM5GFUcCr3nb6yyjsehw7PoCJrSZE9vz8xvbkM6xVsVJNt70fMnMhJf0rvPy+eprRiRO
         Ty8PojI+HXP+87++2mkO7S0BuUWG/HTGlgF+0DB6TkLtmX1DcNO4Nzv7MQOH7Duy2ybV
         FxlLc1Yq9h94HVB1LjkL+9TeNDVE79JZpTMk/TMHnB/ECflauMR9BwOOgbZNzhiX4wde
         fMEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e3xu91cRIV/SXfMyzyfPmU5Jq21le4tYtNrxuGRlo1c=;
        b=MeUihWHZsPzEfu1F3tCJAdybcV4klFSsGbI66pPB7uiTUZCOBg62u5rPJgayIKrZf4
         7d4o5E26AB/EET44o6s9ai6xnmfW4hKPP7532eu/mZhSt/nPyAyzE6zV/vT6WNzy1c8k
         XD0Uzzqay2wqdtaX1mKv9fC8FLMS9Ojk5ZaTWxyLVtY2LBz9zldpUSpxlBDqbhJ/arRP
         vidbqL/0e3N2SsEdovMEEQQyEvqvtqUfvU0o+JOnq5TS+1odBlKPbo8xa2jXug5Lh0aK
         71nZ1rRbPM7Uxyp9BILleOJ9W+KlvAWlYy4l1BeK94YpLJfdkIlqGH0/hZDFGjd9CMnL
         n4Tw==
X-Gm-Message-State: AOAM532hp0fUwSSPOSydVVtqEto9OXGPOPQL9+ckJNB/FGGRfZxvxSkF
        N+kPIaf2w+kDkJKHC72ARJc=
X-Google-Smtp-Source: ABdhPJwgYvRgivD5INlHAqEJru61CzqBgBKpvNe5pZRxIE1sR7fqfZ2c9IEjdQKnv+x0UClZ8IJX5g==
X-Received: by 2002:a63:fe12:: with SMTP id p18mr1945747pgh.147.1614828487729;
        Wed, 03 Mar 2021 19:28:07 -0800 (PST)
Received: from localhost.localdomain ([178.236.46.205])
        by smtp.gmail.com with ESMTPSA id g15sm25683091pfb.30.2021.03.03.19.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 19:28:07 -0800 (PST)
From:   menglong8.dong@gmail.com
X-Google-Original-From: zhang.yunkai@zte.com.cn
To:     mpe@ellerman.id.au
Cc:     benh@kernel.crashing.org, paulus@samba.org, rppt@kernel.org,
        akpm@linux-foundation.org, christophe.leroy@csgroup.eu,
        clg@kaod.org, zhang.yunkai@zte.com.cn,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arch/powerpc/include: remove duplicate include in pgtable.h
Date:   Wed,  3 Mar 2021 19:28:00 -0800
Message-Id: <20210304032800.188897-1-zhang.yunkai@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Yunkai <zhang.yunkai@zte.com.cn>

'asm/tlbflush.h' included in 'arch/powerpc/include/asm/pgtable.h'
is duplicated.It is also included in the 11th line.

Signed-off-by: Zhang Yunkai <zhang.yunkai@zte.com.cn>
---
 arch/powerpc/include/asm/pgtable.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
index 4eed82172e33..c6a676714f04 100644
--- a/arch/powerpc/include/asm/pgtable.h
+++ b/arch/powerpc/include/asm/pgtable.h
@@ -41,8 +41,6 @@ struct mm_struct;
 
 #ifndef __ASSEMBLY__
 
-#include <asm/tlbflush.h>
-
 /* Keep these as a macros to avoid include dependency mess */
 #define pte_page(x)		pfn_to_page(pte_pfn(x))
 #define mk_pte(page, pgprot)	pfn_pte(page_to_pfn(page), (pgprot))
-- 
2.25.1

