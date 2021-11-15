Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC2B44FF43
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 08:34:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbhKOHhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 02:37:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbhKOHgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 02:36:37 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94F2C061746;
        Sun, 14 Nov 2021 23:33:40 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id b11so13655652pld.12;
        Sun, 14 Nov 2021 23:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/dQKM6Vi+xbmsi2IWyfz9saHV4nVyKR/J4jSrspx45E=;
        b=WBOj4H/GjtPc4aLHjlWeRrOGun4Nn3S+8FAfiR2MKRbA3Jr4TLySdN69h58Anqet0K
         YJy5oGZw2+1wP9UyOnmvuTQ5nGtrQkQ8Oxjn7kqEGDqQbTTk5ysFDtfqhjTRUmKj5vtn
         qv/di+GK1LuL3hF8z+i1eGtjcRHrdW3Plnjl3YXmlCj2hDIEBc2k70SXM0+x8X3ya9gk
         A0P44IKj+3s1/TTZRUPF/yDEl+g3fn7a+HJr974wvh2MivOvhFlwnEX5EroRH0rZIKbV
         +6Fgdfu6HMu4zUxG9tyKWOFtvoW1NQ8lRawZSXfddDeZ1NRY+kZojsPfPyISk5WsjRXA
         4UGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/dQKM6Vi+xbmsi2IWyfz9saHV4nVyKR/J4jSrspx45E=;
        b=v+XMz1jLmUk9SD3LFnGGSJvmAIpz44GKVD0Ki3ppyX3lTnYnducszxxrZBfsl7pwiF
         4BuFoDlwEyAisBeTNdVdM0YImggcfIKFHHP9v5EXpscmtOw96XRRXjyb8EDLEiIAajqs
         KFVDgDYR4fG5zsw2ScshpXBzab09dnOcsawVjd/K6IiDzX42ULUAW1+ejxMpFJx/wV1J
         8iI0PdufrGSOnbsN3T9G71pQTCFL28mc88jBmnvoRCOTjgNc8aVkYawqsy3C9XiGhW9v
         YrGd6gHnHzpfc3ikgL30NNDZuYzteR+B0wXzn79ymogLogw64s2Nlg+QH2jsa3TGj3p7
         q13Q==
X-Gm-Message-State: AOAM531jUO9JMZETS1d39MK3/S9nxYrUmAGHyw3YqFmJ5Z9j1RJAcAWY
        H4suW+iqDePkuzAvTbE2h09XqQ0zroaOsg==
X-Google-Smtp-Source: ABdhPJzjk5a4xFIILiS6XXVnNV0TB6/EsIrOo6taGKzn2Jt0fU1oS7/KzU+6pbn4Fjeo+E3oTBSlOQ==
X-Received: by 2002:a17:90a:3d41:: with SMTP id o1mr37671094pjf.215.1636961620285;
        Sun, 14 Nov 2021 23:33:40 -0800 (PST)
Received: from localhost.localdomain ([103.99.179.247])
        by smtp.gmail.com with ESMTPSA id n15sm13441851pfv.216.2021.11.14.23.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Nov 2021 23:33:39 -0800 (PST)
From:   Calvin Zhang <calvinzhang.cool@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Calvin Zhang <calvinzhang.cool@gmail.com>
Subject: [PATCH v2] of: make MAX_RESERVED_REGIONS configurable
Date:   Mon, 15 Nov 2021 15:32:40 +0800
Message-Id: <20211115073240.3476043-1-calvinzhang.cool@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MAX_RESERVED_REGIONS has changed several times. Max reserved regions
count grows bigger as more SOC subsystems require reserved regions.

Add a Kconfig for it so that when properly configured, the static
reserved_mem array consumes less memory on systems with few reserved
regions.

Signed-off-by: Calvin Zhang <calvinzhang.cool@gmail.com>
---
 drivers/of/Kconfig           | 10 ++++++++++
 drivers/of/of_reserved_mem.c |  3 +--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
index 80b5fd44ab1c..47ffff9f6aba 100644
--- a/drivers/of/Kconfig
+++ b/drivers/of/Kconfig
@@ -73,6 +73,16 @@ config OF_IRQ
 config OF_RESERVED_MEM
 	def_bool OF_EARLY_FLATTREE
 
+config OF_MAX_RESERVED_REGIONS
+	int "Maximum count of reserved regions"
+	depends on OF_RESERVED_MEM
+	default 64
+	help
+	  Reserved regions in /reserved-memory node includes static
+	  reservations with fixed location and dynamic ones for device
+	  CMA regions. This parameter sets the maximum number of reserved
+	  regions in the system.
+
 config OF_RESOLVE
 	bool
 
diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 9c0fb962c22b..d90ae4c03011 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -25,8 +25,7 @@
 
 #include "of_private.h"
 
-#define MAX_RESERVED_REGIONS	64
-static struct reserved_mem reserved_mem[MAX_RESERVED_REGIONS];
+static struct reserved_mem reserved_mem[CONFIG_OF_MAX_RESERVED_REGIONS];
 static int reserved_mem_count;
 
 static int __init early_init_dt_alloc_reserved_memory_arch(phys_addr_t size,
-- 
2.30.2

