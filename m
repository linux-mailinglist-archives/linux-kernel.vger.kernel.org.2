Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFC64340BC9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 18:27:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbhCRR1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 13:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbhCRR0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 13:26:41 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C4A4C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 10:26:41 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id cl21-20020a17090af695b02900c61ac0f0e9so7186563pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 10:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sHweBOu87N9g9RKv5TWD5Rj8wEEJ3GYvvqd55wtZEbI=;
        b=TQvJIdX/XWX8GGUYM9ea2FwlskID9/bCoUtkfBR8qYG1RG15oIc1wNmyqgfPCmhryI
         jbQxvqFeo1ynfoIXHNONifPkZwqFWIs00ILSclsv4bV/nURB3xYTC+bnFOEbtCHQ4qZA
         wFDk50SAkiROguF+LuHIdBpm6I4scBRk9ZUeVn5BqeHk9kEdipEBcLQPCB8CRS0/dRPP
         +U1Zi8qOH3aZiD2HnRG11ULlvsj3Be9QQ0NxsScYaHgC8v37uc7mr6rZZVBB5NJZsCYA
         9XL+XbJpmUy7q9u8HU0kBt5AujhPkpiSIfdhD+5BP74Lm9e7SwxwPkFsOam62ya1qg0t
         aGxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sHweBOu87N9g9RKv5TWD5Rj8wEEJ3GYvvqd55wtZEbI=;
        b=gO4TGxyP3proQnChX4r3v4pGsB4+tWClpGq58VPGW2GWK+S7thn98Mxt/u0nR+l0gH
         n9O9VxKZYTNpaDzVW9UX0IalEHbAzazIGymJWfKYD3dZ3uHkyHIPWqkEzVHG9D8SkRtv
         CbAxU5lj0pWoclv2CGHBsiynou5IJmyakEu3Mi635McJ5Kl2/UjIg5UH6yGxPeqDxywj
         WNNFCNcRcGrjgg3UhSd9VVm8OUuggAIT3icias1g0L9Z20rHqdFex1/kAQ/0uFdUv5w6
         X2+qF8BFdWRozWomAFOjYIGnnNb806hM/kuUzjqNiFyBDsfm6IiHc67nVw50lhWgDEX2
         Bmwg==
X-Gm-Message-State: AOAM5314PwRy96cKvXSUeI4Rmt7fCRQdQnJ3Wr0Wi/ImQWucHBFFADkE
        oqjM4BDllgXkm8D6q/mekYY=
X-Google-Smtp-Source: ABdhPJwVIyl5FoWv3FG2mTLwetmTy19oZ5LMGtWOYkVvVW0mFKLaDdrgf3sUmkMpw7OVMTNQEW5E8A==
X-Received: by 2002:a17:902:dac2:b029:e6:30a6:4c06 with SMTP id q2-20020a170902dac2b02900e630a64c06mr10850318plx.65.1616088400873;
        Thu, 18 Mar 2021 10:26:40 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:9004:6aa2:3e25:28b1:e7b3:767e])
        by smtp.gmail.com with ESMTPSA id bk8sm2751442pjb.13.2021.03.18.10.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 10:26:40 -0700 (PDT)
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
To:     joe@perches.com
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com,
        Dwaipayan Ray <dwaipayanray1@gmail.com>
Subject: [PATCH] checkpatch: remove check for include/asm modifications
Date:   Thu, 18 Mar 2021 22:56:29 +0530
Message-Id: <20210318172629.123182-1-dwaipayanray1@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

include/asm/ got removed over a decade back. checkpatch
still has a check for it: MODIFIED_INCLUDE_ASM

Remove the check as it is no longer useful.

Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
---
 scripts/checkpatch.pl | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index f42e5ba16d9b..798e2236b1a3 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2799,10 +2799,6 @@ sub process {
 				     "patch prefix '$p1_prefix' exists, appears to be a -p0 patch\n");
 			}
 
-			if ($realfile =~ m@^include/asm/@) {
-				ERROR("MODIFIED_INCLUDE_ASM",
-				      "do not modify files in include/asm, change architecture specific files in include/asm-<architecture>\n" . "$here$rawline\n");
-			}
 			$found_file = 1;
 		}
 
-- 
2.30.0

