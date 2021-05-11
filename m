Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86893379CD0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 04:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbhEKCSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 22:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbhEKCSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 22:18:09 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CAE2C061574;
        Mon, 10 May 2021 19:17:02 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id n84so10238778wma.0;
        Mon, 10 May 2021 19:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/CKoqFTpb+P15Tc2VdjW4Tup4wwaQBmtzCdHHZT/d/U=;
        b=Ms192diDwaJIei7rAzHkvTsDDUpZ93ASGGzx4L4ALY/zDdkx6lNhIGbfk5H8j9x+ku
         I/bU029i6ByxFnfIeiOrF1QyUVWJ5S9KbL0dvjehrmeO8UuF66Jgh2vhcu+EGxEGMfEu
         Dcc3ucdDaRLpu+mWJ5KnP+wD/oWFMiIdzdByx2LrF1SqwofJGKdTKyIK//m19gD1xgj6
         uTtuXNSkyFN1NGlrbdFYEEyLsDSosr2lmd9kV2agLLfYmuIsr4ryJZffaMarvlKDe0Tc
         dQZnn1xKxvHBgB6GPADVIDH0zWaQ/SJ5lvvEamiE7u9IUIYRXImqu9vHfa3RW5USUYrH
         7pbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/CKoqFTpb+P15Tc2VdjW4Tup4wwaQBmtzCdHHZT/d/U=;
        b=hE2BPeT8zVJ7EOaVf69+mslrW8oBSc/v9zeqL9t34+mWrbyRNTCh9o+YQte3cTABA2
         lupT+MMKAoPiZzKBgYT1bIJi4JGsCCfwyVNdg00UzyIXzCbEfXcUsTDi9Ww9pBZZSa9i
         20XQ3VZAhht/+QLhF64OMhAqtfYy9BHWMee1vJg1h+NAIYJhQUfy7gc8Gjwcf8e8KeUN
         mwe+Hu9SLl9Nb8Fadspg19MizDsZeZqDWiuYH/LL0xuuwFVw+WHFYsMTqQmpJeLj/KQ6
         dVMtCPkMwiv8W8PHOPrsFQ+GmmVjYmJjeV6l0e08lg5YcnnJOglQrbZGZXVt4HinyoRp
         GKVQ==
X-Gm-Message-State: AOAM530s2QTVzTBKoLij0w5zrOO6WK7FXcxCPSYQHr3T+PDa/T4LHlmm
        7qMZEcVHljYXstehqEnyBxU=
X-Google-Smtp-Source: ABdhPJwZ9fFwHaCaULSS1k2d/D3QgdkciE/XuWIAiJ33S4I7EtHzqK3fQiFVVZCfLrbK56osnkCMFg==
X-Received: by 2002:a1c:7d92:: with SMTP id y140mr29752104wmc.41.1620699420831;
        Mon, 10 May 2021 19:17:00 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-35-189-2.ip56.fastwebnet.it. [93.35.189.2])
        by smtp.googlemail.com with ESMTPSA id p1sm17628998wrs.50.2021.05.10.19.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 19:17:00 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Abbott Liu <liuwenliang@huawei.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] arm: Enlarge IO_SPACE_LIMIT needed for some SoC
Date:   Tue, 11 May 2021 04:16:54 +0200
Message-Id: <20210511021656.17719-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ipq8064 SoC requires larger IO_SPACE_LIMIT on second and third pci port.
Each pci line I/O space require 0x100000 and the current limit in the
specific case of ipq8064 cause the malfunction of the second and the
third line that are commonly used for wifi cards.
Current IO space is set to support only 0x100000 space while for ipq806x
if all 3 pcie lines are connected, it's required 0x300000 of space.
Update the IO_SPACE_LIMIT to permit this larger space and update the
documentation for the Mapping PCI I/O space memory end to the new value
of ff0fffff.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 Documentation/arm/memory.rst | 2 +-
 arch/arm/include/asm/io.h    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/arm/memory.rst b/Documentation/arm/memory.rst
index 0cb1e2938823..938fe74c9020 100644
--- a/Documentation/arm/memory.rst
+++ b/Documentation/arm/memory.rst
@@ -53,7 +53,7 @@ ffc00000	ffc7ffff	Guard region
 ff800000	ffbfffff	Permanent, fixed read-only mapping of the
 				firmware provided DT blob
 
-fee00000	feffffff	Mapping of PCI I/O space. This is a static
+fee00000	ff0fffff	Mapping of PCI I/O space. This is a static
 				mapping within the vmalloc space.
 
 VMALLOC_START	VMALLOC_END-1	vmalloc() / ioremap() space.
diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index fc748122f1e0..76f1c668df5e 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -197,7 +197,7 @@ void __iomem *pci_remap_cfgspace(resource_size_t res_cookie, size_t size);
 #ifdef CONFIG_NEED_MACH_IO_H
 #include <mach/io.h>
 #elif defined(CONFIG_PCI)
-#define IO_SPACE_LIMIT	((resource_size_t)0xfffff)
+#define IO_SPACE_LIMIT	((resource_size_t)0x2fffff)
 #define __io(a)		__typesafe_io(PCI_IO_VIRT_BASE + ((a) & IO_SPACE_LIMIT))
 #else
 #define __io(a)		__typesafe_io((a) & IO_SPACE_LIMIT)
-- 
2.30.2

