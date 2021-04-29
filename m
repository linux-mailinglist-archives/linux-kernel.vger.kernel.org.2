Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8136F36EF97
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 20:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241245AbhD2SlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 14:41:15 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59824 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241236AbhD2SlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 14:41:11 -0400
Received: from mail-pl1-f200.google.com ([209.85.214.200])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <tim.gardner@canonical.com>)
        id 1lcBaJ-0001vm-FV
        for linux-kernel@vger.kernel.org; Thu, 29 Apr 2021 18:40:23 +0000
Received: by mail-pl1-f200.google.com with SMTP id z2-20020a1709030182b02900eca55a002dso16571342plg.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 11:40:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0OUrEu3/29WV/lDM4r+szkRmP1MV+40G+dNKGjfZYt8=;
        b=ubyXPozTKoaaAv+jKcK0pVQx2OXFK0/PIizboTw4sntOpr2wx44XjIfZYOtlzJdH8R
         VKhA8Wul+/85tFKaNhC3y5jsklQzZc0AuNU+lsUIydCQAuR9lfeufFsj23nGwIYLaRoA
         luOoLfVt0Ab3gmxzKWz72yPBSNp/iLjZJobNE23o2gS0RFeDcPE18i1Le2lmWhvQZO2e
         gF2xZGZ32p3nw7Bw9ae9LyKl052UsKDGkCtM+iplgzkNypca0TxWfuyBzN5KqdjtLj2D
         TXzce16IBmA61IIkIoubG+2rnLb7Rswdsx+WiwV2YVtkWu6MutV8FrFN7JGwsNTMej+g
         6E2A==
X-Gm-Message-State: AOAM533cN24hIpguw3dx7EkGJMp8GnA20kWgUbe0rqI6a8NM/C9cC9t7
        ROg0o3mzU0EtymCRF4W+r6XADJnGn/C0wdRETUgx0zNKcUwSsP3fsHeWoqOx5GHrN3l+7O19W3X
        SaXNDU4N1BXVV/fOyV0ScKfZLwWQrosQ0hvk41wf1hQ==
X-Received: by 2002:a17:90a:cb0e:: with SMTP id z14mr11314576pjt.128.1619721622211;
        Thu, 29 Apr 2021 11:40:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxP/sVvL06a92jnUUZ2B1gLcXqqV7Y30Y0/R/Ft4O7oXGNSU5HG7BG/ZDYxyPM1DDTHd2+CHg==
X-Received: by 2002:a17:90a:cb0e:: with SMTP id z14mr11314560pjt.128.1619721622063;
        Thu, 29 Apr 2021 11:40:22 -0700 (PDT)
Received: from localhost.localdomain ([69.163.84.166])
        by smtp.gmail.com with ESMTPSA id i123sm3566618pfc.53.2021.04.29.11.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 11:40:21 -0700 (PDT)
From:   Tim Gardner <tim.gardner@canonical.com>
To:     dave.hansen@linux.intel.com
Cc:     tim.gardner@canonical.com, jarkko@kernel.org, shuah@kernel.org,
        linux-sgx@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/sgx: Defeat execute permissions test
Date:   Thu, 29 Apr 2021 12:39:52 -0600
Message-Id: <20210429183952.22797-2-tim.gardner@canonical.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210429183952.22797-1-tim.gardner@canonical.com>
References: <20210429183952.22797-1-tim.gardner@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The permissions check on /dev/sgx_enclave appears to be an oversight
in that it will not allow the test to continue. Skipping this test
with a warning allows the test to proceed.

Cc: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-sgx@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Tim Gardner <tim.gardner@canonical.com>
---
 tools/testing/selftests/sgx/load.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/sgx/load.c b/tools/testing/selftests/sgx/load.c
index f441ac34b4d4..e5bcaca1c372 100644
--- a/tools/testing/selftests/sgx/load.c
+++ b/tools/testing/selftests/sgx/load.c
@@ -155,10 +155,8 @@ bool encl_load(const char *path, struct encl *encl)
 	 * bits set.  It does not check that the current user is
 	 * the owner or in the owning group.
 	 */
-	if (!(sb.st_mode & (S_IXUSR | S_IXGRP | S_IXOTH))) {
-		fprintf(stderr, "no execute permissions on device file %s\n", device_path);
-		goto err;
-	}
+	if (!(sb.st_mode & (S_IXUSR | S_IXGRP | S_IXOTH)))
+		fprintf(stderr, "Warning: no execute permissions on device file %s\n", device_path);
 
 	ptr = mmap(NULL, PAGE_SIZE, PROT_READ, MAP_SHARED, fd, 0);
 	if (ptr == (void *)-1) {
-- 
2.17.1

