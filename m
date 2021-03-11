Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 638DF336BE5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 07:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbhCKGNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 01:13:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbhCKGNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 01:13:17 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28124C061574;
        Wed, 10 Mar 2021 22:13:17 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id x27so2087595qvd.2;
        Wed, 10 Mar 2021 22:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wt46hiMXeu6lVx64exPB+h7EP/J6sSYqbbQi4Xj8zyA=;
        b=TdHZLkuZCvAABU+E4VpoMDdb/snIhqSpqxEwMq0UOboPza+2CFrlDIJqFVM1nJ9QIH
         8GS4QDYh14s6Hr1PEx287huz9YybqrdaVjO0T5C85+7pvYTNGqTKMCcTsfd++ftz0CAf
         8ocVToClC2S/HspxSpmjgzPVS/x5zC2O8Nli8oaJ21qWaUDJMxyeykISPsuA6iQCu77I
         pFe74pHOWm2SBn1pw6F/pl5YuekJYmDAbQS05vgOUZtHPLWwUB60BSobNQinixmjY7/k
         JCead4Fj/EiYa/Er6d2qa8G8BemKGUEaNuY7RrDmSCuJrg7LFa4HpSoRrUprJx0BDauF
         J8Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wt46hiMXeu6lVx64exPB+h7EP/J6sSYqbbQi4Xj8zyA=;
        b=Z4RZbFHFg+F3KBCwGNnRXJSa64druROq+MMc2msnAvXHxVqjqjOi0UnUlj8M+ahZy2
         GwrGI8dC6pnEKEoZm7D9yYaarR3/eMAyT++bOSIsAFruHutAl3xB/jjVX/k7WHUJip4U
         ZW9+iZiyDZmdjTAeVBxJTVwkUJlYEhw4YMUwxrcDK3CnnmYTaWgJVBcwrbX4f0cPufsG
         2UfLIJ5+o2e+EJCxzbSsi5wlKXFhxXwTF/0DpDKKodRGQOpC2Y6lB90L0+qif6b5RgN9
         cAj6KKitZRuuqB04Q2nIcVlCpgYcN8IdsT74NMnLccHdyAs2vJC+T73vOqvEQq9RQ+OA
         qnTQ==
X-Gm-Message-State: AOAM532SieQMoXdB2iUr0axtPFuwK6CJVZnZOJ2zVB3YdJCVcGBvLgh/
        VGciuUSvmfCA+kh8vaUjN6o=
X-Google-Smtp-Source: ABdhPJz+uLcKBc8GXwQMSQriHiGRMJxjHmFT5X8gIisJspYhoVOhYfN9DXeZ1xXpYWg5s49fLJq1Vg==
X-Received: by 2002:a0c:908d:: with SMTP id p13mr6372954qvp.11.1615443196466;
        Wed, 10 Mar 2021 22:13:16 -0800 (PST)
Received: from localhost.localdomain ([156.146.55.115])
        by smtp.gmail.com with ESMTPSA id k28sm1306979qki.101.2021.03.10.22.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 22:13:15 -0800 (PST)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     unixbhaskar@gmail.com, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org
Subject: [PATCH] ia64: kernel: Few typos fixed in the file fsys.S
Date:   Thu, 11 Mar 2021 11:40:58 +0530
Message-Id: <20210311061058.29492-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Mundane spelling fixes.

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 arch/ia64/kernel/fsys.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/ia64/kernel/fsys.S b/arch/ia64/kernel/fsys.S
index 0750a716adc7..2094f3249019 100644
--- a/arch/ia64/kernel/fsys.S
+++ b/arch/ia64/kernel/fsys.S
@@ -172,7 +172,7 @@ ENTRY(fsys_gettimeofday)
 	// r25 = itc_lastcycle value
 	// r26 = address clocksource cycle_last
 	// r27 = (not used)
-	// r28 = sequence number at the beginning of critcal section
+	// r28 = sequence number at the beginning of critical section
 	// r29 = address of itc_jitter
 	// r30 = time processing flags / memory address
 	// r31 = pointer to result
@@ -432,7 +432,7 @@ GLOBAL_ENTRY(fsys_bubble_down)
 	 *	- r29: psr
 	 *
 	 * We used to clear some PSR bits here but that requires slow
-	 * serialization.  Fortuntely, that isn't really necessary.
+	 * serialization.  Fortunately, that isn't really necessary.
 	 * The rationale is as follows: we used to clear bits
 	 * ~PSR_PRESERVED_BITS in PSR.L.  Since
 	 * PSR_PRESERVED_BITS==PSR.{UP,MFL,MFH,PK,DT,PP,SP,RT,IC}, we
--
2.26.2

