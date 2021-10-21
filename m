Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0DD436CBE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 23:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbhJUVfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 17:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbhJUVfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 17:35:51 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A82EC061348
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 14:33:35 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id h10so2219534ilq.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 14:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T+9RQ1gHI6Eo8JuPymqsyKLdV5Ri8DOq7x3uGVF5r64=;
        b=T7eFuIpU7YmfCpGWZHOzJNdxX9cvRpJDwsJ9Y6il1NtbrD+9f4YFOX2Na6jUtKYVTK
         orosVDofcva9UZBr+8OrVVUIx5awBnDrRqq8N48EjjdBdeOJ+5rWIkrF5yHV3WAfr0yc
         UrtgmevpFqYkFhuyvUXlpgk/RIizjyMWfbDV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T+9RQ1gHI6Eo8JuPymqsyKLdV5Ri8DOq7x3uGVF5r64=;
        b=pOeLz0Q484glHt7WMNtUoS/X6XcWEPR4OTZ4t2ykstVh8XwMP1KjQZ4yKNwYnb89Nb
         CvWSMxfFQesQdMmv1A0G7TjI65cQp2oYGRg6z3UoD1XA75Q4mfXUfiQoMYdvVOX+5TyJ
         r2wyqQgqi3L3HsbqHx2YnkK72j5bfkeyTYDVWWFBUtP35NT8VsZ8MaA0U2/I1Zu8+6by
         mpqzfv7nKhmBcNu47JdxzGfuPf8PhhiLbMMkMKSUGXrmgxjR4TAXQv+dlj3WsRFW3Xb0
         fXYl7Izykxux+O3xlQkt8r453OZQZyh1QcwrFJSrJPNeMVqVZYdetCxcHglklsTZEx+T
         DqXw==
X-Gm-Message-State: AOAM5318TIp+UCI0iirs5wOkad0WHAmGSH9auPWKu3SkQyTYMMY/BxZo
        FjWB2yWx+eVAbFhyw59QjFf/8w==
X-Google-Smtp-Source: ABdhPJxOjTr8/NCOQNOcS+SMT9tdakhHIuJb23QgMs6gK/z6v83mczVGktP5mCm45gbNs04DhMrsTg==
X-Received: by 2002:a92:cd4f:: with SMTP id v15mr3124404ilq.153.1634852014526;
        Thu, 21 Oct 2021 14:33:34 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id t12sm467079ilm.2.2021.10.21.14.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 14:33:34 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     shuah@kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: x86: fix [-Wstringop-overread] warn in test_process_vm_readv()
Date:   Thu, 21 Oct 2021 15:33:33 -0600
Message-Id: <20211021213333.38350-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following [-Wstringop-overread] by passing in the variable
instead of the value.

test_vsyscall.c: In function ‘test_process_vm_readv’:
test_vsyscall.c:500:22: warning: ‘__builtin_memcmp_eq’ specified bound 4096 exceeds source size 0 [-Wstringop-overread]
  500 |                 if (!memcmp(buf, (const void *)0xffffffffff600000, 4096)) {
      |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/x86/test_vsyscall.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/x86/test_vsyscall.c b/tools/testing/selftests/x86/test_vsyscall.c
index 65c141ebfbbd..5b45e6986aea 100644
--- a/tools/testing/selftests/x86/test_vsyscall.c
+++ b/tools/testing/selftests/x86/test_vsyscall.c
@@ -497,7 +497,7 @@ static int test_process_vm_readv(void)
 	}
 
 	if (vsyscall_map_r) {
-		if (!memcmp(buf, (const void *)0xffffffffff600000, 4096)) {
+		if (!memcmp(buf, remote.iov_base, sizeof(buf))) {
 			printf("[OK]\tIt worked and read correct data\n");
 		} else {
 			printf("[FAIL]\tIt worked but returned incorrect data\n");
-- 
2.32.0

