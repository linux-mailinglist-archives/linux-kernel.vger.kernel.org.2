Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 288F33520A1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 22:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234874AbhDAUgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 16:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234114AbhDAUgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 16:36:40 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981A4C0613E6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 13:36:38 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id m20-20020a7bcb940000b029010cab7e5a9fso3438958wmi.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 13:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=2KaND/sffuyinKdIJbKbxcJA+nsm9S2X6h8dQ3LasyQ=;
        b=WC8fHh0kp1JkeWuPcZdLaC5r0ucDNMMFkliNRgRK00hZ7vA+QVirCEcFxCjkTqywH2
         QTcY7iwQkjdueVbRqQILr9dQpE54+kQ7djc6HW6gneDbmIejokZl7E75Oj2/Ker5U2ll
         GHFglluG0pW07c9KTvEnaFnzaSLRUnS1gBp1sxPOSweEUlXyKZTH5yCFhCTCTvt3xqjQ
         0cpL5Psp/FRS1oH2jsPNRwhaiXXo6iuY2ERhnD/ipTDvKLLZSqsSluQ9XQ4a4qhzMpXc
         pN+YxN/RgzQvr+C834C2sjcvR+F3Yattf2r47t+LT+1SOjJSeJGq6uRUD9M3qT0Gi4yg
         cdoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=2KaND/sffuyinKdIJbKbxcJA+nsm9S2X6h8dQ3LasyQ=;
        b=BQIIoMnV7FIgcP5ot+numsvYWHOjNS6fciJJQBLxKSMGem5K2umvh+6InMiSM53iXN
         yhLpB/3kf/Zb88t815gPz88mipZg7laXzjFu6P6O+I9pNr6jxVyzV2SvODKdhKFlroY0
         slhppXt3X1ugUs5Xy54bL3Ckom+OzgJZkMTkvHT2X9JhYl4hxA359AN0SMgoz6R0tLZa
         nAB4md6kIWq5/j4MD9yXlO6JTdOqfqmUMi58UPS1wwBFbE4QOs8TFUG6z60Uo4bHi9s1
         UPKCdKiXaHfJwCCtScime900OWJ0/xjDQSD/xeU0YTRVviPP5LbwA2P2K8DWOea6YF3w
         ZuKA==
X-Gm-Message-State: AOAM531f8+lYA3iSZ+R0Spp3ybpQApEUkDyRdjTu+qcIbnPycDoKP4JF
        W1v67PK3DGywt7P9cOquMEBeOaPe0A==
X-Google-Smtp-Source: ABdhPJy/F6dVK3Ul4qZaUZ1AcRr449zoY2CndDQf7wQu4DmoHwe5x7CPFG8PeVbAz1qm0yenk9eoug==
X-Received: by 2002:a7b:c418:: with SMTP id k24mr9733751wmi.169.1617309397285;
        Thu, 01 Apr 2021 13:36:37 -0700 (PDT)
Received: from localhost.localdomain ([46.53.251.196])
        by smtp.gmail.com with ESMTPSA id 137sm9768190wmb.42.2021.04.01.13.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 13:36:36 -0700 (PDT)
Date:   Thu, 1 Apr 2021 23:36:35 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     torvalds@linux-foundation.org
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Dixup sysname wrt recent cultural developments
Message-ID: <YGYu0z7mqhKRsRf5@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is apparent that emoji outbreak can not be contained.
In that case might as well embrace it.

Change main kernel banner, /proc/version and uname(2) output.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 include/linux/uts.h |    2 +-
 init/version.c      |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/include/linux/uts.h
+++ b/include/linux/uts.h
@@ -6,7 +6,7 @@
  * Defines for what uname() should return 
  */
 #ifndef UTS_SYSNAME
-#define UTS_SYSNAME "Linux"
+#define UTS_SYSNAME "🐧"
 #endif
 
 #ifndef UTS_NODENAME
--- a/init/version.c
+++ b/init/version.c
@@ -36,7 +36,7 @@ EXPORT_SYMBOL_GPL(init_uts_ns);
 
 /* FIXED STRINGS! Don't touch! */
 const char linux_banner[] =
-	"Linux version " UTS_RELEASE " (" LINUX_COMPILE_BY "@"
+	"🐧 version " UTS_RELEASE " (" LINUX_COMPILE_BY "@"
 	LINUX_COMPILE_HOST ") (" LINUX_COMPILER ") " UTS_VERSION "\n";
 
 const char linux_proc_banner[] =
