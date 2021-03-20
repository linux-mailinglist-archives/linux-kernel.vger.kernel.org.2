Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36AE3342EFD
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 19:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbhCTS0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 14:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbhCTS0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 14:26:18 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09EAEC061574;
        Sat, 20 Mar 2021 11:26:18 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id s2so9409386qtx.10;
        Sat, 20 Mar 2021 11:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bFrAwojYFFSLnG6A9rSMfG6/9uir3qb9v3jvruMRe+s=;
        b=Tn7L4lEHwwhAbsp3YyE/iQeKhDtYhQU5XCfiD9zr+Iu6M6V1vugx9IprEnEAhJtztI
         oFtdJA6rpbQvGob/+TOC7GJs//Cz76Lyu53eVpjN10zmq8cnvaRbsjlbuYHPoYFbxBea
         HbjXz1Rch19GyVS9OIL0JyahA/FtJWiAawgz/Wb1Yk2oRfywnAxhmF+BMnWDGQbw4xE+
         sgWbRbV/Mrl+cQDMLVtUX1i37Pm4smpxGooilWk8B4jw3GgbBXvEBD3e5KM/tHiRO81l
         f4omsqOoltInhOSy68kWpwtV+Je6U0BkG5valUXDWnMxu7MhkXIZGjnlLa+S4inewIAf
         dTHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bFrAwojYFFSLnG6A9rSMfG6/9uir3qb9v3jvruMRe+s=;
        b=QCqsCckqikzKaih78sZ3yenoh5sRLgmymNFsHyvw/ciDHKWreqjInjGGu9aAbBqfce
         /yM9CvnYWVXJJxPUKMUMMOXC41QtFfNtnnbxcRQanLdFAZA8jRI8hreb2BSJa7adiScf
         7Ggaq0joF1w4ypMGZesEkmvgsMY0BJLtdUzUKsl3SdMF5795woK/2uPAjYV8a/YAgnwJ
         9JEGcFBDrEH8B8dho70zh4BzK6cCKxw3Fa47TrGbcVE+/p2ETzJmvpIIrXsfMIhH080r
         CFwrFcwkNLnEAQJeTYjNnWn3ngSnuDSgvRPf1+B1MC4CbW7Wii3SnrU0pgLl+IUImqMf
         BTsA==
X-Gm-Message-State: AOAM530pJXQdv4hG1BCte7S8V+q/H1v+3i0wTGgYQ+o8yCDOJf3ihxZY
        sgazD8gnGmsKlpructzUDu0=
X-Google-Smtp-Source: ABdhPJwXR91CqLfqLL0bWNmFEJzrpM0nv6oCrVTPcIR/9mrJPYDWxYU5aC+ajx0sdYn5w9OMi8LdPw==
X-Received: by 2002:ac8:109a:: with SMTP id a26mr3802327qtj.156.1616264777021;
        Sat, 20 Mar 2021 11:26:17 -0700 (PDT)
Received: from localhost.localdomain ([138.199.13.205])
        by smtp.gmail.com with ESMTPSA id b21sm7072710qkl.14.2021.03.20.11.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 11:26:16 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     unixbhaskar@gmail.com, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org
Subject: [PATCH] IA64: Trivial spelling fixes
Date:   Sat, 20 Mar 2021 23:53:47 +0530
Message-Id: <20210320182347.21440-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/seralize/serialize/ .....three different places

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 arch/ia64/kernel/pal.S | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/ia64/kernel/pal.S b/arch/ia64/kernel/pal.S
index d3e22c018b68..06d01a070aae 100644
--- a/arch/ia64/kernel/pal.S
+++ b/arch/ia64/kernel/pal.S
@@ -86,7 +86,7 @@ GLOBAL_ENTRY(ia64_pal_call_static)
 	mov ar.pfs = loc1
 	mov rp = loc0
 	;;
-	srlz.d				// seralize restoration of psr.l
+	srlz.d				// serialize restoration of psr.l
 	br.ret.sptk.many b0
 END(ia64_pal_call_static)
 EXPORT_SYMBOL(ia64_pal_call_static)
@@ -194,7 +194,7 @@ GLOBAL_ENTRY(ia64_pal_call_phys_static)
 	mov rp = loc0
 	;;
 	mov ar.rsc=loc4			// restore RSE configuration
-	srlz.d				// seralize restoration of psr.l
+	srlz.d				// serialize restoration of psr.l
 	br.ret.sptk.many b0
 END(ia64_pal_call_phys_static)
 EXPORT_SYMBOL(ia64_pal_call_phys_static)
@@ -252,7 +252,7 @@ GLOBAL_ENTRY(ia64_pal_call_phys_stacked)
 	mov rp = loc0
 	;;
 	mov ar.rsc=loc4			// restore RSE configuration
-	srlz.d				// seralize restoration of psr.l
+	srlz.d				// serialize restoration of psr.l
 	br.ret.sptk.many b0
 END(ia64_pal_call_phys_stacked)
 EXPORT_SYMBOL(ia64_pal_call_phys_stacked)
--
2.26.2

