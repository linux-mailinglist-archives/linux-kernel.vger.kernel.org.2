Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6A2414DB7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 18:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236522AbhIVQGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 12:06:50 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:43892
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232357AbhIVQGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 12:06:46 -0400
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C815E40267
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 16:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632326715;
        bh=JVVwsOf7X0M/+qlOsF+1zUq32C7aF6kWbgyKr7RQdek=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=Pk6PUVDNYIW3TphQ61fWnYBCQdnmCwWr+yizNe6qXLA51ViwxnVgWlvWQzywnb59q
         rpPRIZL81puwHV7eWn+Ifqx2ew0/OpHPR19O34lmSLbWD+5MhhCr7VxtqOEYf1LPt2
         QQts6q8cz2V/ocLsrSXehebe8YDqVk/z2vuVlpiI30xTVdVVnUfiKgY0hpMDYAWgl7
         /Fkxi5HZZc1GCoBSFrlOACwsCSMwR5Yk23ULuMCFzNGLIjblbc0obdnMEQQTNB9ASx
         9lRJ8H9IggaDZfF3+1Sl6S/1Lc0KR4Oib2tWEK6S5UtTaDeJEXN72tsk3ecQhwo8ui
         seEiJfVECAabg==
Received: by mail-ed1-f72.google.com with SMTP id r11-20020aa7cfcb000000b003d4fbd652b9so3582369edy.14
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 09:05:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JVVwsOf7X0M/+qlOsF+1zUq32C7aF6kWbgyKr7RQdek=;
        b=LpT2IWMXvjKm3yOR+Yg8QXqdhZf+CS1Y8M467d80cJ+vkAxK1U7xRKxq9A+ut0GFtc
         TzVwci+K1pAKAH/DfMVYLkr04xa3VyJLrkH1qv4LcGkZk5XC1fS2CA5UJXCXJ+ZReP7F
         dGuCXvdyOnwxWSEJIZQsgoneFgSJ6460BeGQxZrpmlDoz6+YPA5M8Orbr1EbVSS+a9j7
         s9xKyQheaEgKfyvrguiD9tOvpyYqfKooxXPHROdE84upI/K8D/9fCxo7bxK8j5pToC2e
         7wCOVw/VF9DwaQBfeN1L9m1/nDglEpEow+7GqsizGqaS0fH5brcygJtWlPxYK9PLayNY
         lKBw==
X-Gm-Message-State: AOAM533xWmfYm1N5gAsrJIzCChZwY4HghvsPIIA13/7NDG5H9cGNvznC
        7jL3DEAB+bQqNJP4eylIVzQhiUzZd+6APy+2ol0UHIH/Lk4jc5P1PXXV/x4vTHTw7Ygm4CQKyAv
        8koLaPlhf5akOI1T88Y4IwYZCKQG/tV0GeMTtGU17CQ==
X-Received: by 2002:a17:907:10c8:: with SMTP id rv8mr369807ejb.280.1632326715362;
        Wed, 22 Sep 2021 09:05:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwENuY/NrUiy6lL1ValNhLm4wX0hmrOfHOT0PzYAZC0DN+SkCollEpDyJxJAmQWua1juS10tw==
X-Received: by 2002:a17:907:10c8:: with SMTP id rv8mr369772ejb.280.1632326715181;
        Wed, 22 Sep 2021 09:05:15 -0700 (PDT)
Received: from localhost.localdomain (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id l7sm1511135edb.26.2021.09.22.09.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 09:05:14 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 2/2] powerpc/powermac: constify device_node in of_irq_parse_oldworld()
Date:   Wed, 22 Sep 2021 18:04:36 +0200
Message-Id: <20210922160436.130931-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210922160436.130931-1-krzysztof.kozlowski@canonical.com>
References: <20210922160436.130931-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The of_irq_parse_oldworld() does not modify passed device_node so make
it a pointer to const for safety.  Drop the extern while modifying the
line.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

---

Changes since v1:
1. Drop extern.
---
 arch/powerpc/platforms/powermac/pic.c | 2 +-
 include/linux/of_irq.h                | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

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
index aaf219bd0354..83fccd0c9bba 100644
--- a/include/linux/of_irq.h
+++ b/include/linux/of_irq.h
@@ -20,12 +20,12 @@ typedef int (*of_irq_init_cb_t)(struct device_node *, struct device_node *);
 #if defined(CONFIG_PPC32) && defined(CONFIG_PPC_PMAC)
 extern unsigned int of_irq_workarounds;
 extern struct device_node *of_irq_dflt_pic;
-extern int of_irq_parse_oldworld(struct device_node *device, int index,
-			       struct of_phandle_args *out_irq);
+int of_irq_parse_oldworld(const struct device_node *device, int index,
+			  struct of_phandle_args *out_irq);
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

