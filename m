Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9A73DA082
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 11:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235496AbhG2Jpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 05:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235019AbhG2Jpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 05:45:40 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE35C061757
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 02:45:37 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id x11so8717069ejj.8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 02:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RTIOpBIhIXba+iHfkGbk1sKd2cv7hIyyhFm84TIZ/vI=;
        b=E5VNFuwlnm/hWZNfsaxVOYyRAJh/Bebb2DIBdcB97U3Jc3u+7UWGojn9MGliXc51d5
         jFgRckSFdVEMJQkiKmlPNPc0Jcf1jWjNe7T9Cgascuos87PQydPjpztoiOwy2GIJDadM
         pLf6O4tetR3/th6ahlw7zeWLI6uAhPIn1EMXx+KaEPKOoEUhbGmvqM4bMniaiLWY97aF
         hNkLbi2YqPYlwg6wdwxxtC1jxf+Y4ZNLN/Y0tws5qXhQRxz0wPbkPxDqgs4ddEWIiIlk
         0FM0io5HIT+sdoD4ZQS1WzoR79lmxGSuOppkgfA0rGDk69shCyk44L/e+AMX5RdVAVeT
         a+Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RTIOpBIhIXba+iHfkGbk1sKd2cv7hIyyhFm84TIZ/vI=;
        b=DXyThN3uYNCxO35/oCWYW5J6JHeYVPIfdf19VrmZWZ/BFfj1CvYGDHAmCAmU8ymW1A
         StTjJxcz7xH1WNQcv7bd8Hms5qnzw54lbF/67G9CNRfVYGKABpKCsbLDphc3FoEBQtzw
         UhpMCvliY42wo2rxGJmAwvTOedDZpxMtfb10PMt9MvvrM17t6s7MAcS/iR67lJYqEyPi
         ogqo3Et5R7l4ZO2T6Gac2Ce+pbNDhJ+wx77FkyOWj3DP4e2iJOOo8SgWx8/WN64IJyfg
         UjGvvjjehbZR8uQSFkRtqd5x4Sv603o8eJnITz3RN+zzR4gBkI7WcE835kHmbUCR/qy4
         ma6Q==
X-Gm-Message-State: AOAM532oel/3qvNdF7XySq3TvPZrNuxG11YauiYCuKWPiZUEg8KD8SE5
        M5y9lcyG/ZzMxwa0bRLZjSDaiw==
X-Google-Smtp-Source: ABdhPJyJdvD5DjTCPmr1TXl9bWCrJ7GsZp3ykSnNdM0FEZav34FCo4bqcM0yOwCyBLhr7wsMRKpYSQ==
X-Received: by 2002:a17:906:cc57:: with SMTP id mm23mr3665043ejb.12.1627551936120;
        Thu, 29 Jul 2021 02:45:36 -0700 (PDT)
Received: from localhost.localdomain ([89.18.44.40])
        by smtp.gmail.com with ESMTPSA id b15sm774965ejv.15.2021.07.29.02.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 02:45:35 -0700 (PDT)
From:   Pavo Banicevic <pavo.banicevic@sartura.hr>
To:     arkamar@atlas.cz, matt.redfearn@mips.com, mingo@kernel.org,
        dvlasenk@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH] include/uapi/linux/swab: Fix potentially missing __always_inline
Date:   Thu, 29 Jul 2021 11:45:58 +0200
Message-Id: <20210729094558.5935-1-pavo.banicevic@sartura.hr>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matt Redfearn <matt.redfearn@mips.com>

Commit bc27fb68aaad ("include/uapi/linux/byteorder, swab: force inlining
of some byteswap operations") added __always_inline to swab functions
and commit 283d75737837 ("uapi/linux/stddef.h: Provide __always_inline to
userspace headers") added a definition of __always_inline for use in
exported headers when the kernel's compiler.h is not available.

However, since swab.h does not include stddef.h, if the header soup does
not indirectly include it, the definition of __always_inline is missing,
resulting in a compilation failure, which was observed compiling the
perf tool using exported headers containing this commit:

In file included from /usr/include/linux/byteorder/little_endian.h:12:0,
                 from /usr/include/asm/byteorder.h:14,
                 from tools/include/uapi/linux/perf_event.h:20,
                 from perf.h:8,
                 from builtin-bench.c:18:
/usr/include/linux/swab.h:160:8: error: unknown type name `__always_inline'
 static __always_inline __u16 __swab16p(const __u16 *p)

Fix this by replacing the inclusion of linux/compiler.h with
linux/stddef.h to ensure that we pick up that definition if required,
without relying on it's indirect inclusion. compiler.h is then included
indirectly, via stddef.h.

Fixes: 283d75737837 ("uapi/linux/stddef.h: Provide __always_inline to userspace headers")

Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
Reviewed-by: Petr Vaněk <arkamar@atlas.cz>
---

Resending as patch is not really related to previous series and to not wait long for the merge.

---
 include/uapi/linux/swab.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/swab.h b/include/uapi/linux/swab.h
index 7272f85d6d6a..3736f2fe1541 100644
--- a/include/uapi/linux/swab.h
+++ b/include/uapi/linux/swab.h
@@ -3,7 +3,7 @@
 #define _UAPI_LINUX_SWAB_H
 
 #include <linux/types.h>
-#include <linux/compiler.h>
+#include <linux/stddef.h>
 #include <asm/bitsperlong.h>
 #include <asm/swab.h>
 
-- 
2.32.0

