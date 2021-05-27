Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3DC239366B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 21:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235452AbhE0TkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 15:40:20 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:35619 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234229AbhE0TkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 15:40:19 -0400
Received: by mail-ot1-f44.google.com with SMTP id 69-20020a9d0a4b0000b02902ed42f141e1so1324893otg.2;
        Thu, 27 May 2021 12:38:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CXQaRsjyxbjBhulXP+EXEjVKoHjcMycPwM+d90hn2wY=;
        b=ahDD0m1Wh/LAotatdpexKvIlYkw4ddtKIhq2YFise2ie49hNiJYAu4XdqOn1S6WWfx
         40Qbmew9gqixqc07zgwNU0fWl+WbBNQ7KeDAvBioNe1V660IDARMIwJE8JSMAD821sUH
         uUgZEwHq7zBy0SaHdhGcY8A08aa+FZLcfUBL9dM7tLWxOxgIoNnFaNy6m7rRr+hqFsYg
         jRaxyH8uOLZMiLMqv2Ijq4vSzMgj+mCwi3NqRLF4rUwTKYZP3nn8NlggiJU/1QhdmpHf
         wfwnlBVzENq5qnmfuFahebSyFiAzVX4lTlyfhUFHN3ukz+OElDVQvcxhAL9bZlq+UUfM
         Z88g==
X-Gm-Message-State: AOAM533Z1kUhPnohkh8Ot7HCRoUh5lXcrvDSzKZ5NkraXmFtBZJ2SDoW
        dithof1BfNC1t6e+tzAnRQAVna9Ngg==
X-Google-Smtp-Source: ABdhPJx0QQljnkdU3sMAlzrqVwx+MoGRd6IZ5qlgPRXeLB+jNZinWHyjWux0MGplGdAHy4AiQcgWWQ==
X-Received: by 2002:a9d:7384:: with SMTP id j4mr4149697otk.268.1622144324018;
        Thu, 27 May 2021 12:38:44 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id c18sm669935otm.1.2021.05.27.12.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 12:38:43 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>
Subject: [PATCH] of: Move reserved memory private function declarations
Date:   Thu, 27 May 2021 14:38:41 -0500
Message-Id: <20210527193841.1284169-1-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fdt_init_reserved_mem() and fdt_reserved_mem_save_node() are private to
the DT code, so move there declarations to of_private.h. There's no need
for the dummy functions as CONFIG_OF_RESERVED_MEM is always enabled for
CONFIG_OF_EARLY_FLATTREE.

Cc: Frank Rowand <frowand.list@gmail.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/of/of_private.h         | 4 ++++
 include/linux/of_reserved_mem.h | 6 ------
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index d717efbd637d..631489f7f8c0 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -171,4 +171,8 @@ static inline int of_dma_get_range(struct device_node *np,
 }
 #endif
 
+void fdt_init_reserved_mem(void);
+void fdt_reserved_mem_save_node(unsigned long node, const char *uname,
+			       phys_addr_t base, phys_addr_t size);
+
 #endif /* _LINUX_OF_PRIVATE_H */
diff --git a/include/linux/of_reserved_mem.h b/include/linux/of_reserved_mem.h
index 8216a4156263..76e4a0fffba4 100644
--- a/include/linux/of_reserved_mem.h
+++ b/include/linux/of_reserved_mem.h
@@ -39,9 +39,6 @@ int of_reserved_mem_device_init_by_name(struct device *dev,
 					const char *name);
 void of_reserved_mem_device_release(struct device *dev);
 
-void fdt_init_reserved_mem(void);
-void fdt_reserved_mem_save_node(unsigned long node, const char *uname,
-			       phys_addr_t base, phys_addr_t size);
 struct reserved_mem *of_reserved_mem_lookup(struct device_node *np);
 #else
 static inline int of_reserved_mem_device_init_by_idx(struct device *dev,
@@ -59,9 +56,6 @@ static inline int of_reserved_mem_device_init_by_name(struct device *dev,
 
 static inline void of_reserved_mem_device_release(struct device *pdev) { }
 
-static inline void fdt_init_reserved_mem(void) { }
-static inline void fdt_reserved_mem_save_node(unsigned long node,
-		const char *uname, phys_addr_t base, phys_addr_t size) { }
 static inline struct reserved_mem *of_reserved_mem_lookup(struct device_node *np)
 {
 	return NULL;
-- 
2.27.0

