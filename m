Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A48630AD4A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 18:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232008AbhBARAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 12:00:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbhBARAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 12:00:13 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF9FCC061573;
        Mon,  1 Feb 2021 08:59:32 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id d16so17343856wro.11;
        Mon, 01 Feb 2021 08:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lfvjglo2iWimqrT++GTgmO35jZY6+DY5kg/Ywj5v+9o=;
        b=MfctAOutPixsTtOSVI72g22GtuHABCVIbpzu1Oui8G1sQJo36pM0l0X373Nnuf1u97
         jNjbDQHN+oMxTCFQthc0+ppO8DC02kio1JTLQgzHQ2WeoIxkqQ+yX8TWdtvwUZaeS1FT
         ltuCaso3j2Qp/oAiUJBPhzvNjbhrumNDzhw223d7dYQujNFQhrYQAP0sTQwppq7vZRhr
         mv7aZPRPEQz7x1w3AuWGTtTrXqFUhJm50cKX4UJtB0Allppm4tHt6q0u1xKb/4GR2XBX
         ySZWPko4AvfvRMsTXyc0GgGGU8W9Kl9zJOYGvyeV390cFzqJhJQLVBnDgeswmoCLyL0/
         DtSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lfvjglo2iWimqrT++GTgmO35jZY6+DY5kg/Ywj5v+9o=;
        b=hoB+lIUCPMXvfXx46jzHMJLbDnTBp7unx/4LZRsxkjIn5p1ve1W6bUysDibg+kKa/B
         OiqXwv+mOU9G+cSKrjHaYhN6ZpUEOlEO9V28yPMGs55EHUanbCIPgRdoft5yfmF7C3yk
         Xei7OVCFLxF+WOdW+VmM4MUMtACqIU6VSzPWmzOdNcWYDIuK3tgwmyFfiKFWHRus3+F7
         ByeLn2A+BHWj6/T96a/7SyJ6ZkOq7Rmw53+Or8BIlGxVZpWf8ya3JJUInOIs7rNSupTr
         5yo7ZczFuCj+UPdf5UBkachBzYhj3sh8HWeQuoj7RFD9TvW/zjuFq9h295HCJjLvBZLC
         1GOw==
X-Gm-Message-State: AOAM533JqdZ0XBVj9qMug3/s20QgMDw29w6mXz5q2gPzWlgn5692/AoX
        UWxazx6Mvvxpw1ayaQ3mHrs=
X-Google-Smtp-Source: ABdhPJws59KzzULQEh1KFT0w85G3rFB0Q0RRUDMvlD/iC9yvmrWp9gIruLJ5IU6UfOjFvFgKuWVuKQ==
X-Received: by 2002:a05:6000:192:: with SMTP id p18mr18958779wrx.69.1612198771621;
        Mon, 01 Feb 2021 08:59:31 -0800 (PST)
Received: from localhost (178-169-161-196.razgrad.ddns.bulsat.com. [178.169.161.196])
        by smtp.gmail.com with ESMTPSA id l10sm27890759wro.4.2021.02.01.08.59.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Feb 2021 08:59:30 -0800 (PST)
From:   Iskren Chernev <iskren.chernev@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Iskren Chernev <iskren.chernev@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Andrei Ziureaev <andrei.ziureaev@arm.com>,
        Cristian Ciocaltea <cristian.ciocaltea@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: Use portable sort for version cmp
Date:   Mon,  1 Feb 2021 18:58:28 +0200
Message-Id: <20210201165829.58656-1-iskren.chernev@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sort -C is like sort -c >/dev/null but less portable. It fails on
busybox sort (i.e alpine linux).

Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
Fixes: ea5b8b5eb004 ("dt-bindings: Add a minimum version check for dtschema")
---
 Documentation/devicetree/bindings/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/Makefile b/Documentation/devicetree/bindings/Makefile
index 90fcad98984d..780e5618ec0a 100644
--- a/Documentation/devicetree/bindings/Makefile
+++ b/Documentation/devicetree/bindings/Makefile
@@ -10,7 +10,7 @@ DT_SCHEMA_MIN_VERSION = 2020.8.1
 PHONY += check_dtschema_version
 check_dtschema_version:
 	@{ echo $(DT_SCHEMA_MIN_VERSION); \
-	$(DT_DOC_CHECKER) --version 2>/dev/null || echo 0; } | sort -VC || \
+	$(DT_DOC_CHECKER) --version 2>/dev/null || echo 0; } | sort -Vc >/dev/null || \
 	{ echo "ERROR: dtschema minimum version is v$(DT_SCHEMA_MIN_VERSION)" >&2; false; }
 
 quiet_cmd_extract_ex = DTEX    $@

base-commit: fd821bf0ed9a7db09d2e007df697f4d9ecfda99a
prerequisite-patch-id: c90e3d48df0672dab84da1b294374598bfc45db8
prerequisite-patch-id: f0b48cda55170cf82855daa6f7b4edfdba83d90c
prerequisite-patch-id: 48482c0c3e2797459e311f73db1828f2531bd11c
prerequisite-patch-id: 5512fd0c8367c8c8a2ace8003b533057422e1437
prerequisite-patch-id: 1635c0e78c99506fd2710f54be4e5fc5980712a6
prerequisite-patch-id: e80dacf2da55197be027f297617868832ddabfc9
prerequisite-patch-id: bd3efb4ced6ceb2c6a50dcd8527ea4d6d19baf5d
-- 
2.30.0

