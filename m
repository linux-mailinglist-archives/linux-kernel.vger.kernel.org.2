Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5980531A96D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 02:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbhBMBRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 20:17:16 -0500
Received: from mail-ot1-f41.google.com ([209.85.210.41]:43284 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbhBMBRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 20:17:07 -0500
Received: by mail-ot1-f41.google.com with SMTP id l23so935223otn.10;
        Fri, 12 Feb 2021 17:16:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=378QAQ4bK+x4rxGe6jOYIRjyUvbnNgGahQKoi2qE1ek=;
        b=cqYnF/pYZxHlWf3JbjSbAcFXUCijZ2ZwzEWgaGfaJhHDVN5w0vNLsAoJ6ePu61nDf2
         CD2QNdKRB5jqdZrgPJk54Ck+DH20nAeXHJjgji7926OQtl5ONpYHPr1AXzJQpEUTlMmv
         BYGbJIEeu/wYDIZuRCgFOx/d9xfoNZuEuDRvs4LaVuRu33XNf9TAMglHgg8AH1HIwOF7
         RQk5thpd7mlXEesBMqDJ9hw8grQQWJmJiIJo0Br6DSiUUEjfyZzO3DV04hdAH6BXFTq7
         X/6xhmmwvf+emUklzFF71cDP30sRfZHwTRTiHP9oJAi56Mew1mIDBytc4K5OVaOuns4d
         nmPg==
X-Gm-Message-State: AOAM531HQbohK2/XLJW22KhKS3a+IF15uE9u8R+Ke1PzUIPoovk3QERu
        a8JxpBQl2QJUrh2EbfQ4Yf1+Az/9/Q==
X-Google-Smtp-Source: ABdhPJyMVHPveHs5txHzOVjexHBwRd+NzFpzxOOF1zuyzA0re0picRMlSxNYDZEspQoiEM9q6DnJLQ==
X-Received: by 2002:a9d:70d7:: with SMTP id w23mr4246596otj.352.1613178986121;
        Fri, 12 Feb 2021 17:16:26 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id x16sm1519848otp.81.2021.02.12.17.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 17:16:25 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Michal Simek <monstr@monstr.eu>
Subject: [PATCH] microblaze: Fix built-in DTB alignment to be 8-byte aligned
Date:   Fri, 12 Feb 2021 19:16:24 -0600
Message-Id: <20210213011624.251838-1-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 79edff12060f ("scripts/dtc: Update to upstream version
v1.6.0-51-g183df9e9c2b9") broke booting on Microblaze systems depending on
the build. The problem is libfdt gained an 8-byte starting alignment check,
but the Microblaze built-in DTB area is only 4-byte aligned. This affected
not just built-in DTBs as bootloader passed DTBs are copied into the
built-in DTB region.

Other arches using built-in DTBs use a common linker macro which has
sufficient alignment.

Fixes: 79edff12060f ("scripts/dtc: Update to upstream version v1.6.0-51-g183df9e9c2b9")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Cc: Michal Simek <monstr@monstr.eu>
Signed-off-by: Rob Herring <robh@kernel.org>
---
As the commit is in my tree, I'll take this via the DT tree.

 arch/microblaze/kernel/vmlinux.lds.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/microblaze/kernel/vmlinux.lds.S b/arch/microblaze/kernel/vmlinux.lds.S
index df07b3d06cd6..fb31747ec092 100644
--- a/arch/microblaze/kernel/vmlinux.lds.S
+++ b/arch/microblaze/kernel/vmlinux.lds.S
@@ -45,7 +45,7 @@ SECTIONS {
 		_etext = . ;
 	}
 
-	. = ALIGN (4) ;
+	. = ALIGN (8) ;
 	__fdt_blob : AT(ADDR(__fdt_blob) - LOAD_OFFSET) {
 		_fdt_start = . ;		/* place for fdt blob */
 		*(__fdt_blob) ;			/* Any link-placed DTB */
-- 
2.27.0

