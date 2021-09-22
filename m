Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73B154143FC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 10:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234022AbhIVIqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 04:46:25 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:48098
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233952AbhIVIqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 04:46:22 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 2A5173F4B9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 08:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632300292;
        bh=z8fZpvZ//AsliWlBk6ZI/8MtJW2aVmSD5QrohcqQ3Yg=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=Yv+TYoT/vfF6FFIa9Wd6PsSFGharJyKvrM22BnVqpFtZ9zqZVglPMuY9zEE3tvDcI
         5z9hMpu0i+cB8nfDUotXlba9kgOtX1tPEdcw067fJy2W2QQoMH56I1o7N4lfHVqb7Y
         TiRF+55OT1Ju4EDdiGeaa8S4vdLtJdgFuxI1v7a7Qm4+ZIANAcGuQxYCFeYsrEtcgO
         p2vilOLY/BjLJB3F1MKhgsxkbxryq6EzAgGzwWdhutEunhJp4AHL2cf9CDzmE8VWe4
         02vb531iodh4Yay2b5fFfHPRsgxV+9ryC0A9XfKbwJgK3f8Ip0uoDZRAaLXJTXHC4c
         27WxRQm/v2tEQ==
Received: by mail-wr1-f70.google.com with SMTP id f11-20020adfc98b000000b0015fedc2a8d4so1528221wrh.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 01:44:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z8fZpvZ//AsliWlBk6ZI/8MtJW2aVmSD5QrohcqQ3Yg=;
        b=iJNMCZQrsdrInQoXZw3yrp4KQT5Ytl3KD6FCXbNzxork4SWBAQPEH4cE27VDC7/g2b
         TRtrwW5Yo2EGNqmR/vS1nYjNPlGWxQDtlPDkQs9eqkwzDFu7TzQ5YV0Xz7haCvkaTEgr
         dhACjRTaaK7I8oRx6RnpP1r8wfnzQPnYCBH/ap3rGg4VbJJR3+Yk43Qnl59OtaGHmBdS
         ISuX3bmnSV4Tv6Xe9yqcr3o/P1s/dA3JT3aRqydrYptTpAiVCg5zX5/mSI5ryThG/1n1
         rK6gFABS6jDjoUHyQaaoE298vQV6U1OcRL8MYdHLzOZB/OArOil4xN/Lp9O00Awr4JDN
         ouFQ==
X-Gm-Message-State: AOAM532XnUsvPPF784eAh8li2KLHz1pKuYW2fCBpDN1gdQfUSt2i0sUl
        Ggct1qIERN4LxjfYscsiNESfDRNUKrB9YogBpQsGz2b7o8vV7/bZfl5k2RUQwUByDammlejagEe
        NaIdSRp2M4tb4Sp2DuregGCb3VLd0BcGu0wl/eXH4Rg==
X-Received: by 2002:adf:8b19:: with SMTP id n25mr43049487wra.216.1632300291868;
        Wed, 22 Sep 2021 01:44:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwOzt5CWBoWaHmRLpJDmTWsqixtsWYMLhwi8nFJSalUAu/s/IlJpD6Al6BX4ejH9Ir7BxkZGA==
X-Received: by 2002:adf:8b19:: with SMTP id n25mr43049468wra.216.1632300291674;
        Wed, 22 Sep 2021 01:44:51 -0700 (PDT)
Received: from localhost.localdomain (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id o7sm1851490wro.45.2021.09.22.01.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 01:44:51 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [RESEND PATCH 2/2] powerpc/powermac: constify device_node in of_irq_parse_oldworld()
Date:   Wed, 22 Sep 2021 10:44:15 +0200
Message-Id: <20210922084415.18269-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210922084415.18269-1-krzysztof.kozlowski@canonical.com>
References: <20210922084415.18269-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The of_irq_parse_oldworld() does not modify passed device_node so make
it a pointer to const for safety.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/powerpc/platforms/powermac/pic.c | 2 +-
 include/linux/of_irq.h                | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/powermac/pic.c b/arch/powerpc/platforms/powermac/pic.c
index 4921bccf0376..af5ca1f41bb1 100644
--- a/arch/powerpc/platforms/powermac/pic.c
+++ b/arch/powerpc/platforms/powermac/pic.c
@@ -384,7 +384,7 @@ static void __init pmac_pic_probe_oldstyle(void)
 #endif
 }
 
-int of_irq_parse_oldworld(struct device_node *device, int index,
+int of_irq_parse_oldworld(const struct device_node *device, int index,
 			struct of_phandle_args *out_irq)
 {
 	const u32 *ints = NULL;
diff --git a/include/linux/of_irq.h b/include/linux/of_irq.h
index aaf219bd0354..6074fdf51f0c 100644
--- a/include/linux/of_irq.h
+++ b/include/linux/of_irq.h
@@ -20,12 +20,12 @@ typedef int (*of_irq_init_cb_t)(struct device_node *, struct device_node *);
 #if defined(CONFIG_PPC32) && defined(CONFIG_PPC_PMAC)
 extern unsigned int of_irq_workarounds;
 extern struct device_node *of_irq_dflt_pic;
-extern int of_irq_parse_oldworld(struct device_node *device, int index,
+extern int of_irq_parse_oldworld(const struct device_node *device, int index,
 			       struct of_phandle_args *out_irq);
 #else /* CONFIG_PPC32 && CONFIG_PPC_PMAC */
 #define of_irq_workarounds (0)
 #define of_irq_dflt_pic (NULL)
-static inline int of_irq_parse_oldworld(struct device_node *device, int index,
+static inline int of_irq_parse_oldworld(const struct device_node *device, int index,
 				      struct of_phandle_args *out_irq)
 {
 	return -EINVAL;
-- 
2.30.2

