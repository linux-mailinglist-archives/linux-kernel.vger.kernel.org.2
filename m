Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A646387F34
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 20:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346643AbhERSF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 14:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344188AbhERSFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 14:05:25 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4D8C061573;
        Tue, 18 May 2021 11:04:06 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id cu11-20020a17090afa8bb029015d5d5d2175so1999187pjb.3;
        Tue, 18 May 2021 11:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=aSYL3pcR/hm+AB6E8ZocVOOdmI+sax3R1YjjSrPim0Q=;
        b=msX/iV3PaXpMuvYv16n8sm1kVUXR1VCASL7ij/VUywRX2z6VPSy1ckrjSTOt0Q7kzi
         D7CPUQ7uG0bRGuJ6zW4MBWP52e+85KX8s1UFvjUBZnepinyq5N/3cSTm57Q093I9eQDO
         fbWrugDBiDe4ruLEUcMafl2qZKXtXNbimw4Er6gmCGF8HJYJr8qvX5q4dy+4mtQRnIe7
         b0AZD4C6JfOuNz7ai+8EBPP5wPMbfeAFKb3VEDMOAOK9SQFGSjLOD+99LrdcHCt1vvDn
         8QWmZjgHJ93hG/0MSOwKvfGywyUZXS5gA2dCToRibKuxq671zyykTrQmcCulcfyzls0/
         mA6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=aSYL3pcR/hm+AB6E8ZocVOOdmI+sax3R1YjjSrPim0Q=;
        b=nwHUNRrtpAl1Y7iHpwYbB3S2DgGjmJfpeqwzTS5rbCo7VmOnAb5jfXbk7r0kmwcpuY
         eQ93r4F6zJ3YbdvJdDW9DSKpeDBYMvroHR4GO0JsQnmucQof4Y/LIJJozO73HqGj/Y8F
         qDVAuQ2eNenw4FH1alF7PL+HjGg18kKC+9F8rYkVTdbOp5irp9uj9hV1fFRfQZSYQfY4
         p0zzQ9+dnATYevqI/w2Y0ExSqIjG3pjXJMAY+VxRZBDerEbWZYqEqHUGoQ1QlcR4tzwA
         YA9ucRWRvoQ0fmfZpWNFiwHCk4AMhMR1JnkLT/VihUKgdtW/Q/aLn4rN27VmZzBx2zxG
         uN1Q==
X-Gm-Message-State: AOAM531zbPnsOEElddTVLPN92HY4jCxqwTTGcPUhLY9FD0IfTkV+RRU1
        kwOJ2QlZvdIpI/NxDdghmgwEOLVBMjvf+A==
X-Google-Smtp-Source: ABdhPJwTdBbXo34uOl7LFiUUM4F9v0Sf1Z28QFEANtjrFKXHbPjOCMlk9qr14UFXSipskYcxZYC4cA==
X-Received: by 2002:a17:902:bc81:b029:ef:3f99:9f76 with SMTP id bb1-20020a170902bc81b02900ef3f999f76mr6003422plb.33.1621361045418;
        Tue, 18 May 2021 11:04:05 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:600d:a93f:e998:b72d:dcc8:8823])
        by smtp.googlemail.com with ESMTPSA id o9sm13573919pfh.217.2021.05.18.11.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 11:04:04 -0700 (PDT)
From:   Aditya Srivastava <yashsri421@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     yashsri421@gmail.com, lukas.bulwahn@gmail.com,
        rdunlap@infradead.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org
Subject: [PATCH] win_minmax: fix kernel-doc syntax in file header
Date:   Tue, 18 May 2021 23:33:52 +0530
Message-Id: <20210518180352.13154-1-yashsri421@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The opening comment mark '/**' is used for highlighting the beginning of
kernel-doc comments.
The header for include/linux/win_minmax.h follows this syntax, but the
content inside does not comply with kernel-doc.

This line was probably not meant for kernel-doc parsing, but is parsed
due to the presence of kernel-doc like comment syntax(i.e, '/**'), which
causes unexpected warning from kernel-doc:
warning: expecting prototype for c(). Prototype was for MINMAX_H() instead

Provide a simple fix by replacing this occurrence with general comment
format, i.e. '/*', to prevent kernel-doc from parsing it.

Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
---
* Applies perfectly on next-20210514

 include/linux/win_minmax.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/win_minmax.h b/include/linux/win_minmax.h
index 4ca2842d2842..54bd6f133fa6 100644
--- a/include/linux/win_minmax.h
+++ b/include/linux/win_minmax.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/**
+/*
  * lib/minmax.c: windowed min/max tracker by Kathleen Nichols.
  *
  */
-- 
2.17.1

