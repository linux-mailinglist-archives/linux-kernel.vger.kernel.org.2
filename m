Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48FC933A9F7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 04:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbhCODV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 23:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbhCODVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 23:21:41 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92AB2C061574
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 20:21:41 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id x7so5699718pfi.7
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 20:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eBf/sk5E7J2NnRI5SQxV/VesLFcwwvK7iLArpCnMv5Y=;
        b=kLHUejzbCkynKeZB5k+q9YBW0BTGkqZBrTTsvPj4kkRehDzf+E58x5BAv3KBiM1fHA
         7L+yXusaDWv0yIR1AlCDDoy+i6N7aMZ3MjGh3NGjV+myjeE0b0qAFZQaal/EZSZmjctA
         LhyZrJ3DjcF5jbuuhGqwP8J4e8FrsCYKYeUxeACCIecDAiAsh0Gag5gCpxN0tsaoHLOM
         p2C44jQY/kScUlEGgkfphE6bt/90VGzauhSFCiafHIf1uiiFWcaXWwp0z+eDF8DKdRT+
         A0dEDpK28iGmVIvSVK02/P5zQeqsUnwmlTZGiAhm8yu1VRU/ma3ikF96pAcJoXAzl/YM
         Ylhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eBf/sk5E7J2NnRI5SQxV/VesLFcwwvK7iLArpCnMv5Y=;
        b=Fw82oOkFsrj4qNqnmCdtKJnRcSabWBnjacbrgc3sJ+/G1d5BagUTQ8Nz7cA4G1FCK6
         QNy5kNgrbIoOUofb/qTwocf3Q2GPNJRCZV9HiU51QSsT7+KUTg3xa+cSwbYttF+pSAKb
         lUS0+WZL180XvD0l4GOfrXgDW17uGH/xCFCotKZeK8IhSiEmGaCGFhmAeDN59ss6FUtC
         FDM+NNjaXGatwFKJJfFk3IQFC+IX66jiLTiWAW+xzlnlK20Q/LS8TT4GfdlRlD4l+5Rd
         pB5qiOhMr4CVxbxFhp8MJOECvxr1HDZQpC5bFrorMDO9h8mLdYf6uUCrXog0MpsGTWka
         +4kg==
X-Gm-Message-State: AOAM533tm404rmhh45EJasrwx07XzZ29GZ5ugUk2ZSZOeDCf6/PvGrY/
        4pS8peXbhW4r2jXZKHWb8KzwNE5TA/c=
X-Google-Smtp-Source: ABdhPJy3srCuCO8feKWf1LX18wu+f14F7eeV9Ldp8g3AfJIwOCCU4/klkIDE0PpKNngrRSbxocHYVw==
X-Received: by 2002:a63:fa52:: with SMTP id g18mr21409341pgk.193.1615778501164;
        Sun, 14 Mar 2021 20:21:41 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:400:9e10:6493:2d45:37bd:648d])
        by smtp.gmail.com with ESMTPSA id i2sm10781030pgs.82.2021.03.14.20.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Mar 2021 20:21:40 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH] xtensa: fix pgprot_noncached assumptions
Date:   Sun, 14 Mar 2021 20:21:28 -0700
Message-Id: <20210315032128.11145-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pgprot_noncached assumes that cache bypass attribute is represented as
zero. This may not always be true. Fix pgprot_noncached definition by
adding _PAGE_CA_BYPASS to the result.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/include/asm/pgtable.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/xtensa/include/asm/pgtable.h b/arch/xtensa/include/asm/pgtable.h
index 4dc04e6c01d7..d7fc45c920c2 100644
--- a/arch/xtensa/include/asm/pgtable.h
+++ b/arch/xtensa/include/asm/pgtable.h
@@ -280,7 +280,9 @@ static inline pte_t pte_mkyoung(pte_t pte)
 static inline pte_t pte_mkwrite(pte_t pte)
 	{ pte_val(pte) |= _PAGE_WRITABLE; return pte; }
 
-#define pgprot_noncached(prot) (__pgprot(pgprot_val(prot) & ~_PAGE_CA_MASK))
+#define pgprot_noncached(prot) \
+		((__pgprot((pgprot_val(prot) & ~_PAGE_CA_MASK) | \
+			   _PAGE_CA_BYPASS)))
 
 /*
  * Conversion functions: convert a page and protection to a page entry,
-- 
2.20.1

